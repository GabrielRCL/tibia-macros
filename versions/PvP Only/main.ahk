; =======================================================================================
;
; $$$$$$$$\ $$\ $$\       $$\           $$\      $$\
; \__$$  __|\__|$$ |      \__|          $$$\    $$$ |
;    $$ |   $$\ $$$$$$$\  $$\  $$$$$$\  $$$$\  $$$$ | $$$$$$\   $$$$$$$\  $$$$$$\   $$$$$$\   $$$$$$$\
;    $$ |   $$ |$$  __$$\ $$ | \____$$\ $$\$$\$$ $$ | \____$$\ $$  _____|$$  __$$\ $$  __$$\ $$  _____|
;    $$ |   $$ |$$ |  $$ |$$ | $$$$$$$ |$$ \$$$  $$ | $$$$$$$ |$$ /      $$ |  \__|$$ /  $$ |\$$$$$$\
;    $$ |   $$ |$$ |  $$ |$$ |$$  __$$ |$$ |\$  /$$ |$$  __$$ |$$ |      $$ |      $$ |  $$ | \____$$\
;    $$ |   $$ |$$$$$$$  |$$ |\$$$$$$$ |$$ | \_/ $$ |\$$$$$$$ |\$$$$$$$\ $$ |      \$$$$$$  |$$$$$$$  |
;    \__|   \__|\_______/ \__| \_______|\__|     \__| \_______| \_______|\__|       \______/ \_______/
;
; =======================================================================================
; Project .......: TibiaMacros - PvP Only
VersionMacro := "10.0 - PvP Only"
; AHK Version ...: AHK_L 1.1.22.06 (Unicode 64-bit)
; Platform ......: Windows 10 / 11
; Language ......: Portugues Brasil (PT-BR)
; Author ........: Gabriel R. C. Lucas <gabrielrcl@protonmail.com>
; Repository ....: https://github.com/GabrielRCL/tibia-macros
; License .......: MIT
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

; Global ================================================================================
#SingleInstance, Force ; Allow only one running instance of script
#Persistent ; Keep script permanently running until terminated
#NoEnv ; Avoid checking empty variables to see if they are environment variables
#KeyHistory 0
SetBatchLines, -1 ; Run script at maximum speed
SetKeyDelay, 0, 75	;colocando 75ms pra fix bug ControlSend (Shift, Alt, Control)
SetMouseDelay 1 ;~ SetMouseDelay, -1
SetDefaultMouseSpeed, 1		;0 = client12 //// 2 = client 10
SetWinDelay, -1
SetControlDelay, -1

Thread, NoTimers, true
SetStoreCapsLockMode, Off	;nao desativa o capslock no controlsend


OnMessage(0x0201, "WM_LBUTTONDOWN")
; Inicializa o GDI+
if !pToken := Gdip_Startup() {
    MsgBox, Falha ao iniciar GDI+.
    ExitApp
}
LoadGDIplus() 		;[Load Modules GDIP - PrintScreen MH]
Declarar_Variaveis()
Load_Images()		;LOAD GDIP IMAGES
Load_Picture_GUI()	;LOAD GDIP PICTURES GUI
Draw_MainGui()


TibiaServer := "PvP Only"
SetTimer, EngineLoop, 50
RETURN


; LIBS ==================================================================================
#Include %A_ScriptDir%\..\..\libs\GDIP.ahk
#Include %A_ScriptDir%\..\..\libs\JSON.ahk
#Include %A_ScriptDir%\..\..\libs\PrintScreen.ahk

; Functions (MODELS) ==============================================================================
#Include models\core.ahk
#Include models\debugger.ahk
#Include models\flower.ahk
#Include models\push_item.ahk
#Include models\trash.ahk

; GUI (VIEWS) ==============================================================================
#Include views\debugger.ahk
#Include views\flower.ahk
#Include views\load_images_b64.ahk
#Include views\push_item.ahk
#Include views\trash.ahk



