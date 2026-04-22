; =======================================================================================
; Name ..........: TibiaMacros - NTSW
; AHK Version ...: AHK_L 1.1.22.06 (Unicode 64-bit)
; Platform ......: Windows 10 / 11
; =======================================================================================

; [RUN ADMINISTRADOR] ===========================================================================
full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)")) {
	try
	{
		if A_IsCompiled
			Run *RunAs "%A_ScriptFullPath%" /restart
		else
			Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
	}
	ExitApp
}
; END [RUN ADMINISTRADOR] =======================================================================

; Inicializa o GDI+
if !pToken := Gdip_Startup() {
    MsgBox, Falha ao iniciar GDI+.
    ExitApp
}
;[Load Modules GDIP - PrintScreen MH]
LoadGDIplus()

;~ snap := Gdip_CreateBitmapFromFile(A_WorkingDir "\images\PlatinumCoin.png")
;~ test := EncodeBitmapTo64string(snap,"PNG")
;~ test := RegExReplace(test,"\.? *(\n|\r)+","")		;remove break lines
;~ clipboard := test
;~ msgbox % test
;~ EXITAPP




;PostMessage, 0x00F5, 0, 0, , ahk_id %BTNGui1% ; BM_CLICK
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
GlobalLanguage := "Portugues"
Client := "ahk_class GLFW30"
WinMaximize, Client
#Persistent
#NoEnv
;~ #Warn
#SingleInstance Force
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
;~ CoordMode, Pixel, Client
;~ CoordMode, Mouse, Client
;~ CoordMode, ToolTip, Client
;~ SendMode Input
SetBatchLines, -1 ; Run script at maximum speed
;~ SetKeyDelay, -1, -1
SetKeyDelay, 0, 75	;colocando 75ms pra fix bug ControlSend (Shift, Alt, Control)
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
;~ SetControlDelay, -1
Thread, NoTimers, true
SetStoreCapsLockMode, Off	;nao desativa o capslock no controlsend

;[PROGRAM ICON AND NAME]
TrayName := "TibiaMacros"
Menu, Tray, Tip, %TrayName%
Menu, Tray, Add, Pause Script, ForcePauseScript
Menu, Tray, Add, Reload, Reload
Menu, Tray, Add, Exit, Exit
;Menu, Tray, Add, OpenNewScript, OpenNewScript
Menu, Tray, NoStandard



OnMessage(0x0201, "WM_LBUTTONDOWN")
;~ Draw_LoginScreen()
Draw_MainGui()
Declarar_Variaveis()
SetTimer, Start_Label, 0
Gui Submit, NoHide
Hotkey, %Key_Enable_Walker%, Toggle_Walker
RETURN

Declarar_Variaveis() {
GLOBAL
	ArColor:=[], Data:=[], Data.Group:=[], Dados:=[], Cords:=[], AutoHunt:=[], Data.FriendHP:=[], Cords.BattleList:=[], Cords.AttackMode:=[], SQMLoot:=[], RubinOT_Status_MP:=[]

	;CaveBot -> Minimap
	ColorHex_Validate_Minimap := "#"

	;TOOLTIP DELAY
	List_State_ToolTip := []

	Status_Gui_Hide := FALSE

	CharacterCoordX := ""
	CharacterCoordY := ""

	StartTime_ManaFluid := A_TickCount
	ManaFluidX := 0
	ManaFluidY := 0
	Have_ManaFluid := false
	Coord_MPx := 0
	Coord_MPy := 0
	Color_MP:=""

	ElapsedTime_HP := A_TickCount
	UHx := 0
	UHy := 0
	Have_UH := false
	Coord_HPx := 0
	Coord_HPy := 0
	Color_HP := ""

	HMMx := 0
	HMMy := 0
	Have_HMM := false

	StartX := 0
	StartY := 0

	StartTime_EatFood	:= -9999999
	StartTime_CastRune	:= -9999999
	StartTime_EquipLifeRing := -9999999


	TOOLTIP
}


;~ Hotkey, IfWinActive, % Client
;~ HOTKEY_HMM := RegExReplace(HOTKEY_HMM, "[{}]")
;~ Hotkey, %HOTKEY_HMM%, Attack_Rune
Reload:
RETURN

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



; ============================================================================== [ START SCRIPTS ] ==============================================================================
; ============================================================================== [ START SCRIPTS ] ==============================================================================
; ============================================================================== [ START SCRIPTS ] ==============================================================================
; ============================================================================== [ START SCRIPTS ] ==============================================================================
Start_Label:
If (WinActive(Client) or true) {
;~ StarTime_RunScript := A_TickCount
Gui, Gui_CaveBot:Default
	PrintScreenData()
	CaveBot()


;~ ToolTip % ElapsedTime_RunScript := A_TickCount - StarTime_RunScript
	if (ActiveHwnd != "" && false) {
		Send, !{Tab}
		ActiveHwnd := ""
	}
}
RETURN

Toggle_Walker:
	state_Cavebot := !state_Cavebot
	if (state_Cavebot == true) {
		ToolTip("[ ON ] CaveBot [ ON ]",Time:=-700,PosX:="",PosY:="",WhichToolTip:=10)
	} else {
		ToolTip("[ OFF ] CaveBot [ OFF ]",Time:=-700,PosX:="",PosY:="",WhichToolTip:=10)
	}
	SetTimer, AutoCombo, OFF
	State_StartAutoCombo := false
RETURN
CaveBot() {
GLOBAL
	if (state_Cavebot == true) {
		if (Auto_Attack() != true) {
			Change_Gold()
			Lootear()
			CaveBot_Action()
		}
	}
}
Auto_Attack() {
GLOBAL
	GuiControlGet, CheckBox_AutoAttack
	if StartTime_AutoAttack is not number
		StartTime_AutoAttack := -99999
	ElapsedTime_AutoAttack := A_TickCount - StartTime_AutoAttack
	if (CheckBox_AutoAttack == 1 && ElapsedTime_AutoAttack > 250) {
		SearchPNG(PNG.BattleList, 0,0,WindowInfo.Client.w,WindowInfo.Client.h, Tole:=5, Erro, Mode:=1)
		if (Erro.1 == 1) {    ;se ele encontrar a imagem
			CountMobs := 0
			TargetMob := false
			Qtd_Buffed_Monster := 0
			Buffed_Monster_PosY := false
			Change_TargetMob := false ;priority non-buffed monster

			TargetMonsterX := Erro.2+26
			TargetMonsterY := Erro.3+101
			color_BlackTargetLife := GetColorHex(X:=TargetMonsterX, Y:=TargetMonsterY)
			if (color_BlackTargetLife == "#000000") {				
				while (color_BlackTargetLife == "#000000" && CountMobs <= 10){
					CountMobs++
					;Verify Buffed Monster
					Color_Verify_Buffed_Monster := GetColorHex(TargetMonsterX+133, TargetMonsterY-10)
					switch Color_Verify_Buffed_Monster {
						case "#9924E8": Qtd_Buffed_Monster++, Buffed_Monster_PosY := A_Index		;roxinho
						case "#E14A79": Qtd_Buffed_Monster++, Buffed_Monster_PosY := A_Index		;sanguine
						case "#E0DB1D": Qtd_Buffed_Monster++, Buffed_Monster_PosY := A_Index		;dourado
						case "#31ADEA": Qtd_Buffed_Monster++, Buffed_Monster_PosY := A_Index		;azulzinho
					}
					;~ TOOLTIP, Qtd_Buffed_Monster = %Qtd_Buffed_Monster% ||| Buffed_Monster_PosY = %Buffed_Monster_PosY%
					; TOOLTIP, Qtd_Buffed_Monster = %Qtd_Buffed_Monster% ||| CountMobs = %CountMobs%
					;~ tooltip, %Color_Verify_Buffed_Monster%

					color_monster_is_target := GetColorHex(X:=TargetMonsterX-6, Y:=TargetMonsterY)
					if (color_monster_is_target = "#FF0000" or color_monster_is_target = "#FF8080" or color_monster_is_target = "#FFA500" or color_monster_is_target = "#FFFF88") {
						TargetMob := true
						isAttacking_Looter := true

						if (Buffed_Monster_PosY == A_Index) {
							if (Qtd_Buffed_Monster != CountMobs or CountMobs == 1) {
								Change_TargetMob := true
							}
							
						}
					}
					TargetMonsterY += 24
					color_BlackTargetLife := GetColorHex(X:=TargetMonsterX, Y:=TargetMonsterY)
				}
			}

			GuiControlGet, LureMonsterDropDownList
			if (CountMobs >= LureMonsterDropDownList OR Qtd_Buffed_Monster > 0) {
				if (State_StartAutoCombo != true) {
					GuiControlGet, Start_Combo_Delay
					SetTimer, AutoCombo, -%Start_Combo_Delay%
					State_StartAutoCombo := true
				}
			} else if (CountMobs == 0) {
				State_StartAutoCombo := false
			}

			if ( (TargetMob == false && State_StartAutoCombo == true) or (Change_TargetMob == true && CountMobs > 1) ) {
				Lootear()
				KeyWait, Control
				KeyWait, Shift
				ControlSend,, {Space}, %Client% ;ahk_group Tibia
				;~ MouseMove_And_Click(X:=Erro.2+26-6,Y:=Erro.3+101-6,Speed:=2,fix_coordinates:=true, Click:="Left",variation:=5)
				StartTime_AutoAttack := A_TickCount
			}

			if (State_StartAutoCombo == true) {
				RETURN, TRUE
			}

		}
		SetTimer, AutoCombo, OFF
		State_StartAutoCombo := false
		return, false
	}
	return, true
}
CaveBot_Action() {
GLOBAL
	Gui, Gui_CaveBot:Default
	Gui, ListView, ListView_Walker
	Gui Submit, NoHide	;ALL GUI CONTROL GET
	List_Number_Lines := LV_GetCount()	;numero de linhas da lista
	if List_Number_Lines is not number
		RETURN, FALSE

	GuiControlGet, WayPoint
	if ( WayPoint > List_Number_Lines) {
		GuiControl,, WayPoint, 1
		deSelect_AllLines_ListView()	;deseleciona todas as linhas
		LV_Modify(WayPoint, "+Select")	;seleciona celula step 1
		WalkerTentativas := 0
	} else {
		deSelect_AllLines_ListView()
		LV_Modify(WayPoint, "+Select")	;seleciona celula step atual
	}

	;[GET -> SLEEP AND ACTION]
	LV_GetText(Sleep_Walker,WayPoint,3)	;pega o texto da linha atual, coluna 3 (Sleep Walker)
	LV_GetText(LV_CaveBot_Action,WayPoint,2)	;pega o texto da linha 1, coluna 2 (Action)

	;[Click Map Action]
	if (InStr(LV_CaveBot_Action, "Click Map")) {
		Verify_Minimap()
		Click_Walk_Minimap()
	}

	;[Training Control Action]
	if (InStr(LV_CaveBot_Action, "Training Control")) {
		TrainingControl()
	}
}
Verify_Minimap() {
GLOBAL
	if( GetColorHex(Minimap.2+8, Minimap.3+8) != ColorHex_Validate_Minimap ) {
		SearchPNG(PNG.Minimap, 0,0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Minimap, Mode:=1,1)
		if (Minimap.1 == 1) { ;se encontrar
			ColorHex_Validate_Minimap := GetColorHex(Minimap.2+8, Minimap.3+8)	;[GET ColorHex Validate Minimap]

			Inicio_MiniMap_X := Minimap.2+1
			Inicio_MiniMap_Y := Minimap.3+19

			Final_MiniMap_X := Minimap.2+182

			SearchPNG(PNG.FooterMinimap, Minimap.2-4,Minimap.3, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, FooterMinimap, Mode:=1)
			if (FooterMinimap.1 == 1) { ;se encontrar
				Final_MiniMap_Y := FooterMinimap.3+10
			}
		}
	}

	if( GetColorHex(FooterMinimap.2+1, FooterMinimap.3+9) != ColorHex_Validate_FooterMinimap ) {
		SearchPNG(PNG.FooterMinimap, Minimap.2-4,Minimap.3, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, FooterMinimap, Mode:=1)
		if (FooterMinimap.1 == 1) { ;se encontrar
			ColorHex_Validate_FooterMinimap := GetColorHex(FooterMinimap.2+1, FooterMinimap.3+9)	;[GET ColorHex Validate Footer Minimap]
			Final_MiniMap_Y := FooterMinimap.3+10
		}
	}



}
Click_Walk_Minimap() {
GLOBAL
	if StartTime_WalkMinimap is not number
		StartTime_WalkMinimap := -99999
	ElapsedTime_WalkMinimap := A_TickCount - StartTime_WalkMinimap
	if (ElapsedTime_WalkMinimap > 500) {
		Verify_Minimap()
		Walk_To_Mark := SubStr(LV_CaveBot_Action, InStr(LV_CaveBot_Action, "(")+1, InStr(LV_CaveBot_Action, ")")-InStr(LV_CaveBot_Action, "(")-1)	;FORMAT STRING
		SearchPNG(PNG.Mark[Walk_To_Mark], Inicio_MiniMap_X,Inicio_MiniMap_Y, Final_MiniMap_X,Final_MiniMap_Y, Tole:=15, Mark, Mode:=1)
		if (Mark.1 == 1) {	;SE ENCONTRAR
			if (Mark.2 == lastPosition_Mark_X && Mark.3 == lastPosition_Mark_Y) {
				BlockInput, ON
				MouseMove_And_Click(X:=Mark.2+2,Y:=Mark.3+2,Speed:=2,fix_coordinates:=true, Click:="Left",variation:=0)
				BlockInput, OFF
			}
			lastPosition_Mark_X := Mark.2
			lastPosition_Mark_Y := Mark.3
			StartTime_WalkMinimap := A_TickCount
		} else {
			GuiControl,, WayPoint, % WayPoint+1	;goto next waypoint
		}
	}
}
Lootear(){
GLOBAL
	if (isAttacking_Looter == true) {
		KeyWait, Control
		KeyWait, Shift
		ControlSend,, {r}, %Client% ;ahk_group Tibia
		;~ Sleep 1100
		;~ ToolTip("Loteando...")
		;~ PrintScreenData()
		;~ Gdip_Haystack := Gdip_CreateBitmapFromHBITMAP(WindowInfo.HBITMAP)
		;~ Gdip_Needle := Gdip_CreateBitmapFromFile(A_WorkingDir "\images\DeadCyborg.png")
		;~ result := Gdip_ImageSearch(Gdip_Haystack,Gdip_Needle, outputVar, 687, 347, 687+222, 347+185, 43, Trans:="",SearchDirection:=1,Instances:=0)
		;~ Gdip_disposeImage(Gdip_Haystack)
		;~ Gdip_disposeImage(Gdip_Needle)
		;~ if (result > 0) {
			;~ outputVar := StrSplit(outputVar, "`n")
			;~ for i, monsterPos in outputVar {
				;~ DeadMonster := StrSplit(outputVar[i], ",")
				;~ MouseMove_And_Click(X:=DeadMonster[1],Y:=DeadMonster[2],Speed:=10,fix_coordinates:=true, Click:="Right",variation:=0)
				;~ Sleep 250
			;~ }
		;~ }
		isAttacking_Looter := false
	}
}
Change_Gold(){
GLOBAL
	if StartTime_ChangeGold is not number
		StartTime_ChangeGold := -99999
	ElapsedTime_ChangeGold := A_TickCount - StartTime_ChangeGold
	if (ElapsedTime_ChangeGold > 5*1000) {
		SearchPNG(PNG.PlatinumCoin, WindowInfo.ClassNN.w/1.5,0,WindowInfo.ClassNN.w,WindowInfo.ClassNN.h , Tole:=35, PlatinumCoin, Mode:=1)
		if (PlatinumCoin.1 == 1) {
			MouseMove_And_Click(X:=PlatinumCoin[2]+12,Y:=PlatinumCoin[3]+12,Speed:=2,fix_coordinates:=true, Click:="Right",variation:=5)
		}
		StartTime_ChangeGold := A_TickCount
	}
}

AutoCombo:
	; ControlSend,, {F5}, %Client% ;ahk_group Tibia
	if (state_Cavebot != true) {
		SetTimer, AutoCombo, OFF
	} else {
		SetTimer, AutoCombo, 200
	}
RETURN

TrainingControl() {
GLOBAL
	KeyWait, Control
	KeyWait, Shift
	if (PixelSearch(687,347, 222,185, "7FBCFF",5, outputvarX:="PoffX", outputvarY:="PoffY") == 0) {	;encontrou
		if StartTime_TrainingControl is not number
			StartTime_TrainingControl := A_TickCount
		ElapsedTime_TrainingControl := A_TickCount - StartTime_TrainingControl
		if (ElapsedTime_TrainingControl > 300) {
			ToolTip("x",Time:=-500,PosX:=PoffX+687,PosY:=PoffY+347,WhichToolTip:=20)

			if ( (PoffX > 103 && PoffX < 126) && (PoffY > 90 && PoffY < 127) ) {
				Send_Key(Key:="{Down}")
				StartTime_TrainingControl := A_TickCount
			}
			if (PoffX == 104 && PoffY == 0) {
				Send_Key(Key:="{Up}")
				StartTime_TrainingControl := A_TickCount
			}
			if ( PoffX == 60 && (PoffY > 28 && PoffY < 34) ) {
				Send_Key(Key:="{Left}")
				StartTime_TrainingControl := A_TickCount
			}
			if (PoffX >= 165 && PoffY >= 29) {
				Send_Key(Key:="{Right}")
				StartTime_TrainingControl := A_TickCount
			}
		}
		Tooltip % PoffX " , " PoffY
	}
 }
