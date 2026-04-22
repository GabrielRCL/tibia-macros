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
; Project .......: TibiaMacros - Loader
VersionMacro := "10"
; AHK Version ...: AHK_L 1.1.22.06 (Unicode 64-bit)
; Platform ......: Windows 10 / 11
; Language ......: Portugues Brasil (PT-BR)
; Author ........: Gabriel R. C. Lucas <gabrielrcl@protonmail.com>
; Repository ....: https://github.com/GabrielRCL/tibia-macros
; License .......: MIT
; =======================================================================================

SetWorkingDir, %A_ScriptDir%

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

; Global ================================================================================
#SingleInstance, Force ; Allow only one running instance of script
#Persistent ; Keep script permanently running until terminated
#NoEnv ; Avoid checking empty variables to see if they are environment variables
#KeyHistory 0

OnMessage(0x0200, "MouseHover")
OnMessage(0x0201, "WM_LBUTTONDOWN")

pToken := Gdip_startup()	;inicia o GDIP
Load_Picture_GUI()
Draw_Gui_Login()
ShowDonationMessage()
Gui, LoginScreen:Show, % " w" GUIWidth " h" GUIHeight, TibiaMacros - Login
RETURN

ShowDonationMessage() {
	global GlobalLanguage

	; Unicode emojis (work regardless of file encoding)
	rocket    := Chr(0xD83D) . Chr(0xDE80)  ; rocket
	coffee    := Chr(9749)                    ; hot beverage
	lightning := Chr(9889)                    ; high voltage
	heart     := Chr(0xD83D) . Chr(0xDC96)   ; sparkling heart

	if (GlobalLanguage = "Portugues") {
		title     := rocket . "  Apoie o projeto"
		intro     := "Ei! Obrigado por usar o TibiaMacros."
		body1     := "Este projeto agora e Open Source! Depois de anos de desenvolvimento, decidi compartilhar o codigo com a comunidade de graca."
		body2     := "Se esta ferramenta esta te economizando tempo ou te ajudando a evoluir, considere apoiar minha jornada como desenvolvedor. Qualquer 'cafezinho' ajuda."
		stripeTxt := coffee . "  Me pague um cafezinho (Stripe)"
		lightTxt  := lightning . "  Lightning Network:  em breve"
		btnTxt    := "Continuar"
		thanks    := heart . "  Valeu!"
	} else {
		title     := rocket . "  Support the project"
		intro     := "Hey! Thanks for using TibiaMacros."
		body1     := "This project is now Open Source! After years of development, I've decided to share the code with the community for free."
		body2     := "If this tool is saving you time or helping you progress, consider supporting my journey as a developer. Any 'coffee donation' helps."
		stripeTxt := coffee . "  Buy me a coffee (Stripe)"
		lightTxt  := lightning . "  Lightning Network:  coming soon"
		btnTxt    := "Continue"
		thanks    := heart . "  Thanks!"
	}

	Gui, Donate:New, +LabelDonate_ +AlwaysOnTop +OwnDialogs -MinimizeBox -MaximizeBox
	Gui, Donate:Color, 390202
	Gui, Donate:Margin, 20, 15

	Gui, Donate:Font, s14 cWhite Bold, Segoe UI Emoji
	Gui, Donate:Add, Text, w480 Center, %title%

	Gui, Donate:Font, s10 Norm, Segoe UI Emoji
	Gui, Donate:Add, Text, w480 y+15, %intro%
	Gui, Donate:Add, Text, w480 y+10, %body1%
	Gui, Donate:Add, Text, w480 y+10, %body2%

	Gui, Donate:Font, s11 Bold, Segoe UI Emoji
	Gui, Donate:Add, Link, w480 y+20 Center, <a href="https://donate.stripe.com/4gw28Vam6a5n1UY8wD">%stripeTxt%</a>

	Gui, Donate:Font, s10 Norm cSilver, Segoe UI Emoji
	Gui, Donate:Add, Text, w480 y+8 Center, %lightTxt%

	Gui, Donate:Font, s9 Italic cWhite, Segoe UI Emoji
	Gui, Donate:Add, Text, w480 y+20 Center, %thanks%

	Gui, Donate:Font, s10 Norm, Segoe UI Emoji
	Gui, Donate:Add, Button, w120 xp+180 y+15 gDonate_Continue Default, %btnTxt%

	Gui, Donate:+LastFound
	donateHwnd := WinExist()
	Gui, Donate:Show,, Support the project
	WinWaitClose, ahk_id %donateHwnd%
}

Donate_Continue:
Donate_Close:
Donate_Escape:
	Gui, Donate:Destroy
Return

; LIBS ==================================================================================
#Include libs\GDIP.ahk
#Include libs\Download_File_Progress.ahk
#Include libs\PrintScreen.ahk

; GUI ====================================================================================
WM_LBUTTONDOWN() {
	PostMessage, 0xA1, 2,,, A
}

