Create_Gui_Settings(NameChange) {
    GLOBAL
	Gui, Main:Hide
	Gui, %NameChange%_Settings:New
	Gui, %NameChange%_Settings:+Label%NameChange%_Settings_On
	Gui, Color, 390202
	Gui, +AlwaysOnTop

	Gui, Font, cWhite
	Gui, Font, BOLD ;Negrito
	Gui, Add, Text,x15, ===== [%NameChange% Settings] =====

	Gui, Font,
	Gui, Font, cWhite
	Gui, Add, Text,x25 y28 w100 h20 +Right, %NameChange%_PosX1 =
	Gui, Font, cRed
	Gui, Add, Edit,x130 y25 w40 h20 v%NameChange%_PosX1, % %NameChange%_PosX1

	Gui, Font, cWhite
	Gui, Add, Text,x25 y53 w100 h20 +Right, %NameChange%_PosY1 =
	Gui, Font, cRed
	Gui, Add, Edit,x130 y50 w40 h20 v%NameChange%_PosY1, % %NameChange%_PosY1

	Gui, Font, cWhite
	Gui, Add, Text,x25 y78 w100 h20 +Right, %NameChange%_PosX2 =
	Gui, Font, cRed
	Gui, Add, Edit,x130 y75 w40 h20 v%NameChange%_PosX2, % %NameChange%_PosX2

	Gui, Font, cWhite
	Gui, Add, Text,x25 y103 w100 h20 +Right, %NameChange%_PosY2 =
	Gui, Font, cRed
	Gui, Add, Edit,x130 y100 w40 h20 v%NameChange%_PosY2, % %NameChange%_PosY2

	Gui, Font, cWhite
	Gui, Add, Text,x25 y128 w105 h20 +Right,%NameChange%_variation =
	Gui, Font, cRed
	Gui, Add, Edit,x135 y125 w30 h20 v%NameChange%_variation, % %NameChange%_variation

	Gui, Add, Button,x13 y170 w90 h20 g%NameChange%_Settings_GetCoord, Get Coordinates
	Gui, Add, Button,x13 y192 w90 h20 g%NameChange%_Settings_GetNewImage, Get New Image
	Gui, Font, cWhite
	Gui, Add, CheckBox,x120 y180 w80 h22 v%NameChange%_Settings_Default g%NameChange%_Settings_Default, Set Default
	GuiControl,, %NameChange%_Settings_Default, % %NameChange%_Settings_Default	;mark checkbox

	if (%NameChange%_Settings_Default == 1) {
		Gui_Settings_SetDefault(NameChange)	;%NameChange%_Settings_Default()
	}

	Gui, Show, AutoSize Center, %TrayName%
}

Gui_Settings_OnClose(NameChange) {
    GLOBAL
	Gui, %NameChange%_Settings:Default
	GuiControlGet, %NameChange%_PosX1
	IniWrite, % %NameChange%_PosX1, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_PosX1
	GuiControlGet, %NameChange%_PosY1
	IniWrite, % %NameChange%_PosY1, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_PosY1
	GuiControlGet, %NameChange%_PosX2
	IniWrite, % %NameChange%_PosX2, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_PosX2
	GuiControlGet, %NameChange%_PosY2
	IniWrite, % %NameChange%_PosY2, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_PosY2
	GuiControlGet, %NameChange%_variation
	IniWrite, % %NameChange%_variation, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_variation
	GuiControlGet, %NameChange%_Settings_Default
	IniWrite, % %NameChange%_Settings_Default, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_Settings_Default
	Gui, %NameChange%_Settings:Destroy
	Gui, Main:Show
}

Gui_Settings_ButtonSetDefault(NameChange) {
    GLOBAL
	Gui, %NameChange%_Settings:Default
	GuiControlGet, %NameChange%_Settings_Default
	if (%NameChange%_Settings_Default == 0) {
		GuiControl,Enable,%NameChange%_PosX1
		GuiControl,Enable,%NameChange%_PosY1
		GuiControl,Enable,%NameChange%_PosX2
		GuiControl,Enable,%NameChange%_PosY2
		GuiControl,Enable,%NameChange%_variation
	} else {
		Gui_Settings_SetDefault(NameChange)
	}

}

Gui_Settings_SetDefault(NameChange) {
    GLOBAL
	Gui, %NameChange%_Settings:Default

	%NameChange%_PosX1 := Round(A_ScreenWidth/2) ;Round( (A_ScreenWidth/(A_ScreenDPI/96))-300 )
	GuiControl,, %NameChange%_PosX1, % %NameChange%_PosX1
	GuiControl,Disable, %NameChange%_PosX1

	%NameChange%_PosY1 := 0
	GuiControl,, %NameChange%_PosY1, % %NameChange%_PosY1
	GuiControl,Disable, %NameChange%_PosY1

	%NameChange%_PosX2 := 0
	GuiControl,, %NameChange%_PosX2, % %NameChange%_PosX2
	GuiControl,Disable,%NameChange%_PosX2

	%NameChange%_PosY2 := Round(A_ScreenHeight/2)
	GuiControl,, %NameChange%_PosY2, % %NameChange%_PosY2
	GuiControl,Disable,%NameChange%_PosY2

	%NameChange%_variation := 55
	GuiControl,, %NameChange%_variation, % %NameChange%_variation
	GuiControl,Disable,%NameChange%_variation

	%NameChange%_Settings_Default := 1
	GuiControl,, %NameChange%_Settings_Default, % %NameChange%_Settings_Default	;mark checkbox

	IniWrite, % %NameChange%_PosX1, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_PosX1
	IniWrite, % %NameChange%_PosY1, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_PosY1
	IniWrite, % %NameChange%_PosX2, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_PosX2
	IniWrite, % %NameChange%_PosY2, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_PosY2
	IniWrite, % %NameChange%_variation, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_variation
	IniWrite, % %NameChange%_Settings_Default, Configs\%Vocation%\%NameChange%.ini, Settings, %NameChange%_Settings_Default
}

Gui_Settings_ButtonGetCoord(NameChange) {
    GLOBAL
	Minimize_All_AutoHotkeyGUI()
	Gui, %NameChange%_Settings:Default
	Gui, -AlwaysOnTop
	MsgBox,4,WARNING, [BR] CUIDADO! as configurações a seguir são importantes para o bom funcionamento do macro. SÓ CONFIGURE SE SOUBER O QUE ESTÁ FAZENDO. `nDeseja Continuar? `n`n`n[EN] CAUTION! the following settings are important for the proper functioning of the macro. ONLY CONFIGURE IF YOU KNOW WHAT YOU'RE DOING. `nDo you want to continue?
		IfMsgBox No
		RETURN
	SetTimer, area, 0
	Hotkey, LButton, GetCoord, On
	WinActivate, ahk_id %active_id%
}

Minimize_All_AutoHotkeyGUI() {
	Loop, 9 {
		WinMinimize, ahk_class AutoHotkeyGUI
	}
}