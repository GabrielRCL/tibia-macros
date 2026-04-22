; =======================================================================================
; Name ..........: TibiaMacros - v7.4
VersionMacro := "10.0 - v7.4"
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

; Global ================================================================================
#SingleInstance, Force ; Allow only one running instance of script
#Persistent ; Keep script permanently running until terminated
#NoEnv ; Avoid checking empty variables to see if they are environment variables
#KeyHistory 0
SetBatchLines, -1 ; Run script at maximum speed
SetKeyDelay, 0, 75	;colocando 75ms pra fix bug ControlSend (Shift, Alt, Control)
SetMouseDelay, 1			;-1 = client12 //// 1 = client 10
SetDefaultMouseSpeed, 1		;0 = client12 //// 2 = client 10
SetWinDelay, -1
SetControlDelay, -1

Thread, NoTimers, true
SetStoreCapsLockMode, Off	;nao desativa o capslock no controlsend
CoordMode, ToolTip, Screen

OnMessage(0x0201, "WM_LBUTTONDOWN")
; Inicializa o GDI+
if !pToken := Gdip_Startup() {
    MsgBox, Falha ao iniciar GDI+.
    ExitApp
}
LoadGDIplus() 		;[Load Modules GDIP - PrintScreen MH]
; Login()
Declarar_Variaveis()
Load_Images()		;LOAD GDIP IMAGES
Load_Picture_GUI()	;LOAD GDIP PICTURES GUI
Draw_MainGui()
Refresh_Picture_GUI() ;LOAD GDIP PICTURES GUI

screen_capture_mode := "PrintDC"
TibiaServer := "v7.4"
SetTimer, EngineLoop, 50
RETURN

; LIBS ==================================================================================
#Include %A_ScriptDir%\..\..\libs\GDIP.ahk
#Include %A_ScriptDir%\..\..\libs\JSON.ahk
#Include %A_ScriptDir%\..\..\libs\PrintScreen.ahk

; Functions (MODELS) ==============================================================================
#Include models\core.ahk
#Include models\debugger.ahk
#Include models\get_character_position.ahk
#Include models\get_picture.ahk
#Include models\healing.ahk
#Include models\hotkeys.ahk
#Include models\remove_tooltip.ahk
#Include models\runemaker.ahk


; GUI (VIEWS) ==============================================================================
#Include views\debugger.ahk
#Include views\get_character_position.ahk
#Include views\healing.ahk
#Include views\hotkeys.ahk
#Include views\load_images_b64.ahk
#Include views\runemaker.ahk


; Functions (RunScripts)) ==============================================================================
EngineLoop:
StarTime_RunScript := A_TickCount
Gui, Main:Default
GuiControlGet, NameClient
Client := NameClient	;algumas lib utilizam essa var
WinGet, active_id, ID, % NameClient
if (PrintScreenData() != False) {
	;RUNEMAKER
	EatFood()
	CastRune()
	EquipLifeRing()
	AlertPlayer()
	

	Verify_Items()
	UseManaPotion()
	HealingHP()



	; if (ActiveHwnd != "" && false) {
	; 	Send, !{Tab}
	; 	ActiveHwnd := ""
	; }
} else {
	Gui Main:-AlwaysOnTop
	MsgBox, % "[OtServer 7.4] Game Not Found `nSelect Name Client"
	Gui Main:+AlwaysOnTop
}
RETURN


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
	ArColor:=[], Data:=[], Data.Group:=[], Dados:=[], Cords:=[], AutoHunt:=[], Data.FriendHP:=[], Cords.BattleList:=[], Cords.AttackMode:=[], SQMLoot:=[], RubinOT_Status_MP:=[]


	;TOOLTIP DELAY
	List_State_ToolTip := []

	Status_Gui_Hide := FALSE

	StartTime_ManaFluid := A_TickCount
	ManaFluidX := 0
	ManaFluidY := 0
	Have_ManaFluid := false
	Coord_MPx := 0
	Coord_MPy := 0
	Color_MP:=""

	ElapsedTime_HP := A_TickCount
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

Draw_MainGui() {
	GLOBAL
	Gui, Main:New
	Gui, Main:+LabelMain_On	;label Main_OnClose
	GUIWidth := 500, GUIHeight := 500
	Gui, Main:Show, xCenter yCenter w%GUIWidth% h%GUIHeight%, %TrayName%	;NAME PROGRAMA

	Gui, Main:Color, 390202
	Gui, Main:Font, cWhite
	Gui, Main:Margin, 10, 10
	Gui, Main:+AlwaysOnTop

	
	DrawGetCharacterPosition()
	DrawGuiHealing()
	DrawGuiHotkeys()	
	DrawGuiRuneMaker()
	DrawGuiDebugger()
}


Main_OnClose:
EXITAPP