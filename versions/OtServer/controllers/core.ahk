
Fix_Bug_Addapted_GuiControlGet(ControlID) {
	GLOBAL
	if (ControlID == "" or ControlID == "ERROR") {
		RETURN, TRUE
	}

	if (MainScript == true) {
		switch ControlID {
			case "OldUtamoVita": RETURN, TRUE	;old utamo vita is not GUI
			case "Renew_Growth_Stop_Combo": RETURN, TRUE	;Renew Growth Stop Combo is not GUI
		}
	}
}

Remove_All_Tooltips() {
	ik := 0
	Loop, 9 {
		ik++
		ToolTip,,,, %ik%
	}
}
ToolTip(Text,Time:=-500,X:="",Y:="",WhichToolTip:=20,Force:=False){
	GLOBAL
	;[WhichToolTip Map]
	;1 = drop flask warning	; 	2 = Party List			;	3 = AutoCombo		;	4 = Exercise Training	;	6 = interrogation GUI
	;7 = swap sqm warning	;	8 = KeyToActive
	;10 = CaveBot			;	18 = waiting goto hunt	; 	20 = change gold	;	15 = RemapKeys 8.6
	if (WinActive("ahk_id " active_id) or WinActive("ahk_exe explorer.exe") or Force == True) {
		GuiControlGet, CheckBox_ShowToolTip, Extras:
		if (List_State_ToolTip[WhichToolTip] != 1 && CheckBox_ShowToolTip) {
			Tooltip, %Text%, %X%, %Y%, %WhichToolTip%
			SetTimer, RemoveToolTip%WhichToolTip%, %Time%
			List_State_ToolTip[WhichToolTip] := 1
		}
	}
}

fix_Hotkey_to_ControlSend(hotkeyGB, ByRef HotkeyControlSend:="HotkeyControlSend") {
	;made by boiler - ahk forum
	HotkeyControlSend := RegExReplace(hotkeyGB, "([!+^]*)(.+)", "$1{$2}")
	return HotkeyControlSend
}
MgsBox() {
	GLOBAL
	Hide_All_GUI(state:="Hide")	;HIDE ALL GUI
	Remove_All_Tooltips()
	MsgBox % %GlobalLanguage%
	Hide_All_GUI(state:="Show")
}

KeyWait_Addapted(){
	GLOBAL
	While (GetKeyState("Shift", "P") || GetKeyState("Control", "P") || GetKeyState("Alt", "P")) {
		Sleep 50
		PrintScreenData()
		Verify_HP()
		Verify_MP()
		GuiControlGet, Force_HP_Percent, Extras:
		GuiControlGet, Force_MP_Percent, Extras:
		if (Data.HP < Force_HP_Percent || Data.MP < Force_MP_Percent) {
			TOOLTIP("[SHIFT/CTRL PRESSED] WARNING HP(" Data.HP "%)/MP(" Data.MP "%) < " Force_HP_Percent "%/" Force_MP_Percent "%", -500)
			;~ WinActivate, ahk_id %active_id%
			if (GetKeyState("Shift", "P")) {
				Send, {Shift Up}
			}
			if (GetKeyState("Control", "P")) {
				Send, {Ctrl Up}
			}
			if (GetKeyState("Alt", "P")) {
				Send, {Alt Up}
			}
			BREAK
		}
	}
}
Press_Key(Key, Tab:=""){
	GLOBAL
	KeyWait_Addapted()
	KeyWait, %Key%
	GuiControlGet, %Key%, %Tab%
	if (%Key% != "") {
		HotkeyControlSend := fix_Hotkey_to_ControlSend(%Key%)
		ControlSend,, %HotkeyControlSend%, ahk_id %active_id% ;ahk_group Tibia
		if (TibiaServer == "Global") {
			GuiControlGet, Delay_PressHotkey, Extras:
			Sleep %Delay_PressHotkey%
		}
	}
}
Send_Text(text, sleep:=250){
	GLOBAL
	;ENABLE CHAT
	Loop, {
		PrintScreenData()
		SearchPNG(PNG.Chat, A_ScreenWidth/2, A_ScreenHeight/2, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=15, Erro, Mode:=1), Cords.Chat := Erro
		if (GetColorHex(Cords.Chat.2+46, Cords.Chat.3+5) = "#c0c0c0"){
			KeyWait_Addapted()
			ControlSend,, {Enter}, ahk_id %active_id% ;ahk_group Tibia
		} else {
			BREAK
		}
		Sleep 300
	}


	KeyWait_Addapted()
	if (TibiaServer != "deprecated_Global") {
		ControlSend,, %text%, ahk_id %active_id% ;ahk_group Tibia
		Sleep 150
		ControlSend,, {Enter}, ahk_id %active_id% ;ahk_group Tibia
	} else {
		SendInput, %text%
		ControlSend,, {Enter}, ahk_id %active_id% ;ahk_group Tibia
	}

	Sleep, %sleep%
}

