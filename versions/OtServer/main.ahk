; =======================================================================================
; Name ..........: TibiaMacros - OtServer
VersionMacro := "v10.0 - OtServer"
; AHK Version ...: AHK_L 1.1.22.06 (Unicode 64-bit)
; Platform ......: Windows 10 / 11
; Language ......: Portugues Brasil (PT-BR)
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

SetWorkingDir, %A_ScriptDir%
IniRead, TibiaServer, %A_ScriptDir%\..\..\conf\Login.ini, Login, TibiaServer
IniRead, GlobalLanguage, %A_ScriptDir%\..\..\conf\Login.ini, Login, GlobalLanguage
if (TibiaServer == "Global") {
	Portugues := "Voce pode ser penalizado/banido por utilizar macros no Tibia Global. Voce concorda com os riscos e mesmo assim esta disposto a usar?"
	English := "You can be penalized/banned for using macros on Tibia Global. Do you agree with the risks and are you still willing to use it?"
	MsgBox,4, WARNING (CAUTION) , % %GlobalLanguage%
	IfMsgBox, No
		EXITAPP
	TrayName := "TibiaMacros"
	Menu, Tray, Tip, %TrayName%
}
Menu, Tray, Add, Pause Script, ForcePauseScript
Menu, Tray, Add, Reload, Reload
Menu, Tray, Add, Exit, Exit
Menu, Tray, NoStandard

LoadGDIplus() 		;[Load Modules GDIP - PrintScreen MH]

; Global ================================================================================
#SingleInstance, OFF ; Allow only one running instance of script
#Persistent ; Keep script permanently running until terminated
#NoEnv ; Avoid checking empty variables to see if they are environment variables
#KeyHistory 0
;#Warn ; Enable warnings to assist with detecting common errors
;#NoTrayIcon ; Disable the tray icon of the script
SendMode, Input ; Recommended for new scripts due to its superior speed and reliability
SetBatchLines, -1 ; Run script at maximum speed
CoordMode, ToolTip, Screen
ListLines Off
PIDs := DllCall("GetCurrentProcessId")
Process, Priority, %PIDs%, Realtime
;Thread, interrupt, 250
Thread, NoTimers, true  ;uma Thread nao interrompe a outra
SetStoreCapsLockMode, Off	;nao desativa o capslock no controlsend

SetMouseDelay, -1			;-1 = client12 //// 1 = client 10
SetDefaultMouseSpeed, 0		;0 = client12 //// 2 = client 10
SetWinDelay, -1
SetControlDelay, -1
; HOTKEYS DELAY
IniRead, CheckBox_NoDelayActions, Configs\Login.ini, Extras, CheckBox_NoDelayActions
if (CheckBox_NoDelayActions == 1 && TibiaServer != "Global") {
	SetKeyDelay, -1, -1
} else {
	SetKeyDelay, 0, 75	;colocando 75ms pra fix bug ControlSend (Shift, Alt, Control)
}

; Groups ================================================================================
GroupAdd, DreamBot, ahk_class Qt5QWindowOwnDCIcon	;used in Shift+F12 HIDE ALL GUI
GroupAdd, DreamBot, ahk_exe client.exe	;used in Shift+F12 HIDE ALL GUI
GroupAdd, DreamBot, ahk_exe Tibia.exe	;used in Shift+F12 HIDE ALL GUI
GroupAdd, DreamBot, ahk_class AutoHotkeyGUI