; Functions (RunScripts)) ==============================================================================
EngineLoop:
	StarTime_RunScript := A_TickCount
	Gui, Main:Default
	if (VerifyNewConfigs() == False) {
		Gui Main:-AlwaysOnTop
		MsgBox, % "[PvP Only] Game Not Found"
		GuiControlGet, NameClient
		WinGet, active_id, ID, % NameClient
		Gui Main:+AlwaysOnTop
	}
RETURN

Check_New_Hotkey_Script(GuiControl, Label, CheckBox1:="Skip1", CheckBox2:="Skip2") {
	GLOBAL 
	;DISABLE OLD HOTKEY
	if (%GuiControl% != "ERROR" && %GuiControl% != "" && %GuiControl% != "Nothing") {
		Hotkey, % "~" %GuiControl%, %Label%, Off
	}

	;GET NEW HOTKEY
	GuiControlGet, %GuiControl%

	;CheckBox GuiControlGet
	if (CheckBox1 != "Skip1") {
		GuiControlGet, %CheckBox1%
	}
	GuiControlGet, %CheckBox2%


	;Verify CheckBox
	if (%CheckBox1% or %CheckBox2%) {
		;ENABLE NEW HOTKEY
		if (%GuiControl% != "ERROR" && %GuiControl% != "" && %GuiControl% != "Nothing") {
			Hotkey, % "~" %GuiControl%, %Label%, ON
		}
	} else if (SubStr(Label, 1, 7) == "SwapSqm") {
		;~ Hotkey, % "~" %GuiControl%, PauseLabel, ON ;BUG FIX PAUSE LABEL
	}

}


VerifyNewConfigs(first_time_verify:=false) {
	GLOBAL
	;verify client is open
	if !WinExist( "ahk_ID " active_id ) {
		Return False
	}

	;fix bug when open first time
	if (first_time_verify == false) {
		if !(WinActive("ahk_class AutoHotkeyGUI")) {
			RETURN
		}
	}
	Gui, Main:Default

	;[Flower]
		Check_New_Hotkey_Script("Key_Enable_Flower", "FlowerOnMouse", "Flower")
	;[Trash 1 e Trash 2]
		Check_New_Hotkey_Script("Key_Enable_Trash", "TrashOnMouse", "Trash1", "Trash2")
	;[Push Item to Backpack]
		Check_New_Hotkey_Script("Key_Enable_PushItem", "PushItemOnBP", "PushItem")
}








WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
    ; hwnd é o handle da janela que recebeu a mensagem
    ; Suponha que MyGuiHwnd seja o handle da GUI que você quer ignorar
    global MyGuiHwnd
    if (hwnd = MyGuiHwnd) {
        ; Ignora o evento para essa GUI específica
        return
    }
    ; Caso contrário, processa normalmente
    PostMessage, 0xA1, 2,,, A
}

Declarar_Variaveis() {
	GLOBAL
	Picture := [] ;TO USE GDIP
	ToolTip
}