Mouse_Click_Drag(X1,Y1,X2,Y2,Speed:=2,fix_coordinates_1:=true,fix_coordinates_2:=true, variation:=10, Click:="Left"){
	GLOBAL
	KeyWait_Addapted()

	if (X2=="" or Y2=="") {
		RETURN
	}


	If not WinActive("ahk_id " active_id) {
		ActiveHwnd := WinExist("A")
		WinActivate, ahk_id %active_id%
	}
	Sleep 100

	;randomize click
	Random, rand_X, -%variation%, %variation%
	Random, rand_Y, -%variation%, %variation%

	BlockInput, ON
	MouseGetPos, StartX, StartY

	if (fix_coordinates_1 == true) {
		X1 := Round( X1*(A_ScreenDPI/96) ) + rand_X + WindowInfo.ClassNN.x
		Y1 := Round( Y1*(A_ScreenDPI/96) ) + rand_Y + WindowInfo.ClassNN.y
	}
	if (fix_coordinates_2 == true) {
		X2 := Round( X2*(A_ScreenDPI/96) ) + rand_X + WindowInfo.ClassNN.x
		Y2 := Round( Y2*(A_ScreenDPI/96) ) + rand_Y + WindowInfo.ClassNN.y
	}

	SendMode, InputThenPlay
	MouseClickDrag, %Click%, % X1,% Y1,% X2,% Y2, %Speed%
	MouseMove, % StartX, % StartY
	BlockInput, OFF

}
MouseMove(X,Y,fix_coordinates:=true){
	GLOBAL
	;~ KeyWait, Control
	;~ KeyWait, Shift
	If not WinActive("ahk_id " active_id) {
		ActiveHwnd := WinExist("A")
		WinActivate, ahk_id %active_id%
	}

	KeyWait_Addapted()
	if (fix_coordinates == true) {
		if (TibiaServer != "Global") {
			X := Round( X*(A_ScreenDPI/96) )
			Y := Round( Y*(A_ScreenDPI/96) )
		}
		MouseMove, % X + WindowInfo.ClassNN.x, % Y + WindowInfo.ClassNN.y
	} else {
		MouseMove, % X, % Y
	}

}
ControlClick(X,Y,WhichButton:="LEFT",fix_coordinates:=true,ghost_mouse:=true,state:="",zKeyWait:=true,variation:=5,delay_after_click:=0) {
	GLOBAL
	;~ KeyWait, Control
	;~ KeyWait, Shift
	if (zKeyWait == true) {
		KeyWait_Addapted()
	}


	;Verify Ghost Mouse Enable
	if (TibiaServer == "Global") {
		GuiControlGet, CheckBox_State_GhostMouse, Extras:
		if (CheckBox_State_GhostMouse == false) {
			ghost_mouse := false	;movimenta o mouse
		} else {
			ghost_mouse := true		;nao movimenta o mouse
		}
	}
	; fix bug OTC e RTC
	if ( TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe" or TibiaServer = "Shadow-Illusion") {
		ghost_mouse := false
	}
	; fix bug RubinOT
	if (RubinOT_Server == true && delay_after_click != 0) {
		ghost_mouse := false
	}
	if (ghost_mouse == false) {
		If not WinActive("ahk_id " active_id) {
			ActiveHwnd := WinExist("A")
			WinActivate, ahk_id %active_id%
		}
	}

	if (fix_coordinates == true) {
		if (TibiaServer != "Global") {
			Random, rand_X, 0, %variation%
			Random, rand_Y, 0, %variation%

			X := Round( X*(A_ScreenDPI/96) ) + rand_X
			Y := Round( Y*(A_ScreenDPI/96) ) + rand_Y
		}

		if (ghost_mouse == true) {
			SendMode, Input
			ControlClick, % "x" X + WindowInfo.ClassNN.x " y" Y + WindowInfo.ClassNN.y, ahk_id %active_id%,, %WhichButton%,, %state% NA
		} else {
			MouseGetPos, StartX, StartY
			SendMode, Event
			Click, % X+WindowInfo.ClassNN.x " " Y+WindowInfo.ClassNN.y " " state " " WhichButton
			;~ MouseClick, %WhichButton%, % X+WindowInfo.ClassNN.x, % Y+WindowInfo.ClassNN.y, ClickCount:=1, Speed:=3, %state%
			if (TibiaServer == "Global" or RubinOT_Server == true) {
				;~ GuiControlGet, Delay_PressHotkey, Extras:
				;~ Sleep %Delay_PressHotkey%
				Sleep %delay_after_click%
			}
			MouseMove, %StartX%, %StartY%
		}

	} else {
		;; FIX COORD FALSE
		if (TibiaServer != "Global") {
			Random, rand_X, 0, %variation%
			Random, rand_Y, 0, %variation%

			X += rand_X
			Y += rand_Y
		}
		if (ghost_mouse == true) {
			SendMode, Input
			ControlClick, % "x" X " y" Y, ahk_id %active_id%,, %WhichButton%,, %state% NA
		} else {
			MouseGetPos, StartX, StartY
			SendMode, Event
			;~ Click, % X " " Y " " state " " WhichButton
			MouseClick, %WhichButton%, %X%, %Y%, ClickCount:=1, Speed:=3, %state%
			if (TibiaServer == "Global") {
				GuiControlGet, Delay_PressHotkey, Extras:
				Sleep %Delay_PressHotkey%
			}
			MouseMove, %StartX%, %StartY%
		}
	}


	;~ if (ActiveHwnd != "") {
		;~ Send, !{Tab}
		;~ ActiveHwnd := ""
	;~ }
}