Send_Key(Key:=""){
GLOBAL
	KeyWait, Control
	KeyWait, Shift
	ControlSend,, %Key%, %Client% ;ahk_group Tibia
}
; ============================================================================== [ GUI ] ==============================================================================
; ============================================================================== [ GUI ] ==============================================================================
; ============================================================================== [ GUI ] ==============================================================================
WM_LBUTTONDOWN() {
	PostMessage, 0xA1, 2,,, A
}
Draw_LoginScreen(){
GLOBAL
	Gui, LoginScreen:New
	Gui, LoginScreen:+LabelMain_On
	GUIWidth := 300, GUIHeight := 100
	Gui, LoginScreen:Show, xCenter yCenter w%GUIWidth% h%GUIHeight%, %TrayName%	;NAME PROGRAMA

	Gui, LoginScreen:Color, 390202
	Gui, LoginScreen:Font, cWhite
	Gui, LoginScreen:Margin, 10, 10
	Gui, LoginScreen:+AlwaysOnTop

	Gui, Font, Bold
		Gui, Add, Text, SECTION x65 y20 w60 h20, PassKey:
		Gui, Font, cRed
			Gui, Add, Edit, xs+60 ys-2 w100 h20 Lowercase vPassKey, aroncalvanese
		Gui, Font, cWhite
		Gui, Add, Button, xs+50 ys+30 w60 h20 gValidatePasskey, LOGIN
	Gui, Font, Norm
		nmbr := 0
		Gui, Add, Progress, xs ys+55 w170 h20 vProgress_Bar, %nmbr%
		GuiControl,Hide,Progress_Bar


}
Draw_MainGui() {
GLOBAL
	Load_Images()		;LOAD GDIP IMAGES
	Load_Picture_GUI()	;LOAD GDIP PICTURES GUI
	Draw_Gui_CaveBot()	;DRAW GUI CAVEBOT

	GUIWidth := 791, GUIHeight := 766
	Gui, Gui_CaveBot:Show, xCenter yCenter w%GUIWidth% h%GUIHeight%, %TrayName%	;NAME PROGRAMA



	; [ Debugger ]
	Gui, Tab, Targeting
	Gui, Add, Button, x220 y483 w60 h15 gDebugger, Debugger
	Gui, Add, CheckBox, x5 y480 w130 h20 vCheckBox_HUD_ScreenBox, Show HUD ScreenBox
}
Draw_Gui_CaveBot() {
GLOBAL

	;[Create NEW GUI Loot Separator]
	Gui, Gui_CaveBot:New
	Gui, Gui_CaveBot:+LabelMain_On	;label Main_OnClose

	Gui, Gui_CaveBot:Color, 390202
	Gui, Gui_CaveBot:Font, cWhite
	Gui, Gui_CaveBot:Margin, 10, 10
	Gui, Gui_CaveBot:+AlwaysOnTop

	Gui, Add, Tab, x1 y1 w790 h765, Walker|Targeting|Utilities|Adv. Options

	;[Walker - Geral]
	if (true) {
		; TAB WALKER
		Gui, Tab, Walker
		AdminMode := 1
		Gui, Add, Button, x600 y30 w50 h20 gSave_Conf_Walker_GUI, Save
		Gui, Add, Button, x655 y30 w50 h20 gLoad_Conf_Walker_GUI, Load
		Gui, Add, Button, x710 y30 w50 h20 gReset_Conf_Walker_GUI, Reset

		Gui, Font, Bold
			Gui, Add, Text, section x610 y120 w100 h30 +Center, Hotkey to Start CaveBot:
			Gui, Add, Hotkey, xs+15 ys+30 w70 h20 vKey_Enable_Walker, Numpad0 ;%Key_Enable_Walker%

			Gui, Add, Text, x22 y39 w200 h20 +Center, Configure os Passos:
		Gui, Font, Normal


		Gui, Add, Button, x280 y50 w150 h30 gAdd_Step_Walker_GUI, Add Step

		Gui, Add, Text, x22 y72 w110 h20 , Selecione uma opcao:
		Gui, Add, DropDownList, x132 y69 w120 h20 r5 vDropDownList_Action Choose1 gChange_GUI_CaveBot, Click Map|Press Hotkey|Click On Coordinate|Training Control

		Gui, Add, Text, x22 y216 w200 h20 vText_Sleep_ClickMap, Quando Chegar na marca, esperar por:
		Gui, Add, DropDownList, x212 y213 w30 h20 r8 Choose1 vDropDownList_Sleep_Walker, 0|1|2|3|4|5|6|7
		Gui, Add, Text, x245 y216 w220 h20 vText_Sleep2_ClickMap, segundos antes de ir para o proximo passo.

		;[ List View - Walker ]
		Step := 0
		Gui, Font, Bold
		Gui, Add, GroupBox, x22 y279 w630 h480 , Configuracao Atual:
		Gui, Font, Normal
		Gui, Add, ListView, backgroundD4D0C8 cBlack grid hwndLV_Walker x27 y295 r20 w620 h455 +altsubmit gLV_Walker vListView_Walker, Step|Action|Delay|Others
		LV_SetSelColors(LV_Walker, 0x0096FF)
		LV_ModifyCol(1, 40)
		LV_ModifyCol(2, 220)
		LV_ModifyCol(3, 40)
		LV_ModifyCol(4, 318)

		Gui, Font, Bold
		Gui, Add, Text, x547 y268 w60 h15, Step Atual:
		Gui, Font, Normal
		Gui, Font, cRed
		Gui, Add, Edit, x611 y265 w25 h20 vWayPoint Number Limit4, 1
		Gui, Font, cWhite

		Gui, Add, Button, x655 y295 w50 h20 gUp_Step_Walker_GUI, Up
		Gui, Add, Button, x655 y317 w50 h20 gDown_Step_Walker_GUI, Down
		Gui, Add, Button, x655 y339 w50 h20 gDelete_Step_Walker_GUI, Delete
		Gui, Add, Button, x655 y361 w50 h20 gEdit_Step_Walker_GUI, Edit

		;Delay Action
		Gui, Font, Bold
		Gui, Add, Text, section x680 y700 w80 h20 Center, Delay Action:
		Gui, Font, Normal
		Gui, Font, cRed
		Gui, Add, Edit, xs+20 ys+20 w30 h20 vDelay_CaveBot Number Limit4, 250
		Gui, Font, cWhite
		Gui, Add, Text, xs+52 ys+24 w20 h20, ms.


	}

	;[Walker - ClickMap]
	if (true) {
		Gui, Add, GroupBox, x22 y99 w510 h110 vGroupBox_ClickMap, Escolha a marca do Mini Mapa que voce quer andar:
		Gui, Add, Text, x22 y242 w205 h20 vText_IgnoreMonster_ClickMap, Ignorar targeting quando chegar na marca:
		Gui, Add, DropDownList, x225 y240 w60 h20 r2 vDropDownList_IgnoreTargeting_Walker Choose2, TRUE|FALSE

		;[Mark - Picture]
		Gui, Add, Picture, x32 y119 w11 h11 +BackgroundTrans vPictureMark1, % "HBITMAP:* " Picture.Mark1
		Gui, Add, Picture, x82 y119 w11 h11 +BackgroundTrans vPictureMark2, % "HBITMAP:* " Picture.Mark2
		Gui, Add, Picture, x132 y119 w11 h11 +BackgroundTrans vPictureMark3, % "HBITMAP:* " Picture.Mark3
		Gui, Add, Picture, x182 y119 w11 h11 +BackgroundTrans vPictureMark4, % "HBITMAP:* " Picture.Mark4
		Gui, Add, Picture, x232 y119 w11 h11 +BackgroundTrans vPictureMark5, % "HBITMAP:* " Picture.Mark5
		Gui, Add, Picture, x282 y119 w11 h11 +BackgroundTrans vPictureMark6, % "HBITMAP:* " Picture.Mark6
		Gui, Add, Picture, x332 y119 w11 h11 +BackgroundTrans vPictureMark7, % "HBITMAP:* " Picture.Mark7
		Gui, Add, Picture, x382 y119 w11 h11 +BackgroundTrans vPictureMark8, % "HBITMAP:* " Picture.Mark8
		Gui, Add, Picture, x432 y119 w11 h11 +BackgroundTrans vPictureMark9, % "HBITMAP:* " Picture.Mark9
		Gui, Add, Picture, x482 y119 w11 h11 +BackgroundTrans vPictureMark10, % "HBITMAP:* " Picture.Mark10

		Gui, Add, Picture, x32 y174 w11 h11 +BackgroundTrans vPictureMark11, % "HBITMAP:* " Picture.Mark11
		Gui, Add, Picture, x82 y174 w11 h11 +BackgroundTrans vPictureMark12, % "HBITMAP:* " Picture.Mark12
		Gui, Add, Picture, x132 y174 w11 h11 +BackgroundTrans vPictureMark13, % "HBITMAP:* " Picture.Mark13
		Gui, Add, Picture, x182 y174 w11 h11 +BackgroundTrans vPictureMark14, % "HBITMAP:* " Picture.Mark14
		Gui, Add, Picture, x232 y174 w11 h11 +BackgroundTrans vPictureMark15, % "HBITMAP:* " Picture.Mark15
		Gui, Add, Picture, x282 y174 w11 h11 +BackgroundTrans vPictureMark16, % "HBITMAP:* " Picture.Mark16
		Gui, Add, Picture, x332 y174 w11 h11 +BackgroundTrans vPictureMark17, % "HBITMAP:* " Picture.Mark17
		Gui, Add, Picture, x382 y174 w11 h11 +BackgroundTrans vPictureMark18, % "HBITMAP:* " Picture.Mark18
		Gui, Add, Picture, x432 y174 w11 h11 +BackgroundTrans vPictureMark19, % "HBITMAP:* " Picture.Mark19
		Gui, Add, Picture, x482 y174 w11 h11 +BackgroundTrans vPictureMark20, % "HBITMAP:* " Picture.Mark20


		;[Mark - Radio Button]
		Gui, Add, Radio, x30 y132 w30 h12 Checked vRadio_Mark hwndRMark1, 1
		Gui, Add, Radio, x80 y132 w30 h12 hwndRMark2, 2
		Gui, Add, Radio, x130 y132 w30 h12 hwndRMark3, 3
		Gui, Add, Radio, x180 y132 w30 h12 hwndRMark4, 4
		Gui, Add, Radio, x230 y132 w30 h12 hwndRMark5, 5
		Gui, Add, Radio, x280 y132 w30 h12 hwndRMark6, 6
		Gui, Add, Radio, x330 y132 w30 h12 hwndRMark7, 7
		Gui, Add, Radio, x380 y132 w30 h12 hwndRMark8, 8
		Gui, Add, Radio, x430 y132 w30 h12 hwndRMark9, 9
		Gui, Add, Radio, x480 y132 w33 h12 hwndRMark10, 10

		Gui, Add, Radio, x30 y187 w33 h12 hwndRMark11, 11
		Gui, Add, Radio, x80 y187 w33 h12 hwndRMark12, 12
		Gui, Add, Radio, x130 y187 w33 h12 hwndRMark13, 13
		Gui, Add, Radio, x180 y187 w33 h12 hwndRMark14, 14
		Gui, Add, Radio, x230 y187 w33 h12 hwndRMark15, 15
		Gui, Add, Radio, x280 y187 w33 h12 hwndRMark16, 16
		Gui, Add, Radio, x330 y187 w33 h12 hwndRMark17, 17
		Gui, Add, Radio, x380 y187 w33 h12 hwndRMark18, 18
		Gui, Add, Radio, x430 y187 w33 h12 hwndRMark19, 19
		Gui, Add, Radio, x480 y187 w33 h12 hwndRMark20, 20
	}

	;[Walker - Press Hotkey]
	if (true) {
		Gui, Add, GroupBox, x22 y99 w510 h110 vGroupBox_PressHotkey, Escolha a Hotkey que voce quer pressionar:
		GuiControl, Hide, GroupBox_PressHotkey
		Gui, Add, Text, x32 y121 w40 h20 vText_PressHotkey, Hotkey:
		GuiControl, Hide, Text_PressHotkey
		Gui, Add, Hotkey, x72 y119 w60 h20 vHotkey_Walker_PressHotkey
		GuiControl, Hide, Hotkey_Walker_PressHotkey
	}

	;[Walker - Click On Coordinate]
	if (true) {
		Gui, Add, GroupBox, x22 y99 w510 h110 vGroupBox_ClickOnCoord, Escolha a Coordenada que voce quer clicar:
		GuiControl, Hide, GroupBox_ClickOnCoord
		Gui, Add, Text, x32 y121 w60 h20 vText_ClickOnCoord, Coordinate:
		GuiControl, Hide, Text_ClickOnCoord
		Gui, Add, Button, x92 y119 w120 h20 gButton_ClickOnCoord_GetCoord vButton_ClickOnCoord, > Get Coordinate <
		GuiControl, Hide, Button_ClickOnCoord

		Gui, Add, Text, x50 y148 w15 h20 vText_ClickOnCoord_X, X=
		GuiControl, Hide, Text_ClickOnCoord_X
		Gui, Font, cRed
			Gui, Add, Edit, x65 y145 w45 h20 vEdit_ClickOnCoord_X, 1234
			GuiControl, Hide, Edit_ClickOnCoord_X
		Gui, Font, cWhite

		Gui, Add, Text, x130 y148 w15 h20 vText_ClickOnCoord_Y, Y=
		GuiControl, Hide, Text_ClickOnCoord_Y
		Gui, Font, cRed
			Gui, Add, Edit, x145 y145 w45 h20 vEdit_ClickOnCoord_Y, 1234
			GuiControl, Hide, Edit_ClickOnCoord_Y
		Gui, Font, cWhite

		Gui, Add, Text, x32 y183 w65 h20 vText_ClickOnCoord_MouseType, Mouse Type:
		GuiControl, Hide, Text_ClickOnCoord_MouseType
		Gui, Add, DropDownList, x97 y181 w55 h20 r5 Choose1 vDropDownList_ClickOnCoord_MouseType, Left|Right
		GuiControl, Hide, DropDownList_ClickOnCoord_MouseType
	}

	;[Walker - if Cap]
	if (true) {
		Gui, Add, GroupBox, x22 y99 w510 h110 vGroupBox_ifCap, Se o Cap:
			GuiControl, Hide, GroupBox_ifCap
		Gui, Add, Text, section x32 y121 w125 h20 vText_ifCap, Se o Cap for maior que:
		Gui, Add, Text, x195 y121 w80 h20 vText2_ifCap, vᠰara o Step:
			GuiControl, Hide, Text_ifCap
			GuiControl, Hide, Text2_ifCap
		Gui, Font, cRed
		Gui, Add, Edit, x145 y119 w40 h20 vEdit_ifCap Number Limit5, 1000
		Gui, Add, Edit, x270 y119 w30 h20 vEdit2_ifCap Number Limit3, 1
			GuiControl, Hide, Edit_ifCap
			GuiControl, Hide, Edit2_ifCap
		Gui, Font, cWhite

		;~ Gui, Add, Text, section xs w155 h20 vText3_ifCap, Backpack esta com imbuiment?
		;~ Gui, Add, DropDownList, xs+160 ys-2 w45 h20 vBP_Imbuiment_ifCap r2 Choose2, Yes|No
			GuiControl, Hide, Text3_ifCap
			GuiControl, Hide, BP_Imbuiment_ifCap
	}

	;[Targeting]
	if (true) {
		;====[Targeting]====
		Gui, Tab, Targeting
		Gui, Add, GroupBox, x12 y29 w260 h180 , Targeting
		Gui, Add, CheckBox, x22 y55 w80 h20 Checked vCheckBox_AutoAttack, Auto Attack
		Gui, Add, Text, x22 y89 w90 h20, Attack only if have
		Gui, Add, DropDownList, x112 y87 w35 h21 r8 vLureMonsterDropDownList Choose1, 1|2|3|4|5|6|7|8
		Gui, Add, Text, x150 y89 w55 h20, Monster(s)
		Gui, Add, Text, x21 y115 w150 h20, Stop attacking when have
		Gui, Add, DropDownList, x148 y112 w35 h21 r8 vStopAttackWhenHave Choose1, 0|1|2|3|4|5|6|7
		Gui, Add, Text, x185 y115 w55 h20, Monster(s)

		;Start Combo
		Gui, Add, CheckBox, x22 y145 w110 h20 vStart_Combo_CheckBox, Start Combo After:
	Gui, Font, cRed
		Gui, Add, Edit, x132 y145 w40 h20 vStart_Combo_Delay Number Limit4 Right, 2500
	Gui, Font, cWhite
		Gui, Add, Text, x173 y149 w12 h20, ms

		;Loot When Change Targeting
		Gui, Add, CheckBox, x22 y170 w170 h20 vCheckBox_LootWhenChangeTargeting, Loot When Change Targeting
	}

	;[Utilities]
	if (true) {
		; ==== [List View - Save & Load] ====
		Gui, Tab, Utilities
		Gui, Gui_CaveBot:Font, cWhite


		;[IF PLAYER NOT ON SCREEN]
		Gui, Add, GroupBox, x140 y119 w230 h75 +Center, if Player NOT on Screen ;GROUPBOX
			Gui, Add, CheckBox, x150 y139 w110 h20 vCheckBox_Message_Not_PlayerOnScreen, PRESS HOTKEY:
			Gui, Add, Hotkey, x260 y139 w70 h20 vHotkey_Message_Not_PlayerOnScreen,
			Gui, Add, Text, x155 y161 w100 h20 +Right, Delay:
		Gui,Font,cRed
			Gui, Add, Edit, x260 y159 w50 h20 +Right Number vDelay_Message_Not_PlayerOnScreen, 10
		Gui,Font,cWhite
			Gui, Add, Text, x311 y163 w25 h15, seg.

			;[Change Attack Mode]
		Gui, Add, GroupBox, x140 y29 w350 h90 +Center, if Player on Screen ;GROOUP BOX
			Gui, Add, CheckBox, x150 y50 w150 h20 vCheckBox_ChangeAttackMode, Change to Follow Attack
			Gui, Add, CheckBox, x150 y70 w185 h20 vCheckBox_StopCombo_AntiRed, Change to Combo PvP (Anti-Red)
			Gui, Add, CheckBox, x150 y90 w130 h20 vCheckBox_StopAttack_AntiRed, Stop Attack (Anti-Red)

			Gui, Add, CheckBox, x340 y50 w130 h20 vCheckBox_NextWayPoint_PlayerScreen, Goto Next WayPoint
			Gui, Add, CheckBox, x340 y70 w130 h20 vCheckBox_GotoProtectZone, Goto ProtectZone
			;~ Gui, Add, CheckBox, x340 y90 w130 h20 vCheckBox_Deslogar_PlayerScreen, Goto SafeZone

		;[Change Gold]
		Gui, Add, GroupBox, section x575 y29 w120 h170 +Center, Change Gold
		Gui, Add, CheckBox, xs+25 ys+15 w65 h20 vCheckBox_ChangeGold, ENABLE
		Gui, Add, Picture, xs+42 ys+50 w32 h32, % "HBITMAP:* " Picture.GoldConverter
		Gui, Add, Text, xs+25 ys+85 w65 h25 +Center, Hotkey Gold Converter:
		Gui, Add, Hotkey, xs+25 ys+112 w70 h20 vHotkey_GoldConverter

		Portugues := "Utilize Hotkey apenas se necessario"
		English := "Use Hotkey only if necessary"
		Gui, Add, Text, xs+5 ys+135 w110 h30 +Center, % %GlobalLanguage%

	}

	;[Adv. Options]
	if (true) {
		;====[Adv. Options]=====
		Gui, Tab, Adv. Options

		Gui, Add, CheckBox, x12 y30 w180 h20 vCheckBox_Show_HUD_CaveBot_Status, Show HUD CaveBot Status


		;TARGETING E WALKER CONFIGS
		Gui, Add, GroupBox, section x10 y50 w300 h170 Center, CaveBot Settings

		Gui, Add, Text, xs+5 ys+17 w135 h20 Center, Total Time Stuck Targeting:
			Gui, Add, Picture, xs+223 ys+20 Hwnd_IdStuckTargeting, % "HBITMAP:* " Picture.interrogacao

		Gui, Add, Text, xs+5 ys+42 w135 h20 Center, Total Attempt Target:
			Gui, Add, Picture, xs+217 ys+45 Hwnd_IdAttemptTarget, % "HBITMAP:* " Picture.interrogacao

		Gui, Add, Text, xs+5 ys+67 w135 h20 Center, Total Attempt Walker:
			Gui, Add, Picture, xs+217 ys+70 Hwnd_IdAttemptWalker, % "HBITMAP:* " Picture.interrogacao

		Gui, Add, Text, xs+5 ys+92 w135 h20 Center, Attempt to Check Trap:
			Gui, Add, Picture, xs+217 ys+95 Hwnd_IdAttemptCheckTrap, % "HBITMAP:* " Picture.interrogacao

		Portugues := "Maximo de Voltas:"
		English := "Maximum of Laps:"
		Gui, Add, Text, xs+5 ys+117 w135 h20 Center, % %GlobalLanguage%
			Gui, Add, Picture, xs+217 ys+120 Hwnd_IdMaximumLaps, % "HBITMAP:* " Picture.interrogacao

		Gui, Font, cRed
			Gui, Add, Edit, xs+140 ys+15 w35 h20 vTotal_Time_Stuck_Targeting Number Limit5, 90
			Gui, Add, Edit, xs+140 ys+40 w35 h20 vTotal_Attempt_Target Number Limit5, 0
			Gui, Add, Edit, xs+140 ys+65 w35 h20 vTotal_Attempt_Walker Number Limit5, 0
			Gui, Add, Edit, xs+140 ys+90 w35 h20 vTime_to_Check_Trap Number Limit5, 5
			Gui, Add, Edit, xs+140 ys+115 w35 h20 vCaveBot_MaxNumeroDeVoltas Number Limit5, 0
		Gui, Font, cWhite

			Gui, Add, Text, xs+175 ys+21 w45 h15, seconds.
			Gui, Add, Text, xs+175 ys+46 w40 h15, attempt.
			Gui, Add, Text, xs+175 ys+70 w40 h15, attempt.
			Gui, Add, Text, xs+175 ys+96 w40 h15, attempt.
			Gui, Add, Text, xs+175 ys+121 w40 h15, attempt.


		Portugues	:= "OBS: se o valor for = 0, a funcao esta desabilitada"
		English 	:= "NOTE: if the value is = 0, the function is disabled"
		Gui, Font, Bold
			Gui, Add, Text, xs+10 ys+145 w295 h20, % %GlobalLanguage%
		Gui, Font, Norm

		;ESC BUTTON
		Gui, Add, CheckBox, section x12 y240 w150 h20 vPress_Esc_Cavebot_CheckBox, Press ESC before attack
			GuiControl,, Press_Esc_Cavebot_CheckBox, 1
		Gui, Add, Text, xs+10 ys+23 w45 h20, Delay:
		Gui, Font, cRed
			Gui, Add, Edit, xs+45 ys+20 w40 h20 vSleep_Press_ESC Number, 150
		Gui, Font, cWhite
		Gui, Add, Text, xs+86 ys+24 w20 h15, ms.

		;Priority 9º Monster on Battle
		Gui, Add, CheckBox, section x12 y310 w53 h20 vPriority_Monster_CheckBox, Priority	;Priority Monster On Battle
		Gui, Add, DropDownList, xs+53 ys w30 h20 r9 vPriority_Number_Position_DropDownList Choose9, 1|2|3|4|5|6|7|8|9
		Gui, Add, Text, xs+84 ys+3 w120 h20, Monster On Battle List



	}

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

;  [ GUI LABEL]
Debugger:
	TibiaDeBug()
RETURN

; ======== Functions ========
ToolTip(Text,Time:=-500,PosX:="",PosY:="",WhichToolTip:=20){
GLOBAL
	;[WhichToolTip Map]
	; 1 = all

	if ( WinActive(Client) ) {
		Tooltip, %Text%, %PosX%, %PosY%, %WhichToolTip%
		SetTimer, RemoveToolTip%WhichToolTip%, %Time%
		List_State_ToolTip[WhichToolTip] := 1
	}
}
Verify_Items() {
GLOBAL
EXIT
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
	GuiControlGet, CheckBox_Enable_Healing_Life
	GuiControlGet, CheckBox_Healing_Life_UseUH
	UHx -= WindowInfo.ClassNN.x	;FIX COORDINATES WINDOW TO CLIENT
	UHy -= WindowInfo.ClassNN.y	;FIX COORDINATES WINDOW TO CLIENT
	Color_UH := GetColorHex(UHx, UHy)
	if (CheckBox_Healing_Life_UseUH == true	&& CheckBox_Enable_Healing_Life == true
	&& Color_UH != "#47ACD5") {
		SearchPNG(PNG.UH, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, UH, Mode:=1)
		if (UH.1 == 0) { ;NAO ENCONTROU
			ToolTip(Text:="[Supply] UH Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
			Have_UH := false
		} else if (UH.1 == 1) { ;SIM ENCONTROU
			Have_UH := true
		} else if (ErrorLevel = 2) {
			ToolTip(Text:="[ERROR] PNG UH Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
			Have_UH := false
		}
	}

	;[HMM]
	;~ PixelGetColor, Color_HMM, % HMMx, % HMMy, Fast RGB
	;~ Color_HMM := GetColorHex(HMMx, HMMy)
	;~ if (Color_HMM != "0xAA5BE0" && false) {
		;~ ImageSearch, HMMx, HMMy, 0,0, A_ScreenWidth, A_ScreenHeight, *25, Imagens\HMM.png
		;~ if (ErrorLevel = 1) { ;NAO ENCONTROU
			;~ ToolTip(Text:="[Supply] HMM Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
			;~ Have_HMM := false
		;~ } else if (ErrorLevel = 0) { ;SIM ENCONTROU
			;~ Have_HMM := true
		;~ } else if (ErrorLevel = 2) {
			;~ ToolTip(Text:="[ERROR] PNG UH Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
			;~ Have_HMM := false
		;~ }
	;~ }
}
Use_Item_On(state:="", PosX:="", PosY:="") {
GLOBAL
	switch State {
		case "YourSelf":
			;~ BlockInput, On
			MouseGetPos, StartX, StartY
			Click, %PosX% %PosY% Right
			;~ Sleep 50
			Click, %CharacterCoordX% %CharacterCoordX%
			MouseMove, %StartX%, %StartY%
			;~ BlockInput, Off
			RETURN
		case "CrossHair":
			;~ BlockInput, On
			MouseGetPos, StartX, StartY
			Click, %PosX% %PosY% Right
			;~ Sleep 50
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
	KeyWait, %Key%
	GuiControlGet, %Key%, %Tab%
	if (%Key% != "") {
		HotkeyControlSend := fix_Hotkey_to_ControlSend(%Key%)
		ControlSend,, %HotkeyControlSend%, %Client% ;ahk_group Tibia
	}
}
MouseMove_And_Click(X,Y,Speed:=2,fix_coordinates:=true, Click:="Left",variation:=5){
GLOBAL
	KeyWait, Control
	KeyWait, Shift
	If not WinActive(Client) {
		ActiveHwnd := WinExist("A")
		WinActivate, % Client
	}

	;randomize click
	Random, rand_X, -%variation%, %variation%
	Random, rand_Y, -%variation%, %variation%


	;~ BlockInput, ON
	MouseGetPos, StartX, StartY
	if (fix_coordinates == true) {
		X := Round( X*(A_ScreenDPI/96) ) + rand_X
		Y := Round( Y*(A_ScreenDPI/96) ) + rand_Y

		MouseMove, % X + WindowInfo.ClassNN.x, % Y + WindowInfo.ClassNN.y, % Speed
	} else {
		MouseMove, % X + rand_X, % Y + rand_Y, % Speed
	}
	Sleep 55
	ControlClick,, %Client%,, % Click
	;~ Click %Click%
	Sleep 55
	MouseMove, % StartX, % StartY
	;~ BlockInput, OFF

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
ControlClick(X,Y,WhichButton:="LEFT",fix_coordinates:=true,ghost_mouse:=true,state:="") {
GLOBAL
	;~ KeyWait, Control
	;~ KeyWait, Shift

	if (fix_coordinates == true) {

		if (ghost_mouse == true) {
			SendMode, Input
			ControlClick, % "x" X + WindowInfo.ClassNN.x " y" Y + WindowInfo.ClassNN.y, %Client%,, %WhichButton%,, %state% NA
		} else {
			MouseGetPos, StartX, StartY
			SendMode, Event
			Click, % X+WindowInfo.ClassNN.x " " Y+WindowInfo.ClassNN.y " " state " " WhichButton
			;~ MouseClick, %WhichButton%, %X%, %Y%, ClickCount:=1, Speed:=100, %state%
			if (TibiaServer == "Global") {
				GuiControlGet, Delay_PressHotkey, Extras:
				Sleep %Delay_PressHotkey%
			}
			MouseMove, %StartX%, %StartY%
		}

	} else {
		if (ghost_mouse == true) {
			SendMode, Input
			ControlClick, % "x" X " y" Y, %Client%,, %WhichButton%,, %state% NA
		} else {
			MouseGetPos, StartX, StartY
			SendMode, Event
			Click, % X " " Y " " state " " WhichButton
			;~ MouseClick, %WhichButton%, %X%, %Y%, ClickCount:=1, Speed:=100, %state%
			if (TibiaServer == "Global") {
				GuiControlGet, Delay_PressHotkey, Extras:
				Sleep %Delay_PressHotkey%
			}
			MouseMove, %StartX%, %StartY%
		}
	}
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

; ======== TOOLTIP=========
RemoveToolTip01:
RemoveToolTip02:
RemoveToolTip03:
RemoveToolTip04:
RemoveToolTip05:
RemoveToolTip06:
RemoveToolTip07:
RemoveToolTip08:
RemoveToolTip09:
RemoveToolTip10:
RemoveToolTip11:
RemoveToolTip12:
RemoveToolTip13:
RemoveToolTip18:
RemoveToolTip19:
RemoveToolTip20:
	ToolTip,,,, % SubStr(A_ThisLabel, -1)
	SetTimer, % "RemoveToolTip" SubStr(A_ThisLabel, -1), Off
	List_State_ToolTip[SubStr(A_ThisLabel, -1)] := 0	;RESETA O STATE TOOLTIP DELAY
return

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
	Gui, %GuiName%: +alwaysontop -Caption +Border +ToolWindow +LastFound
	Gui, %GuiName%: Color, %Color%
	WinSet, Transparent, %Transparent%
	Gui, %GuiName%: Show, w%widthh% h%heightt% x%PosX% y%PosY% NoActivate, %GuiName%
}
GetPixelHP%:
Gui, HUD_GetPixelHP:Destroy
Hide_All_GUI(state:="Hide")
	;[Healing HP% Coordinates] = Configure Coordinates
	Loop, {
		TOOLTIP, Clique no HP`% que devera usar SPELL...
		If WinActive(Client) {
			if (GetKeyState("LButton", "P")) {
				MouseGetPos, Coord_HPx, Coord_HPy
				PixelGetColor, Color_HP, %Coord_HPx%, %Coord_HPy%, Fast RGB
				Color_HP := RegExReplace(Color_HP, "0x", "0xFF")
				Draw_Rectangle_OnPicture(color:=Color_HP, PosX:=0,PosY:=0, widthh:=20,heightt:=20, GuiTab:="Main",PictureVar:="MyPicLife")
				HUD_ScreenBox(GuiName:="HUD_GetPixelHP",PosX:=Coord_HPx, PosY:=Coord_HPy, widthh:=6,heightt:=8, Color:="Green",Transparent:=255)
				TOOLTIP
				Send, {LButton Up}
				BREAK
			}
		}
	}
Hide_All_GUI(state:="Show")
RETURN

GetCharacterCoord:
	Get_Coord_Mouse(VarName:="CharacterPosition", HUDcolor:="Red",Transparent:=80)
RETURN
asdf:
Hide_All_GUI(state:="Hide")
	;[Character Coordinates] = Configure Coordinates
	Loop, {
		TOOLTIP, Clique no seu CHARACTER para capturar a coordenada...
		If WinActive(Client) {
			if (GetKeyState("LButton", "P")) {
				MouseGetPos, CharacterCoordX, CharacterCoordY
				GuiControl,, CharacterCoordX, % "X = "CharacterCoordX	;imprime na GUI o valor de CharacterCoordX
				GuiControl,, CharacterCoordY, % "Y = "CharacterCoordY	;imprime na GUI o valor de CharacterCoordX
				HUD_ScreenBox(GuiName:="HUD_CharacterCoord",PosX:=CharacterCoordX, PosY:=CharacterCoordY, widthh:=20,heightt:=20, Color:="Red",Transparent:=80)
				TOOLTIP
				Send, {LButton Up}
				BREAK
			}
		}
	}
Hide_All_GUI(state:="Show")
RETURN

GetPixelMP%:
Gui, HUD_GetPixelMP:Destroy
Hide_All_GUI(state:="Hide")
	;[ManaFluid MP% Coordinates] = Configure Coordinates
	Loop, {
		TOOLTIP, Clique no MP`% que devera usar ManaFluid...
		If WinActive(Client) {
			if (GetKeyState("LButton", "P")) {
				MouseGetPos, Coord_MPx, Coord_MPy
				PixelGetColor, Color_MP, %Coord_MPx%, %Coord_MPy%, Fast RGB
				Color_MP_Gdip := RegExReplace(Color_MP, "0x", "0xFF")
				Draw_Rectangle_OnPicture(color:=Color_MP_Gdip, PosX:=0,PosY:=0, widthh:=20,heightt:=20, GuiTab:="Main",PictureVar:="MyPicMana")
				HUD_ScreenBox(GuiName:="HUD_GetPixelMP",PosX:=Coord_MPx, PosY:=Coord_MPy, widthh:=6,heightt:=8, Color:="Green",Transparent:=255)
				TOOLTIP
				Send, {LButton Up}
				BREAK
			}
		}
	}
Hide_All_GUI(state:="Show")
RETURN


; RUNEMAKER
GetCoord_EatFood:
	Get_Coord_Mouse(VarName:="EatFood", HUDcolor:="Blue",Transparent:=180)
RETURN
GetPixel_MP_CastRune:
	Get_Coord_And_Color(VarName:="MP_CastRune",GuiTab:="Main",HUDcolor:="Green")
RETURN


Exit:
Main_OnClose:
	Gdip_shutdown(pToken)
EXITAPP
ForcePauseScript:
	Pause
RETURN



; ==================================================================================== [ Login Stub ] =========================================================================================
; License validation / remote passkey API removed in open-source release.
; Kept as a no-op stub so the pre-existing login GUI still advances to the main UI.
ValidatePasskey:
	FormatTime, DataDeHoje,, yyyyMMdd
	Gui, LoginScreen:Destroy
	Draw_MainGui()
RETURN

; ==================================================================================== [ Print Screen ] =========================================================================================
; ==================================================================================== [ Print Screen ] =========================================================================================
; ==================================================================================== [ Print Screen ] =========================================================================================
; ==================================================================================== [ Print Screen ] =========================================================================================
PrintScreenData(){
GLOBAL
	FindProcessesID := Client	;Client	;tibia client
	PrintScreenDC()
	;~ PrintScreenPW()
}
PrintScreenPW(){
GLOBAL
      static PWWinID, WinTitle, WinX, WinY, WinW, WinH, ClientWidth, ClientHeight, Area, hBitmap
      if ( !WinID && FindProcessesID ) {
            WinID := WinExist(FindProcessesID)
            PWWinID := WinID
            WinExist( GameInfo )
            WinGetClass, WindowClass
            WinGet , WinExE, ProcessName
            Process, Exist , %WinExE%
            WinGetTitle, WindowTitle
            WindowInfo:={ID: WinID, Title: WindowTitle, Class: WindowClass, IDClassNN: WinID, Exe: WinExE, pID: errorlevel}
            Area := DllCall("CreateCompatibleDC","Ptr",0,"Ptr")
      }
      if !WinExist( "ahk_id" PWWinID ) {
			MsgBox, % "Game Not Found"
			Name_Haystack := ""
			WinTitle := ""
			WinID := ""
			;~ gosub, StartScripts
            EXITAPP
      }
      WinGetTitle, WindowTitle
      WinGetPos, GetWinX, GetWinY, GetWinW, GetWinH
      if (WindowTitle != WinTitle || GetWinX != WinX || GetWinY != WinY || GetWinW != WinW || GetWinH != WinH ) {
            If (WindowTitle != WinTitle){
                  NewName := StrSplit(WindowTitle, "-")
                  If (NewName.2)
                  NewName := Trim(NewName.2)
                  Else
                  NewName := WindowTitle
                  GuiControl, Main:, WindowTitle, %NewName%
                  WindowInfo.Title  := NewName
            }
            WinTitle:=WindowTitle, WinX:=GetWinX, WinY:=GetWinY, WinW:=GetWinW, WinH:=GetWinH
            VarSetCapacity(rect,16), DllCall("GetClientRect","Ptr",PWWinID,"Ptr",&rect), ClientWidth := NumGet(rect,8,"int"), ClientHeight := NumGet(rect,12,"int")
            DllCall("DeleteObject", "Ptr",hBitmap),VarSetCapacity(bi,40,0),NumPut(40,bi,0,"int"),NumPut(ClientWidth,bi,4,"int"),NumPut(-ClientHeight,bi,8,"int"),NumPut(1,bi,12,"short"),NumPut(32,bi,14,"short")
            hBitmap := DllCall("CreateDIBSection","Ptr",0,"Ptr",&bi,"int",0,"Ptr*",PrintScan,"Ptr",0,"int",0,"Ptr")
            DllCall("SelectObject","Ptr",Area,"Ptr",hBitmap,"Ptr")
            ScanBit := PrintScan
            StrideBit := ClientWidth*4
            PNGScanWidth := ClientWidth
            PNGScanHeight := ClientHeight
            WindowInfo.HBITMAP:= hBitmap
            WindowInfo.Window :={x: WinX , y: WinY, w: WinW, h: WinH}
            WindowInfo.Client :={w: ClientWidth, h: ClientHeight}
            WindowInfo.ClassNN:={x: Round((WinW-ClientWidth)/2), y: Round(WinH-ClientHeight-(WinW-ClientWidth)/2), w: ClientWidth, h: ClientHeight}
      }
DllCall("PrintWindow","Ptr",PWWinID,"Ptr",Area,"int",1)
Return
}
PrintScreenDC(){
GLOBAL
      static DCWinID, WinTitle, WinX, WinY, WinW, WinH, ClientWidth, ClientHeight, Area, hBitmap
      if ( !WinID && FindProcessesID ) {
            WinID := WinExist(FindProcessesID)
            DCWinID := WinID
            WinExist( GameInfo )
            WinGetClass, WindowClass
            WinGet , WinExE, ProcessName
            Process, Exist , %WinExE%
            WinGetTitle, WindowTitle
            WindowInfo:={ID: WinID, Title: WindowTitle, Class: WindowClass, IDClassNN: WinID, Exe: WinExE, pID: errorlevel}
            Area := DllCall("CreateCompatibleDC","Ptr",0,"Ptr")
      }
      if !WinExist( "ahk_id" DCWinID ) {
            MsgBox, % "Game Not Found"
			Name_Haystack := ""
			WinTitle := ""
			WinID := ""
			;~ gosub, StartScripts
            EXIT
      }
      WinGetTitle, WindowTitle
      WinGetPos, GetWinX, GetWinY, GetWinW, GetWinH
      if (WindowTitle != WinTitle || GetWinX != WinX || GetWinY != WinY || GetWinW != WinW || GetWinH != WinH ) {
            If (WindowTitle != WinTitle){
                  NewName := StrSplit(WindowTitle, "-")
                  If (NewName.2)
                  NewName := Trim(NewName.2)
                  Else
                  NewName := WindowTitle
                  GuiControl, Main:, WindowTitle, %NewName%
                  WindowInfo.Title  := NewName
            }
            WinTitle:=WindowTitle, WinX:=GetWinX, WinY:=GetWinY, WinW:=GetWinW, WinH:=GetWinH
            VarSetCapacity(rect,16), DllCall("GetClientRect","Ptr",DCWinID,"Ptr",&rect), ClientWidth := NumGet(rect,8,"int"), ClientHeight := NumGet(rect,12,"int")
            DllCall("DeleteObject", "Ptr",hBitmap),VarSetCapacity(bi,40,0),NumPut(40,bi,0,"int"),NumPut(ClientWidth,bi,4,"int"),NumPut(-ClientHeight,bi,8,"int"),NumPut(1,bi,12,"short"),NumPut(32,bi,14,"short")
            hBitmap := DllCall("CreateDIBSection","Ptr",0,"Ptr",&bi,"int",0,"Ptr*",PrintScan,"Ptr",0,"int",0,"Ptr")
            DllCall("SelectObject","Ptr",Area,"Ptr",hBitmap,"Ptr")
            ScanBit := PrintScan
            StrideBit := ClientWidth*4
            PNGScanWidth := ClientWidth
            PNGScanHeight := ClientHeight
            WindowInfo.HBITMAP:= hBitmap
            WindowInfo.Window :={x: WinX , y: WinY, w: WinW, h: WinH}
            WindowInfo.Client :={w: ClientWidth, h: ClientHeight}
            WindowInfo.ClassNN:={x: Round((WinW-ClientWidth)/2), y: Round(WinH-ClientHeight-(WinW-ClientWidth)/2), w: ClientWidth, h: ClientHeight}
      }
      hDC := DllCall("GetDC","Ptr",DCWinID,"Ptr",0,"int",0)
      DllCall(ProcBitBlt,"Ptr",Area,"int",0,"int",0,"int",ClientWidth,"int",ClientHeight,"Ptr",hDC,"int",0,"int",0,"uint",0xCC0020)
      DllCall("DeleteDC","Ptr",hDC)
Return
}
TibiaDeBug(){
GLOBAL
PrintScreenData()
DllCall(ProcCreateBitmap, "Ptr", WindowInfo.HBITMAP, "Ptr", 0, "Ptr*", NewBitmap)
Gdip_SaveBitmapToFile(NewBitmap, "DeBug.png")
Debugger_hBitmap := Gdip_CreateHBITMAPFromBitmap(NewBitmap)
DllCall(ProcDisposeImage, "Ptr", NewBitmap)

MsgBox, 4096, DeBug, % "`VersionType:`t " VersionType "`nTitle:`t " WindowInfo.Title "`nExe:`t " WindowInfo.Exe "`nClass:`t " WindowInfo.Class "`nIDClassNN: " WindowInfo.IDClassNN "`nID:`t " WindowInfo.ID "`npID:`t " WindowInfo.pID "`nWindow:`t x" WindowInfo.Window.x "`t y" WindowInfo.Window.y "`tw" WindowInfo.Window.w "`th" WindowInfo.Window.h "`nClassNN:`t x" WindowInfo.ClassNN.x "`t y" WindowInfo.ClassNN.y "`tw" WindowInfo.ClassNN.w "`th" WindowInfo.ClassNN.h "`nClient:`t w" WindowInfo.Client.w "`t h" WindowInfo.Client.h "`nLoot:`t x:" SQTLoot.1.x " y" SQTLoot.1.y " SQM: " SQTLoot.SQT

Gui, Debugger:New
Gui, Debugger:+AlwaysOnTop
Gui, Debugger:Add, Picture, x5 y5, % "HBITMAP:* " Debugger_hBitmap
Gui, Debugger:Show, AutoSize

Gui, Gui_CaveBot:Default

}
LoadGDIplus(){
GLOBAL
VarSetCapacity(startInput, A_PtrSize = 8 ? 24 : 16, 0)
startInput := Chr(1)
HModuleGdip := DllCall("LoadLibrary", "Str", "gdiplus", "Ptr")
DllCall("gdiplus\GdiplusStartup", "Ptr*", pToken, "Ptr", &startInput, "Ptr", 0)
ProcBitBlt := DllCall("GetProcAddress", "Ptr", DllCall("GetModuleHandle", "Str", "gdi32", "Ptr"), "AStr", "BitBlt", "Ptr")
ProcCreateBitmap := DllCall("GetProcAddress", "Ptr", HModuleGdip, "AStr", "GdipCreateBitmapFromHBITMAP", "Ptr")
ProcBitmapLock := DllCall("GetProcAddress", "Ptr", HModuleGdip, "AStr", "GdipBitmapLockBits", "Ptr")
ProcBitmapUnlock := DllCall("GetProcAddress", "Ptr", HModuleGdip, "AStr", "GdipBitmapUnlockBits", "Ptr")
ProcDisposeImage := DllCall("GetProcAddress", "Ptr", HModuleGdip, "AStr", "GdipDisposeImage", "Ptr")
Ptr := A_PtrSize ? "UPtr" : "UInt"
PtrA := Ptr . "*"
MCode_ImageSearch := "8b44243883ec205355565783f8010f857a0100008b7c2458897c24143b7c24600f8db50b00008b44244c8b5c245c8b4c24448b7424548be80fafef896c242490897424683bf30f8d0a0100008d64240033c033db8bf5896c241c895c2420894424183b4424480f8d0401000033c08944241085c90f8e9d0000008b5424688b7c24408beb8d34968b54246403df8d4900b803000000803c18008b442410745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424108b7c24408b4c24444083c50483c30483c604894424103bc17c818b5c24208b74241c0374244c8b44241840035c24508974241ce92dffffff8b6c24688b5c245c8b4c244445896c24683beb8b6c24240f8c06ffffff8b44244c8b7c24148b7424544703e8897c2414896c24243b7c24600f8cd5feffffe96b0a00008b4424348b4c246889088b4424388b4c24145f5e5d890833c05b83c420c383f8020f85870100008b7c24604f897c24103b7c24580f8c310a00008b44244c8b5c245c8b4c24448bef0fafe8f7d8894424188b4424548b742418896c24288d4900894424683bc30f8d0a0100008d64240033c033db8bf5896c2420895c241c894424243b4424480f8d0401000033c08944241485c90f8e9d0000008b5424688b7c24408beb8d34968b54246403df8d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c241c8b7424200374244c8b44242440035c245089742420e92dffffff8b6c24688b5c245c8b4c244445896c24683beb8b6c24280f8c06ffffff8b7c24108b4424548b7424184f03ee897c2410896c24283b7c24580f8dd5feffffe9db0800008b4424348b4c246889088b4424388b4c24105f5e5d890833c05b83c420c383f8030f85650100008b7c24604f897c24103b7c24580f8ca10800008b44244c8b6c245c8b5c24548b4c24448bf70faff04df7d8896c242c897424188944241c8bff896c24683beb0f8c020100008d64240033c033db89742424895c2420894424283b4424480f8d76ffffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff8b6c24688b5c24548b4c24448b7424184d896c24683beb0f8d0affffff8b7c24108b44241c4f03f0897c2410897424183b7c24580f8c580700008b6c242ce9d4feffff83f8040f85670100008b7c2458897c24103b7c24600f8d340700008b44244c8b6c245c8b5c24548b4c24444d8bf00faff7896c242c8974241ceb098da424000000008bff896c24683beb0f8c020100008d64240033c033db89742424895c2420894424283b4424480f8d06feffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff8b6c24688b5c24548b4c24448b74241c4d896c24683beb0f8d0affffff8b44244c8b7c24104703f0897c24108974241c3b7c24600f8de80500008b6c242ce9d4feffff83f8050f85890100008b7c2454897c24683b7c245c0f8dc40500008b5c24608b6c24588b44244c8b4c2444eb078da42400000000896c24103beb0f8d200100008be80faf6c2458896c241c33c033db8bf5896c2424895c2420894424283b4424480f8d0d01000033c08944241485c90f8ea60000008b5424688b7c24408beb8d34968b54246403dfeb0a8da424000000008d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424240374244c8b44242840035c245089742424e924ffffff8b7c24108b6c241c8b44244c8b5c24608b4c24444703e8897c2410896c241c3bfb0f8cf3feffff8b7c24688b6c245847897c24683b7c245c0f8cc5feffffe96b0400008b4424348b4c24688b74241089088b4424385f89305e5d33c05b83c420c383f8060f85670100008b7c2454897c24683b7c245c0f8d320400008b6c24608b5c24588b44244c8b4c24444d896c24188bff896c24103beb0f8c1a0100008bf50faff0f7d88974241c8944242ceb038d490033c033db89742424895c2420894424283b4424480f8d06fbffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff8b6c24108b74241c0374242c8b5c24588b4c24444d896c24108974241c3beb0f8d02ffffff8b44244c8b7c246847897c24683b7c245c0f8de60200008b6c2418e9c2feffff83f8070f85670100008b7c245c4f897c24683b7c24540f8cc10200008b6c24608b5c24588b44244c8b4c24444d896c241890896c24103beb0f8c1a0100008bf50faff0f7d88974241c8944242ceb038d490033c033db89742424895c2420894424283b4424480f8d96f9ffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b803000000803c18008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff8b6c24108b74241c0374242c8b5c24588b4c24444d896c24108974241c3beb0f8d02ffffff8b44244c8b7c24684f897c24683b7c24540f8c760100008b6c2418e9c2feffff83f8080f85640100008b7c245c4f897c24683b7c24540f8c510100008b5c24608b6c24588b44244c8b4c24448d9b00000000896c24103beb0f8d200100008be80faf6c2458896c241c33c033db8bf5896c2424895c2420894424283b4424480f8d9dfcffff33c08944241485c90f8ea60000008b5424688b7c24408beb8d34968b54246403dfeb0a8da424000000008d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb604068d0c103bf97f422bc23bf87c3c8b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424240374244c8b44242840035c245089742424e924ffffff8b7c24108b6c241c8b44244c8b5c24608b4c24444703e8897c2410896c241c3bfb0f8cf3feffff8b7c24688b6c24584f897c24683b7c24540f8dc5feffff8b4424345fc700ffffffff8b4424345e5dc700ffffffffb85ff0ffff5b83c420c3,4c894c24204c89442418488954241048894c24085355565741544155415641574883ec188b8424c80000004d8bd94d8bd0488bda83f8010f85b3010000448b8c24a800000044890c24443b8c24b80000000f8d66010000448bac24900000008b9424c0000000448b8424b00000008bbc2480000000448b9424a0000000418bcd410fafc9894c24040f1f84000000000044899424c8000000453bd00f8dfb000000468d2495000000000f1f800000000033ed448bf933f6660f1f8400000000003bac24880000000f8d1701000033db85ff7e7e458bf4448bce442bf64503f7904d63c14d03c34180780300745a450fb65002438d040e4c63d84c035c2470410fb64b028d0411443bd07f572bca443bd17c50410fb64b01450fb650018d0411443bd07f3e2bca443bd17c37410fb60b450fb6108d0411443bd07f272bca443bd17c204c8b5c2478ffc34183c1043bdf7c8fffc54503fd03b42498000000e95effffff8b8424c8000000448b8424b00000008b4c24044c8b5c2478ffc04183c404898424c8000000413bc00f8c20ffffff448b0c24448b9424a000000041ffc14103cd44890c24894c2404443b8c24b80000000f8cd8feffff488b5c2468488b4c2460b85ff0ffffc701ffffffffc703ffffffff4883c418415f415e415d415c5f5e5d5bc38b8424c8000000e9860b000083f8020f858c010000448b8c24b800000041ffc944890c24443b8c24a80000007cab448bac2490000000448b8424c00000008b9424b00000008bbc2480000000448b9424a0000000418bc9410fafcd418bc5894c2404f7d8894424080f1f400044899424c8000000443bd20f8d02010000468d2495000000000f1f80000000004533f6448bf933f60f1f840000000000443bb424880000000f8d56ffffff33db85ff0f8e81000000418bec448bd62bee4103ef4963d24903d3807a03007460440fb64a02418d042a4c63d84c035c2470410fb64b02428d0401443bc87f5d412bc8443bc97c55410fb64b01440fb64a01428d0401443bc87f42412bc8443bc97c3a410fb60b440fb60a428d0401443bc87f29412bc8443bc97c214c8b5c2478ffc34183c2043bdf7c8a41ffc64503fd03b42498000000e955ffffff8b8424c80000008b9424b00000008b4c24044c8b5c2478ffc04183c404898424c80000003bc20f8c19ffffff448b0c24448b9424a0000000034c240841ffc9894c240444890c24443b8c24a80000000f8dd0feffffe933feffff83f8030f85c4010000448b8c24b800000041ffc944898c24c8000000443b8c24a80000000f8c0efeffff8b842490000000448b9c24b0000000448b8424c00000008bbc248000000041ffcb418bc98bd044895c24080fafc8f7da890c24895424048b9424a0000000448b542404458beb443bda0f8c13010000468d249d0000000066660f1f84000000000033ed448bf933f6660f1f8400000000003bac24880000000f8d0801000033db85ff0f8e96000000488b4c2478458bf4448bd6442bf64503f70f1f8400000000004963d24803d1807a03007460440fb64a02438d04164c63d84c035c2470410fb64b02428d0401443bc87f63412bc8443bc97c5b410fb64b01440fb64a01428d0401443bc87f48412bc8443bc97c40410fb60b440fb60a428d0401443bc87f2f412bc8443bc97c27488b4c2478ffc34183c2043bdf7c8a8b842490000000ffc54403f803b42498000000e942ffffff8b9424a00000008b8424900000008b0c2441ffcd4183ec04443bea0f8d11ffffff448b8c24c8000000448b542404448b5c240841ffc94103ca44898c24c8000000890c24443b8c24a80000000f8dc2feffffe983fcffff488b4c24608b8424c8000000448929488b4c2468890133c0e981fcffff83f8040f857f010000448b8c24a800000044890c24443b8c24b80000000f8d48fcffff448bac2490000000448b9424b00000008b9424c0000000448b8424a00000008bbc248000000041ffca418bcd4489542408410fafc9894c2404669044899424c8000000453bd00f8cf8000000468d2495000000000f1f800000000033ed448bf933f6660f1f8400000000003bac24880000000f8df7fbffff33db85ff7e7e458bf4448bce442bf64503f7904d63c14d03c34180780300745a450fb65002438d040e4c63d84c035c2470410fb64b028d0411443bd07f572bca443bd17c50410fb64b01450fb650018d0411443bd07f3e2bca443bd17c37410fb60b450fb6108d0411443bd07f272bca443bd17c204c8b5c2478ffc34183c1043bdf7c8fffc54503fd03b42498000000e95effffff8b8424c8000000448b8424a00000008b4c24044c8b5c2478ffc84183ec04898424c8000000413bc00f8d20ffffff448b0c24448b54240841ffc14103cd44890c24894c2404443b8c24b80000000f8cdbfeffffe9defaffff83f8050f85ab010000448b8424a000000044890424443b8424b00000000f8dc0faffff8b9424c0000000448bac2498000000448ba424900000008bbc2480000000448b8c24a8000000428d0c8500000000898c24c800000044894c2404443b8c24b80000000f8d09010000418bc4410fafc18944240833ed448bf833f6660f1f8400000000003bac24880000000f8d0501000033db85ff0f8e87000000448bf1448bce442bf64503f74d63c14d03c34180780300745d438d040e4c63d84d03da450fb65002410fb64b028d0411443bd07f5f2bca443bd17c58410fb64b01450fb650018d0411443bd07f462bca443bd17c3f410fb60b450fb6108d0411443bd07f2f2bca443bd17c284c8b5c24784c8b542470ffc34183c1043bdf7c8c8b8c24c8000000ffc54503fc4103f5e955ffffff448b4424048b4424088b8c24c80000004c8b5c24784c8b54247041ffc04103c4448944240489442408443b8424b80000000f8c0effffff448b0424448b8c24a800000041ffc083c10444890424898c24c8000000443b8424b00000000f8cc5feffffe946f9ffff488b4c24608b042489018b442404488b4c2468890133c0e945f9ffff83f8060f85aa010000448b8c24a000000044894c2404443b8c24b00000000f8d0bf9ffff8b8424b8000000448b8424c0000000448ba424900000008bbc2480000000428d0c8d00000000ffc88944240c898c24c80000006666660f1f840000000000448be83b8424a80000000f8c02010000410fafc4418bd4f7da891424894424084533f6448bf833f60f1f840000000000443bb424880000000f8df900000033db85ff0f8e870000008be9448bd62bee4103ef4963d24903d3807a03007460440fb64a02418d042a4c63d84c035c2470410fb64b02428d0401443bc87f64412bc8443bc97c5c410fb64b01440fb64a01428d0401443bc87f49412bc8443bc97c41410fb60b440fb60a428d0401443bc87f30412bc8443bc97c284c8b5c2478ffc34183c2043bdf7c8a8b8c24c800000041ffc64503fc03b42498000000e94fffffff8b4424088b8c24c80000004c8b5c247803042441ffcd89442408443bac24a80000000f8d17ffffff448b4c24048b44240c41ffc183c10444894c2404898c24c8000000443b8c24b00000000f8ccefeffffe991f7ffff488b4c24608b4424048901488b4c246833c0448929e992f7ffff83f8070f858d010000448b8c24b000000041ffc944894c2404443b8c24a00000000f8c55f7ffff8b8424b8000000448b8424c0000000448ba424900000008bbc2480000000428d0c8d00000000ffc8890424898c24c8000000660f1f440000448be83b8424a80000000f8c02010000410fafc4418bd4f7da8954240c8944240833ed448bf833f60f1f8400000000003bac24880000000f8d4affffff33db85ff0f8e89000000448bf1448bd6442bf64503f74963d24903d3807a03007460440fb64a02438d04164c63d84c035c2470410fb64b02428d0401443bc87f63412bc8443bc97c5b410fb64b01440fb64a01428d0401443bc87f48412bc8443bc97c40410fb60b440fb60a428d0401443bc87f2f412bc8443bc97c274c8b5c2478ffc34183c2043bdf7c8a8b8c24c8000000ffc54503fc03b42498000000e94fffffff8b4424088b8c24c80000004c8b5c24780344240c41ffcd89442408443bac24a80000000f8d17ffffff448b4c24048b042441ffc983e90444894c2404898c24c8000000443b8c24a00000000f8dcefeffffe9e1f5ffff83f8080f85ddf5ffff448b8424b000000041ffc84489442404443b8424a00000000f8cbff5ffff8b9424c0000000448bac2498000000448ba424900000008bbc2480000000448b8c24a8000000428d0c8500000000898c24c800000044890c24443b8c24b80000000f8d08010000418bc4410fafc18944240833ed448bf833f6660f1f8400000000003bac24880000000f8d0501000033db85ff0f8e87000000448bf1448bce442bf64503f74d63c14d03c34180780300745d438d040e4c63d84d03da450fb65002410fb64b028d0411443bd07f5f2bca443bd17c58410fb64b01450fb650018d0411443bd07f462bca443bd17c3f410fb603450fb6108d0c10443bd17f2f2bc2443bd07c284c8b5c24784c8b542470ffc34183c1043bdf7c8c8b8c24c8000000ffc54503fc4103f5e955ffffff448b04248b4424088b8c24c80000004c8b5c24784c8b54247041ffc04103c44489042489442408443b8424b80000000f8c10ffffff448b442404448b8c24a800000041ffc883e9044489442404898c24c8000000443b8424a00000000f8dc6feffffe946f4ffff8b442404488b4c246089018b0424488b4c2468890133c0e945f4ffff"
if ( A_PtrSize == 8 )
MCode_ImageSearch := SubStr(MCode_ImageSearch,InStr(MCode_ImageSearch,",")+1)
else
MCode_ImageSearch := SubStr(MCode_ImageSearch,1,InStr(MCode_ImageSearch,",")-1)
VarSetCapacity(ImageSearchMCode, LEN := StrLen(MCode_ImageSearch)//2, 0)
Loop, %LEN%
NumPut("0x" . SubStr(MCode_ImageSearch,(2*A_Index)-1,2), ImageSearchMCode, A_Index-1, "uchar")
MCode_ImageSearch := ""
DllCall("VirtualProtect", Ptr,&ImageSearchMCode, Ptr,VarSetCapacity(ImageSearchMCode), "uint",0x40, PtrA,0)
return
}
SearchPNG(ND,x,y,sx,sy,Tole:=0,ByRef Found:="",Mode:=1,Draw:=0,AreaDraw:=0){
GLOBAL
      If !( ScanBit && ND.Scan )
      Return Found:=-1001
      If Tole not between 0 and 255
      return Found:=-1002
      If ( ( x < 0 ) || ( y < 0 ) )
      return Found:=-1003
      If Mode not between 1 and 8
      return Found:=-1004
      OutX := ( !sx ? PNGScanWidth - ND.Width +1 : sx - ND.Width +1 )
      OutY := ( !sy ? PNGScanHeight - ND.Height+1 : sy - ND.Height+1 )
      If ( OutX > (sx-ND.Width+1) )
      return Found:=-3003
      If ( OutY > (sy-ND.Height+1) )
      return Found:=-3004
      Info := LockedBitsSearch(StrideBit,ScanBit,ND.Stride,ND.Scan,ND.Width,ND.Height,FoundX,FoundY,x,y,OutX,OutY,Tole,Mode)
      if (AreaDraw = 1)
		;DrawRectangle(x+WindowInfo.ClassNN.x,y+WindowInfo.ClassNN.y,sx-x,sy-y,"0xffffffff")
      if (Info == 0 && Draw = 1){
            ;DrawRectangle(FoundX+WindowInfo.ClassNN.x, FoundY+WindowInfo.ClassNN.y, ND.Width, ND.Height ,"0xffFF0000")
            ;DrawRectangle(FoundX+WindowInfo.ClassNN.x, FoundY+WindowInfo.ClassNN.y, 1, 1 ,"0xffffff00")
      }
      if (Info == 0)
      Found := {1: 1, 2: FoundX, 3: FoundY}
      else
      Found := {1: 0}
      return
}
LockedBitsSearch(hStride,hScan,nStride,nScan,nWidth,nHeight,ByRef x:="",ByRef y:="",slx1:=0,sly1:=0,slx2:=0,sly2:=0,Variation:=0,SearchDirection:=1){
GLOBAL
If ( slx2 < slx1 )
return -3001
If ( sly2 < sly1 )
return -3002
If ( slx2-slx1 == 0 )
return -3005
If ( sly2-sly1 == 0 )
return -3006
E := DllCall( &ImageSearchMCode,"int*",x,"int*",y,Ptr,hScan, Ptr,nScan,"int",nWidth,"int",nHeight,"int",hStride,"int",nStride,"int",slx1,"int",sly1,"int",slx2,"int",sly2,"int",Variation,"int",SearchDirection,"cdecl int")
Return ( E == "" ? -3007 : E )
}
Load_Images() {
GLOBAL
	PNG := []	;Amulets e Rings: start 7,6 - tamanho 20x20 (Referencia: Total:34x34)


	; [Healing]
	if (true) {
		PNG.UH := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAABEAAAAUCAYAAABroNZJAAAABGdBTUEAALGPC/xhBQAABGVJREFUOE8llOlvVGUUxm+nM50WqGiny0xLO9NZ7p3eZaYt09IF6UZLN1paWltaSKCKZbMGxVqKULpDF4KJLCICcdcAEiVGg5Fo1A/Gb0TjkugHxcR/gp9nrh/evLnvPed5n/Oc57zKtps/0XnvT/r+fkT3N//S8v4DGl//luqpW1SduEmkcZK0tCJSU30kEgl03SAcicgKE9V1YvEYSjK57+EjOj77nfrX7tNw+Wuar/1Ax93faP/iD+pW71E5/g5a2wxOVwFlZaUYhokv34emRjEtS0D+esTGg29Q0j5FfO959O3TxIeXMHoWsfrOkDh6gy3nv6Rq8kOiHTNkZGgCYgiAhr84gGWZKB13fiXaPElJxxTRtlN2stZ8/P+zrROyH6ds/0U2L3zK5uXPCcRHcTkLMM0Y+Rs2UFjkR2m9/TPq1uMkDl0hvuc8Nadu2klq40sY3fMYnadln5V/56gaf5fEkasEKw7hchVSWlqGZQqTrvv/EG19BatrVmp/zw6uGLuOOTxPaloG+s5ZjA5ZPXMC8Ca107cxB5fIy+nEKYySuiittx6gt5+ipO0k1uAqpU9fkKBFCmp6cDjdrPHIjfsuYIhWscFlqsdvkxi7gS7s3O4wqqqi1M7dJbpNmAwsYfafwRxYICtSSfnoJbylrTQt/0hurIXYrmWs/mViu0X87tOYO+eJNEzgSPWiVE/fItpyArN3kdjQOTyRGqyhs3annO616H3CQADW5PglZhbzqRU71tgxgzV8jlRHNsqmF98SJieE7gwedRPO9HWszQ3hcLlQFAWHwyXfxaQ4nFKek6oDH0kXT6I2jBPaeBAl5XGUqokPMPvO2mzK9l4i26ij4sjbBJ4cIUVJpbB6gPrF73isQEfvmiE2sCqlLBCuGsObt0PK8aDUTH0sWpy1f5j9i5Ttu0ymT5XgJWFWS+mzF8nW6jEEwExqIt3TO6cIlo+Sm9Mm45CH0v7JL1i9C7YX9C7xhNQaH1olIzNPAlx4Y21yNofROydazGHtWiFcOyYtbsXn3SnGyxeffPWQ8sNX0MUHhqiuNU8IqAgn6qev81Fz4I4tpNk7T1xaHNx0iKLIbnI8LTI//XJRDkpUZqbp6vd2i/XuaduNyTnSt09R3n+JkkaxfsskldKAkuZxCgND5BcOCoseMtdVEAoGUVIduVQ8f426V+/ZbIpLR9EaXkbbchS15hjF8f1odcdQ64+yITCMN7cLrwB4PPWkpKy3h1FRNZX09DDlz1wm8dx1gpWHyS/oJ2CNYHbMozaN28De3G5ysltk77QFTUl5AlXThEkIJSDjnPzISA8RG14hvnsFvz4itw5SbIzgl+Xz7pDEbdLS7XiymuSR8hORh0k3DaLREmEi3rdfqWiUNHfA7pJa/wJF4T34S/ZJYo/Q76XAP0SWZ6t4J5NgKIQh05u8PBwOoyQRk2z88i4U+f2idpYMVrEwC+OWG91pQSlXFeeKqaQETRK9Pp/EF6GLHqZp8R/RKmb9x4Wt6AAAAABJRU5ErkJggg==")
		PNG.ManaFluid := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAScwAAEnMBjCK5BwAAAbhJREFUOE+llEtOAkEQhvsaRN7Mi2GGhBDDznvg2htwAY5hNHHJVYyncMdCWYiujDFlfQWlI6CSWMlvm5ruj7+rqzuIx9ONrC6DhBAkzTKJokiSJJE0TU1xHEu/37d8Phjot1Ra7baUZWn5DehRBxUgwmC6OM/zCiyTdqdjwG63q4ChnNTr0mg2pdVq7YPWr++m+PRM4iQ2WK/XM+BwODRIoS4ajaaMRiMpikLG4/EWtN2Wg+bzuY04O6S2bomt8QM4Ba75DcudXF0EWSwWBqvmq8It63CJrEaZFpYkEzxerp8NRm51/vBNd7Xbb0CK39Q6Bf7JlEjyfv22RX0Fi2ezmWk6nZqAORATk8lkA6KIjMCWy+Wn3EFVDqyCirKQQKEonoP46HEIhKowAljgeOkFirZbq59AaA+0OcLUj9BAAIjfQLhiJAzE0QHB2b9A3gfVrR0DchEGihWAI4d5wY+BEUBsNyzO+plBuPXuivgLxjzmc+dCR2+0PxOInnJX7szlAHrMIdwMKwt/rLs1gSNg3Gjbt+pQ+LdEDbCW9ymwkIbkTeHO2ClqS1Rhu6rVajYfAE9KFEXyAYIq9dxzkNqhAAAAAElFTkSuQmCC")
	}

	; [Combo]
	if (true) {
		PNG.HMM := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAwAAAASCAYAAABvqT8MAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAScwAAEnMBjCK5BwAAAxZJREFUOE8lk3lME1Ycx19bztDJMVEhoydHCaUNlWMZ1AIN5VRMkYoSgohxKHYGtYNI5oHMoBziwWGIEWVhIvGYikZxCw5mjEdEYzKzuGV/bNkiRJP5h8c/nz3LHy8vL3nfX77XT4xX/8m77g+MrX1Ou/MC++xnGVg1w56cM+y0dSGEAp1eT0JCAgaDETHX/o5/295ypGTS/7mr+Dq9xZN0OC+za3mPBAisFgsGowFzqhnxpvM9P29+RZtjlAPy1KS1EKQKYXdun39AldGLQoLMZjM6nQ7xxPeGwZIp2vPO4804TKAqmOCAMD5bpGdo5T186cep0nuJCIglOdmE+GXLK3pcE7RkD5ESncnXX/RTlFDB8VVn0UbEMyxB9Yk+MsOy/fTElKQzUvGU/Xnfs8cxQq/rJumxTh40/s6l6tt0FlyhNesk6w1b/QaIK7X/cK32b7oKJhguf0RX4VUsS+2Mr73PQNk0Q6sfsD2tg3y1k3BVFKKzcIJr9XNcrPmLb3PPc7jgB5I/UrP3cUJqO1byI81Z/VJ8A+bQDIQ7vonT7kfc2faagwWXWKbWEh6yGENUCrvsHRzKv8h+x3dss7SjVkUi8pdVM7buN6njCZ7UJrxZPcQuiuVo2Sgb07+Uwx6zV4ZYl+QjSBmKsIW7GHbPcqr8IZ/HFUneM+gjTTz+6jX16TvpK73D7sxB1mjrUSiUCGOIjdHKXzldMUtiVBrjnj9ozhni3tY5fI5exqpeMFh6mw1JzQu26oKtTEtrz3meU2NpQReeTGNmJ984zsh3E3e3vGWHrRvXEs8CIFImOOv7jxt187IeY1LgKJUpDXjMXl7ue8m56hekhC6nMGYdgUo1QiFU3KidZ3LTPEeLbtFf/BO9sogDpVOcWn2fWlMzWZ/kYVPnLgRnMpkIUUYwUvlM+j1It3Oc1oxjskMncGsaWBHtxrV0vSxgAEajrLdGq0Wj0fjRbfZhGs0HaEjdyxrdZlZ8WkZ53CZJI4ikxCRiYmIQ8XIx/NWVS/KxxpKjBKtYEmggTLmYYMnbarWSarXI28r/O2i/itRfnjEAAAAASUVORK5CYII=")
		PNG.ClosedTrap := BitmapFromBase64(1,0,"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")
		PNG.Trap := BitmapFromBase64(1,0,"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")
	}

	; [RuneMaker]
	if (true) {
		PNG.LeftHand := BitmapFromBase64(1,0,"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")
		PNG.BrownMushroom := BitmapFromBase64(1,0,"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")
		PNG.Club := BitmapFromBase64(1,0,"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")
		PNG.BlankRune := BitmapFromBase64(1,0,"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")
		PNG.NoAmulet := BitmapFromBase64(1,0,"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")
		PNG.LifeRing := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAACIAAAAiCAIAAAC1JZyVAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAABxVJREFUSEu910tvVMkVB/D5CDO7+NF2v27f2+6n3W2bQQ4CYwxYFmEIYgDzMGOIxSCGIR7DwFjss8w660QZRUq+QfbZRMpIySJSpHyIKFIiRcrvVDkon2BKVqn61Dn//3lV1fUHH3700ffwFzT9fr/Vag0Gg6rbbTabjWazqrpLS13DbKvT6QyHQz/r9Tq1pbTX6y2VZafdbtvtlJ2sVlWlASTLG41Gpyw3NjaCBhgmQCsrKxCg1Go1cLAQ22IzHA0BWczPz5dV1e/3qNlaXl5mSE45z+QIlnpLrXarKDqLi4vnzp0LGma9fo9HzEbjMXcYmPkbBMNBvVHHMV2dZkSWCa7LpKzKzAc6B8EwwitLJjS5dv78+aDB3E0psh1hjcbW7IUCgr9VVTEoivZ4HFvUfjAzw9l2Ee4nofj6aGjaLYqClQwbDDc3N4PGxnQ6pccFM0vBWdNGxKnJZEI/5yRnib61LTnkipRKco4GdKPhr9Hr9SR/dnZ2a2sraGzYHo1GGcgYDIfgMGXL92mB22y2GBNmBZK5uTkKQM0RSqewK4iEtoRwe3s7aCJRachepLss5dBMMh4vZ272Bld4naKMgosJdFs26YhpOKTTHwwAorHmEEevXLkSNDwiWpmsLNbrK5MJS4UBxMG8xamc9Gi13MGpyCDE1Ov1Z2ZnyrLKvW40W027FnqH3zs7O6e1YTwaj/JCSTO6FkBgoS8LuFWVOUAY72OSLzIunp6BqnQwGo1mLjZXdnd3gyaMwtOWDWFyEAE4gZNIu3VUIp09Pv6PqZJ3ZIAGg+Hc/HxtYSFKUrR5aRulmfK1a9eChvsOARHXtIMtrcWYxE/aGdciCtMpMOVwFYOaYtRqC/zgE0OJpSD6aLhkfv369aChOh6P+oN+bjklVQmqXANEYDYk54P/G7Ua/2ugWXEjRVCB0nGgWWX/SG7cuBE0DETAnbRRMDutTVXKZE6dn6Dvfrd58Pedo39+tvfHLT8d0oWFBVY5k4a1sjeaDRJSKdUCN2/eDBoNOTc3Ky3aF4HM8MVPMSHgjlCAPvzr9t6fL279YvKj326c/PvV8T/2CTmROcyssLrugDieGYT5rVu3gmYwHDgBqaHiOnDgOaWa9PSCOceBo9yrWRtbP1/93X9+8+Av29Y5Gs4BXV9f5xPnZtxGregp5rdv3w4avtBYXVtV3lyVSlum9mWTaSRq+aexECRji91vPz7+14EFRDFBkCIFxqmnsGpauJy4e/du0GQNcM5muuSj35GJNzcFLFna+XbdIt+nFkLJedNRNNHDjb30GnE9zBsNaPfu3QsaQGhqCzW9iEAEnjUiBo4CA1hqLksbPxtYG1d/tbb/t8u7vz5rjQRcdE264rQSk6DsLjmz1g8ePDiNBiIySnlmQGJhi1MW4PguJtm7/YcLOH78+3OECJz59B7GWXEfnz17dnVtLczbrbhsOp39/f2gyYfIdZk5UPkFPc8MKKACKqZ7323t/eni1V9GAiGmdMW5diWura+Hm0VbYc6cOZNdN392cBA0AvTDgBun12jEXWCQmN2hRNag34+INb382TC7qPi5x6TOQ6w13EOPHz8OGlI9rbvYRKt0u7ZVC2WOKTFFazoNdKTU2oOmfk6fQubnIz85QjGz9aVBzfjJ4WHQSKiL1VsSXVxVWoANAui4zdov5bINKBkW+o0rhJywIQgmOQiuOKThcb9PDvbp06dBYy82Kj0WRwwTY2co+x5hFQVuM+h842U5Ky3gp7V33YJPohEKTTGFo1X1+bNnQTOdxlOWnU2Bx4OWlQgDNAHxLtTe09hOcILoufRSJuOtpueKammaaCX99vz586Bhs7xy+rllW0xyKN2gdQOgfD+yYy/EqFZqkBxuvgUQeBEgxBdP+lJIR6erEV68eBE0o1EUQxINQBLKX05JngX3CSUHbvZVTDlc+j5OzJjyqchZMRYX69PVVfRq/OXLl0GTGjKetZyNVJzoCFlWfh8uzKB5Gy2S8LTRczIBbWz80H1hTUHQHgJtIo22/Dw6Ogqa7CDw1J1Rf1wMCCfTCWOIiSC+b2VcMH6mpDUDq9WK8+tTq+gI1hY5ncl0KjH1ZuP4+DhofPE4DCkNkSUGiOWUQYQZnzVxxYnD9eUnYlXJCgqAGSW342YTd8q8dPEVDbTXr18HjV70FlE1WMp77k5mSIJyNLLguLhSg53e6LakOH5H9LFDDRMP0HPFpwGFN2/eBA3bnLdsAAKR25BN+tAq1RkrBXLC3GBZGShJso08kyAwh229oTVsfXNyEjRuQBeDfw/OX7iwefHipUuXLl++fHVnx/eVb5/rn3zim8F7fuvTT+/cubO3t3f//v2HDx8+evTo4ODgyZMnh4eHTz93BJ89/+KLF19qq5dHX3316tWr119//fbt25OTk3fv3v0XzBNCVc13ZX0AAAAASUVORK5CYII=")
		PNG.WhiteSkull := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAB0AAAAdCAYAAABWk2cPAAAABGdBTUEAALGPC/xhBQAAAopJREFUSEvt1j1v2lAUBmD4b8jsZKVS2YpEYDcS3go/gWymSLDAUmboZq8IlkbYC4SPAYzEhwkS0el5jz+gaqvIqTs1R3p1ETH3uffm2JB4r/+6KJHkYPwlSYwxVVImE+xyeaHT6UQu53g40OHIORxltCzruiBvfHMxdAkD8HRyBV0uFpLFYsmwhyKFQkGCz3pTRCuBXCCuS0/zOc2fOBhvgvcXjAfol2YzhJMR4RsQx+kKYFm2TCygv4B2q0XtdpvTotFoLGgT8H1kOClHiB0GOw0CINglXmMhNmc0GoUBWqvVoqOr1UpA0zTIMExKKwopnNYNil3X63WqP9Tlb7mPOdIqmqCaVon8vxUUAZrJZGRSpN3CUV7hB0YVJU25XE6iaRpVGFRVNRqKIwFo804+V6t0x6gHp2nrbMlxHOlkoLKYtELFYolTpOVySd1uNzrK5TeNTVVGAWYyd9Tv9xn0UW4wxLZtWUypVJTj3W4dfs8S9D46akmDoHuBBNBut6M9J5/PU/5TXhYCOLgGwW7LjGaz2eioxSt2eOXoWhzncDhkcE+7vY9ygCKADMMIR+w0Koqiht6gx++P1Ol0BLxNKpWSADBNkwzpci9otGz2A2Nvex6TznCJGwRN0ulecYDT2TSEEFyDa8tq+e+fv5PJRCZ7Pj/Lk2q93tB0OuVxTSbfwxgHg2+ClssMRjzS35WgCCbH7vb7vaAYZ8A3G0YHkthQvdEI0fP5LOBO4Fm4AGC6rseGohjWaeOjwIHhmPEaEKJyon6zvFbyMA92Kkftj8Eu4wZRcgsF3yRfez3qcdCp3rGqsR3rT4Wd4BYCAnjMAfbPwJvy0bHAcTbOa+VD/o+29/pjJRI/AHMYxWgmkLXvAAAAAElFTkSuQmCC")

	}

	;[CaveBot]
	if (true) {
		PNG.ThereIsNoWay := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAG0AAAANCAYAAACjDOAMAAAABGdBTUEAALGPC/xhBQAAAj1JREFUWEftlWuOwyAMhJv7XzY5QddvxsYk6Z+20vaTrA2eMQkYuo8XeVr8+BK8IRBbPG8U+75LWO6TfMM3fBxqxhFN6UI99Hzs0kAt+wjpmzT1f/FNiE2x5kjUmwZaJWosEMxV3cc139F5sLZqCGnjF8SiovltqSPh0T2RuZnIA54705wXLgd9KDZHk0LkOQ7+S7eO8yoLycPBOZVII7/nXPfm87PMSTee/9qGdUQtP2vq9L2IaPqepTdpjY4MT9k3XKs4y7yyRtfmPZ89pyybtlFOf0JpICE+bZwA46Grn3kethCMeoPFl8eV6pf3wgKf2/2Gp3H3LWVcEc3fjV555r3I3+LzJK/u7dn4mlXByOuH0HM0UeBn33CNpEfe6z2GP4fplUmv7+RFc74hfNbYGPPz+bidM/RouB3aURdrWO1N6EPT4JxKV9BiuqKLUyhUHYIxP29q5BicZ0Q+oQP/vnGjORlzlLkqouGtzH6dZ61PJB0bUerSuNlLJnKNxtRxggqmU8DkyWTz5psGdRKhLw4DkfParM7ndPOkuju1m96c6m/H0MSOqcZvlI2ZyVPGDuTHzZYm278WGqI/iEI2Wy42fXEKnZhcG0q3SjdTteHHGia0E48THv++qLtYGGG1cdu7GvOM4JxKLdW3qqOcHnIMzqssnOfTr0vBNqMTa77x6QmGQLqcgzUrj1M9UZcOWk+qFf84WA7OVbWO7LNbr4OE5dMeOauGGdudtf14M6Np8yH68a3cu9mPxx+UJHlM71vRSAAAAABJRU5ErkJggg==")

		PNG.NPC := []
		PNG.NPCTrade := BitmapFromBase64(1,0,"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")
		PNG.NPC.SellButton := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAACsAAAAQCAYAAACP4IauAAAABGdBTUEAALGPC/xhBQAAAShJREFUSEvVVYuNwzAI9TCN/0mUjtDbordEbMe/6TmgrnQjxEiIwANMLMAipgS1Vkgsyz+uzDlfjOWc4SK+Lmi9QS0Ygxjbhp34PE+IEXO1zvZv/toaNOQQA+MF42OKHJNzgVwKdMTJXkY9fCbivXd4/75BUEIxARljQCT8u6HfmhapQNBVD/3WtO8btgH2xNBvTcdxUBukeXqWJnXot6ZlWeZpA6NxwGKcYxs452jPznGz2uDNniFMUaxUEkTDZ3Hot6bnE1dXCHP0rDYai51kwLZtnWcbWGtB/LxeoLUGWg30SihsZCklWNSts+BXD8exM85+1oH3nnHy9379YPhtECdJ8WQjTCnFftpYWDGOljvh27azJH48HuxDBTk8k/0x11dqTdLAHxTi2z7tzWqZAAAAAElFTkSuQmCC")
		PNG.NPC.TabChat := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAACAAAAAKCAYAAADVTVykAAAABGdBTUEAALGPC/xhBQAAAN5JREFUOE+NUwESgzAIK/9/tIMUSkDU5W4TUggpnstx+bPj8CLrEs3tp2k8O3C2tNbjb5jwDlqD5xgk8iRG/L3mwWRHNkodhDhuDkYBw2RWdn/rUy4uQLXO1Q0NLpEHjwEssvmTm+mmMcbjNlwXf90pv5phwMlvGxhfV+Fc27lYO4aQCRc29A0knGfzbzdlHP1soIEMbSYzqN+/5KjXUGo9NHC8YcZy1STS4m+hasC3Co62E1zkBo2zmQ8MyOPGYIAyLDGsWRHc7axu8A9RNzHXJfR8374NMJzPLz/3tX5+Hnz8osWSzgAAAABJRU5ErkJggg==")

		PNG.Minimap := BitmapFromBase64(1,0,"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")
		PNG.FooterMinimap := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAL0AAAAJCAYAAABnjC1TAAAABGdBTUEAALGPC/xhBQAAAbRJREFUWEftVm1ygyAQtZdoE8VPEgk9Sb2Auf9JKG8RNQYUM+0fw868AXaXx/LcMEk+kkR1P50SQqiqKVQSLdoBrawZ9XjXddTjNIEDAcqIFu1gVpRZbPpo72XxpY/2duZ96ev4nz7aQc370je8jE0f7ZC2+tJb4AeQsdMI+PBrwdjeuOLXmvwgw1x+t2McPhsDWJHqWE4jgJw5r4kzlWZfiz2McuBP9YiabBxnYo0cjBe9zstU555Urvfm50/FC82JfZea4sgTunZzl5z2Wj7E5rVcRTOehzVg72brR/zaGi2ojkulavBWuZICnExxDbM/V5VGxs7j3ZfY1uGTRlsX4NKBBeiAb2h0MPUVxcCnYw86tGs6mB5BHDo0Mx1wV6sDNOCN0WDSwa0BAP6a7+xDXb+/D/Vd9Fy0i6aXUlLj/wVah2+EPtg538Aq5waC6xnw0llPPO1iHYhgTQZ+yn/xLAfo7ju+yz7463zSfF7DcEdfTuj3kjc5Nf39fp/Qz+ar6B0+D4hzR/5L+G/+HfBpOPj72XwVwd9iA3v1d5xLNRMGnr2cDjxx+hCswyPPnH+a9+oXOU/NtOSrp4MAAAAASUVORK5CYII=")

		PNG.Mark:=[]
		PNG.Mark.1 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAExJREFUGFdj2D27/f+9g+tRsH679X+Xc+H/GXBJcCSp/GcAMUACyBIgGiyJLIAsURXr+Z8BxMAmATIJbCdMAbIEWBLmWnSJ3bPb/wMApw14cQtd7ZkAAAAASUVORK5CYII=")
		PNG.Mark.2 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAE5JREFUGFdj2LN4yn9+/v9wzODV8H9Cbtj/6zuX/WeACcAwsgIGEAOkG4ZRJO8dXP8fhNGNBYnBJUGCyBIokui6wJIgV4EZaDqv71z2HwAq53rA7Nzv6QAAAABJRU5ErkJggg==")
		PNG.Mark.3 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAGVJREFUGFdj2DGl5v9VBob//5KT/18G0iuBeEJu2H+QOMO9g+v/PwMKfAXiD0iSIHGw5G2oJEjRAnRJED4GFNwJlVjfmIwqCcIgQZgEiuQHDQ24TrgkyFUgxmugBMhomOSOKTX/AeQWfh8XE0znAAAAAElFTkSuQmCC")
		PNG.Mark.4 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAFdJREFUGFdjuL5z2f97B9eD8adUxf+7Z7eD2SBxBmSJHwvMUBQwgDgg/Gah2//vU2TAGCYGloQJImOwJMxIdIkJuWH/wQ4CcdAxWBLEgDkAhkH8T6mK/wGgTIcv1gBWtwAAAABJRU5ErkJggg==")
		PNG.Mark.5 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAEBJREFUGFdj2D27/f8qQcH/9w6uh2MQHyTOAGL8d3ODKwDRDxgYwDQDugCMBomDJdEVwMTw60QXANEwjMe17f8Bvz91i+m2ynwAAAAASUVORK5CYII=")
		PNG.Mark.6 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAFxJREFUGFdj2D27/f+9g+v/V+sygPGE3DAwHyTOAGKAcI4WCxjDJEGYIV6N5T82DFLEEKHM8h8bBkvCjAhSYAFjkCAMwyW9ZZnBGCQIE4O71k2aCYxhkrtnt/8HANHwb69WOEtUAAAAAElFTkSuQmCC")
		PNG.Mark.7 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAJJJREFUGFdjuHdw/f9KBgYwRmczgBgf1eT/HwTSmUB8G4ifSoqAFTAksrH9T1YW///z5w849ubj+B/MCJSsYGb+z8nF9l9fT/O/iYnBfw0l2f8sQIlpTIz/GWKFBP4f52T/vxlozHYgBhl/hYv9P0gc7KBaPq7/Reys//OBEsVAiUoBnv8TcsMgkiAGOt4xpeY/AI5rYery1N5uAAAAAElFTkSuQmCC")
		PNG.Mark.8 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAF1JREFUGFdj2D27/f+9g+tRcKUGw/8Fjlz/GXBJVDIwoEoiSxxfOxciGRgY+D8iIgJFAiTOUFlR8f/69etgBRZmZnAJsGR6Wtr/np4esE4MyfzcXLAgusT1ncv+AwA5QYCQOka2vQAAAABJRU5ErkJggg==")
		PNG.Mark.9 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAHRJREFUGFdjMNXX/h8d5PP/9r41/+8dXA/H13cu+88Q5mjx/+PHj/+L0+JQJEGYYd/Saf9BCh4+fPi/KicZLAjigyVBBEzBmjVrwHSEi/X/PYunQCSRFSxw5ALTG2d1IyRBAjAMU8AAchWybpAOkISLrvx/AGyygldrFjZZAAAAAElFTkSuQmCC")
		PNG.Mark.10 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAGZJREFUGFdj2D27/b+9ttD/ewfXwzFIDIQZQByQJCPjBzgGiZ1cMRkhaW//+7+Z2bf/GhoP/vPx3QYrwKqTg+MaWAFccu2EOhQMUsAAMhsmCVIIw2AH7ZhS899IVRZFEiSxY0rNfwDdp30s0i5RAwAAAABJRU5ErkJggg==")
		PNG.Mark.11 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAGRJREFUGFdjOLli8v97B9f/z/TigGMQHyTOAGLk+bKDBWAYpgAuiawTLgmSePNM7P///wz/t81m/X9nF8P/Xb28YAVgyXfPRcGStR4M/69tYPi/u48HUxIkgSIJcwA63jGl5j8AMKF1HVqgBbAAAAAASUVORK5CYII=")
		PNG.Mark.12 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAH9JREFUGFdjuHdw/f9oD1MwDjBXhGOQOFgSpqAy3AIuAZcEScyvDPlfFGTyvyrCEqETJPH/xdH/a9sS/s8pDwYriLRVBitgABFXVtb8v7a+5f/s8qD/DTGW/4sCjRCS0dby/zsTrP53JNr+z/bS+Z/mqgmRBJkNYqDjHVNq/gMAGrZtVgllw/4AAAAASUVORK5CYII=")
		PNG.Mark.13 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAINJREFUGFdlzrEKhDAMBmDfzcHd6VYnX0mQcosIcanQSehQt44dCpYON5S+xy+pSIcbfhLyQZLmd0qMw/AXnjfcxBgRQkDOGc45aK3x6fsHrbXo2hbGmFKFEBVTSgU4SilIKR98b/La7zyDlqXASVNF7z32bQMRVbyOtXzGgzcM17HiBh3NhsYI6wfWAAAAAElFTkSuQmCC")
		PNG.Mark.14 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAF5JREFUGFdj2D27/f+Vncv/3zu4/j9nuTmYhmEGmCAIc+QZw9lrJ9T9Z0DmsKXpgWkQxtDJGq35nz1NH4zhkjDMEqwK1gVTAJZk9lHCwGA7QZIwe5id5eDstRPq/gMA6GFzoDqp7RoAAAAASUVORK5CYII=")
		PNG.Mark.15 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAFFJREFUGFdjuL5z2f97B9eDcTkXA5wNEmdAltjDwoWiACwJEljHyvH/MQM/mIYpYAAxYLqQJUEYxdizTDxwXWCdyJIYdsJcCxKEYRD/+s5l/wEKu3ceSQIGDQAAAABJRU5ErkJggg==")
		PNG.Mark.16 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAFZJREFUGFdjuL5z2f97B9f/L+digGMQHyTOAGLAJPewcMElQRhF8iwTD6okiAPT9ZiB//86Vg4wH4TBOkEMkCCyJFgnzAiYbpgEWBLmWpgCGPv6zmX/AUlXdx5Y00GFAAAAAElFTkSuQmCC")
		PNG.Mark.17 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAFBJREFUGFdjuL5z2f97B9eDcTkXA5wNEmeAcWCSyAoYYAIgvIeF6/86Vg64ArAkSPAsE8//xwz8YAzig8RRdIJ0oeiEmQ/CMEUwPh7XLvsPAAyEdx5hQF5lAAAAAElFTkSuQmCC")
		PNG.Mark.18 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAE9JREFUGFdjuL5z2f97B9eDcTkXA5wNEmdAlkCWBGGwJEhwHSvH/z0sXHBFIMwAIkCCjxn4wfgsEw9cEYpOEIbpgkvCFIAwjA/CeFy77D8ASnx3HppQTFkAAAAASUVORK5CYII=")
		PNG.Mark.19 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAEVJREFUGFdjuL5z2f97B9f/3zaz7T9DkDyYBvFB4gzIEkrtOigKGJAlLFaZoChgQJaAYZgCsCRODNKOC8Ndi46v71z2HwAZQXTmqVD41QAAAABJRU5ErkJggg==")
		PNG.Mark.20 := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAEtJREFUGFdjuL5z2f97B9djYJA4w7aZbf9xYQaGIPn/ODGIUGrX+W+xygSOQXywJFg7kgKYBFgcZDmyApgESBzuWpgCmMT1ncv+AwBXB3TmtOLhlAAAAABJRU5ErkJggg==")


		PNG.BattleList := BitmapFromBase64(1,0,"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")
		PNG.DeadMonster := BitmapFromBase64(1,0,"iVBORw0KGgoAAAANSUhEUgAAABgAAAALCAYAAABlNU3NAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAA0FJREFUOE9lk9tP23UYxn8kMma2MdYUIuzQxAUzcBvZsA2UscEGAjuU0nYFCoUih5Zu0NKWDleLMBHogdKyWkhKmkq4QDmYQEwkRE3M1O3CC73XqJf+Ex/5fZPhhRdPvhfv4Xme932/0tuFJ8g9nkPumzmcPH0cleocpaUXUSjzOa8qZmDwA5LJpEA0GsXn8+EPDLL7o4Nf/xlj+5vZo/hrxGIxxsf9+J4MImkbc6luzeNqVTHlV8pRa9Rcr7xOYbGSs4cEQ/ZBUTQ/P08gEMDhcDDsMpPcaWTzlwaWsnampqYEZmZmWFxcFPlzc3N88mkA6eETCU86n+7H76HT6QRu36nnnKrkiCAejzMxMcHAwACdnZ102BpxJy4Q3FDgftaA3W4XGB0dZXZ2lpWVFZaXl4kn4kjTmQoy32sZf6ajo6MDo9HIvXt3qanVoqlW09TyPjr9A+ru3EJTpaFSrUatvUK96S2abWeov3+Z+tsNtLUZ6Ovrw+v1Hjl5noogffXCxsu/homm7CKhvb1dkHRbuzGajLxTVkreyVyOnXjj8D3GqYICCpRFnClUoihSHr5FlJxXoa25gclkore398hJMj2D9O1vo7z628lcoo+uri4Bm82Gx+PBPebm7v0WKq5dpfxyGWXvXuJaZSXVNyu52XqWOrOCmsYytDdqaWpuxmw2MzIywvT0tFj08+Uw0qvfn/Lznw4+DlmEgp6eHpEkK4jFFsTVyKrkmL5NLwQMjZrwLF3Enz3No4/qhCDZucViIRgMkkqlxA4SSwmk7IGOtR9u4Q62YDAYxB6Gh4dJJBKsr6+zsLCA3+8XJHIT2f7TSZdYrmOqAvtYK/39/aJOJpicnCSdTovaLzfXkLyfXeDDNQU2dxV6vf5wWW3iWuSk/f19kRiJRMR5yurlBpFoBOejIR626+m1Wf9HkMlk2N3d5cXLr5FqDfk02fJ5YNYIAhmyZfkKdnZ22NraYnV1FZfLJWbsdDoJBL2EloYIp6y4fN2isTxCq9VKOBwWNdvb23yx+TlS3qkclCX5VNf8RyAnyovKZrPs7e0JInlMckweo+NxO5vf9fPTHw6moxbh+rUw+Q8cHBywsbFBKBTiX4ecRBuxEaIlAAAAAElFTkSuQmCC")
		PNG.PlatinumCoin := BitmapFromBase64(1,0,"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")
	}



}
Load_Picture_GUI() {
GLOBAL
	Picture := []

	Picture.interrogacao           := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAA8AAAAPCAYAAAA71pVKAAAABGdBTUEAALGPC/xhBQAAAKBJREFUOE+NkVEShDAIQ73/od0l9IWWWnf2fagJBJjxWvmIux5HaO2sAayGh+qFNXDuUdhwWGCYu4J1Rb7GN6WlPzzXqdV5K1a0MCCWjY89PLXwPGQP4x1R075ZpFYB3XDAYewiN/8M88BqqPJ6tjcjH2QtO6IT7y/qogwn/TyfjSzsizQ8qYzAFjKpVIA1wDtuE1QzjtWZc+e/3aE1uK4vs5emMk0TtyQAAAAASUVORK5CYII=")
	Picture.ToolTip				   := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAD8AAAAZCAYAAACGqvb0AAAABGdBTUEAALGPC/xhBQAAAtVJREFUWEe1WI118yAM/KZMFomdPdw96j3cNdw1QkEIJCTxF+e792gcOJ10CNt9+beuq7PG05i7Opqaz8o1jv9RD5gfwgs/GYypBubYJTD2ioQAmQfRjvJE4hE5QJMzkVCBx9o6YD4cpwRFGy6uSSxRo3YkaHkilwLFqmN/OUEnTC3ziVrsm6U04TXX9Wnc8x9I9r4Ej6xdI3BKrcCEwRcQ5msBfaGAPgsZI3JvcUaCCOrYA1Dj2O7ufvPjboztiKQPIORZ9jNf8zw3dp1yBs7tvrnxCtCQ2BvbvAEoasIw5al1gwri5jlyzpoEh8HphTXMl6FQyFc0P1zLCNGjax7BNQelMyw+mW+qvVQhES937gsey1s8opyDmsTBgZuYYJr3sXZOzU/fizzL7vR2RiSrjc5zGOa9QkzG773T7Y+SFzhwf+bN9Zyl5ATtx0DnAbgp0nwwnOdeOgcg1+Dhr/vmIcDq/OG2++K+Zc3n7pa8IYHzcMoXcL7ypkkzCaZ5D9M8P02h5vPb51hybvJNV4Od54Vg8LFB13/iNwa2KcgxygdOKuwT5uN3MiZzELh5/55X/97Sn4wfZh5WOuYh6YfNp4qO7VbcJnZ8zTzB7nzpGwCFwNHCRTi65bGHFX7skaMKQA5snA/KxYu8waTqPPK5eWoMQ3XjCWQeEmNXDcguBMBckSA+aOSRpH9Ignri/MJMQDaPSDXInHxe5ggPPKKGrhsPUWHO7jygZMpCEuRrbFFPQOd+JUcUFTos5wLKnFiP/7CP/eE3FV+3YaQ4YZhDdH4ME1SF4dga0ZiXJ6GHJNHoPM8zXHKHOqGjUIuNr+Gq+XpYNM+f9oSRQstnhH19TUcBFpGPxJHOc36C6Hz9gWdjjj2PTj0X05P5CaERKnE4uxMJyyWnGYGLHVWFlIZ+zBhWGCPOFjSMDwpn8+Pjacy1BvLxd/j+7/aG/sRv+E19NVb3B5jGWtgNhB3eAAAAAElFTkSuQmCC")


	; [HUD]
	if (true) {
		Picture.GetCharacterPosition := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAACcAAAApCAYAAAC2qTBFAAAABGdBTUEAALGPC/xhBQAAEJpJREFUWEetWGdYVVcWPQ9LNEaiMbHGREE6PHg8qoCAqIAFVEQQRcQCKEVRQEFA6QIiIAiCAgqi2KMmZuJgNH3yRZNYEAtVLFhQoybONyVr9j6PmGicb/7Mj/2de8897+511t5r3QPCfYkJpseZYd5Gc/hnKuE4wxBjvQzhQKN3rBnm5prL5+N8DeERagLXACOMDzTGpMXG8E1Rwi3IGGo3A7jOM4LzHCMYmOjCK8aU1hjJtT5rlfDPUGLaClO51muVGeZkmWPqclNMWGAM9yXGmL761fnFxGBeYILeCgUUFG9Q9KcYTDGcQgjxQiheuv9/xqJyFRZuVUngLgEEjnfHoGqjBE6vF/goXmBvtAIfxGmu5Q/r/1fQJl6eO/nSPYXipfsX1iiEZDQgWxMu/kY0R8A+iBW4VSbQXiLwdbrA5ykCbVsEmoroRwTujy/9U4Lu+G/zf4o/ge7eGOXxXKZpMW6n5+DObBC4lK8BdzZb4NtMgS9SBeqT+EfdpaWdyfH/En9sl9+vx3oZYex0Q3guNZH9Tc8UaCRgv+7VsHelUKCjVIGWYoHPiMHDsQqULBHYFCQwrCf1JAVviEvgTc09mXbLYmFBTIkwlY0dVGQB3/VKTFpkjFnJZvBaaQrVOH3oGejC1tMAMxNMEXVQjYkLjWHjYYCltZY0p1nH98wai0T0okTMGgNi5j5dJ/C3DIEfcwVO0fWx1QIbAwUKFgis96Udjl4CMWIGRryhhf69tNCDft+HYjwrkV4emG+BWeuUUsnRx6xkczNYbnQX2gCDc6bk3FfBJRYI3GQu1e+TqHEEVjWr2NmfBMEsXMwT+CpN4AKN3HNf0vXBVQL7ogWOErjyUIFtFNvDCJxhAsS7vhAGsRB6yyki6H4WhvTVMMoAOThxSJUK8yg5u4F/hjkWkhqnRGqYXlSmwpJKS0wgt2Cm1K76cPIxhImlHszH6kmAEtyhGIFWEsDVI6lA40Fc+UsRzu/LkL24PUyBPcsFTsbNQtUyAqcTAvH+fAIZD6HMhTBJhXhvLoGMJlYXoX8P0e1fJpKdJRUqWTInHyoVNTsz6k0+yExFHVbLNmAhWE/Qh4WjHmwmGcB6kr78vQSX6ieAxx/RzRCg4SD+3bAfw9/SxT9/2IVvqMS7IgWqgsfjZDKBk0BWSNYUDIwZNEmDMEqG0A2n5wEY3k9LstjU0YBmCh4vN13E1esNuNp2Ee1dl9B8qwHtDy6h7V4jWm834Bo9u9auiSutF2UIRu5rZIsDy7zxr9bDQPsHeNxQg4ZtMWiuWIGPEtzJ9wTqVhAwYkfBDFmUQIyJpHLO1oxm2RCqLRCWpfSsULOBoR7oSwBb71zSJGumaCGAbZrkrXcZ2CW0dBL4GxQ3CXg3KL5nsCJivxp9tAbDdbi2BPjshx34+ewO3D6+GRcrV2N/xDhiJZEYitOIQZkHod6uKalpBsYQADHSH0J/leYZgzVKIsAbZPnf6aGQyuXGn5WkhEeYiSxj8BYLxJ2yBudP+s5WPmO1s7B4A00dxJzrXCPZzJxYoROKD6PsSRCTcXrdFFT5vU9JV8oSahiihLZ1ENY7JEsKAsdl1e2jgG4vBumnWW9RBGFTA2GeL3+n10+BNZ9ZI55iSqQpzO2pt8gyGCTn555cUGwhrYVFwcxdJqYF+8kA2p3mhdWaRuc+GhOlAcT9pbtMA5BLZ3+A1tVqrk2zCMAm2W8KYm8AGarLcFItK9qqijayGwpi3HRwb8TWW0s7CauxhNt8Y+mPbLScfyIJyDuWFa6C82wjWf4W6kPBHsSqMhyopXkhgbTT7gFhvI4AEGDlRo19MFB1uUapNruIuTJNGXlTtFZhkg4zYpDfJQ8MzCAx/Z52T4wZ2AtuvRXSXji8VmnM1m6KAXmgSv5mdppSeiKrlEXTdIOYY0/ihwr+PHEpODFZwhBiM8x+QPccMcVNz0CYOQ4uLTOtJOaMUzRqJb9jlS4stYAxjSZva2EkgXuQ5wPUx0OP5risDM5+qgHGz9MYN+dn31tUZgErshSpbFKtYEP0IkpDqiyg+zrtuNtc7d5USOWM4jlVsQYQN73hWnpOxkvgFAzacqvGSozXQwx2k+A4uOF9qMnd6BqtFcC9A5hB12oXffIxAwloMglA5iffC6nUHJX4a3GNrEeWlVXCPcCHQv50WFNjo/0IUBMBA3rZMC1ilMvncEQTbCUOh6kFKjQqlf1H4EcFw9NoKJImGiFQ/Z4EyE3Oow6F18Ceki1L+hKM0deRRh1ep5Yq5UPob/l5QywGthnhl6qUjcqI+Qf8MqoBcK0WVnTNPjWEekkCdPyQGNtJ7FI/cX9yMDDqrTmqkVgz3kBGDLGjTYwH5ivll4C/peyn0+PNoKurK78EjqRKBuOXSiX9Q34+ATdevYhm8j1pwnzCsJ9qJKXNVI8iUIEkf94x72D0gJ4wYoDcd2y0I3y6P2FU4hHeiHU1QLqnCVYTsFQPExkh9jroTVWYV2Ahj0AudIQP2WGJyeF8TUd+yjUn01yClvmn0VGpOz+rtfkmCYLVyrvjH3uSQfKYk5Qox7b7lyRz/FK+Z1aXOehike1o+BNTHME2oyRrRTMsUEhR4qPCFgoGu8B6FHqRsPj9v707ZfUaOfIc535V/s6bNyVA8duDbUU5cizdXIywQF/EhMfIBQyQDZSf9SRFM5iECYZY726MtTRGOo7BPOqxFeP0UOZrid3zbFHpb4XSWZbInGyKhbS+F50B+feT3d2QmroSZ76tl/d/BLZtc+7z/O2tzeho74DgifTEOKyIWITslDVwMDVAxJIgxEXF42aHZge85osT9Sgu3Ii+VKp4N0OUz7aUDOVOU0qWuIxZU0xRHWCNA0H2NNpIJjdMNUMclV2LWN9cmoHdlQXYVVYk3/kbsJfzX29rxY3rNyAm2dvC1ckdBTmbUZCWhbKcAhw/WAG/xbNoQRt+evQIJdkFOFB3EGlJWaj/5HP6C0yBgulK7A+yw975dpIxZmk0fR1WkRh2zbWRAGtozPNSyh6cS+z2o77duTUdM7zdsHj2THmO4/wuL+V/9PAemtuaIIJ9pyMhMh4fHalHbVUOTh+vwOcffozNadFob2tG560O7N5RBZXhUFjaOSAqPBLJ0bGy/8pnq7En0FaOzFC0sx50hipk2Qumm2MjAeN5Lj1HKLE7UFuBAf36obI4Cwu8XfGq/E8e/YQ7lFeMVTmiIL8Ah+sqkBAajpKN2fj62GEs8pmPxz89xL07dzB5QgA8ps2A+zQ/BC1eDDclGabDOAkwgxjj0vKYSB7Hyh32Dn3oSbmbvM3lfPFMlRQMe2D4WF0pJC0tLegMoT+gKX/hphfzP330EG3NrRBvvNEfa6PjUVtejRWhYUhaF4kvPzmMorwkPP35CTqut6Mwp4gATsfAgYMREhYIM3MlDEe9C6+xYyVABldB7HG/MZBsYmvMCAXWTTKW9ywSLnX2FDMJnhns3aMH+vYfiBfzL5X5nxApdzpvQgwaNAwRy/xQvjkJ7pa6SFsdhdod5TAZqoeOtg7cvd2JZLIWf5/p2JCZgsrSTZg5eTx03h2CgLl+WB0bIw2XS7hzjjVZiQXSSCCGOlrQGy2gNO4te69mri2BNaJNKTB0kED/115DTGwyXpW/q+seGs5dgAgImoEqAvPNV5/jvUFDsT4qFIdqthBTrui6dwcPHnQhfs1KhMzzx5B3BmPhfH8cPVqN4/sqsKVoI3ZWFWB32V6MHqmAg1Uf6NA4cpgC+gb6GD5Ygey0tRg6WAtWplowGK2AsbExlEol+vfpg+1VZXgx/zCkUP6HXXdx7eoViIzUdHx84mOkJIUjeLYHDlWXov7IHtg4GODvz37Gfeo5Wz0LvNV/GFavjMXx44fw4cG9sDdS49D+3cjPzsKe6hJoU5msrKygVqthamoKfX198J+dKWui8HrPnnB0dIKdnR1UKpUEp03M6euMQXpqBo5z/sTf8z9+2IXGy2TCMVFJ8HC2h83o4YgMnIGSzJVIWBOD8FkLSKl3cIvCdqI1vB0dULG5DJ8cO4ptZduRnpSKWfOmojAvHbvKt8vec3JygoODgwRgZmaG3mTaKTEZ6EfgXF1dMW7cuOfgBhBzLhbeeFX+Gzc60M6CCFvsjqWBM+HupEZJQRzK81OwszIXFnoqNDW14DHJOn/tSgRPc0bR+mTU7a1EwGJfxK4Mx0KvqchJWYtDByv5zzhixxHOzs7P2RtIoOxMTNCLlMmg+bm9vb0E9/brr2PhNA+8Kv/9+524dKER4lDVTpw8Uolv/7oPX57ah7pj9dgQvwWlazLQdKUFD4ni8BBHVBZmo7qgEAlhsYhYkYAViSsQG70MpblZqNtXiqzcFPTr3Rs6w4Zh5KBBGD5gABx1DOGob4nk8ES82asXdIcMwfA335RMvv2mNvISEnGoasef8t++cRd3b9ymU4mPF5Yunoc1q+YjMzmU+ioKarO3kBEfi+st1yiuwtPGAzvLKlGQlYqi/A3YvXU76uu+gNrWCIXFudiYlYJSKq+vsyW0e/XFkAHvI8QnEGtCUzDibQP4TfZFGHnYzBk+KC8pxqa0OCwIcIKnizVelf9Sw48EkEz45McfU1OnIzp8PraRa+dkRlH/COiPVKGjow23aFFEmC+SIwNRlpsHF9NxcFO7I3BmMPKS0rA1OwX7qNSnT59A4KKZmDheRc6vxjJ/X7g5GWOijSNs1RPg6TEN/nO88elf9uDbz04gJ30VirPS8Hv+oOf5z5w5g4vn6bAZFTYBuTnx2JQfTxZSDk97X9RUb0VubBgePnggjfjTw9sROUFJ/leIAD8TavI0LFkciqSYdchZlYi/koK/+uoUooJCYDXGCXrvG8De1gaZ61chOTQKcdHRKCsooS9RPLLWz8HVC9/jq0+/xv7aInD+nOf5t8n8XffvorOjHWLHjlKERwSgqroMm/I2ID4mAnW7a7Bz1zY8e/oEz355gvyNmaimk8TO4kIc3rUFtSWF2LezCl98cAgh4cvReP4M9uzdDU8Ha7pfgMKMdIwY+g5++O4kAfkbvjt1HKePHkJ2YhYWBczHifrD2FtTiraWC+D8y2T+rc/zP7jfhftkxCJh+VzkJ8Xho6PHsIXorS5KhZvOYIQvjcT19htE8dkX/g/sNM2elPn7/R+vY4LDsIH8bgmp831SL8/tKM9Gze7tz9dsyc3H0V1fozSzBMmJZFuvyH/lwjm0t18n5lKTkLBsKSryS7AtrxR9er+G8TY2RHUZHtAXguv/TY/RaNXSxuYeU6FNCVwp8V0CcImABPXQwqlTp54nNyKwl8gm2kmVJrTu2EH6o4jmec2FC/RJousD+4pw4pNa1BYX4U/5yZyvNDais5OYS45NQ4C7J+rKSnD2y2/Qt+8gTBw7mZo9nT6+dyW4rrOX8SuN/6BopuA5ZvTfNP797Fk8aWrCT52dcv7x48f45eFD/FM+O4Mr3XMcz375BY/ofMjrfnn6FE8fP6UD7S20XL1GRNzFz0+e4vvvf8TVy9foqE5W4mo5k76N1di2oRLWSjvMcZmE2W4z4WrnRD3R2g3kDJ6dO4tfqbeenf0edwnYTxQMmB7iX5yMQLbQeOvWLTw4fx7/IGD8/Geab6Kxq6sL9+7do3K1y/c1nDv3/N2/RWNDI1quXEXzlSZi7zL+A/1PXOuLf869AAAAAElFTkSuQmCC")

	}

	; [Healing]
	if (true) {
		Picture.UH := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAABEAAAAUCAYAAABroNZJAAAABGdBTUEAALGPC/xhBQAABGVJREFUOE8llOlvVGUUxm+nM50WqGiny0xLO9NZ7p3eZaYt09IF6UZLN1paWltaSKCKZbMGxVqKULpDF4KJLCICcdcAEiVGg5Fo1A/Gb0TjkugHxcR/gp9nrh/evLnvPed5n/Oc57zKtps/0XnvT/r+fkT3N//S8v4DGl//luqpW1SduEmkcZK0tCJSU30kEgl03SAcicgKE9V1YvEYSjK57+EjOj77nfrX7tNw+Wuar/1Ax93faP/iD+pW71E5/g5a2wxOVwFlZaUYhokv34emRjEtS0D+esTGg29Q0j5FfO959O3TxIeXMHoWsfrOkDh6gy3nv6Rq8kOiHTNkZGgCYgiAhr84gGWZKB13fiXaPElJxxTRtlN2stZ8/P+zrROyH6ds/0U2L3zK5uXPCcRHcTkLMM0Y+Rs2UFjkR2m9/TPq1uMkDl0hvuc8Nadu2klq40sY3fMYnadln5V/56gaf5fEkasEKw7hchVSWlqGZQqTrvv/EG19BatrVmp/zw6uGLuOOTxPaloG+s5ZjA5ZPXMC8Ca107cxB5fIy+nEKYySuiittx6gt5+ipO0k1uAqpU9fkKBFCmp6cDjdrPHIjfsuYIhWscFlqsdvkxi7gS7s3O4wqqqi1M7dJbpNmAwsYfafwRxYICtSSfnoJbylrTQt/0hurIXYrmWs/mViu0X87tOYO+eJNEzgSPWiVE/fItpyArN3kdjQOTyRGqyhs3annO616H3CQADW5PglZhbzqRU71tgxgzV8jlRHNsqmF98SJieE7gwedRPO9HWszQ3hcLlQFAWHwyXfxaQ4nFKek6oDH0kXT6I2jBPaeBAl5XGUqokPMPvO2mzK9l4i26ij4sjbBJ4cIUVJpbB6gPrF73isQEfvmiE2sCqlLBCuGsObt0PK8aDUTH0sWpy1f5j9i5Ttu0ymT5XgJWFWS+mzF8nW6jEEwExqIt3TO6cIlo+Sm9Mm45CH0v7JL1i9C7YX9C7xhNQaH1olIzNPAlx4Y21yNofROydazGHtWiFcOyYtbsXn3SnGyxeffPWQ8sNX0MUHhqiuNU8IqAgn6qev81Fz4I4tpNk7T1xaHNx0iKLIbnI8LTI//XJRDkpUZqbp6vd2i/XuaduNyTnSt09R3n+JkkaxfsskldKAkuZxCgND5BcOCoseMtdVEAoGUVIduVQ8f426V+/ZbIpLR9EaXkbbchS15hjF8f1odcdQ64+yITCMN7cLrwB4PPWkpKy3h1FRNZX09DDlz1wm8dx1gpWHyS/oJ2CNYHbMozaN28De3G5ysltk77QFTUl5AlXThEkIJSDjnPzISA8RG14hvnsFvz4itw5SbIzgl+Xz7pDEbdLS7XiymuSR8hORh0k3DaLREmEi3rdfqWiUNHfA7pJa/wJF4T34S/ZJYo/Q76XAP0SWZ6t4J5NgKIQh05u8PBwOoyQRk2z88i4U+f2idpYMVrEwC+OWG91pQSlXFeeKqaQETRK9Pp/EF6GLHqZp8R/RKmb9x4Wt6AAAAABJRU5ErkJggg==")
		Picture.ManaFluid := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAScwAAEnMBjCK5BwAAAbhJREFUOE+llEtOAkEQhvsaRN7Mi2GGhBDDznvg2htwAY5hNHHJVYyncMdCWYiujDFlfQWlI6CSWMlvm5ruj7+rqzuIx9ONrC6DhBAkzTKJokiSJJE0TU1xHEu/37d8Phjot1Ra7baUZWn5DehRBxUgwmC6OM/zCiyTdqdjwG63q4ChnNTr0mg2pdVq7YPWr++m+PRM4iQ2WK/XM+BwODRIoS4ajaaMRiMpikLG4/EWtN2Wg+bzuY04O6S2bomt8QM4Ba75DcudXF0EWSwWBqvmq8It63CJrEaZFpYkEzxerp8NRm51/vBNd7Xbb0CK39Q6Bf7JlEjyfv22RX0Fi2ezmWk6nZqAORATk8lkA6KIjMCWy+Wn3EFVDqyCirKQQKEonoP46HEIhKowAljgeOkFirZbq59AaA+0OcLUj9BAAIjfQLhiJAzE0QHB2b9A3gfVrR0DchEGihWAI4d5wY+BEUBsNyzO+plBuPXuivgLxjzmc+dCR2+0PxOInnJX7szlAHrMIdwMKwt/rLs1gSNg3Gjbt+pQ+LdEDbCW9ymwkIbkTeHO2ClqS1Rhu6rVajYfAE9KFEXyAYIq9dxzkNqhAAAAAElFTkSuQmCC")
	}

	; [Combo]
	if (true) {
		Picture.HMM := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAwAAAASCAYAAABvqT8MAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAScwAAEnMBjCK5BwAAAxZJREFUOE8lk3lME1Ycx19bztDJMVEhoydHCaUNlWMZ1AIN5VRMkYoSgohxKHYGtYNI5oHMoBziwWGIEWVhIvGYikZxCw5mjEdEYzKzuGV/bNkiRJP5h8c/nz3LHy8vL3nfX77XT4xX/8m77g+MrX1Ou/MC++xnGVg1w56cM+y0dSGEAp1eT0JCAgaDETHX/o5/295ypGTS/7mr+Dq9xZN0OC+za3mPBAisFgsGowFzqhnxpvM9P29+RZtjlAPy1KS1EKQKYXdun39AldGLQoLMZjM6nQ7xxPeGwZIp2vPO4804TKAqmOCAMD5bpGdo5T186cep0nuJCIglOdmE+GXLK3pcE7RkD5ESncnXX/RTlFDB8VVn0UbEMyxB9Yk+MsOy/fTElKQzUvGU/Xnfs8cxQq/rJumxTh40/s6l6tt0FlyhNesk6w1b/QaIK7X/cK32b7oKJhguf0RX4VUsS+2Mr73PQNk0Q6sfsD2tg3y1k3BVFKKzcIJr9XNcrPmLb3PPc7jgB5I/UrP3cUJqO1byI81Z/VJ8A+bQDIQ7vonT7kfc2faagwWXWKbWEh6yGENUCrvsHRzKv8h+x3dss7SjVkUi8pdVM7buN6njCZ7UJrxZPcQuiuVo2Sgb07+Uwx6zV4ZYl+QjSBmKsIW7GHbPcqr8IZ/HFUneM+gjTTz+6jX16TvpK73D7sxB1mjrUSiUCGOIjdHKXzldMUtiVBrjnj9ozhni3tY5fI5exqpeMFh6mw1JzQu26oKtTEtrz3meU2NpQReeTGNmJ984zsh3E3e3vGWHrRvXEs8CIFImOOv7jxt187IeY1LgKJUpDXjMXl7ue8m56hekhC6nMGYdgUo1QiFU3KidZ3LTPEeLbtFf/BO9sogDpVOcWn2fWlMzWZ/kYVPnLgRnMpkIUUYwUvlM+j1It3Oc1oxjskMncGsaWBHtxrV0vSxgAEajrLdGq0Wj0fjRbfZhGs0HaEjdyxrdZlZ8WkZ53CZJI4ikxCRiYmIQ8XIx/NWVS/KxxpKjBKtYEmggTLmYYMnbarWSarXI28r/O2i/itRfnjEAAAAASUVORK5CYII=")
	}

	; [RuneMaker]
	if (true) {
		Picture.BrownMushroom := BitmapFromBase64(0,1,"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")
		Picture.BlankRune := BitmapFromBase64(0,1,"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")
		Picture.LifeRing := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAB0AAAAdCAIAAADZ8fBYAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAABR5JREFUSEs91suKJEUUBuDc+Qr2pe6ZlVmVlVXVdekem3Kh0ygOA27FFhmctRtlXPkCs3TtXhwEfQfBhRthBnQn+A6K4oiO34no6aQ7OBlxzn/++M+JyCoWi8VyudxsNvP5bD6f93q9rutms1kzm1kqy3K5Wk4mE8bp6WndNItFy83S2dmZQPOc82h+Op3O2/mknBTtop3WU36r9bquax7Gtp0H4rIbjoZAd/tdhhgMBil+JqRu6pwA1ng8zoFso5BiNuc58x7EV2u2AGTFYNQ0DayqKtfrWOL26tEROmUVBNOkHSzg8rRaVZWo4XBY7HY7C5IYuaLPtgxZ2u12OxwO8jbzxvmzLZFFbirRLfMFNxr5G7VtW3hfrVY50tMtl+JBZ9fbnQIajyfUN5kdzJycnHCAYgyy08qq/RkLFDzEDsnqmixGM+v1WU4mwCM3XmkfUSWsYZUE4oP1csln0XVIwGUX/jfbzWA43Gy3XIkrEgV0LFEjCxcNUZYMT94N1m27ODo+qutGSrGe8WRslZF0WK94M9Qhw6kbREZlb4CaJoOK8dyyJoE5nG5as6n162g0xrrQGurLoh0KEMXbixnSsUNNEYnFS+hGdaBj3XXLk9PTXr8fslYlWpblKDQjS3LV1H8agLcZr5YzECPEnVag84YIyo2gvV5fYiQE0oqD/clarNerRbeAAlodqGlNcpEm/vn941TVtnj5PP3hlV4Pwx4sUfImjo00+iLrE3xxlDBRq/jd6NvUxIH+3/PvvYJ7/9mbD3+7B1Qmo9PR7/dFZXE8bIdzNB6ZMVucnBzbqa6CaLOyecVaPNAXL/4ysq9/vnv15fbdbw9AH/3xQCZZM6hRlDSuDiDOhdc4b6nsU4ajJa0SWFBAI1BMgdbXvSRDcfXF/rt/v/nwl7fYmS82qFxcXFCMOEcOuvvB1P58ryZZ2Ua3pK661ffTPz86+6SEYhvCGPefvPbo74cMEFhD0BuKJIlOlUZrFabEOxTpDoyLAroi5EoK/vz5Z/eeXDDyZcRANkuh7ql5GkCxRtnUQiYDt9fvaRGIODbNTFfw0JI8BF//dGXjh8cd2/POV+cPfn37/teXbKigo9TpulB/IZFjNte/obrZPPIww5BGWoZ47LAmyHs/vgGUOCYhOl3pgxA9e3x8fHl5uT8/j3D3OubumgwK2xu4PPKgBmwoWH/w7Or66d3cJ8akQBwo18v5xUXwqkri3rlzR2Dw9QCKc+IZxanzmDG6gEyxQd8+QF1PuRKWMicVy51ADZ+eolt2eoBTFHQ2U1+Ky5FZJ+j4yulKPlRiu9HVwL2qGPl2zVcwskaxh8OBDo27NZqradSNE0Rwkhk1SZKnFGm0VV0ht0lZLaApJNOU2+kIitoxrEYnRG+D5q2XM7sgXlWSGWHl2yPPi1I3r2yfLgYS+CKbz+FNP6CT9hI3uhlOJgMlRcofbre4llM8mq2vVBInPkf8fEMnKl0WZ5ubnwHesSYLyWApoch8uXAUYBOheKpq3lA+bxBdmBDiO52+fnHeLNPXI5JYGElLDwaCJu0XUGaDdd4Qf19YI2gM5Mv79gwGw91+H/0LOm8wCRxlpJSa+dzyE+5rwEiTN/2X9VHhw+F1J5PNwbbck2pLmdAXWmqaKBpwHia3uy1vEAkxfkpRDV2vSYexYEBxcPwiqKa2Y8k8n+1uF/d62llsnIfN6moecticXNTA1FXgVSbKZgciSiWH0x63RPySCzEpXtf1/+GHvFsRm+LXAAAAAElFTkSuQmCC")
		Picture.WhiteSkull := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAB0AAAAdCAYAAABWk2cPAAAABGdBTUEAALGPC/xhBQAAAopJREFUSEvt1j1v2lAUBmD4b8jsZKVS2YpEYDcS3go/gWymSLDAUmboZq8IlkbYC4SPAYzEhwkS0el5jz+gaqvIqTs1R3p1ETH3uffm2JB4r/+6KJHkYPwlSYwxVVImE+xyeaHT6UQu53g40OHIORxltCzruiBvfHMxdAkD8HRyBV0uFpLFYsmwhyKFQkGCz3pTRCuBXCCuS0/zOc2fOBhvgvcXjAfol2YzhJMR4RsQx+kKYFm2TCygv4B2q0XtdpvTotFoLGgT8H1kOClHiB0GOw0CINglXmMhNmc0GoUBWqvVoqOr1UpA0zTIMExKKwopnNYNil3X63WqP9Tlb7mPOdIqmqCaVon8vxUUAZrJZGRSpN3CUV7hB0YVJU25XE6iaRpVGFRVNRqKIwFo804+V6t0x6gHp2nrbMlxHOlkoLKYtELFYolTpOVySd1uNzrK5TeNTVVGAWYyd9Tv9xn0UW4wxLZtWUypVJTj3W4dfs8S9D46akmDoHuBBNBut6M9J5/PU/5TXhYCOLgGwW7LjGaz2eioxSt2eOXoWhzncDhkcE+7vY9ygCKADMMIR+w0Koqiht6gx++P1Ol0BLxNKpWSADBNkwzpci9otGz2A2Nvex6TznCJGwRN0ulecYDT2TSEEFyDa8tq+e+fv5PJRCZ7Pj/Lk2q93tB0OuVxTSbfwxgHg2+ClssMRjzS35WgCCbH7vb7vaAYZ8A3G0YHkthQvdEI0fP5LOBO4Fm4AGC6rseGohjWaeOjwIHhmPEaEKJyon6zvFbyMA92Kkftj8Eu4wZRcgsF3yRfez3qcdCp3rGqsR3rT4Wd4BYCAnjMAfbPwJvy0bHAcTbOa+VD/o+29/pjJRI/AHMYxWgmkLXvAAAAAElFTkSuQmCC")
	}

	;CaveBot
	if (true) {
		Picture.Mark1 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAACwSURBVChThdG7DcIwEAbgv2QQeiRKaGzp/CIxpqOiYQwWyBAMwQBULMAIrBJ8gQTHtkRxsXT3nS86Q2uNpmng9wF6s+7zsNZCCAGlFGCMGTAX7teuCM5L+cX8GeHrcZvFqtv29Dx+psQ/+AsX5+U0YcJcYJBCPqs4BSm8nFyJuVCDPKnAnBwbUjjDUsqioQZ3cb1wzsWH+a0vD87z2rz3QAgHEBHath0a8mBk44VEhDccC/Uc7j9DvQAAAABJRU5ErkJggg==")
		Picture.Mark2 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADCSURBVChTdZEtEsIwFIT3Br0LDlTDpGn6E4LiFtwBh0XgkMxg0R0wnALHVUL3QTolHcRWvP3eZucVxhg0TQO38jCLWUhlrUWe5yiKAijLUmC/nIfbaT8R50p9YX44uJ+PIcvCINS7cNhuwrO7yAIbyNNMiEDUeIE+OYG5TYPpUWn6D/x6XEVpDc7+woTG4ARmp2ikqdTQWSkl14jpaTLn9Ov+vKiqqv8xn/MxIVU8m3MO8H4NrTXatpVKqQjZPlBrjTfj4PpBuvO0AgAAAABJRU5ErkJggg==")
		Picture.Mark3 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADcSURBVChTfZEtDsJAEIXfcaqRqG6y/aNdiuIC1dwAww0QHACLwoLEcAGCIkFiMDVYlnlLt9mUBPGa5s03b6ZTpGmKsixhpjXS8cgOlec54jhGkiRAlmUOZmG9mNsHYHcivlP0lepgPmgcNkt7FejdNPYSNNB3U2SDPvF+2rvUl6gNYPp+goNpULcOZtM2gKkfmDoLdOzA/ar5D1OEQpDq4XBcG0V9svf6nZVSroFfzcJTQK7iYX+NiZwXRVHIj/mejwCLfg2fyLMZY4C6nkFrjaqqXMNQhHIJ1FrjA6AM9cIyzsKsAAAAAElFTkSuQmCC")
		Picture.Mark4 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADMSURBVChTbZEhEsIwEEX3IBiugGAGVMKkaUobguIGSM6BReAwYLBoBsUpcJwAhQFX+he202QQr012XzbbLVlrqSxL8rNAdjyoU5xzpJSiLMuI8jxnOUxG9e18ZJ7LfrtGXOufjIeI9+uJgXzZrXktB9ABX52K7/0wOoA3PJaREB4HW7+2PaYbb2VURkCkLohvVotYlhb+ichFslRPiWStNU8DCfkgAXvEkZ8246WiKJof8x1fVxRkbN57ohDmZIyhqqq4pRRIrilojKEPBhYIz9qgmfUAAAAASUVORK5CYII=")
		Picture.Mark5 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAACiSURBVChTpZHNDQIhEIVfC9uKR0+QDH+yiF1ZhB14sQBPNmLsZGU2OxhGbx4eEx7fG8gA7z1yzijHCr/fLVoxRhhj4JwDQggrzAf3y/lL7Fu7wbwIeJ2m5fm4dfFeAvyCAWxOD3B9AUOgwxqQyv5PWAfE+6+zBriKOmytHQJytQQEPLTxIqXUPuYzPi32eWylFKDWE4gI8zyvAS2GYmtIRHgDI4PyNhWFoQsAAAAASUVORK5CYII=")
		Picture.Mark6 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADASURBVChTY3Bzc2Pw9vZm8PXzZ3CzMvqPjj08PBgcHBwYXF1dGRjc3d3BikESu2e3Y2CQuKMjVDGIgCm8d3D9/2pdBjCekBsG5sM0gFyAohCEc7RYwBimGFkDXHG8GgtWDNKEoThCmQUrxqoYZmWQAgsYgxTBME7F3rLMYAxSBBODK3Z0dETR4CbNBMYwxTCFXsDgZfD09ARGDCL40DFIHBRsvr6+DAz+/gEMLi4uDD4+PmAN6BikyANooIuLCwMAnMDsWtpAqCIAAAAASUVORK5CYII=")
		Picture.Mark7 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAEFSURBVChTY3Bzc2Pw9vZm8PXzZ3CzMvqPjj08PBgcHBwYXF1dGRjc3d3BikES9w6ux8AgcUdHqGIQAVNYycAAxuhssC1AF6Ao/Kgm//8gkM4E4ttA/FRSBEUDWDFIIJGN7X+ysvj/nz9/wLE3H8f/YEaIDXDFIJ0VzMz/ObnY/uvraf43MTH4r6Ek+58FqHAaE+P/HVNqUBXHCgn8P87J/n8z0JTtQAxyzhUudrA4hmIQruXj+l/Ezvo/H6iwGKiwUoDn/4TcMIRiR0dHuAaQBDqGKfQCBi+Dp6cnMGIgwQeSQMcgcVCw+fr6MjD4+wcwuLi4MPj4+IA1oGOQIg+ggS4uLgwAC87fj4ox9goAAAAASUVORK5CYII=")
		Picture.Mark8 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADNSURBVChTfdE/DoIwFAbwb/Ykzg5EnahpCwgV2TgBTsRVTuDCDYyJk5txNk5OHqGbV6n0RYj80eHr0P5eX/MKKSXCMIRaxZDzienG9324rgshBOB5HuF4MTP3w74Xu8/YB9ulhq/HtZViDHNiIyqwL6DW/2AB0Ll1g/gbPi/HYZwkiUnTtAXtfg8Xu53RWlPB1HEaOIg3WWbKsqSbf2LGGE1jm+eEulDfzjSNZTVeBEFQfYxoOnRTj00pBcTxGpxzRFFEBd1Y5FcXcs7xBqhX/ePOdBkNAAAAAElFTkSuQmCC")
		Picture.Mark9 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAD1SURBVChTY3Bzc2Pw9vZm8PXzZ3CzMvqPjj08PBgcHBwYXF1dGRjc3d3Biv2dLP/vnt2OgUHijo5QxSACJGCqr/0/Osjn/+19a/7fO7gejq/vXAbWAHIB2GqQCWGOFv8/fvz4vzgtDkUxCIPkQerAikG69y2dBtbw8OHD/1U5yWBFID6IBsmjKAYJwjSsWbMGTEe4WP/fs3gKdsXIGhY4coHpjbO6URWD3ARTDFIAwzANcDc7OjqCQwPddJCJIIUuuvLg0PACBi+Dp6cnMGIgwQcyAR3Dgs3X15eBwd8/gMHFxYXBx8cH7CR0DFLkATTQxcWFAQCuMgHnkR/dmwAAAABJRU5ErkJggg==")
		Picture.Mark10 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADTSURBVChTY3Bzc2Pw9vZm8PXzZ3CzMvqPjj08PBgcHBwYXF1dGRjc3d3BikESu2e3Y2CQuKMjVDGIgCm01xb6f+/gejhG1gByAVwhSBKkmJHxAxyDxE6umAzXgKHY3v73fzOzb/81NB785+O7DbcBq2Jkkzk4roE14FS8dkIdCgZpwFAMchtMMUgjDIPk4IodHR3BGnZMqflvpCqLohikCCQOkvcCBi+Dp6cnMGIQwYeOQeKgYPP19WVg8PcPYHBxcWHw8fEBa0DHIEUeQANdXFwYAD7p+deHYgt9AAAAAElFTkSuQmCC")
		Picture.Mark20 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADRSURBVChThZExCsIwGIXfTQRnJ3FQp0bSNrWNEQ/iHXTQC7iIk4uDi+AgiJOncPMqsS+aUFvE4RX63vc3f16RJAnyPIeeGCTDrq1LKYUoihDHMZCmqYPNaGBvu3VD9IX4wHzQeFwP9nk/NUSfOTdwR++Xc3vZrn6KOTkHY9b6qwCfNwtntNcd2z/2gvhOn3mAuRePqw54kD7zAPPWvEx1wIP0mTtYCPHVhh/woG9jXNaLLMvKH/Our9qvl69Naw0YM4WUEkVRuJXqIqTKD0op8QL1T+9nuSdhrAAAAABJRU5ErkJggg==")
		Picture.Mark19 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADNSURBVChTY3Bzc2Pw9vZm8PXzZ3CzMvqPjj08PBgcHBwYXF1dGRjc3d3Biv2dLP/vnt2OgUHijo5QxSACJHB957L/9w6u/79tZtt/hiB5MA3ig8RB8iAXgK0GmYCsUKldB0UDSB6kDqwYpBtZocUqExQNIHm44k1TGlEUwjBMA0gerhgkQAjDFS9sygNbhwuD5MGKHR0dUUIDHcNCwwsYvAyenp7AiIEEH3L4wjAs2Hx9fRkY/P0DGFxcXBh8fHzATkLHIEUeQANdXFwYACR872ed2YVWAAAAAElFTkSuQmCC")
		Picture.Mark18 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADASURBVChTjZGxDcIwEEW/EEgoQmIXOqhi5NgOiTHbMAJD0FOGGkHDANR0NAxi8g2JgtOkeJF19/xzOkMphaIoYLcOarXwMcYYpGmKLMsArXWQ3Xrpr8dDD9aF+Mn8sPC8nPzrfg7sE7Rn1tnnBOHXTOiKXZmwTy/ITSqlajL1t3HSXiLs/8ksUnpjHniMZu2lntxNJk1qTx48sxBi0DY29XqR53n9MN/1MSGmWZu1FnBuByklyrIMI8VQMnWglBIfPSH2n7HzyUsAAAAASUVORK5CYII=")
		Picture.Mark17 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADBSURBVChTjZGxDcIwFERPCCQUIbELHVQxchybxJhtGIEh6ClDjaBhAGo6GgYxOYMjlICU4iL7/vuXr28opVAUBezaQS1mvi2tNdI0RZZlQJ7nAXbLuT/vdx3RF+ID80Pjfjr4x/UYtE3QnOmzzgnCr5kQixH+bmCdXIDZHQHqMkx8NRo3Dax3YEK3wcQ/MQ3inf5POIqpf5N7zyyE6LWNVb1eGGPqh3mvjwltxbVZawHnNpBSoizLMFJbhHQdKKXEC/8a9p8j+6uiAAAAAElFTkSuQmCC")
		Picture.Mark16 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADFSURBVChTjZGxDcIwFERPCCQUIbELHVQxchyHxJhtGIEh6CmhRtAwADUdDYOYnOFHJGkozkruXs5fPzDGoCxLuLWHWcxCV9ZapGmKLMuAPM8j7JfzcNnveqKv1BfmQeNxPoTn7RS2CRrxnT5zThCvZgMDga/DpIEp5uQiLK0C3weTFsy8BTOU1hem4TgaN14PllZCv3Cv+e+ZlVKtbcgH8kyf+apeL4qiqH/MZ31s6ErW5pwDvN9Aa42qquJIXRGydaHWGm+/Dfaf/Gg2TAAAAABJRU5ErkJggg==")
		Picture.Mark15 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADHSURBVChTjZExDsIgGIVfjCamMfEubjoVQynYIt7GI3gId0edjS4ewNnNxYNgH4op7eLwoH3v4+fPD5RSqKoKdu2gFjPfldYaeZ6jKAqgLMsAu+XcX/a7nugL8YW50HicD/55OwVtM/y+6TNnB+FqVmiD12GWHGBOLsCxKoHjaOxfmIY9HmCewAxi1TZM9eB4JcP7YBL26CXw3z0LIZJpEIriP33mq2a8MMY0D/MZHyt0FcdmrQWc20BKibquQ0tdEdJNQSkl3nhg9p8kmSrbAAAAAElFTkSuQmCC")
		Picture.Mark14 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADUSURBVChTY3Bzc2Pw9vZm8PXzZ3CzMvqPjj08PBgcHBwYXF1dGRjc3d3Biv2dLP/vnt2OgUHijo5QxSACpvDKzuX/7x1c/5+z3BxMwzBIHuQCsNUghTBFIMyRZwxnr51QB5YDqYMrRpZkS9MD0zCFGIqRTWaN1vzPnqYPxjgVwzBLsCrYVGQNGIqZfZQwMIqbHR0dwaEBEoC5k9lZDs4GYZC8FzB4GTw9PYERAwk+kAaYJhgbFmy+vr4MDP7+AQwuLi4MPj4+YCehY5AiD6CBLi4uDADh+/TizSB1fwAAAABJRU5ErkJggg==")
		Picture.Mark13 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADtSURBVChTddG9boMwEAfwe6Zu6YQT81WgRJm6Zuqj9BUqIdQFRTKLIzFFYSAbIwNSEEMHxHtcuVPdCmiHP5bOP5vTGRzHgSAIIHqOwXl8wGU8zwPLssC2bQDXdRnH2w1+3vQqVBfiG9PHwNfjcRVzgDrgXxvY9z12XYfjOGLTNFiWJb4cDrxPbobrukZ3t8OqqnhN0/R/PAwDQ0pRFKi1/hubA9TGR5KgyjKGN/U+x9fk7Qe3bYvnPEel1BoLIXga98uJiwRMCFKd9p+m8YLv+9PD/I5vGTO2KIoA4ngPUkoIw5BbWoaQN10opYQvBegMoyZsDZIAAAAASUVORK5CYII=")
		Picture.Mark12 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADuSURBVChTY3Bzc2Pw9vZm8PXzZ3CzMvqPjj08PBgcHBwYXF1dGRjc3d3BikES9w6ux8AgcUdHqGIQAVMY7WEKxgHminAM0wByAYaJIMWV4RZwhTAMUoeiGKRwfmXI/6Igk/9VEZYoGlAUgxT+f3H0/9q2hP9zyoPBGiJtlVGcAlcMEryysub/tfUt/2eXB/1viLH8XxRoBBbfMaUGU3G0tfz/zgSr/x2Jtv+zvXT+p7lqoip2dHRE0YCOYQq9gMHL4OnpCYwYSPCBJNAxSBwUbL6+vgwM/v4BDC4uLgw+Pj5gDegYpMgDaKCLiwsDANeX7yvmWiwGAAAAAElFTkSuQmCC")
		Picture.Mark11 := BitmapFromBase64(0,1,"iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAADTSURBVChThZG7DcIwEIb/BkEBJQxCSRVLTuI8TFiDhglgBGigYwE6qBAKFSULUCFKaBArHDmDozyQKD5b9n3/yTrD8zxEUQQ9TOAN+lRFKQXHceC6LuD7vpG5cN4sa/C9EF+ZFyveTlsah60cPtsAv6AkTnTT7JZqwMi2yHKxs5WZkszi894jItB+3aBrCkrnHRM4rKZ1+fXoGnmmQJcd6Lho/5dZ/CkLIfKAfWcRK4bZeBEEQfYxn/FxoQrf89i01kCSjCClRBzHJlCFJZU1lFLiDbbd9GaW40BhAAAAAElFTkSuQmCC")
		;[AUTO GROWTH]
		Picture.RenewGrowth           := BitmapFromBase64(0,1,"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")
		Picture.GoldConverter := BitmapFromBase64(0,1,"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")
	}



	;~ Picture.zzzz           := BitmapFromBase64(0,1,"")

}
BitmapFromBase64(BitLock, Type, B64, NameFile:=""){
GLOBAL
VarSetCapacity(B64Len, 0)
, DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", StrLen(B64), "UInt", 0x01, "Ptr", 0, "UIntP", B64Len, "Ptr", 0, "Ptr", 0)
, VarSetCapacity(B64Dec, B64Len, 0)
, DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", StrLen(B64), "UInt", 0x01, "Ptr", &B64Dec, "UIntP", B64Len, "Ptr", 0, "Ptr", 0)
, pStream := DllCall("Shlwapi.dll\SHCreateMemStream", "Ptr", &B64Dec, "UInt", B64Len, "UPtr")
, DllCall("Gdiplus.dll\GdipCreateBitmapFromStream", "Ptr", pStream, "PtrP", pBitmap)
, ObjRelease(pStream)
if Type
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "UInt", pBitmap, "UInt*", hBitmap, "Int", 0XFFFFFFFF)
, Gdip_DisposeImage(pBitmap)
	if (BitLock && !Type) {
		Gdip_GetImageDimensions(pBitmap,nWidth,nHeight)
		, Gdip_LockBits(pBitmap,0,0,nWidth,nHeight,nStride,nScan,nBitmapData)
		if (NameFile != "") {
			Gdip_SaveBitmapToFile(pBitmap, "test/" NameFile ".png")
			MsgBox, % "Saved File: " NameFile
		}
		return Object := {Stride: nStride,Scan: nScan,Width: nWidth,Height: nHeight, Bitmap: (Type ? hBitmap : pBitmap)}
	} Else {
		if (NameFile != "") {
			tmpBitmap := Gdip_CreateBitmapFromHBITMAP(hBitmap)
			Gdip_SaveBitmapToFile(tmpBitmap, "test/" NameFile ".png")
			MsgBox, % "Saved File: " NameFile
		}
		return Type ? hBitmap : pBitmap
	}
}
EncodeBitmapTo64string(pBitmap, ext, Quality:=75) {
	if Ext not in BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG
		return -1
	Extension := "." Ext

	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)
	if !(nCount && nSize)
		return -2



	Loop, %nCount%
	{
		sString := StrGet(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
		if !InStr(sString, "*" Extension)
			continue
		pCodec := &ci+idx
		break
	}

	if !pCodec
	return -3

        if (Quality != 75)
         {
               Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
               if Extension in .JPG,.JPEG,.JPE,.JFIF
               {
                     DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)
                     VarSetCapacity(EncoderParameters, nSize, 0)
                     DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)
                     Loop, % NumGet(EncoderParameters, "UInt")
                     {
                        elem := (24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
                        if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)
                        {
                              p := elem+&EncoderParameters-pad-4
                              NumPut(Quality, NumGet(NumPut(4, NumPut(1, p+0)+20, "UInt")), "UInt")
                              break
                        }
                     }
               }
         }

         DllCall("ole32\CreateStreamOnHGlobal", "ptr",0, "int",true, "ptr*",pStream)
         DllCall("gdiplus\GdipSaveImageToStream", "ptr",pBitmap, "ptr",pStream, "ptr",pCodec, "uint",p ? p : 0)

         DllCall("ole32\GetHGlobalFromStream", "ptr",pStream, "uint*",hData)
         pData := DllCall("GlobalLock", "ptr",hData, "uptr")
         nSize := DllCall("GlobalSize", "uint",pData)

         VarSetCapacity(Bin, nSize, 0)
         DllCall("RtlMoveMemory", "ptr",&Bin , "ptr",pData , "uint",nSize)
         DllCall("GlobalUnlock", "ptr",hData)
         DllCall(NumGet(NumGet(pStream + 0, 0, "uptr") + (A_PtrSize * 2), 0, "uptr"), "ptr",pStream)
         DllCall("GlobalFree", "ptr",hData)

         DllCall("Crypt32.dll\CryptBinaryToString", "ptr",&Bin, "uint",nSize, "uint",0x01, "ptr",0, "uint*",base64Length)
         VarSetCapacity(base64, base64Length*2, 0)
         DllCall("Crypt32.dll\CryptBinaryToString", "ptr",&Bin, "uint",nSize, "uint",0x01, "ptr",&base64, "uint*",base64Length)
         Bin := ""
         VarSetCapacity(Bin, 0)
         VarSetCapacity(base64, -1)

         return base64
}
CorToDec(hex,ByRef Out:=""){
GLOBAL
hex := "FF" SubStr(hex, 2)
, VarSetCapacity(Out, 66, 0)
, val := DllCall("msvcrt.dll\_wcstoui64", "Str", hex, "UInt", 0, "UInt", 16, "CDECL Int64")
, DllCall("msvcrt.dll\_i64tow", "Int64", val, "Str", Out, "UInt", 10, "CDECL")
return Out
}
GetColorDecimal(X, Y){
GLOBAL
If ( ScanBit && StrideBit && X>=0 && Y>=0 && X < PNGScanWidth && Y < PNGScanHeight )
return NumGet(ScanBit + 0, X * 4 + Y * StrideBit, "UInt")
}
GetColorHex(X, Y){
GLOBAL
If ( ScanBit && StrideBit && X>=0 && Y>=0 && X < PNGScanWidth && Y < PNGScanHeight )
return "#" SubStr(Format("{1:#x}", NumGet(ScanBit + 0, X * 4 + Y * StrideBit, "UInt")), 5)
}



; ========================================================================== [ LIBRARY ] ==========================================================================
; ========================================================================== [ LIBRARY ] ==========================================================================
; ========================================================================== [ LIBRARY ] ==========================================================================
; ========================================================================== [ LIBRARY ] ==========================================================================
; ========================================================================== [ LIBRARY ] ==========================================================================
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
; Supports: Basic, _L ANSi, _L Unicode x86 and _L Unicode x64
Gdip_BitmapFromScreen(Screen=0, Raster="") {
	hhdc := "" ;fix warning by vanguard


	if (Screen = 0)
	{
		Sysget, x, 76
		Sysget, y, 77
		Sysget, w, 78
		Sysget, h, 79
	}
	else if (SubStr(Screen, 1, 5) = "hwnd:")
	{
		Screen := SubStr(Screen, 6)
		if !WinExist( "ahk_id " Screen)
			return -2
		WinGetPos,,, w, h, ahk_id %Screen%
		x := y := 0
		hhdc := GetDCEx(Screen, 3)
	}
	else if (Screen&1 != "")
	{
		Sysget, M, Monitor, %Screen%
		x := MLeft, y := MTop, w := MRight-MLeft, h := MBottom-MTop
	}
	else
	{
		StringSplit, S, Screen, |
		x := S1, y := S2, w := S3, h := S4
	}

	if (x = "") || (y = "") || (w = "") || (h = "")
		return -1

	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(w, h, chdc), obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()
	BitBlt(chdc, 0, 0, w, h, hhdc, x, y, Raster)
	ReleaseDC(hhdc)

	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
	return pBitmap
}
Gdip_BitmapFromHWND(hwnd, TibiaServer){
	WinGetPos,,, Width, Height, ahk_id %hwnd%
	if (TibiaServer != "Global") {
		Width := Width/(A_ScreenDPI/96)		;fix bug dpi by vanguard
		Height := Height/(A_ScreenDPI/96)	;fix bug dpi by vanguard
	}
	hbm := CreateDIBSection(Width, Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
	RegExMatch(A_OsVersion, "\d+", Version)
	PrintWindow(hwnd, hdc, Version >= 8 ? 2 : 0)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	return pBitmap
}
PrintWindow(hwnd, hdc, Flags=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("PrintWindow", Ptr, hwnd, Ptr, hdc, "uint", Flags)
}
Gdip_GetImageDimensions(pBitmap, ByRef Width, ByRef Height){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	; [ FIX WARN BY VANGUARD ]
	BufSize := 16 + (2*(A_PtrSize ? A_PtrSize : 4))
	VarSetCapacity(buf, BufSize, 0)
	Width := NumGet(buf, 4, "int"), Height := NumGet(buf, 8, "int")
	; [ FIX WARN BY VANGUARD ]

	DllCall("gdiplus\GdipGetImageWidth", Ptr, pBitmap, "uint*", Width)
	DllCall("gdiplus\GdipGetImageHeight", Ptr, pBitmap, "uint*", Height)
}
Gdip_LockBits(pBitmap, x, y, w, h, ByRef Stride, ByRef Scan0, ByRef BitmapData, LockMode = 3, PixelFormat = 0x26200a){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	CreateRect(Rect, x, y, w, h)
	VarSetCapacity(BitmapData, 16+2*(A_PtrSize ? A_PtrSize : 4), 0)
	E := DllCall("Gdiplus\GdipBitmapLockBits", Ptr, pBitmap, Ptr, &Rect, "uint", LockMode, "int", PixelFormat, Ptr, &BitmapData)
	Stride := NumGet(BitmapData, 8, "Int")
	Scan0 := NumGet(BitmapData, 16, Ptr)
	return E
}
Gdip_CloneBitmapArea(pBitmap, x, y, w, h, Format=0x26200A){
	pBitmapDest:=""
	DllCall("gdiplus\GdipCloneBitmapArea"
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "int", Format
					, A_PtrSize ? "UPtr" : "UInt", pBitmap
					, A_PtrSize ? "UPtr*" : "UInt*", pBitmapDest)
	return pBitmapDest
}
Gdip_DisposeImage(pBitmap){
   return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
}
Gdip_UnlockBits(pBitmap, ByRef BitmapData){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("Gdiplus\GdipBitmapUnlockBits", Ptr, pBitmap, Ptr, &BitmapData)
}
Gdip_FromARGB(ARGB, ByRef A, ByRef R, ByRef G, ByRef B){
	A := (0xff000000 & ARGB) >> 24
	R := (0x00ff0000 & ARGB) >> 16
	G := (0x0000ff00 & ARGB) >> 8
	B := 0x000000ff & ARGB
}
Gdip_Startup(){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	;pToken := 0	;fix warning by: Vanguard

	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}
Gdip_CreateBitmapFromFile(sFile, IconNumber=1, IconSize=""){
	;pBitmap := "" ;fix warning by Vanguard

	Ptr := A_PtrSize ? "UPtr" : "UInt"
	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"

	SplitPath, sFile,,, ext
	if ext in exe,dll
	{
		Sizes := IconSize ? IconSize : 256 "|" 128 "|" 64 "|" 48 "|" 32 "|" 16
		BufSize := 16 + (2*(A_PtrSize ? A_PtrSize : 4))

		VarSetCapacity(buf, BufSize, 0)
		Loop, Parse, Sizes, |
		{
			DllCall("PrivateExtractIcons", "str", sFile, "int", IconNumber-1, "int", A_LoopField, "int", A_LoopField, PtrA, hIcon, PtrA, 0, "uint", 1, "uint", 0)

			if !hIcon
				continue

			if !DllCall("GetIconInfo", Ptr, hIcon, Ptr, &buf)
			{
				DestroyIcon(hIcon)
				continue
			}

			hbmMask  := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4))
			hbmColor := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4) + (A_PtrSize ? A_PtrSize : 4))
			if !(hbmColor && DllCall("GetObject", Ptr, hbmColor, "int", BufSize, Ptr, &buf))
			{
				DestroyIcon(hIcon)
				continue
			}
			break
		}
		if !hIcon
			return -1

		Width := NumGet(buf, 4, "int"), Height := NumGet(buf, 8, "int")
		hbm := CreateDIBSection(Width, -Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
		if !DllCall("DrawIconEx", Ptr, hdc, "int", 0, "int", 0, Ptr, hIcon, "uint", Width, "uint", Height, "uint", 0, Ptr, 0, "uint", 3)
		{
			DestroyIcon(hIcon)
			return -2
		}

		VarSetCapacity(dib, 104)
		DllCall("GetObject", Ptr, hbm, "int", A_PtrSize = 8 ? 104 : 84, Ptr, &dib) ; sizeof(DIBSECTION) = 76+2*(A_PtrSize=8?4:0)+2*A_PtrSize
		Stride := NumGet(dib, 12, "Int"), Bits := NumGet(dib, 20 + (A_PtrSize = 8 ? 4 : 0)) ; padding
		DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", Stride, "int", 0x26200A, Ptr, Bits, PtrA, pBitmapOld)
		pBitmap := Gdip_CreateBitmap(Width, Height)
		G := Gdip_GraphicsFromImage(pBitmap)
		, Gdip_DrawImage(G, pBitmapOld, 0, 0, Width, Height, 0, 0, Width, Height)
		SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
		Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmapOld)
		DestroyIcon(hIcon)
	}
	else
	{
		if (!A_IsUnicode)
		{
			VarSetCapacity(wFile, 1024)
			DllCall("kernel32\MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sFile, "int", -1, Ptr, &wFile, "int", 512)
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &wFile, PtrA, pBitmap)
		}
		else
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &sFile, PtrA, pBitmap)
	}

	return pBitmap
}
Gdip_CreateHBITMAPFromBitmap(pBitmap, Background=0xffffffff){
	hbm := ""
	DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hbm, "int", Background)
	return hbm
}
Gdip_SaveBitmapToFile(pBitmap, sOutput, Quality:=75, toBase64:=0) {
Static Ptr := "UPtr"
nCount := 0
nSize := 0
_p := 0
SplitPath sOutput,,, Extension
If !RegExMatch(Extension, "^(?i:BMP|DIB|RLE|JPG|JPEG|JPE|JFIF|GIF|TIF|TIFF|PNG)$")
Return -1
Extension := "." Extension
DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
VarSetCapacity(ci, nSize)
DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)
If !(nCount && nSize)
Return -2
If (A_IsUnicode)
{
StrGet_Name := "StrGet"
N := (A_AhkVersion < 2) ? nCount : "nCount"
Loop %N%
{
sString := %StrGet_Name%(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
If !InStr(sString, "*" Extension)
Continue
pCodec := &ci+idx
Break
}
} Else
{
N := (A_AhkVersion < 2) ? nCount : "nCount"
Loop %N%
{
Location := NumGet(ci, 76*(A_Index-1)+44)
nSize := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int",  0, "uint", 0, "uint", 0)
VarSetCapacity(sString, nSize)
DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "str", sString, "int", nSize, "uint", 0, "uint", 0)
If !InStr(sString, "*" Extension)
Continue
pCodec := &ci+76*(A_Index-1)
Break
}
}
If !pCodec
Return -3
If (Quality!=75)
{
Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
If (quality>90 && toBase64=1)
Quality := 90
If RegExMatch(Extension, "^\.(?i:JPG|JPEG|JPE|JFIF)$")
{
DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)
VarSetCapacity(EncoderParameters, nSize, 0)
DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)
nCount := NumGet(EncoderParameters, "UInt")
N := (A_AhkVersion < 2) ? nCount : "nCount"
Loop %N%
{
elem := (24+A_PtrSize)*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
If (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)
{
_p := elem+&EncoderParameters-pad-4
NumPut(Quality, NumGet(NumPut(4, NumPut(1, _p+0)+20, "UInt")), "UInt")
Break
}
}
}
}
If (toBase64=1)
{
DllCall("ole32\CreateStreamOnHGlobal", "ptr",0, "int",true, "ptr*",pStream)
_E := DllCall("gdiplus\GdipSaveImageToStream", "ptr",pBitmap, "ptr",pStream, "ptr",pCodec, "uint", _p ? _p : 0)
If _E
Return -6
DllCall("ole32\GetHGlobalFromStream", "ptr",pStream, "uint*",hData)
pData := DllCall("GlobalLock", "ptr",hData, "ptr")
nSize := DllCall("GlobalSize", "uint",pData)
VarSetCapacity(bin, nSize, 0)
DllCall("RtlMoveMemory", "ptr",&bin, "ptr",pData, "uptr",nSize)
DllCall("GlobalUnlock", "ptr",hData)
ObjRelease(pStream)
DllCall("GlobalFree", "ptr",hData)
DllCall("Crypt32.dll\CryptBinaryToStringA", "ptr",&bin, "uint",nSize, "uint",0x40000001, "ptr",0, "uint*",base64Length)
VarSetCapacity(base64, base64Length, 0)
_E := DllCall("Crypt32.dll\CryptBinaryToStringA", "ptr",&bin, "uint",nSize, "uint",0x40000001, "ptr",&base64, "uint*",base64Length)
If !_E
Return -7
VarSetCapacity(bin, 0)
Return StrGet(&base64, base64Length, "CP0")
}
_E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, "WStr", sOutput, Ptr, pCodec, "uint", _p ? _p : 0)
Return _E ? -5 : 0
}
Gdip_GetPixel(pBitmap, x, y){
	;SetFormat, Integer, H	;transform

	;Global ARGB:=""	;fix warning
	DllCall("gdiplus\GdipBitmapGetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", x, "int", y, "uint*", ARGB)

	ARGB := Format("{:X}", ARGB)

	return "0x" . SubStr(ARGB, -5)	;formata corretamente

	;SetFormat, Integer, D	;transform
	;return ARGB
}
GetDCEx(hwnd, flags=0, hrgnClip=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

    return DllCall("GetDCEx", Ptr, hwnd, Ptr, hrgnClip, "int", flags)
}
CreateCompatibleDC(hdc=0){
   return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	hdc2 := hdc ? hdc : GetDC()
	VarSetCapacity(bi, 40, 0)

	NumPut(w, bi, 4, "uint")
	, NumPut(h, bi, 8, "uint")
	, NumPut(40, bi, 0, "uint")
	, NumPut(1, bi, 12, "ushort")
	, NumPut(0, bi, 16, "uInt")
	, NumPut(bpp, bi, 14, "ushort")

	hbm := DllCall("CreateDIBSection"
					, Ptr, hdc2
					, Ptr, &bi
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "uint*", ppvBits
					, Ptr, 0
					, "uint", 0, Ptr)

	if !hdc
		ReleaseDC(hdc2)
	return hbm
}
SelectObject(hdc, hgdiobj){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
}
BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster=""){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdi32\BitBlt"
					, Ptr, dDC
					, "int", dx
					, "int", dy
					, "int", dw
					, "int", dh
					, Ptr, sDC
					, "int", sx
					, "int", sy
					, "uint", Raster ? Raster : 0x00CC0020)
}
GetDC(hwnd=0){
	return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
}
Gdip_ReleaseDC(pGraphics, hdc){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipReleaseDC", Ptr, pGraphics, Ptr, hdc)
}
ReleaseDC(hdc, hwnd=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
}
DeleteDC(hdc){
   return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	;pBitmap := "" ;fix warning by Vanguard

	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", Ptr, hBitmap, Ptr, Palette, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}
DeleteObject(hObject){
   return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
}
CreateRect(ByRef Rect, x, y, w, h){
	VarSetCapacity(Rect, 16)
	NumPut(x, Rect, 0, "uint"), NumPut(y, Rect, 4, "uint"), NumPut(w, Rect, 8, "uint"), NumPut(h, Rect, 12, "uint")
}
DestroyIcon(hIcon){
	return DllCall("DestroyIcon", A_PtrSize ? "UPtr" : "UInt", hIcon)
}
Gdip_CreateBitmap(Width, Height, Format=0x26200A){
    DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, A_PtrSize ? "UPtr" : "UInt", 0, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
    Return pBitmap
}
Gdip_GraphicsFromImage(pBitmap){
	DllCall("gdiplus\GdipGetImageGraphicsContext", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
	return pGraphics
}
Gdip_DrawImage(pGraphics, pBitmap, dx="", dy="", dw="", dh="", sx="", sy="", sw="", sh="", Matrix=1){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		if (dx = "" && dy = "" && dw = "" && dh = "")
		{
			sx := dx := 0, sy := dy := 0
			sw := dw := Gdip_GetImageWidth(pBitmap)
			sh := dh := Gdip_GetImageHeight(pBitmap)
		}
		else
		{
			sx := sy := 0
			sw := Gdip_GetImageWidth(pBitmap)
			sh := Gdip_GetImageHeight(pBitmap)
		}
	}

	E := DllCall("gdiplus\GdipDrawImageRectRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, "float", dx
				, "float", dy
				, "float", dw
				, "float", dh
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}
Gdip_BrushCreateSolid(ARGB:=0xff000000) {
pBrush := 0
E := DllCall("gdiplus\GdipCreateSolidFill", "UInt", ARGB, "UPtr*", pBrush)
return pBrush
}
Gdip_DrawImageFast(pGraphics, pBitmap, X:=0, Y:=0) {
Static Ptr := "UPtr"
_E := DllCall("gdiplus\GdipDrawImage"
, Ptr, pGraphics
, Ptr, pBitmap
, "float", X
, "float", Y)
return _E
}
Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h) {
Static Ptr := "UPtr"
return DllCall("gdiplus\GdipFillRectangle"
, Ptr, pGraphics
, Ptr, pBrush
, "float", x, "float", y
, "float", w, "float", h)
}
Gdip_CreateARGBHBITMAPFromBitmap(ByRef pBitmap) {
Gdip_GetImageDimensions(pBitmap, Width, Height)
hdc := CreateCompatibleDC()
hbm := CreateDIBSection(width, -height, hdc, 32, pBits)
obm := SelectObject(hdc, hbm)
CreateRect(Rect, 0, 0, width, height)
VarSetCapacity(BitmapData, 16+2*A_PtrSize, 0)
, NumPut(     width, BitmapData,  0,   "uint")
, NumPut(    height, BitmapData,  4,   "uint")
, NumPut( 4 * width, BitmapData,  8,    "int")
, NumPut(   0xE200B, BitmapData, 12,    "int")
, NumPut(     pBits, BitmapData, 16,    "ptr")
DllCall("gdiplus\GdipBitmapLockBits"
,    "ptr", pBitmap
,    "ptr", &Rect
,   "uint", 5
,    "int", 0xE200B
,    "ptr", &BitmapData)
DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", &BitmapData)
SelectObject(hdc, obm)
DeleteObject(hdc)
return hbm
}
SetImage(hwnd, hBitmap) {
Static Ptr := "UPtr"
E := DllCall("SendMessage", Ptr, hwnd, "UInt", 0x172, "UInt", 0x0, Ptr, hBitmap )
DeleteObject(E)
return E
}
Gdip_DeleteGraphics(pGraphics){
   return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}
Gdip_SetImageAttributesColorMatrix(Matrix){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	VarSetCapacity(ColourMatrix, 100, 0)
	Matrix := RegExReplace(RegExReplace(Matrix, "^[^\d-\.]+([\d\.])", "$1", "", 1), "[^\d-\.]+", "|")
	StringSplit, Matrix, Matrix, |
	Loop, 25
	{
		Matrix := (Matrix%A_Index% != "") ? Matrix%A_Index% : Mod(A_Index-1, 6) ? 0 : 1
		NumPut(Matrix, ColourMatrix, (A_Index-1)*4, "float")
	}
	DllCall("gdiplus\GdipCreateImageAttributes", A_PtrSize ? "UPtr*" : "uint*", ImageAttr)
	DllCall("gdiplus\GdipSetImageAttributesColorMatrix", Ptr, ImageAttr, "int", 1, "int", 1, Ptr, &ColourMatrix, Ptr, 0, "int", 0)
	return ImageAttr
}
Gdip_GetImageWidth(pBitmap){
   DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Width)
   return Width
}
Gdip_GetImageHeight(pBitmap){
   DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Height)
   return Height
}
Gdip_DisposeImageAttributes(ImageAttr){
	return DllCall("gdiplus\GdipDisposeImageAttributes", A_PtrSize ? "UPtr" : "UInt", ImageAttr)
}
Gdip_Shutdown(pToken){
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	DllCall("gdiplus\GdiplusShutdown", Ptr, pToken)
	if hModule := DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("FreeLibrary", Ptr, hModule)
	return 0
}
; [ GDIP IMAGE SEARCH ]
Gdip_ImageSearch(pBitmapHaystack,pBitmapNeedle,ByRef OutputList=""
,OuterX1=0,OuterY1=0,OuterX2=0,OuterY2=0,Variation=0,Trans=""
,SearchDirection=1,Instances=0,LineDelim="`n",CoordDelim=",") {

    ;DumpCurrentNeedle := "" ;fix warn by vanguard

    ; Some validations that can be done before proceeding any further
    If !( pBitmapHaystack && pBitmapNeedle )
        Return -1001
    If Variation not between 0 and 255
        return -1002
    If ( ( OuterX1 < 0 ) || ( OuterY1 < 0 ) )
        return -1003
    If SearchDirection not between 1 and 8
        SearchDirection := 1
    If ( Instances < 0 )
        Instances := 0

    ; Getting the dimensions and locking the bits [haystack]
    Gdip_GetImageDimensions(pBitmapHaystack,hWidth,hHeight)
    ; Last parameter being 1 says the LockMode flag is "READ only"
    If Gdip_LockBits(pBitmapHaystack,0,0,hWidth,hHeight,hStride,hScan,hBitmapData,1)
    OR !(hWidth := NumGet(hBitmapData,0,"UInt"))
    OR !(hHeight := NumGet(hBitmapData,4,"UInt"))
        Return -1004

    ; Careful! From this point on, we must do the following before returning:
    ; - unlock haystack bits

    ; Getting the dimensions and locking the bits [needle]
    Gdip_GetImageDimensions(pBitmapNeedle,nWidth,nHeight)
    ; If Trans is correctly specified, create a backup of the original needle bitmap
    ; and modify the current one, setting the desired color as transparent.
    ; Also, since a copy is created, we must remember to dispose the new bitmap later.
    ; This whole thing has to be done before locking the bits.
    If Trans between 0 and 0xFFFFFF
    {
        pOriginalBmpNeedle := pBitmapNeedle
        pBitmapNeedle := Gdip_CloneBitmapArea(pOriginalBmpNeedle,0,0,nWidth,nHeight)
        Gdip_SetBitmapTransColor(pBitmapNeedle,Trans)
        DumpCurrentNeedle := true
    }

    ; Careful! From this point on, we must do the following before returning:
    ; - unlock haystack bits
    ; - dispose current needle bitmap (if necessary)

    If Gdip_LockBits(pBitmapNeedle,0,0,nWidth,nHeight,nStride,nScan,nBitmapData)
    OR !(nWidth := NumGet(nBitmapData,0,"UInt"))
    OR !(nHeight := NumGet(nBitmapData,4,"UInt"))
    {
        If ( DumpCurrentNeedle )
            Gdip_DisposeImage(pBitmapNeedle)
        Gdip_UnlockBits(pBitmapHaystack,hBitmapData)
        Return -1005
    }

    ; Careful! From this point on, we must do the following before returning:
    ; - unlock haystack bits
    ; - unlock needle bits
    ; - dispose current needle bitmap (if necessary)

    ; Adjust the search box. "OuterX2,OuterY2" will be the last pixel evaluated
    ; as possibly matching with the needle's first pixel. So, we must avoid going
    ; beyond this maximum final coordinate.
    OuterX2 := ( !OuterX2 ? hWidth-nWidth+1 : OuterX2-nWidth+1 )
    OuterY2 := ( !OuterY2 ? hHeight-nHeight+1 : OuterY2-nHeight+1 )

    OutputCount := Gdip_MultiLockedBitsSearch(hStride,hScan,hWidth,hHeight
    ,nStride,nScan,nWidth,nHeight,OutputList,OuterX1,OuterY1,OuterX2,OuterY2
    ,Variation,SearchDirection,Instances,LineDelim,CoordDelim)

    Gdip_UnlockBits(pBitmapHaystack,hBitmapData)
    Gdip_UnlockBits(pBitmapNeedle,nBitmapData)
    If ( DumpCurrentNeedle )
        Gdip_DisposeImage(pBitmapNeedle)

    Return OutputCount
}
Gdip_SetBitmapTransColor(pBitmap,TransColor) {
    static _SetBmpTrans, Ptr, PtrA
    if !( _SetBmpTrans ) {
        Ptr := A_PtrSize ? "UPtr" : "UInt"
        PtrA := Ptr . "*"
        MCode_SetBmpTrans := "
            (LTrim Join
            8b44240c558b6c241cc745000000000085c07e77538b5c2410568b74242033c9578b7c2414894c24288da424000000
            0085db7e458bc18d1439b9020000008bff8a0c113a4e0275178a4c38013a4e01750e8a0a3a0e7508c644380300ff450083c0
            0483c204b9020000004b75d38b4c24288b44241c8b5c2418034c242048894c24288944241c75a85f5e5b33c05dc3,405
            34c8b5424388bda41c702000000004585c07e6448897c2410458bd84c8b4424304963f94c8d49010f1f800000000085db7e3
            8498bc1488bd3660f1f440000410fb648023848017519410fb6480138087510410fb6083848ff7507c640020041ff024883c
            00448ffca75d44c03cf49ffcb75bc488b7c241033c05bc3
            )"
        if ( A_PtrSize == 8 ) ; x64, after comma
            MCode_SetBmpTrans := SubStr(MCode_SetBmpTrans,InStr(MCode_SetBmpTrans,",")+1)
        else ; x86, before comma
            MCode_SetBmpTrans := SubStr(MCode_SetBmpTrans,1,InStr(MCode_SetBmpTrans,",")-1)
        VarSetCapacity(_SetBmpTrans, LEN := StrLen(MCode_SetBmpTrans)//2, 0)
        Loop, %LEN%
            NumPut("0x" . SubStr(MCode_SetBmpTrans,(2*A_Index)-1,2), _SetBmpTrans, A_Index-1, "uchar")
        MCode_SetBmpTrans := ""
        DllCall("VirtualProtect", Ptr,&_SetBmpTrans, Ptr,VarSetCapacity(_SetBmpTrans), "uint",0x40, PtrA,0)
    }
    If !pBitmap
        Return -2001
    If TransColor not between 0 and 0xFFFFFF
        Return -2002
    Gdip_GetImageDimensions(pBitmap,W,H)
    If !(W && H)
        Return -2003
    If Gdip_LockBits(pBitmap,0,0,W,H,Stride,Scan,BitmapData)
        Return -2004
    ; The following code should be slower than using the MCode approach,
    ; but will the kept here for now, just for reference.
    /*
    Count := 0
    Loop, %H% {
        Y := A_Index-1
        Loop, %W% {
            X := A_Index-1
            CurrentColor := Gdip_GetLockBitPixel(Scan,X,Y,Stride)
            If ( (CurrentColor & 0xFFFFFF) == TransColor )
                Gdip_SetLockBitPixel(TransColor,Scan,X,Y,Stride), Count++
        }
    }
    */
    ; Thanks guest3456 for helping with the initial solution involving NumPut
    Gdip_FromARGB(TransColor,A,R,G,B), VarSetCapacity(TransColor,0), VarSetCapacity(TransColor,3,255)
    NumPut(B,TransColor,0,"UChar"), NumPut(G,TransColor,1,"UChar"), NumPut(R,TransColor,2,"UChar")
    MCount := 0
    E := DllCall(&_SetBmpTrans, Ptr,Scan, "int",W, "int",H, "int",Stride, Ptr,&TransColor, "int*",MCount, "cdecl int")
    Gdip_UnlockBits(pBitmap,BitmapData)
    If ( E != 0 ) {
        ErrorLevel := E
        Return -2005
    }
    Return MCount
}
Gdip_MultiLockedBitsSearch(hStride,hScan,hWidth,hHeight,nStride,nScan,nWidth,nHeight
,ByRef OutputList="",OuterX1=0,OuterY1=0,OuterX2=0,OuterY2=0,Variation=0
,SearchDirection=1,Instances=0,LineDelim="`n",CoordDelim=","){
    OutputList := ""
    OutputCount := !Instances
    InnerX1 := OuterX1 , InnerY1 := OuterY1
    InnerX2 := OuterX2 , InnerY2 := OuterY2

    ; The following part is a rather ugly but working hack that I
    ; came up with to adjust the variables and their increments
    ; according to the specified Haystack Search Direction
    /*
    Mod(SD,4) = 0 --> iX = 2 , stepX = +0 , iY = 1 , stepY = +1
    Mod(SD,4) = 1 --> iX = 1 , stepX = +1 , iY = 1 , stepY = +1
    Mod(SD,4) = 2 --> iX = 1 , stepX = +1 , iY = 2 , stepY = +0
    Mod(SD,4) = 3 --> iX = 2 , stepX = +0 , iY = 2 , stepY = +0
    SD <= 4   ------> Vertical preference
    SD > 4    ------> Horizontal preference
    */
    ; Set the index and the step (for both X and Y) to +1
    iX := 1, stepX := 1, iY := 1, stepY := 1
    ; Adjust Y variables if SD is 2, 3, 6 or 7
    Modulo := Mod(SearchDirection,4)
    If ( Modulo > 1 )
        iY := 2, stepY := 0
    ; adjust X variables if SD is 3, 4, 7 or 8
    If !Mod(Modulo,3)
        iX := 2, stepX := 0
    ; Set default Preference to vertical and Nonpreference to horizontal
    P := "Y", N := "X"
    ; adjust Preference and Nonpreference if SD is 5, 6, 7 or 8
    If ( SearchDirection > 4 )
        P := "X", N := "Y"
    ; Set the Preference Index and the Nonpreference Index
    iP := i%P%, iN := i%N%

    While (!(OutputCount == Instances) && (0 == Gdip_LockedBitsSearch(hStride,hScan,hWidth,hHeight,nStride
    ,nScan,nWidth,nHeight,FoundX,FoundY,OuterX1,OuterY1,OuterX2,OuterY2,Variation,SearchDirection)))
    {
        OutputCount++
        OutputList .= LineDelim FoundX CoordDelim FoundY
        Outer%P%%iP% := Found%P%+step%P%
        Inner%N%%iN% := Found%N%+step%N%
        Inner%P%1 := Found%P%
        Inner%P%2 := Found%P%+1
        While (!(OutputCount == Instances) && (0 == Gdip_LockedBitsSearch(hStride,hScan,hWidth,hHeight,nStride
        ,nScan,nWidth,nHeight,FoundX,FoundY,InnerX1,InnerY1,InnerX2,InnerY2,Variation,SearchDirection)))
        {
            OutputCount++
            OutputList .= LineDelim FoundX CoordDelim FoundY
            Inner%N%%iN% := Found%N%+step%N%
        }
    }
    OutputList := SubStr(OutputList,1+StrLen(LineDelim))
    OutputCount -= !Instances
    Return OutputCount
}
Gdip_LockedBitsSearch(hStride,hScan,hWidth,hHeight,nStride,nScan,nWidth,nHeight
,ByRef x="",ByRef y="",sx1=0,sy1=0,sx2=0,sy2=0,Variation=0,sd=1){
    ;_ImageSearch := ""   ;fix warning by vanguard
    static _ImageSearch, Ptr, PtrA

    ; Initialize all MCode stuff, if necessary
    if !( _ImageSearch ) {
        Ptr := A_PtrSize ? "UPtr" : "UInt"
        PtrA := Ptr . "*"

        MCode_ImageSearch := "
            (LTrim Join
            8b44243883ec205355565783f8010f857a0100008b7c2458897c24143b7c24600f8db50b00008b44244c8b5c245c8b
            4c24448b7424548be80fafef896c242490897424683bf30f8d0a0100008d64240033c033db8bf5896c241c895c2420894424
            183b4424480f8d0401000033c08944241085c90f8e9d0000008b5424688b7c24408beb8d34968b54246403df8d4900b80300
            0000803c18008b442410745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b44
            24400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424108b7c
            24408b4c24444083c50483c30483c604894424103bc17c818b5c24208b74241c0374244c8b44241840035c24508974241ce9
            2dffffff8b6c24688b5c245c8b4c244445896c24683beb8b6c24240f8c06ffffff8b44244c8b7c24148b7424544703e8897c
            2414896c24243b7c24600f8cd5feffffe96b0a00008b4424348b4c246889088b4424388b4c24145f5e5d890833c05b83c420
            c383f8020f85870100008b7c24604f897c24103b7c24580f8c310a00008b44244c8b5c245c8b4c24448bef0fafe8f7d88944
            24188b4424548b742418896c24288d4900894424683bc30f8d0a0100008d64240033c033db8bf5896c2420895c241c894424
            243b4424480f8d0401000033c08944241485c90f8e9d0000008b5424688b7c24408beb8d34968b54246403df8d4900b80300
            0000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b44
            24400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424148b7c
            24408b4c24444083c50483c30483c604894424143bc17c818b5c241c8b7424200374244c8b44242440035c245089742420e9
            2dffffff8b6c24688b5c245c8b4c244445896c24683beb8b6c24280f8c06ffffff8b7c24108b4424548b7424184f03ee897c
            2410896c24283b7c24580f8dd5feffffe9db0800008b4424348b4c246889088b4424388b4c24105f5e5d890833c05b83c420
            c383f8030f85650100008b7c24604f897c24103b7c24580f8ca10800008b44244c8b6c245c8b5c24548b4c24448bf70faff0
            4df7d8896c242c897424188944241c8bff896c24683beb0f8c020100008d64240033c033db89742424895c2420894424283b
            4424480f8d76ffffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b80300
            0000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b44
            24400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c
            24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff
            8b6c24688b5c24548b4c24448b7424184d896c24683beb0f8d0affffff8b7c24108b44241c4f03f0897c2410897424183b7c
            24580f8c580700008b6c242ce9d4feffff83f8040f85670100008b7c2458897c24103b7c24600f8d340700008b44244c8b6c
            245c8b5c24548b4c24444d8bf00faff7896c242c8974241ceb098da424000000008bff896c24683beb0f8c020100008d6424
            0033c033db89742424895c2420894424283b4424480f8d06feffff33c08944241485c90f8e9f0000008b5424688b7c24408b
            eb8d34968b54246403dfeb038d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f
            752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d
            04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b742424
            8b4424280374244c40035c2450e92bffffff8b6c24688b5c24548b4c24448b74241c4d896c24683beb0f8d0affffff8b4424
            4c8b7c24104703f0897c24108974241c3b7c24600f8de80500008b6c242ce9d4feffff83f8050f85890100008b7c2454897c
            24683b7c245c0f8dc40500008b5c24608b6c24588b44244c8b4c2444eb078da42400000000896c24103beb0f8d200100008b
            e80faf6c2458896c241c33c033db8bf5896c2424895c2420894424283b4424480f8d0d01000033c08944241485c90f8ea600
            00008b5424688b7c24408beb8d34968b54246403dfeb0a8da424000000008d4900b803000000803c03008b442414745e8b44
            243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a
            2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424148b7c24408b4c24444083c50483c30483
            c604894424143bc17c818b5c24208b7424240374244c8b44242840035c245089742424e924ffffff8b7c24108b6c241c8b44
            244c8b5c24608b4c24444703e8897c2410896c241c3bfb0f8cf3feffff8b7c24688b6c245847897c24683b7c245c0f8cc5fe
            ffffe96b0400008b4424348b4c24688b74241089088b4424385f89305e5d33c05b83c420c383f8060f85670100008b7c2454
            897c24683b7c245c0f8d320400008b6c24608b5c24588b44244c8b4c24444d896c24188bff896c24103beb0f8c1a0100008b
            f50faff0f7d88974241c8944242ceb038d490033c033db89742424895c2420894424283b4424480f8d06fbffff33c0894424
            1485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b803000000803c03008b442414745e8b44
            243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f56
            2bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483
            c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff8b6c24108b74241c0374242c8b5c
            24588b4c24444d896c24108974241c3beb0f8d02ffffff8b44244c8b7c246847897c24683b7c245c0f8de60200008b6c2418
            e9c2feffff83f8070f85670100008b7c245c4f897c24683b7c24540f8cc10200008b6c24608b5c24588b44244c8b4c24444d
            896c241890896c24103beb0f8c1a0100008bf50faff0f7d88974241c8944242ceb038d490033c033db89742424895c242089
            4424283b4424480f8d96f9ffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d49
            00b803000000803c18008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c
            06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b44
            24148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e9
            2bffffff8b6c24108b74241c0374242c8b5c24588b4c24444d896c24108974241c3beb0f8d02ffffff8b44244c8b7c24684f
            897c24683b7c24540f8c760100008b6c2418e9c2feffff83f8080f85640100008b7c245c4f897c24683b7c24540f8c510100
            008b5c24608b6c24588b44244c8b4c24448d9b00000000896c24103beb0f8d200100008be80faf6c2458896c241c33c033db
            8bf5896c2424895c2420894424283b4424480f8d9dfcffff33c08944241485c90f8ea60000008b5424688b7c24408beb8d34
            968b54246403dfeb0a8da424000000008d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04
            113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0f
            b604068d0c103bf97f422bc23bf87c3c8b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c2420
            8b7424240374244c8b44242840035c245089742424e924ffffff8b7c24108b6c241c8b44244c8b5c24608b4c24444703e889
            7c2410896c241c3bfb0f8cf3feffff8b7c24688b6c24584f897c24683b7c24540f8dc5feffff8b4424345fc700ffffffff8b
            4424345e5dc700ffffffffb85ff0ffff5b83c420c3,4c894c24204c89442418488954241048894c24085355565741544
            155415641574883ec188b8424c80000004d8bd94d8bd0488bda83f8010f85b3010000448b8c24a800000044890c24443b8c2
            4b80000000f8d66010000448bac24900000008b9424c0000000448b8424b00000008bbc2480000000448b9424a0000000418
            bcd410fafc9894c24040f1f84000000000044899424c8000000453bd00f8dfb000000468d2495000000000f1f80000000003
            3ed448bf933f6660f1f8400000000003bac24880000000f8d1701000033db85ff7e7e458bf4448bce442bf64503f7904d63c
            14d03c34180780300745a450fb65002438d040e4c63d84c035c2470410fb64b028d0411443bd07f572bca443bd17c50410fb
            64b01450fb650018d0411443bd07f3e2bca443bd17c37410fb60b450fb6108d0411443bd07f272bca443bd17c204c8b5c247
            8ffc34183c1043bdf7c8fffc54503fd03b42498000000e95effffff8b8424c8000000448b8424b00000008b4c24044c8b5c2
            478ffc04183c404898424c8000000413bc00f8c20ffffff448b0c24448b9424a000000041ffc14103cd44890c24894c24044
            43b8c24b80000000f8cd8feffff488b5c2468488b4c2460b85ff0ffffc701ffffffffc703ffffffff4883c418415f415e415
            d415c5f5e5d5bc38b8424c8000000e9860b000083f8020f858c010000448b8c24b800000041ffc944890c24443b8c24a8000
            0007cab448bac2490000000448b8424c00000008b9424b00000008bbc2480000000448b9424a0000000418bc9410fafcd418
            bc5894c2404f7d8894424080f1f400044899424c8000000443bd20f8d02010000468d2495000000000f1f80000000004533f
            6448bf933f60f1f840000000000443bb424880000000f8d56ffffff33db85ff0f8e81000000418bec448bd62bee4103ef496
            3d24903d3807a03007460440fb64a02418d042a4c63d84c035c2470410fb64b02428d0401443bc87f5d412bc8443bc97c554
            10fb64b01440fb64a01428d0401443bc87f42412bc8443bc97c3a410fb60b440fb60a428d0401443bc87f29412bc8443bc97
            c214c8b5c2478ffc34183c2043bdf7c8a41ffc64503fd03b42498000000e955ffffff8b8424c80000008b9424b00000008b4
            c24044c8b5c2478ffc04183c404898424c80000003bc20f8c19ffffff448b0c24448b9424a0000000034c240841ffc9894c2
            40444890c24443b8c24a80000000f8dd0feffffe933feffff83f8030f85c4010000448b8c24b800000041ffc944898c24c80
            00000443b8c24a80000000f8c0efeffff8b842490000000448b9c24b0000000448b8424c00000008bbc248000000041ffcb4
            18bc98bd044895c24080fafc8f7da890c24895424048b9424a0000000448b542404458beb443bda0f8c13010000468d249d0
            000000066660f1f84000000000033ed448bf933f6660f1f8400000000003bac24880000000f8d0801000033db85ff0f8e960
            00000488b4c2478458bf4448bd6442bf64503f70f1f8400000000004963d24803d1807a03007460440fb64a02438d04164c6
            3d84c035c2470410fb64b02428d0401443bc87f63412bc8443bc97c5b410fb64b01440fb64a01428d0401443bc87f48412bc
            8443bc97c40410fb60b440fb60a428d0401443bc87f2f412bc8443bc97c27488b4c2478ffc34183c2043bdf7c8a8b8424900
            00000ffc54403f803b42498000000e942ffffff8b9424a00000008b8424900000008b0c2441ffcd4183ec04443bea0f8d11f
            fffff448b8c24c8000000448b542404448b5c240841ffc94103ca44898c24c8000000890c24443b8c24a80000000f8dc2fef
            fffe983fcffff488b4c24608b8424c8000000448929488b4c2468890133c0e981fcffff83f8040f857f010000448b8c24a80
            0000044890c24443b8c24b80000000f8d48fcffff448bac2490000000448b9424b00000008b9424c0000000448b8424a0000
            0008bbc248000000041ffca418bcd4489542408410fafc9894c2404669044899424c8000000453bd00f8cf8000000468d249
            5000000000f1f800000000033ed448bf933f6660f1f8400000000003bac24880000000f8df7fbffff33db85ff7e7e458bf44
            48bce442bf64503f7904d63c14d03c34180780300745a450fb65002438d040e4c63d84c035c2470410fb64b028d0411443bd
            07f572bca443bd17c50410fb64b01450fb650018d0411443bd07f3e2bca443bd17c37410fb60b450fb6108d0411443bd07f2
            72bca443bd17c204c8b5c2478ffc34183c1043bdf7c8fffc54503fd03b42498000000e95effffff8b8424c8000000448b842
            4a00000008b4c24044c8b5c2478ffc84183ec04898424c8000000413bc00f8d20ffffff448b0c24448b54240841ffc14103c
            d44890c24894c2404443b8c24b80000000f8cdbfeffffe9defaffff83f8050f85ab010000448b8424a000000044890424443
            b8424b00000000f8dc0faffff8b9424c0000000448bac2498000000448ba424900000008bbc2480000000448b8c24a800000
            0428d0c8500000000898c24c800000044894c2404443b8c24b80000000f8d09010000418bc4410fafc18944240833ed448bf
            833f6660f1f8400000000003bac24880000000f8d0501000033db85ff0f8e87000000448bf1448bce442bf64503f74d63c14
            d03c34180780300745d438d040e4c63d84d03da450fb65002410fb64b028d0411443bd07f5f2bca443bd17c58410fb64b014
            50fb650018d0411443bd07f462bca443bd17c3f410fb60b450fb6108d0411443bd07f2f2bca443bd17c284c8b5c24784c8b5
            42470ffc34183c1043bdf7c8c8b8c24c8000000ffc54503fc4103f5e955ffffff448b4424048b4424088b8c24c80000004c8
            b5c24784c8b54247041ffc04103c4448944240489442408443b8424b80000000f8c0effffff448b0424448b8c24a80000004
            1ffc083c10444890424898c24c8000000443b8424b00000000f8cc5feffffe946f9ffff488b4c24608b042489018b4424044
            88b4c2468890133c0e945f9ffff83f8060f85aa010000448b8c24a000000044894c2404443b8c24b00000000f8d0bf9ffff8
            b8424b8000000448b8424c0000000448ba424900000008bbc2480000000428d0c8d00000000ffc88944240c898c24c800000
            06666660f1f840000000000448be83b8424a80000000f8c02010000410fafc4418bd4f7da891424894424084533f6448bf83
            3f60f1f840000000000443bb424880000000f8df900000033db85ff0f8e870000008be9448bd62bee4103ef4963d24903d38
            07a03007460440fb64a02418d042a4c63d84c035c2470410fb64b02428d0401443bc87f64412bc8443bc97c5c410fb64b014
            40fb64a01428d0401443bc87f49412bc8443bc97c41410fb60b440fb60a428d0401443bc87f30412bc8443bc97c284c8b5c2
            478ffc34183c2043bdf7c8a8b8c24c800000041ffc64503fc03b42498000000e94fffffff8b4424088b8c24c80000004c8b5
            c247803042441ffcd89442408443bac24a80000000f8d17ffffff448b4c24048b44240c41ffc183c10444894c2404898c24c
            8000000443b8c24b00000000f8ccefeffffe991f7ffff488b4c24608b4424048901488b4c246833c0448929e992f7ffff83f
            8070f858d010000448b8c24b000000041ffc944894c2404443b8c24a00000000f8c55f7ffff8b8424b8000000448b8424c00
            00000448ba424900000008bbc2480000000428d0c8d00000000ffc8890424898c24c8000000660f1f440000448be83b8424a
            80000000f8c02010000410fafc4418bd4f7da8954240c8944240833ed448bf833f60f1f8400000000003bac24880000000f8
            d4affffff33db85ff0f8e89000000448bf1448bd6442bf64503f74963d24903d3807a03007460440fb64a02438d04164c63d
            84c035c2470410fb64b02428d0401443bc87f63412bc8443bc97c5b410fb64b01440fb64a01428d0401443bc87f48412bc84
            43bc97c40410fb60b440fb60a428d0401443bc87f2f412bc8443bc97c274c8b5c2478ffc34183c2043bdf7c8a8b8c24c8000
            000ffc54503fc03b42498000000e94fffffff8b4424088b8c24c80000004c8b5c24780344240c41ffcd89442408443bac24a
            80000000f8d17ffffff448b4c24048b042441ffc983e90444894c2404898c24c8000000443b8c24a00000000f8dcefeffffe
            9e1f5ffff83f8080f85ddf5ffff448b8424b000000041ffc84489442404443b8424a00000000f8cbff5ffff8b9424c000000
            0448bac2498000000448ba424900000008bbc2480000000448b8c24a8000000428d0c8500000000898c24c800000044890c2
            4443b8c24b80000000f8d08010000418bc4410fafc18944240833ed448bf833f6660f1f8400000000003bac24880000000f8
            d0501000033db85ff0f8e87000000448bf1448bce442bf64503f74d63c14d03c34180780300745d438d040e4c63d84d03da4
            50fb65002410fb64b028d0411443bd07f5f2bca443bd17c58410fb64b01450fb650018d0411443bd07f462bca443bd17c3f4
            10fb603450fb6108d0c10443bd17f2f2bc2443bd07c284c8b5c24784c8b542470ffc34183c1043bdf7c8c8b8c24c8000000f
            fc54503fc4103f5e955ffffff448b04248b4424088b8c24c80000004c8b5c24784c8b54247041ffc04103c44489042489442
            408443b8424b80000000f8c10ffffff448b442404448b8c24a800000041ffc883e9044489442404898c24c8000000443b842
            4a00000000f8dc6feffffe946f4ffff8b442404488b4c246089018b0424488b4c2468890133c0e945f4ffff
            )"
        if ( A_PtrSize == 8 ) ; x64, after comma
            MCode_ImageSearch := SubStr(MCode_ImageSearch,InStr(MCode_ImageSearch,",")+1)
        else ; x86, before comma
            MCode_ImageSearch := SubStr(MCode_ImageSearch,1,InStr(MCode_ImageSearch,",")-1)
        VarSetCapacity(_ImageSearch, LEN := StrLen(MCode_ImageSearch)//2, 0)
        Loop, %LEN%
            NumPut("0x" . SubStr(MCode_ImageSearch,(2*A_Index)-1,2), _ImageSearch, A_Index-1, "uchar")
        MCode_ImageSearch := ""
        DllCall("VirtualProtect", Ptr,&_ImageSearch, Ptr,VarSetCapacity(_ImageSearch), "uint",0x40, PtrA,0)
    }

    ; Abort if an initial coordinates is located before a final coordinate
    If ( sx2 < sx1 )
        return -3001
    If ( sy2 < sy1 )
        return -3002

    ; Check the search box. "sx2,sy2" will be the last pixel evaluated
    ; as possibly matching with the needle's first pixel. So, we must
    ; avoid going beyond this maximum final coordinate.
    If ( sx2 > (hWidth-nWidth+1) )
        return -3003
    If ( sy2 > (hHeight-nHeight+1) )
        return -3004

    ; Abort if the width or height of the search box is 0
    If ( sx2-sx1 == 0 )
        return -3005
    If ( sy2-sy1 == 0 )
        return -3006

    ; The DllCall parameters are the same for easier C code modification,
    ; even though they aren't all used on the _ImageSearch version
    x := 0, y := 0
    , E := DllCall( &_ImageSearch, "int*",x, "int*",y, Ptr,hScan, Ptr,nScan, "int",nWidth, "int",nHeight
    , "int",hStride, "int",nStride, "int",sx1, "int",sy1, "int",sx2, "int",sy2, "int",Variation
    , "int",sd, "cdecl int")
    Return ( E == "" ? -3007 : E )
}
from_window(image) {
      ; Thanks tic - https://www.autohotkey.com/boards/viewtopic.php?t=6517

      ; Get the handle to the window.
      image := (hwnd := WinExist(image)) ? hwnd : image

      ; Restore the window if minimized! Must be visible for capture.
      if DllCall("IsIconic", "ptr", image)
         DllCall("ShowWindow", "ptr", image, "int", 4)

      ; Get the width and height of the client window.
      dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
      DllCall("GetClientRect", "ptr", image, "ptr", &Rect := VarSetCapacity(Rect, 16)) ; sizeof(RECT) = 16
         , width  := NumGet(Rect, 8, "int")
         , height := NumGet(Rect, 12, "int")
      DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")

      ; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
      hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
      VarSetCapacity(bi, 40, 0)              ; sizeof(bi) = 40
         NumPut(       40, bi,  0,   "uint") ; Size
         NumPut(    width, bi,  4,   "uint") ; Width
         NumPut(  -height, bi,  8,    "int") ; Height - Negative so (0, 0) is top-left.
         NumPut(        1, bi, 12, "ushort") ; Planes
         NumPut(       32, bi, 14, "ushort") ; BitCount / BitsPerPixel
      hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", &bi, "uint", 0, "ptr*", pBits:=0, "ptr", 0, "uint", 0, "ptr")
      obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")

      ; Print the window onto the hBitmap using an undocumented flag. https://stackoverflow.com/a/40042587
      DllCall("user32\PrintWindow", "ptr", image, "ptr", hdc, "uint", 0x3) ; PW_RENDERFULLCONTENT | PW_CLIENTONLY
      ; Additional info on how this is implemented: https://www.reddit.com/r/windows/comments/8ffr56/altprintscreen/

      ; Convert the hBitmap to a Bitmap using a built in function as there is no transparency.
      DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hbm, "ptr", 0, "ptr*", pBitmap:=0)

      ; Cleanup the hBitmap and device contexts.
      DllCall("SelectObject", "ptr", hdc, "ptr", obm)
      DllCall("DeleteObject", "ptr", hbm)
      DllCall("DeleteDC",     "ptr", hdc)

      return pBitmap
   }
; [ GDIP PIXEL SEARCH ]
DEPRECATED_Gdip_PixelSearch(pBitmap, ARGB, ByRef x, ByRef y, StartWidth,StartHeight,Width,Height, variation){
	static MCode_PixelSearch := ""
	if !MCode_PixelSearch
           MCode_PixelSearch := MCode("2,x86:VVdWU4PsEItMJDCLRCQ0i3QkOIXJjVEDD0nRi0wkLMH6AoXJD46RAAAAicEPtvzHRCQIAAAAAA+26MH5EIk8JA+2+Yl8JASNPJUAAAAAiXwkDIt8JCSLRCQoMcmFwH5IixSPD7bCKeiJw8H7HzHYKdg58H8qD7bGKwQkicPB+x8x2CnYOfB/F8HqEA+20itUJASJ0MH4HzHCKcI58n5Bg8EBOUwkKHW4g0QkCAEDfCQMi0QkCDlEJCx1m4tEJDzHAP////+LRCRAxwD/////g8QQuP////9bXl9dw410JgCLRCQ8i3wkCIkIi0QkQIk4g8QQMcBbXl9dww==,x64:QVdBVkFVQVRVV1ZTSIPsGESLlCSIAAAARYXJQY1BA0GJ1UmJzEQPSMiLlCSAAAAARYnGQcH5AkSJTCQMRYXAD46KAAAAidcPtvZFMf8x7cH/EEQPttpJY91AD7b/RYXtfmBJY8cxyU2NDIQPH0QAAEGLFIkPtsJEKdhBicBBwfgfRDHARCnARDnQfy0PtsYp8EGJwEHB+B9EMcBEKcBEOdB/FsHqEA+20in6idDB+B8xwinCRDnSfj9Ig8EBSDnLda6DxQFEA3wkDEE57nWOSIuEJJAAAADHAP////9Ii4QkmAAAAMcA/////7j/////6xxmDx9EAABIi4QkkAAAAIkISIuEJJgAAACJKDHASIPEGFteX11BXEFdQV5BX8M=")
	;Gdip_GetImageDimensions(pBitmap, Width, Height) ;IMPORTANT
	;if !(Width && Height)
	;	return -1

	if (E1 := Gdip_LockBits(pBitmap, StartWidth, StartHeight, Width, Height, Stride1, Scan01, BitmapData1))
		return -2

	x := y := 0
	E := DllCall(MCode_PixelSearch, "ptr", Scan01, "int", Width, "int", Height, "int", Stride1, "uint", ARGB, "int", variation, "int*", x, "int*", y)
	Gdip_UnlockBits(pBitmap, BitmapData1)
	return (E = "") ? -3 : E

}
Gdip_PixelSearch(pBitmap, ARGB, ByRef x, ByRef y, variation){
GLOBAL
	static MCode_PixelSearch
	if !MCode_PixelSearch
           MCode_PixelSearch := MCode("2,x86:VVdWU4PsEItMJDCLRCQ0i3QkOIXJjVEDD0nRi0wkLMH6AoXJD46RAAAAicEPtvzHRCQIAAAAAA+26MH5EIk8JA+2+Yl8JASNPJUAAAAAiXwkDIt8JCSLRCQoMcmFwH5IixSPD7bCKeiJw8H7HzHYKdg58H8qD7bGKwQkicPB+x8x2CnYOfB/F8HqEA+20itUJASJ0MH4HzHCKcI58n5Bg8EBOUwkKHW4g0QkCAEDfCQMi0QkCDlEJCx1m4tEJDzHAP////+LRCRAxwD/////g8QQuP////9bXl9dw410JgCLRCQ8i3wkCIkIi0QkQIk4g8QQMcBbXl9dww==,x64:QVdBVkFVQVRVV1ZTSIPsGESLlCSIAAAARYXJQY1BA0GJ1UmJzEQPSMiLlCSAAAAARYnGQcH5AkSJTCQMRYXAD46KAAAAidcPtvZFMf8x7cH/EEQPttpJY91AD7b/RYXtfmBJY8cxyU2NDIQPH0QAAEGLFIkPtsJEKdhBicBBwfgfRDHARCnARDnQfy0PtsYp8EGJwEHB+B9EMcBEKcBEOdB/FsHqEA+20in6idDB+B8xwinCRDnSfj9Ig8EBSDnLda6DxQFEA3wkDEE57nWOSIuEJJAAAADHAP////9Ii4QkmAAAAMcA/////7j/////6xxmDx9EAABIi4QkkAAAAIkISIuEJJgAAACJKDHASIPEGFteX11BXEFdQV5BX8M=")
	Gdip_GetImageDimensions(pBitmap, Width, Height)
	if !(Width && Height)
		return -1001

	if (E1 := Gdip_LockBits(pBitmap, 0, 0, Width, Height, Stride1, Scan01, BitmapData1))
		return -1002

	x := y := 0
	E := DllCall(MCode_PixelSearch, "ptr", Scan01, "int", Width, "int", Height, "int", Stride1, "uint", ARGB, "int", variation, "int*", x, "int*", y)
	Gdip_UnlockBits(pBitmap, BitmapData1)
	return (E = "") ? -3 : E
}
MCode(mcode){
  static e := {1:4, 2:1}, c := (A_PtrSize=8) ? "x64" : "x86", s := "", op := ""
  if (!regexmatch(mcode, "^([0-9]+),(" c ":|.*?," c ":)([^,]+)", m))
    return -4
  if (!DllCall("crypt32\CryptStringToBinary", "str", m3, "uint", 0, "uint", e[m1], "ptr", 0, "uint*", s, "ptr", 0, "ptr", 0))
    return -5
  p := DllCall("GlobalAlloc", "uint", 0, "ptr", s, "ptr")
  if (c="x64")
    DllCall("VirtualProtect", "ptr", p, "ptr", s, "uint", 0x40, "uint*", op)
  if (DllCall("crypt32\CryptStringToBinary", "str", m3, "uint", 0, "uint", e[m1], "ptr", p, "uint*", s, "ptr", 0, "ptr", 0))
    return p
  DllCall("GlobalFree", "ptr", p)
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

; [ OTHERS ]
Gdip_GraphicsFromHDC(hDC, hDevice:="", InterpolationMode:="", SmoothingMode:="", PageUnit:="", CompositingQuality:="") {
pGraphics := 0
If hDevice
DllCall("Gdiplus\GdipCreateFromHDC2", "UPtr", hDC, "UPtr", hDevice, "UPtr*", pGraphics)
Else
DllCall("gdiplus\GdipCreateFromHDC", "UPtr", hdc, "UPtr*", pGraphics)
If pGraphics
{
If (InterpolationMode!="")
Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
If (SmoothingMode!="")
Gdip_SetSmoothingMode(pGraphics, SmoothingMode)
If (PageUnit!="")
Gdip_SetPageUnit(pGraphics, PageUnit)
If (CompositingQuality!="")
Gdip_SetCompositingQuality(pGraphics, CompositingQuality)
}
return pGraphics
}
Gdip_DeleteBrush(pBrush) {
return DllCall("gdiplus\GdipDeleteBrush", "UPtr", pBrush)
}
Gdip_SetInterpolationMode(pGraphics, InterpolationMode) {
return DllCall("gdiplus\GdipSetInterpolationMode", "UPtr", pGraphics, "int", InterpolationMode)
}
Gdip_SetSmoothingMode(pGraphics, SmoothingMode) {
return DllCall("gdiplus\GdipSetSmoothingMode", "UPtr", pGraphics, "int", SmoothingMode)
}
Gdip_SetPageUnit(pGraphics, Unit) {
Static Ptr := "UPtr"
return DllCall("gdiplus\GdipSetPageUnit", Ptr, pGraphics, "int", Unit)
}
Gdip_SetCompositingQuality(pGraphics, CompositionQuality) {
Static Ptr := "UPtr"
return DllCall("gdiplus\GdipSetCompositingQuality", Ptr, pGraphics, "int", CompositionQuality)
}
Gdip_GraphicsClear(pGraphics, ARGB:=0x00ffffff) {
return DllCall("gdiplus\GdipGraphicsClear", "UPtr", pGraphics, "int", ARGB)
}
; ==================================================================================================================================
; Sets the colors for selected rows in a ListView.
; Parameters:
;     HLV      -  handle (HWND) of the ListView control.
;     BkgClr   -  background color as RGB integer value (0xRRGGBB).
;                 If omitted or empty the ListViews's background color will be used.
;     TxtClr   -  text color as RGB integer value (0xRRGGBB).
;                 If omitted or empty the ListView's text color will be used.
;                 If both BkgColor and TxtColor are omitted or empty the control will be reset to use the default colors.
;     Dummy    -  must be omitted or empty!!!
; Return value:
;     No return value.
; Remarks:
;     The function adds a handler for WM_NOTIFY messages to the chain of existing handlers.
; ==================================================================================================================================
LV_SetSelColors(HLV, BkgClr := "", TxtClr := "", Dummy := "") {
   Static OffCode := A_PtrSize * 2              ; offset of code        (NMHDR)
        , OffStage := A_PtrSize * 3             ; offset of dwDrawStage (NMCUSTOMDRAW)
        , OffItem := (A_PtrSize * 5) + 16       ; offset of dwItemSpec  (NMCUSTOMDRAW)
        , OffItemState := OffItem + A_PtrSize   ; offset of uItemState  (NMCUSTOMDRAW)
        , OffClrText := (A_PtrSize * 8) + 16    ; offset of clrText     (NMLVCUSTOMDRAW)
        , OffClrTextBk := OffClrText + 4        ; offset of clrTextBk   (NMLVCUSTOMDRAW)
        , Controls := {}
        , MsgFunc := Func("LV_SetSelColors")
        , IsActive := False
   Local Item, H, LV, Stage
   If (Dummy = "") { ; user call ------------------------------------------------------------------------------------------------------
      If (BkgClr = "") && (TxtClr = "")
         Controls.Delete(HLV)
      Else {
         If (BkgClr <> "")
            Controls[HLV, "B"] := ((BkgClr & 0xFF0000) >> 16) | (BkgClr & 0x00FF00) | ((BkgClr & 0x0000FF) << 16) ; RGB -> BGR
         If (TxtClr <> "")
            Controls[HLV, "T"] := ((TxtClr & 0xFF0000) >> 16) | (TxtClr & 0x00FF00) | ((TxtClr & 0x0000FF) << 16) ; RGB -> BGR
      }
      If (Controls.MaxIndex() = "") {
         If (IsActive) {
            OnMessage(0x004E, MsgFunc, 0)
            IsActive := False
      }  }
      Else If !(IsActive) {
         OnMessage(0x004E, MsgFunc)
         IsActive := True
   }  }
   Else { ; system call ------------------------------------------------------------------------------------------------------------
      ; HLV : wParam, BkgClr : lParam, TxtClr : uMsg, Dummy : hWnd
      H := NumGet(BkgClr + 0, "UPtr")
      If (LV := Controls[H]) && (NumGet(BkgClr + OffCode, "Int") = -12) { ; NM_CUSTOMDRAW
         Stage := NumGet(BkgClr + OffStage, "UInt")
         If (Stage = 0x00010001) { ; CDDS_ITEMPREPAINT
            Item := NumGet(BkgClr + OffItem, "UPtr")
            If DllCall("SendMessage", "Ptr", H, "UInt", 0x102C, "Ptr", Item, "Ptr", 0x0002, "UInt") { ; LVM_GETITEMSTATE, LVIS_SELECTED
               ; The trick: remove the CDIS_SELECTED (0x0001) and CDIS_FOCUS (0x0010) states from uItemState and set the colors.
               NumPut(NumGet(BkgClr + OffItemState, "UInt") & ~0x0011, BkgClr + OffItemState, "UInt")
               If (LV.B <> "")
                  NumPut(LV.B, BkgClr + OffClrTextBk, "UInt")
               If (LV.T <> "")
                  NumPut(LV.T, BkgClr + OffClrText, "UInt")
               Return 0x02 ; CDRF_NEWFONT
         }  }
         Else If (Stage = 0x00000001) ; CDDS_PREPAINT
            Return 0x20 ; CDRF_NOTIFYITEMDRAW
         Return 0x00 ; CDRF_DODEFAULT
}  }  }




#Include %A_ScriptDir%\views\walker.ahk 



