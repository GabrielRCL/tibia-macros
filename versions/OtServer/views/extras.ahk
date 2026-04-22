Draw_Gui_Extras() {
    GLOBAL
	Load_Pre_Settings("Extras")
	Gui, Add, Tab, x1 y1 w580 h420, General|Security Actions



	Gui, Tab, General
	; Pause Hotkey
    Gui, Font, Bold
	Gui, Add, GroupBox, x5 y25 h75 w220, Pause/Start Macro With Hotkey
    Gui, Font, Normal
		Gui, Add, Text, x15 y48 w40 h20, Hotkey:
		Gui, Add, Hotkey, x60 y45 w70 h20 vKeyPauseMacro, Pause
		Gui, Add, CheckBox, x15 y65 w180 h20 vPauseMacro_ChatOn_CheckBox, Pause Macro When Chat ON

	;Hide ALL GUI
    Gui, Font, Bold
	Gui, Add, GroupBox, x5 y100 h75 w220, Hide All GUI
    Gui, Font, Normal
	Gui, Add, Text, x15 y123 w40 h20, Hotkey:
	Gui, Add, Hotkey, x60 y120 w70 h20 vHide_All_Gui_Hotkey, +F12

	;Change Vocation
    Gui, Font, Bold
	Gui, Add, GroupBox, x5 y175 h75 w220, Change Vocation
    Gui, Font, Normal
	switch Vocation {
		case "Knight"	:	n := 1
		case "Paladin"	:	n := 2
		case "Druid"	:	n := 3
		case "Sorcerer" :	n := 4
	}

	Gui, Add, DropDownList, x15 y200 w65 h15 r4 vDropDownList_ChangeVocation Choose%n%, Knight|Paladin|Druid|Sorcerer
	Gui, Add, Button, x81 y198 w80 h25 gButton_ChangeVocation, Change Vocation

	;Show ToolTips
	Gui, Font, Bold
		Gui,Add, GroupBox, section x5 y255 w200 h50, ToolTip's
	Gui, Font, Normal
		Gui, Add, CheckBox, xs+10 ys+20 w95 h20 vCheckBox_ShowToolTip Checked, Show ToolTip's
		Gui, Add, Picture, xs+107 ys+23 w13 h13 Hwnd_IdShowToolTip, % "HBITMAP:* " Picture.interrogacao

	;Transparency
	Gui, Add, CheckBox, x5 y397 w90 h20 vTransparent_Tibia_Client gLabel_Transparent_Tibia_Client, Transparency


	;Debugger
	Gui, Font, Bold
	Gui, Add, Button, x510 y395 h20 w65 gDebugger, Debugger
	Gui, Font, Normal

	;A_TickCount Macro
	Gui, Add, Text, x530 y370 w40 h20 vTickCount_Macro, 0

	; HUD TEST
	Data.BarHP := New StatusBar("BarHP","x400 y370","MHHP","Extras")
	Data.BarMP := New StatusBar("BarMP","x400 y380","MHMP","Extras")

	;Delays
	if (TibiaServer == "Global") {
		Gui, Font, Bold
		Gui, Add, GroupBox, section x350 y130 h75 w220, Delay's
		Gui, Font, Normal
		Gui, Add, Text, section xs+10 ys+20 w110 h20, after press any hotkey:
		Gui, Add, Text, xs+143 ys+4 w15 h15, ms.
		Gui, Font, cRed
		Gui, Add, Edit, xs+110 ys-2 w30 h20 Number Limit3 vDelay_PressHotkey, 0
		Gui, Font, cWhite
		Portugues := "Usar Mouse Fantasma"
		English := "Use Ghost Mouse"
		Gui, Add, CheckBox, xs+10 ys+20 w140 h20 vCheckBox_State_GhostMouse, % %GlobalLanguage%
	}
	if (true) {
		Gui, Font, Bold
			Gui, Add, GroupBox, section x350 y25 h100 w220, Delay's
		Gui, Font, Normal

		Gui, Add, CheckBox, section xs+10 ys+20 w110 h20 gLabel_NoDelayActions vCheckBox_NoDelayActions, No Delay in Action

		Gui, Add, Text, xs+135 ys-5, PING:
		Gui, Add, Text, xs+190 ys-5, ms.

		Gui, Font, cRed
			Gui, Add, Edit, xs+165 ys-6 w25 h15 Number Limit3 vDelay_Ping, 0
		Gui, Font, cWhite

		Gui, Font, Bold
			Portugues := "OBS: Hotkeys com Ctrl,Shift ou Alt nao irao funcionar se essa funcao estiver habilitada"
			English := "NOTE: Hotkeys with Ctrl, Shift or Alt will not work if this function is enabled"
			Gui, Add, Text, section xs ys+30 w200 h40, % %GlobalLanguage%
		Gui, Font, Normal
	}





	Gui, Tab, Security Actions
		; Pause Hotkey
    Gui, Font, Bold
	Portugues := "Forcar Acao do Macro Quando:"
	English := "Force Macro Action When:"
	Gui, Add, GroupBox, section x5 y25 h100 w220, % %GlobalLanguage%
    Gui, Font, Normal
	Gui, Add, Text, xs+10 ys+23 w35 h20, HP`% =
	Gui, Add, Text, xs+10 ys+48 w35 h20, MP`% =
    Gui, Font, cRed
	Gui, Add, Edit, xs+45 ys+20 w20 h20 Number Limit2 vForce_HP_Percent, 10
	Gui, Add, Edit, xs+45 ys+45 w20 h20 Number Limit2 vForce_MP_Percent, 10
    Gui, Font, cWhite
	Gui, Add, Text, xs+65 ys+23 w15 h20, `%
	Gui, Add, Text, xs+65 ys+48 w15 h20, `%

	Gui, Add, CheckBox, x5 y397 w120 h20 vDisable_PrintScreen, Disable PrintScreen

}
Draw_Gui_Extras:
	Gui, Extras:Show, % " w" 581 " h" 421, [Extras] %TrayName%	;NAME PROGRAMA
RETURN


Destroy_All_GUIs() {
    GLOBAL
	Gui, Main:Destroy

	Gui, Healing:Destroy
	Gui, HealFriend:Destroy
	Gui, Combo:Destroy
	Gui, Timer:Destroy

	Gui, TankMode:Destroy
	Gui, Support:Destroy
	Gui, PvP:Destroy
	Gui, Looter:Destroy

	Gui, RemapKeys:Destroy
	Gui, CaveBot:Destroy
	Gui, Extras:Destroy
}