Toggle_KeyToActive(KeyToActive) {
	global
	GuiControlGet, %KeyToActive%
	GuiControl,, %KeyToActive%, % !%KeyToActive%	;example: GuiControl,, SSA_Life, % !SSA_Life

	if (%KeyToActive% == 1) {
		ToolTip(KeyToActive " [OFF]",Time:=-500,X:="",Y:="",WhichToolTip:=08)
	} else {
		ToolTip(KeyToActive " [ON]",Time:=-500,X:="",Y:="",WhichToolTip:=08)
	}
}


Refresh_Picture_GUI(dropdown_var,picture_var,Tab) {
	GLOBAL
	Gui, %Tab%:Default
	GuiControlGet, %dropdown_var%
	if (%dropdown_var% != "" && %dropdown_var% != "ERROR") {
		tmp_picture := Picture[%dropdown_var%]
		GuiControl,, %picture_var%, % "HBITMAP:* " tmp_picture
	}
}

Get_Coordinates_Script(cordx, cordy) {
	GLOBAL
	WinActivate, ahk_id %active_id%
		Loop, {
			ToolTip, Click to get coordinates...
			if ( GetKeyState("LButton") ) {

				MouseGetPos, MouseX, MouseY
				GuiControl,, %cordx%, %MouseX%
				GuiControl,, %cordy%, %MouseY%

				ToolTip, Coordenada Configurada!
				SetTimer, RemoveToolTip, 1000
				Gui, Show
				BREAK
			}
		}

}

