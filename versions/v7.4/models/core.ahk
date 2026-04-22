; CORE.AHK ================================================================================
ToolTip(Text,Time:=-500,PosX:="",PosY:="",WhichToolTip:=20){
	GLOBAL
	;[WhichToolTip Map]
	;1 = drop flask warning	; 	2 = Party List 	;	3 = AutoCombo			;	 4 = Exercise Training	;	6 = interrogation GUI	;
	;7 = swap sqm warning	;	10 = CaveBot	;	18 = waiting goto hunt	; 	20 = change gold	; 15 = RemapKeys 8.6	;
	;12 = ERROR ScanGameBars()


	if ( WinActive(Client) ) {
		Tooltip, %Text%, %PosX%, %PosY%, %WhichToolTip%
		SetTimer, RemoveToolTip%WhichToolTip%, %Time%
		List_State_ToolTip[WhichToolTip] := 01
	}
}
Verify_Items() {
	GLOBAL
	;[ Character Position ]
	if (GetCoord_CharacterPosition_X = "" or GetCoord_CharacterPosition_Y = "") {
		ToolTip(Text:="[ERROR] Get Character Position is not a number.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
		EXIT
	}

	;[Mana Fluid]
	GuiControlGet, CheckBox_Enable_Healing_Mana
	if (CheckBox_Enable_Healing_Mana == true) {
		ManaFluidX -= WindowInfo.ClassNN.x	;FIX COORDINATES WINDOW TO CLIENT
		ManaFluidY -= WindowInfo.ClassNN.y	;FIX COORDINATES WINDOW TO CLIENT
		Color_ManaFluid := GetColorHex(ManaFluidX+8, ManaFluidY+7)
		if (Color_ManaFluid != "#C919C7") {
			SearchPNG(PNG.ManaFluid, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, ManaFluid, Mode:=1)
			if (ManaFluid.1 == 0) {	;NAO ENCONTROU
				ToolTip(Text:="[Supply] Mana Fluid Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
				Have_ManaFluid := false
			} else if (ManaFluid.1 == 1) {	;ENCONTROU
				Have_ManaFluid := true
			} else {
				ToolTip(Text:="[ERROR] PNG.ManaFluid Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
				Have_ManaFluid := false
			}
		}
	}

	;[UH]
	GuiControlGet, CheckBox_Healing_Life_UseUH
	if (CheckBox_Healing_Life_UseUH == true) {
		SearchPNG(PNG.UH, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=50, UH, Mode:=1)
		if (UH.1 == 0) { ;NAO ENCONTROU
			ToolTip(Text:="[Supply] UH Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
			Have_UH := false
		} else if (UH.1 == 1) { ;SIM ENCONTROU
			Have_UH := true
		} else if (ErrorLevel = 2) {
			ToolTip(Text:="[ERROR] PNG UH Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
			Have_UH := false
		}
	} else {
		Have_UH := false
	}

	;[HMM]
	Check_New_Hotkey_Script("Hotkey_HMM", "Attack_Rune") 
	if (Hotkey_HMM != "ERROR" && Hotkey_HMM != "") {
		SearchPNG(PNG.HMM, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=80, HMM, Mode:=1)
		if (HMM.1 == 0) { ;NAO ENCONTROU
			ToolTip(Text:="[Supply] HMM Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
			Have_HMM := false
		} else if (HMM.1 == 1) { ;SIM ENCONTROU
			Have_HMM := true
		} else if (ErrorLevel = 2) {
			ToolTip(Text:="[ERROR] PNG HMM Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
			Have_HMM := false
		}
	} else {
		Have_HMM := false
	}
}

Check_New_Hotkey_Script(GuiControl, Label) {
	GLOBAL
	
	;DISABLE OLD HOTKEY
	if (%GuiControl% != "ERROR" && %GuiControl% != "" && %GuiControl% != "Nothing") {
		Hotkey, % "~" %GuiControl%, %Label%, Off
	}

	;GET NEW HOTKEY
	GuiControlGet, %GuiControl%

	;ENABLE NEW HOTKEY
	if (%GuiControl% != "ERROR" && %GuiControl% != "" && %GuiControl% != "Nothing") {
		Hotkey, % "~" %GuiControl%, %Label%, ON
	}
}

Use_Item_On(state:="", PosX:="", PosY:="") {
	GLOBAL
	switch State {
		case "YourSelf":
			;~ BlockInput, On
			MouseGetPos, StartX, StartY
			CoordMode, Mouse, Client
				Click, %PosX% %PosY% Right
			
			;~ Sleep 50
			GuiControlGet, GetCoord_CharacterPosition_X
			GuiControlGet, GetCoord_CharacterPosition_Y
			CoordMode, Mouse, Window
				Click, %GetCoord_CharacterPosition_X% %GetCoord_CharacterPosition_Y%
			MouseMove, %StartX%, %StartY%
			;~ BlockInput, Off
			RETURN
		case "CrossHair":
			;~ BlockInput, On
			MouseGetPos, StartX, StartY
			CoordMode, Mouse, Client
				Click, %PosX% %PosY% Right
			
			;~ Sleep 50
			CoordMode, Mouse, Window
				Click, %StartX% %StartY%
			;~ BlockInput, Off
			RETURN

		default:
			ToolTip [Error] Use_Item_On()
	}
}
fix_Hotkey_to_ControlSend(hotkeyGB, ByRef HotkeyControlSend:="HotkeyControlSend") {
	;GLOBAL
	;made by boiler - ahk forum
	HotkeyControlSend := RegExReplace(hotkeyGB, "([!+^]*)(.+)", "$1{$2}")
	return HotkeyControlSend
}
Press_Key(Key, Tab:=""){
	KeyWait, Control
	KeyWait, Shift
	GuiControlGet, %Key%, %Tab%
	if (%Key% != "") {
		HotkeyControlSend := fix_Hotkey_to_ControlSend(%Key%)
		ControlSend,, %HotkeyControlSend%, %Client% ;ahk_group Tibia
	}
}
MouseMove_And_Click(X,Y,Speed:=2,fix_coordinates:=true, Click:="Left"){
	GLOBAL
	If not WinActive(Client) {
		;~ ActiveHwnd := WinExist("A")
		WinActivate, % Client
	}

	;randomize click
	Random, rand_X, -10, 10
	Random, rand_Y, -10, 10


	BlockInput, ON
	;~ MouseGetPos, StartX, StartY
	if (fix_coordinates == true) {
		X := Round( X*(A_ScreenDPI/96) ) + rand_X
		Y := Round( Y*(A_ScreenDPI/96) ) + rand_Y

		MouseMove, % X + WindowInfo.ClassNN.x, % Y + WindowInfo.ClassNN.y, % Speed
	} else {
		MouseMove, % X + rand_X, % Y + rand_Y, % Speed
	}
	Sleep 25
	;~ ControlClick,, %Client%,, % Click
	Click % Click
	;~ MouseMove, % StartX, % StartY
	BlockInput, OFF

}
Mouse_Click_Drag(X1,Y1,X2,Y2,Speed:=2,fix_coordinates_1:=true,fix_coordinates_2:=true, Click:="Left"){
	GLOBAL
	If not WinActive(Client) {
		;~ ActiveHwnd := WinExist("A")
		WinActivate, % Client
	}

	;randomize click
	Random, rand_X, -10, 10
	Random, rand_Y, -10, 10

	BlockInput, ON
	;~ MouseGetPos, StartX, StartY

	if (fix_coordinates_1 == true) {
		X1 := Round( X1*(A_ScreenDPI/96) ) + rand_X + WindowInfo.ClassNN.x
		Y1 := Round( Y1*(A_ScreenDPI/96) ) + rand_Y + WindowInfo.ClassNN.y
	}
	if (fix_coordinates_2 == true) {
		X2 := Round( X2*(A_ScreenDPI/96) ) + rand_X + WindowInfo.ClassNN.x
		Y2 := Round( Y2*(A_ScreenDPI/96) ) + rand_Y + WindowInfo.ClassNN.y
	}

	MouseClickDrag, %Click%, % X1,% Y1,% X2,% Y2, %Speed%
	;~ MouseMove, % StartX, % StartY
	BlockInput, OFF

}
Get_Coord_And_Color(VarName,GuiTab:="Main",HUDcolor:="Green") {
	GLOBAL
	Gui, HUD_GetPixel_%VarName%:Destroy
	Hide_All_GUI(state:="Hide")
		Loop, {
			TOOLTIP, Clique no MP`% que Devera Castar RuneSpell...
			If WinActive(Client) {
				if (GetKeyState("LButton", "P")) {
					MouseGetPos, Coord_%VarName%_X, Coord_%VarName%_Y
					Coord_%VarName%_X -= WindowInfo.ClassNN.x	;FIX COORDINATES WINDOW TO CLIENT
					Coord_%VarName%_Y -= WindowInfo.ClassNN.y	;FIX COORDINATES WINDOW TO CLIENT


					Color_%VarName% := GetColorHex(Coord_%VarName%_X, Coord_%VarName%_Y)
					Color_%VarName%_Gdip := RegExReplace(Color_%VarName%, "#", "0xFF")

					Draw_Rectangle_OnPicture(color:=Color_%VarName%_Gdip, PosX:=0,PosY:=0, widthh:=20,heightt:=20, GuiTab:=GuiTab,PictureVar:="Picture_GetPixel_" VarName)
					HUD_ScreenBox(GuiName:="HUD_GetPixel_" VarName,PosX:=Coord_%VarName%_X, PosY:=Coord_%VarName%_Y, widthh:=6,heightt:=8, Color:=HUDcolor,Transparent:=255)

					TOOLTIP
					Send, {LButton Up}
					BREAK
				}
			}
		}
	Hide_All_GUI(state:="Show")
}
Get_Coord_Mouse(VarName,HUDcolor:="Red",Transparent:=80) {
	GLOBAL
	Gui, HUD_%VarName%:Destroy
	Hide_All_GUI(state:="Hide")
		Loop, {
			TOOLTIP, Clique no seu FOOD para capturar a coordenada...
			If WinActive(Client) {
				if (GetKeyState("LButton", "P")) {
					MouseGetPos, GetCoord_%VarName%_X, GetCoord_%VarName%_Y
					GuiControl,, GetCoord_%VarName%_X, % "X = "GetCoord_%VarName%_X	;imprime na GUI o valor de GetCoord_EatFood_X
					GuiControl,, GetCoord_%VarName%_Y, % "Y = "GetCoord_%VarName%_Y	;imprime na GUI o valor de GetCoord_EatFood_Y

					Coord_%VarName%_X := GetCoord_%VarName%_X - WindowInfo.ClassNN.x	;FIX COORDINATES WINDOW TO CLIENT
					Coord_%VarName%_Y := GetCoord_%VarName%_Y - WindowInfo.ClassNN.y	;FIX COORDINATES WINDOW TO CLIENT
					HUD_ScreenBox(GuiName:="HUD_" VarName,PosX:=Coord_%VarName%_X, PosY:=Coord_%VarName%_Y, widthh:=15,heightt:=15, Color:=HUDcolor,Transparent:=Transparent)

					TOOLTIP
					Send, {LButton Up}
					BREAK
				}
			}
		}
	Hide_All_GUI(state:="Show")
}


Draw_Rectangle_OnPicture(color:="", PosX:=0,PosY:=0, widthh:="",heightt:="", GuiTab:="Main",PictureVar:=""){
	Gui, %GuiTab%:Default
	; Define o tamanho da área do controle Picture
    hbm := Gdip_CreateBitmap(widthh, heightt)
    graphics := Gdip_GraphicsFromImage(hbm)

    ; Preenche a área com branco (cor de fundo)
    Gdip_GraphicsClear(graphics, 0xFFFFFFFF)  ; Branco

    ; Preenche com a cor atual (azul ou vermelho)
    brush := Gdip_BrushCreateSolid(color)
    Gdip_FillRectangle(graphics, brush, PosX, PosY, widthh, heightt)

    ; Atualiza o controle Picture com a nova imagem
    hbm_old := Gdip_CreateHBITMAPFromBitmap(hbm)
    GuiControl, , %PictureVar%, HBITMAP:%hbm_old%

    ; Libera objetos GDI+
    Gdip_DeleteBrush(brush)
    Gdip_DeleteGraphics(graphics)
    Gdip_DisposeImage(hbm)
    Gdip_DisposeImage(hbm_old)
}
Hide_All_GUI(state:="",winactive_tibia:=true) {
	GLOBAL
	PrintScreenData()

		if (Status_Gui_Hide != TRUE or state = "Hide") {
			ToolTip("Hide")
			Gui, Main:HIDE
			Status_Gui_Hide := TRUE
		} else if (Status_Gui_Hide == TRUE or state = "Show") {
			Status_Gui_Hide := FALSE
			ToolTip("Show")
			Gui, Main:Show
		}

		if (winactive_tibia == true) {
			WinActivate, % Client	;fix bug on win7
		}
}
HUD_ScreenBox(GuiName:="",PosX:="", PosY:="", widthh:="",heightt:="", Color:="Green",Transparent:=255) {
	GLOBAL
	GuiControlGet, CheckBox_HUD_ScreenBox
	if (CheckBox_HUD_ScreenBox != true) {
		RETURN
	}

	; fix coordinates
	PosX -= widthh/2
	PosY -= (heightt/2)
	PosY += WindowInfo.ClassNN.y + WindowInfo.Window.y ;fix coord Window/Client

	Gui, %GuiName%: New	
	Gui, %GuiName%: +AlwaysOnTop +E0x80020  ; WS_EX_LAYERED (0x80000) | WS_EX_TRANSPARENT (0x20)
	Gui, %GuiName%: +HwndMyGuiHwnd	;NAO TEM COMO MOVER NO ON MESSAGE
	Gui, %GuiName%: -Caption +Border +ToolWindow +LastFound
	Gui, %GuiName%: Color, %Color%
	WinSet, Transparent, %Transparent%

	; Adiciona o estilo WS_EX_NOACTIVATE (0x08000000) - Faz com que a janela não receba foco quando clicada.
	; WinSet, ExStyle, +0x08000000, ahk_id %MyGuiHwnd%

	Gui, %GuiName%: Show, w%widthh% h%heightt% x%PosX% y%PosY% NoActivate, %GuiName%
}