Draw_MainGui() {
	GLOBAL
	Gui, Main:New
	Gui, Main:+LabelMain_On	;label Main_OnClose
	GUIWidth := 480, GUIHeight := 310
	Gui, Main:Show, xCenter yCenter w%GUIWidth% h%GUIHeight%, %TrayName%	;NAME PROGRAMA

	Gui, Main:Color, 390202
	Gui, Main:Font, cWhite
	Gui, Main:Margin, 10, 10
	Gui, Main:+AlwaysOnTop

	DrawGuiDebugger()

	; [ DELAY ]
	Gui, Font, Bold
		Gui, Add, Text, section x310 y11 w45 h20, DELAY:
	Gui, Font, Norm
	Gui, Font, cRed
		Gui, Add, Edit, xs+45 ys-3 w40 h20 Number Limit1 vDelay_PvP, 2
	Gui, Font, cWhite
		Gui, Add, Text, xs+90 ys-5 w70 h30, (MinDelay: 0 MaxDelay: 9)

	; [PvP] Tab ====================================================================
	DrawGuiFlower()
	DrawGuiTrash()
	DrawGuiPushItem()
	
	

	;~ ; ===== [Swap SQM With Rune] =====
	;~ Gui, Add, GroupBox, x5 y299 w460 h119 , MagicWall Or GrowthRune Configs
	;~ ;[Magic Wall]
	;~ Gui, Add, Picture, x12 y329 w32 h32 , % "HBITMAP:* " Picture.Magic_Wall_Rune
	;~ Gui, Add, CheckBox, x46 y329 w80 h20 vInstantMagicWall, Instant MW
	;~ Gui, Add, Text, x46 y349 w85 h15, (Automatic Click)
	;~ ;[Growth]
	;~ Gui, Add, Picture, x12 y376 w32 h32, % "HBITMAP:* " Picture.Wild_Growth_Rune
	;~ Gui, Add, CheckBox, x46 y376 w90 h20 vInstantGrowth, Instant Growth
	;~ Gui, Add, Text, x46 y396 w85 h15, (Automatic Click)

	;~ ;[SWAP SQM]
	;~ ;[MW]
	;~ Gui, Add, CheckBox, x142 y325 w75 h20 vCheckBox_SwapSqmWithMW , Swap SQM
	;~ Gui, Add, DropDownList, x142 y345 w70 h21 r4 vKey_Enable_SwapSqmWithMW , Shift|Control|Alt
	;~ ;[Growth]
	;~ Gui, Add, CheckBox, x142 y372 w75 h20 vCheckBox_SwapSqmWithGrowth , Swap SQM
	;~ Gui, Add, DropDownList, x142 y392 w70 h15 r4 vKey_Enable_SwapSqmWithGrowth , Shift|Control|Alt


	;~ ;[MW]
	;~ Gui, Add, Text, x222 y325 w70 h20 +Center, Hotkey Rune
	;~ Gui, Add, Hotkey, x222 y345 w70 h20 vHotkey_MagicWall, ;%Hotkey_MagicWall%
	;~ ;[Growth]
	;~ Gui, Add, Text, x222 y372 w70 h20 +Center, Hotkey Rune
	;~ Gui, Add, Hotkey, x222 y392 w70 h20 vHotkey_GrowthRune, ;%Hotkey_GrowthRune%


	;~ ; ===== [Auto Follow] ====
	;~ Gui, Add, GroupBox, x475 y29 w100 h75 +Center, Auto Follow
	;~ Gui, Add, CheckBox, x480 y49 w88 h20 vCheckBoxAutoFollow, Hotkey Follow
	;~ Gui, Add, Hotkey, x490 y71 w75 h20 vHotkeyFollow, +Space


	;~ ; ====== [ Click Right ] =======
		;~ Gui, Add, GroupBox, x475 y105 w100 h165 +Center, Auto Click
		;~ Gui, Add, CheckBox, x480 y125 w88 h20 vAutoClickCheckBox, Click Right
		;~ Gui, Add, Text, x490 y150 w20 h15 , X=
		;~ Gui, Add, Text, x490 y171 w20 h15 , Y=
	;~ Gui, Font, cRed
		;~ Gui, Add, Edit, x510 y146 w55 h20 vAutoClickPosX Number, 123
		;~ Gui, Add, Edit, x510 y167 w55 h20 vAutoClickPosY Number, 123
	;~ Gui, Font, cWhite
		;~ Gui, Add, Button, x485 y192 w80 h20 gAutoClickCoordinates, Select Coord.
		;~ Gui, Add, Text, x480 y220 w88 h20, Repeat Every:
	;~ Gui, Font, cRed
		;~ Gui, Add, Edit, x485 y240 w35 h20 vRepeatAutoClickTimer +Right Number, 12
	;~ Gui, Font, cWhite
		;~ Gui, Add, Text, x523 y246 w43 h20, Seconds
}


Main_OnClose:
EXITAPP