MouseHover() {
	Global _IdVocation, _IdTibiaServer, _IdScreenCapture, _IdGlobalLanguage
	MouseGetPos, , , , CurrControl  ,2
	If (CurrControl=_IdVocation)   {
		ToolTip, [BR] Escolha a vocacao do seu personagem. `n[EN] Choose your vocation character.
		Return
	}
	If (CurrControl=_IdTibiaServer)   {
		ToolTip, [BR] escolha a versao do servidor. `n[EN] Choose the server version.
		Return
	}
	If (CurrControl=_IdScreenCapture)   {
		ToolTip, % "[BR] PrintPW e PrintDC tem performance equivalente. `nDependendo da placa de video ou cliente, uma pode deixar a tela piscando ou nao funcionar. `nSe houver algum problema, troque entre PrintPW e PrintDC. `n[EN] PrintPW and PrintDC have equivalent performance. Swap between them if one doesn't work on your setup."
		Return
	}
	if (CurrControl=_IdGlobalLanguage) {
		ToolTip, % "[BR] Escolha sua lingua. `n[EN] Choose your language."
		Return
	}
	ToolTip
}

Draw_Gui_Login() {
	Global
	Menu, Tray, Tip, TibiaMacros
	Menu, Tray, Add, Reload, Reload
	Menu, Tray, Add, Exit, Exit
	Menu, Tray, NoStandard

	Gui, LoginScreen:New
	Gui, LoginScreen:+LabelLoginScreen_On ;label LoginScreen_OnClose

	GUIWidth := 261, GUIHeight := 200

	Gui, Color, 390202
	Gui, Font, cWhite
	Gui, Margin, 10, 10

	Gui, Add, Text, x195 y5 w80 h15, Version: %VersionMacro%

	;[Vocation]
	Gui, Add, Text, x22 y40 w80 h20 Right, Vocation:
	Gui, Add, DropDownList, x105 y37 w100 h15 r4 vVocation Choose1 Hwnd_IdVocation, Knight|Paladin|Druid|Sorcerer

	;[TibiaServer]
	Gui, Add, Text, x22 y75 w80 h15 Right, TibiaServer:
	Gui, Add, DropDownList, x105 y72 w100 h15 r5 vTibiaServer Choose1 Hwnd_IdTibiaServer, OtServer|NTSW|v7.4|PvP Only

	;[Screen Capture]
	Gui, Add, Text, x22 y107 w80 h15 Right, Screen Capture:
	Gui, Add, DropDownList, x105 y104 w100 h15 r2 vscreen_capture_mode Choose1 Hwnd_IdScreenCapture, PrintPW|PrintDC

	;[Language]
	Gui, Add, Text, x22 y139 w80 h15 Right, Language:
	Gui, Add, DropDownList, x105 y136 w100 h15 vGlobalLanguage r2 Choose2 Hwnd_IdGlobalLanguage, English|Portugues

	;[Start Button]
	Gui, Add, Button, x105 y170 w100 h20 gLogin, Start

	; ======================= [ CONFIGS ] ===========================
	IniRead, Vocation,              conf\Login.ini, Login, Vocation
	IniRead, TibiaServer,           conf\Login.ini, Login, TibiaServer
	IniRead, screen_capture_mode,   conf\Login.ini, Login, screen_capture_mode
	IniRead, GlobalLanguage,        conf\Login.ini, Login, GlobalLanguage

	GuiControl, ChooseString, Vocation, %Vocation%
	GuiControl, ChooseString, TibiaServer, %TibiaServer%
	GuiControl, ChooseString, screen_capture_mode, %screen_capture_mode%
	GuiControl, ChooseString, GlobalLanguage, %GlobalLanguage%
}

Load_Picture_GUI() {
	GLOBAL
	Picture := []
}

; LABEL ====================================================================================
Login:
	ToolTip, Please Wait...,,, 2
	SaveINIConfig()
	RunSelectedVersion()
	ToolTip,,,, 2
RETURN

Reload:
Exit:
EXITAPP

; Functions ==================================================================
SaveINIConfig() {
	GLOBAL

	GuiControlGet, Vocation
	GuiControlGet, TibiaServer
	GuiControlGet, screen_capture_mode
	GuiControlGet, GlobalLanguage

	confDir := A_ScriptDir . "\conf"
	if not FileExist(confDir)
		FileCreateDir, %confDir%

	IniWrite, %Vocation%,             %confDir%\Login.ini, Login, Vocation
	IniWrite, %TibiaServer%,          %confDir%\Login.ini, Login, TibiaServer
	IniWrite, %screen_capture_mode%,  %confDir%\Login.ini, Login, screen_capture_mode
	IniWrite, %GlobalLanguage%,       %confDir%\Login.ini, Login, GlobalLanguage
}

RunSelectedVersion() {
	global
	GuiControlGet, TibiaServer

	versionDir := A_ScriptDir . "\versions\" . TibiaServer
	if (TibiaServer = "NTSW") {
		scriptPath := versionDir . "\NTSW.ahk"
	} else {
		scriptPath := versionDir . "\main.ahk"
	}

	if not FileExist(scriptPath) {
		MsgBox, % "[ERROR] Script not found: " scriptPath
		return
	}

	if A_IsCompiled {
		Run, "%scriptPath%", %versionDir%
	} else {
		Run, "%A_AhkPath%" "%scriptPath%", %versionDir%
	}
	ExitApp
}

LoginScreen_OnClose:
EXITAPP