GroupAdd, Tibia, ahk_class Tibiantis c
GroupAdd, Tibia, ahk_exe client.exe
GroupAdd, Tibia, ahk_class Qt5QWindowOwnDCIcon
GroupAdd, Tibia, ahk_exe taleon.exe
GroupAdd, Tibia, ahk_exe Tibia.exe
GroupAdd, Tibia, ahk_exe tibia.exe
GroupAdd, Tibia, ahk_class KingdomSwapATS
GroupAdd, Tibia, ahk_exe Client_launcher
GroupAdd, Tibia, ahk_class Nostalrius_V01
GroupAdd, Tibia, ahk_class ArderaOT
GroupAdd, Tibia, ahk_class Like-Retro
GroupAdd, Tibia, ahk_exe Calmera.exe
GroupAdd, Tibia, ahk_class Qt5158QWindowOwnDCIcon
GroupAdd, Tibia, ahk_class Qt663QWindowIcon ;Arcana GOLD
GroupAdd, Tibia, ahk_class shadowillusionOfficialV4
GroupAdd, Tibia, ahk_class Gods Of Rising
GroupAdd, Tibia, ahk_class Realera
GroupAdd, Tibia, ahk_exe rubinot_dx.exe	;RubinOT
GroupAdd, Tibia, ahk_exe rubinot_gl.exe	;RubinOT
GroupAdd, Tibia, ahk_class DeusOT
#IfWinActive, ahk_group Tibia

	; OnMessage(0x0200, "MouseHover")
	OnMessage(0x0201, "WM_LBUTTONDOWN")
	; Inicializa o GDI+
	if !pToken := Gdip_Startup() {
		MsgBox, Falha ao iniciar GDI+.
		ExitApp
	}

	Create_Variables()
	ReadINI()
	; Login()
	Load_Images()		;LOAD GDIP IMAGES
	Load_Picture_GUI()	;LOAD GDIP PICTURES GUI
	Load_All_GUIs()
	Gui, Main:Show, xCenter yCenter w%GUIWidth% h%GUIHeight% NoActivate, %TrayName%	;NAME PROGRAMA
	SelectClient:
		Load_Images()		;LOAD GDIP IMAGES
		Save_And_Load_Configs("load_config")
		SelectClient()
		SelectHaystack()
		SetTimer, EngineLoop, 50
		; NEED 2 LOOPS TO WORKS
		Loop, 2 {
			Verify_All_Hotkeys(force:=true)
		}
	RETURN

	; Labels ================================================================================
	EngineLoop:
		if ( PrintScreenData() != False ) {
			GuiControlGet, Delay_Ping, Extras:
			if (Delay_Ping > 0) {
				Sleep, % Delay_Ping - ElapsedTime_RunScript
			}

			StarTime_RunScript := A_TickCount

			if(GetColorHex(Cords.HP.2+1, Cords.HP.3+1) != ColorHex_Validate_HPBar)
				if not LocateHPBar()
					Reconnect()
			if(GetColorHex(Cords.CooldownBox.2,Cords.CooldownBox.3) != ColorHex_Validate_CooldownBox)
				LocateCooldownBar()
			if(GetColorHex(Cords.Con.2+1, Cords.Con.3+1) != ColorHex_Validate_ConditionsBar)
				LocateConditionBar()
			if(GetColorHex(Cords.GameBorda_LeftBottom.2, Cords.GameBorda_LeftBottom.3) != ColorHex_Validate_GameBorda_LeftBottom)
				LocateGameBorda()
			if(GetColorHex(Cords.GameBorda_RightTop.2, Cords.GameBorda_RightTop.3) != ColorHex_Validate_GameBorda_RightTop)
				LocateGameBorda()

			if (WinActive("ahk_class AutoHotkeyGUI")) {
				Verify_All_Hotkeys()
			}

			Verify_PartyList()
			Verify_FriendHP_FirstPlayer()
			Verify_FriendHP_SecondPlayer()
			Heal_Friend()	;MAS RES && FOLLOW && SIO

			Verify_CooldownBar()
			Verify_HP()
			Verify_MP()

			Verify_ChatOn()	;Verify Chat ON + Pause

			Special_Foods()
			Healing_Spells()
			Healing_Potions()

			Verify_Conditions()
			Support_Spells()

			OffSet := 28
			RConBarX := Cords.Con.2+3, RConBarY := Cords.Con.3-55	;Rings
			AConBarX := Cords.Con.2+3, AConBarY := Cords.Con.3-127	;Amulet
			Verify_Equips()
			Equip_Amulet()
			Equip_Ring()
			ReloadAmmo()

			Verify_BattleList()
			Auto_Combo()

			Timer_Hotkey()
			Mana_Burn()
			Exercise_AutoTrainer()
			Change_Gold()
			DropFlask()

			CaveBot()

			ElapsedTime_RunScript := A_TickCount - StarTime_RunScript
			Gui, Extras:Default
			GuiControl,, TickCount_Macro, % ElapsedTime_RunScript
			;~ TOOLTIP, % "HP:" Data.HP "`nMP: " Data.MP
		} else {
			if (TibiaServer != "Global") {
				MsgBox, % "[OtServer V12+] Game Not Found"
			} else {
				MsgBox, % "[OtServer V12+] OBS STUDIO NOT FOUND"
			}
			SetTimer, EngineLoop, OFF
			goto, SelectClient
		}
	RETURN

	ForcePauseScript:
		Pause
	RETURN
	Reload:
	RETURN
	Exit:
	Main_OnClose:
		Remove_All_Tooltips()
		ToolTip, Saving And Close...
		Save_And_Load_Configs("save_config")
		Gdip_shutdown(pToken)
	EXITAPP

	; Includes ================================================================================
	#Include ..\..\libs\bcrypt.ahk
	#Include ..\..\libs\GDIP.ahk
	#Include ..\..\libs\JSON.ahk
	#Include ..\..\libs\PrintScreen.ahk

	; Functions (Controllers) ==============================================================================
	#Include controllers\battle_list.ahk
	#Include controllers\condition_bar.ahk
	#Include controllers\cooldown_bar.ahk
	#Include controllers\core.ahk
	#Include controllers\debugger.ahk
	#Include controllers\gui_settings.ahk
	#Include controllers\load_images_b64.ahk
	#Include controllers\remove_tooltip.ahk
	#Include controllers\save_and_load_conf.ahk
	#Include controllers\verify_cap.ahk
	#Include controllers\verify_equips.ahk
	#Include controllers\verify_hotkeys.ahk

	; Functions (MODELS) ==============================================================================
	#Include models\alarms.ahk
	#Include models\cavebot.ahk
	#Include models\heal_friend.ahk
	#Include models\combo.ahk
	#Include models\extras.ahk
	#Include models\healing.ahk
	#Include models\looter.ahk
	#Include models\pvp.ahk
	#Include models\remapkeys.ahk
	#Include models\renew_growth.ahk
	#Include models\support.ahk
	#Include models\tankmode.ahk
	#Include models\telegram.ahk
	#Include models\timer.ahk

	; GUI (VIEWS) ==============================================================================
	#Include views\alarms.ahk
	#Include views\cavebot.ahk
	#Include views\combo.ahk
	#Include views\extras.ahk
	#Include views\gui_settings.ahk
	#Include views\heal_friend.ahk
	#Include views\healing.ahk
	#Include views\looter.ahk
	#Include views\pvp.ahk
	#Include views\remapkeys.ahk
	#Include views\support.ahk
	#Include views\tankmode.ahk
	#Include views\timer.ahk

	; Functions ================================================================================
	WM_LBUTTONDOWN() {
		PostMessage, 0xA1, 2,,, A
	}

	MouseHover() {
		;WhichToolTip:=5
		Global _IdStuckTargeting, _IdAttemptTarget, _IdAttemptWalker, _IdAttemptCheckTrap, _IdMaximumLaps, _IdShowToolTip, _IdLureMode
		Global GlobalLanguage
		MouseGetPos, , , , CurrControl  ,2
		switch CurrControl {
		case _IdStuckTargeting:
			Portugues	:= "Tempo Total em que o macro ira ficar atacando um unico monstro. `n(apos o tempo, sera ignorado)"
			English		:= "Total time that the macro will attack a single monster. `n(after the time, it will be ignored)"
			ToolTip, % %GlobalLanguage%,,, 6
			RETURN

		case _IdAttemptTarget:
			Portugues	:= "Total tentativas que vai targetar o monstro. `n(apos o numero de tentativas, sera ignorado)"
			English		:= "Total attempts that will target the monster. `n(after the number of attempts, it will be ignored)"
			ToolTip, % %GlobalLanguage%,,, 6
			RETURN

		case _IdAttemptWalker:
			Portugues := "Total de tentativas que o macro ira clicar para ir pro proximo waypoint. `n(apos o numero de tentativas, ira para o proximo waypoint)"
			English := "Total number of attempts that the macro will click to go to the next waypoint. `n(after the number of attempts, it will go to the next waypoint)"
			ToolTip, % %GlobalLanguage%,,, 6
			RETURN

		case _IdAttemptCheckTrap:
			Portugues := "Numero de tentativas que ira tentar andar ate a marca antes de checar se esta trapado"
			English := "Number of attempts you will try to reach the mark before checking if you are trapped"
			ToolTip, % %GlobalLanguage%,,, 6
			RETURN

		case _IdMaximumLaps:
			Portugues := "Numero maximo de vezes que vai verificar o cap no final da hunt, `ncaso verifique o numero maximo de vezes ele ira prosseguir pro proximo waypoint ignorando o cap"
			English := "Maximum number of times it will check the cap at the end of the hunt, `nif it checks the maximum number of times it will proceed to the next waypoint ignoring the cap"
			ToolTip, % %GlobalLanguage%,,, 6
			RETURN

		case _IdShowToolTip:
			Portugues := "Isso " Chr(233) " um ToolTip."
			English := "This is a ToolTip"
			ToolTip, % %GlobalLanguage%,,, 6
			RETURN

		case _IdLureMode:
			Portugues := "Valido APENAS para Waypoints com 'Ignore Targeting == TRUE'"
			English := "Valid ONLY for Waypoints with 'Ignore Targeting == TRUE'"
			ToolTip, % %GlobalLanguage%,,, 6
			Return

		default:
			ToolTip,,,, 6
		}
	}

	Create_Variables() {
		GLOBAL
		expire_date := 20301122
		CheckBox_ShowToolTip := true	;ARRUMAR

		ArColor:=[], Data:=[], Data.Group:=[], Dados:=[], Cords:=[], AutoHunt:=[], Data.FriendHP:=[], Cords.BattleList:=[], Cords.AttackMode:=[], SQMLoot:=[], RubinOT_Status_MP:=[]

		if (GlobalLanguage != "English" or GlobalLanguage != "Portugues") {
			GlobalLanguage := "Portugues"
		}

		ColorHP := ["0x00C000", "0x60C060", "0xC0C000", "0xC03030", "0x707070", "0x600000", "0xC00000", "0x5D0707"]	;os tres ultimos sao pro targeting

		;TOOLTIP DELAY
		List_State_ToolTip := []
		; [ GERAL = 20 ]
		; [ 1 = Healing ]  &&  [ 2 = Healing Friend ] && [ 3 = Combo ] && [ 4 = Timer ]
		; [ 5 = TankMode ] && [ 6 = Support ] && [ 7 = PvP ] && [ 8 = Looter ]
		; [ 9 = Alarms ] && [ 10 = CaveBot ] && [ 11 = Extras ] && [ 12 = Others]

		;Pause Macro
		State_Script := "ON"
		Status_Gui_Hide := FALSE

		; HEALING
		StartTime_Healing_Spells := -1		;exaust use spell
		StartTime_Healing_Potions := -1		;exaust use potion mana
		StartTime_DropFlask := -1			;exaust drop flask

		ColorHex_Validate_HPBar := "#"
		ColorHex_Validate_CooldownBox := "#"

		; SUPPORT
		ColorHex_Validate_ConditionsBar := "#"
		StartTime_Support_Spells := -1

		; TANKMODE
		RingSlot_Coord_X:="" ;V7.x
		RingSlot_Coord_Y:=""	;V7.x
		StartTime_Equip_Amulet := -1		;exaust equip amulet
		StartTime_Equip_Ring := -1			;exaust equip ring
		StartTime_UtamoTempo := -1
		StartTime_SpecialFoods_Life := -1	;exaust special food
		StartTime_SpecialFoods_Mana := -1	;exaust special food

		;SIO FRIEND ICONS PARTY LIST
		EK_PositionY := 30
		RP_PositionY := 56
		State_Icons_Party_List := "Show"

		;[MAS RES]
		MasRes := 0	;fix bug

		;[ Combo ]
		Type_Combo_Active := "Combo_PvE"
		StartTime_Combo_Spells_Attack := -1
		StartTime_ExetaRes := -1
		ElapsedTime_UtitoTempo := -1
		;[Knight]
		NextExeta := "ExetaRes"
		StartTime_ExetaRes := -1
		StartTime_UtitoTempo := -1

		;[ Looter ]
		ColorHex_Validate_GameBorda_LeftBottom := "#"
		ColorHex_Validate_GameBorda_RightTop := "#"

		;[Timer]
		StartTime_Timer1 := -1
		StartTime_Timer2 := -1
		StartTime_Timer3 := -1
		StartTime_Timer4 := -1
		StartTime_Change_Gold := -1
		StartTime_Reconnect := -1
		StartTime_Mana_Burn := -1

		;[Exercise Timer]
		StartTimeTimer := -9999
		VoltaPraJanelaAnterior := 0 ;deprecated

		;[PvP]
		Hotkey_MagicWall := ""
		Hotkey_GrowthRune := ""
		HotkeyFollow := ""
		ElapsedTime_AutoFollow:=0

		;[ CaveBot ]
		VipMode := "true"
		ColorHex_Validate_MapHunt := "#"
		ColorHex_Validate_EstrelaCardial := "#"
		StartTime_CaveBot := -1
		StartTime_TrialCaveBot := -1
		StartTime_Walker := -1
		StartTime_ThereIsNoWay := -1
		StartTime_Alarm := -1
		StartTime_AutoAttack := -1

		Start_Round_Attack := false	;fix bug targeting Stop Attack
		StartTime_PressHotkeyifDontHavePlayer := -1
		StartTime_WalkToWaypoint := -1

		WalkerEnable := 0
		WayPoint := 1
		AntiRed_PlayerOnScreen := false
		Life_Pause_Walker := false

		TargetingTentativas := 0

		CaveBot_NumeroDeVoltas := 0

		Previous_Mark := []

		;[ renew growth ]
		Renew_Growth_Stop_Combo := false

		;[Check player On Screen]
		StartTimeAlert := 9999999	;Player Detected
		StartTime_Message_Not_PlayerOnScreen := 9999999

		; [Telegram]
		StartTime_TelegramBot := -1
	}

	Draw_Gui_Main() {
		GLOBAL
		Gui, Main:New
		Gui, Main:+LabelMain_On	;goto label Main_OnClose

		GUIWidth := 331, GUIHeight := 68

		Gui, Color, 390202
		Gui, Font, cWhite
		Gui, Margin, 10, 10
		Gui, +AlwaysOnTop

		Gui, Add, Hotkey, x9999 y9999 w10 h10 vtmpHotkey,

		Gui, Add, Button, x1 y1 w80 h20 gShow_Gui_Healing, Healing
		Gui, Add, Button, x84 y1 w80 h20 gDraw_Gui_HealFriend, Heal Friend
		Gui, Add, Button, x167 y1 w80 h20 gDraw_Gui_Combo, Combo
		Gui, Add, Button, x250 y1 w80 h20 gDraw_Gui_Timer, Timer

		Gui, Add, Button, x1 y24 w80 h20 gDraw_Gui_TankMode, TankMode
		Gui, Add, Button, x84 y24 w80 h20 gDraw_Gui_Support, Support
		Gui, Add, Button, x167 y24 w80 h20 gDraw_Gui_PvP, PvP
		Gui, Add, Button, x250 y24 w80 h20 gDraw_Gui_Looter, Looter

		Gui, Add, Button, x1 y47 w80 h20 gDraw_Gui_RemapKeys, RemapKeys
		Gui, Add, Button, x84 y47 w80 h20 gDraw_Gui_Alarms, Alarms
		Gui, Add, Button, x167 y47 w80 h20 gDraw_Gui_CaveBot, CaveBot
		Gui, Add, Button, x250 y47 w80 h20 gDraw_Gui_Extras, Extras
	}
	Load_Pre_Settings(Gui_Name) {
		GLOBAL
		Gui, %Gui_Name%:-DPIScale
		Gui, %Gui_Name%:New
		Gui, %Gui_Name%:+AlwaysOnTop

		Gui, Color, 390202
		Gui, Font, cWhite
		Gui, Margin, 10, 10
	}
	Load_All_GUIs() {
		GLOBAL
		Draw_Gui_Main()

		Draw_Gui_Healing()
		Draw_Gui_HealFriend()
		Draw_Gui_Combo()
		gosub, Refresh_Images_GUI_Combo
		Draw_Gui_Timer()

		Draw_Gui_TankMode()
		gosub, Refresh_All_Images_GUI_TankMode
		Draw_Gui_Support()
		Draw_Gui_PvP()
		Draw_Gui_Looter()

		Draw_Gui_RemapKeys()
		Draw_Gui_Alarms()
		Create_HUD_CaveBot()
		Draw_Gui_CaveBot()
		Draw_Gui_Extras()

	}

	SelectClient() {
		GLOBAL
		Loop, {
			ToolTip, Waiting for Tibia Client...
			Sleep 35
			if (WinActive("ahk_group Tibia") or ( GetKeyState("Control") && GetKeyState("s") ) ) {
				ToolTip
				Gui, Main:-AlwaysOnTop
				WinGet, active_id, ID, A
				WinMaximize, ahk_id %active_id%
				;#if WinActive("ahk_id " active_id) || WinActive("ahk_class AutoHotkeyGUI")	;enable hotkeys only in this client
				WinGetTitle, active_title, ahk_id %active_id%
				MsgBox,4,AutoHotkey, Tibia Client is "%active_title%"??
				IfMsgBox Yes
					BREAK
				WinActivate, ahk_class AutoHotkeyGUI
			}
		}

		Gui, Main:+AlwaysOnTop
		GroupAdd, TibiaVM, ahk_id %active_id%
		GroupAdd, TibiaVM, ahk_exe explorer.exe

		GroupAdd, Tibia, 	ahk_id %active_id%	;fix bug ctrl+s
		GroupAdd, DreamBot, ahk_id %active_id%	;fix bug ctrl+s
		Config_TibiaClient_Style()
		if (TibiaServer != "Global") {
			Gui, Main:Show, NoActivate, %active_title%	;NAME PROGRAMA
			Menu, Tray, Tip, %active_title% 			; Change the tooltip of the tray icon
		}
	}

	SelectHaystack() {
		GLOBAL
		Loop {
			if (TibiaServer != "Global") {
				if ( WinExist("ahk_group Tibia") ) {	;redundancia depois que criei o select client, mas decidi deixar
					ToolTip
					Name_Haystack := "ahk_id" . active_id
					TrayName := active_title
					BREAK
				}
				RETURN
			}

			if (TibiaServer == "Global") {
				if ( WinExist("OnTopReplica") ) { ;OnTopReplica
					ToolTip
					WinGet, Haystack_id, ID, OnTopReplica
					Name_Haystack := "OnTopReplica"
					BREAK
				}

				if ( WinExist("Projetor:") ) { ;stream labs pt-br
					ToolTip
					WinGet, Haystack_id, ID, Projetor:
					Name_Haystack := "Projetor:"
					BREAK
				}

				if ( WinExist("Projetor em janela") ) {
					ToolTip
					WinGet, Haystack_id, ID, Projetor em janela
					Name_Haystack := "Projetor em janela"
					BREAK
				}

				if ( WinExist("Windowed Projector") ){
					ToolTip
					WinGet, Haystack_id, ID, Windowed Projector
					Name_Haystack := "Windowed Projector"
					BREAK
				}

				if (WinExist("ahk_exe obs64.exe") && ObsStudioAlternative) {
					ToolTip
					WinGet, Haystack_id, ID, ahk_exe obs64.exe
					Name_Haystack := "ahk_exe obs64.exe"
					BREAK
				}

				if ( WinExist("ahk_class OBSWindowClass") ) {	;old obs studio
					ToolTip
					WinGet, Haystack_id, ID, ahk_class OBSWindowClass
					Name_Haystack := "ahk_class OBSWindowClass"
					BREAK
				}

				if ( WinExist("Podgl") ) {	;polski obs studio
					ToolTip
					WinGet, Haystack_id, ID, Podgl
					Name_Haystack := "Podgl"
					BREAK
				}

				if ( WinExist("Proyector con ventana") ) {	;spanish obs studio
					ToolTip
					WinGet, Haystack_id, ID, Proyector con ventana
					Name_Haystack := "Proyector con ventana"
					BREAK
				}

				;RETORNA SE NAO TIVER ENCONTRADO OBS WIN EXIST
				if ( Name_Haystack == "" ) {
					ToolTip, [PT-BR] Nao foi possivel encontrar a tela projetada do OBS Studio. `n[EN] OBS Studio Windowed Projector NOT FOUND. `nPlease`, Put OBS Studio in English Language. `n`n[ERROR] SelectHaystack()
					Sleep 150
				}

			}
		}
	}

	Config_TibiaClient_Style() {
		GLOBAL
		WinGetClass, client_ahk_class, ahk_id %active_id% ; Used to reference in controllers
		if (client_ahk_class = "DeusOT") {
			screen_capture_mode := "PrintDC"
			Load_Images_DeusOT()
		}
		if (client_ahk_class = "shadowillusionOfficialV4") {
			screen_capture_mode := "PrintDC"
			TibiaServer := "Shadow-Illusion"
			Load_Images_ShadowIllusion()
		}
	}