fix_Coordinates_Gdip(PosX, PosY, TibiaServer) {
	GLOBAL
	if (TibiaServer != "Global") {
		%PosX% := Round( %PosX%*(A_ScreenDPI/96) )
		%PosY% := Round( %PosY%*(A_ScreenDPI/96) )
	}
}
PixelSearch(posX,posY,w,h, colorRGB,variation, outputvarX:="outputvarX", outputvarY:="outputvarY") {
	GLOBAL
	;~ StartTime_Growth := A_TickCount

	tmpBitmap := Gdip_CreateBitmapFromHBITMAP(WindowInfo.HBITMAP)
	;~ Gdip_SaveBitmapToFile(tmpBitmap, "DeBug1.png")
	Gdip_disposeImage(Haystack_Bitmap)
	Haystack_Bitmap := Gdip_CloneBitmapArea(tmpBitmap, posX,posY,w,h)
	DllCall(ProcDisposeImage, "Ptr", tmpBitmap)
	;~ Gdip_SaveBitmapToFile(Haystack_Bitmap, "DeBug2.png")

	OutPutVar_Gdip_PixelSearch := Gdip_PixelSearch(Haystack_Bitmap, ARGB := "0xFF" . colorRGB, tmp_outputvarX,tmp_outputvarY, variation)
	%outputvarX% := tmp_outputvarX
	%outputvarY% := tmp_outputvarY

	;~ ElapsedTime_Growth := A_TickCount - StartTime_Growth
	;~ TOOLTIP % ElapsedTime_Growth

	RETURN % OutPutVar_Gdip_PixelSearch
	; 0 = found
	; -1 = not found
}

GetDpiForWindow(hwnd) {
   return DllCall("User32\GetDpiForWindow", "Ptr", hwnd, "UInt")
}

Crop_And_Save_Haystack(posX,posY,w,h) {
	Global
	tmpBitmap := Gdip_CreateBitmapFromHBITMAP(WindowInfo.HBITMAP)
	Gdip_SaveBitmapToFile(tmpBitmap, "DeBug1.png")

	Gdip_disposeImage(Haystack_Bitmap)
	Haystack_Bitmap := Gdip_CloneBitmapArea(tmpBitmap, posX,posY,w,h)
	DllCall(ProcDisposeImage, "Ptr", tmpBitmap)
	Gdip_SaveBitmapToFile(Haystack_Bitmap, "DeBug2.png")

	MsgBox, Saved Image!
}

Hide_All_GUI(state:="",winactive_tibia:=true) {
	GLOBAL
	if (Status_Gui_Hide != TRUE or state = "Hide") {
		ToolTip("Hide")
		Gui, Main:HIDE
		Gui, Healing:HIDE
		Gui, TankMode:HIDE
		Gui, Support:HIDE
		Gui, PvP:HIDE
		Gui, Timer:HIDE
		Gui, Looter:HIDE
		Gui, Combo:HIDE
		Gui, HealFriend:HIDE
		Gui, RemapKeys:HIDE
		Gui, Gui_CaveBot:HIDE
		Gui, Alarms:HIDE
		Gui, Extras:HIDE
		Status_Gui_Hide := TRUE
	} else if (Status_Gui_Hide == TRUE or state = "Show") {
		Status_Gui_Hide := FALSE
		ToolTip("Show")
		Gui, Main:Show, NoActivate
	}

	if (winactive_tibia == true) {
		WinActivate, ahk_id %active_id%	;fix bug on win7
	}
}

