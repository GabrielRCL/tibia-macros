fix_Hotkey_to_ControlSend(hotkeyGB, ByRef HotkeyControlSend:="") {
	HotkeyControlSend := RegExReplace(hotkeyGB, "([!+^]*)(.+)", "$1{$2}")
	return HotkeyControlSend
}


Press_Key(Key, Tab:=""){
    GLOBAL
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

ToolTip(Text,Time:=-500,X:="",Y:="",WhichToolTip:=20){
    GLOBAL
	;[WhichToolTip Map]
	;1 = drop flask warning	; 	2 = Party List 	;	3 = AutoCombo			;	 4 = Exercise Training	;	6 = interrogation GUI	;
	;7 = swap sqm warning	;	10 = CaveBot	;	18 = waiting goto hunt	; 	20 = change gold	; 15 = RemapKeys 8.6

	if (WinActive("ahk_id " active_id) or WinActive("ahk_exe explorer.exe")) {
		GuiControlGet, CheckBox_ShowToolTip, Extras:
		CheckBox_ShowToolTip := true
		if (List_State_ToolTip[WhichToolTip] != 1 && CheckBox_ShowToolTip) {
			Tooltip, %Text%, %X%, %Y%, %WhichToolTip%
			SetTimer, RemoveToolTip%WhichToolTip%, %Time%
			List_State_ToolTip[WhichToolTip] := 1
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


Hide_All_GUI(state:="",winactive_tibia:=true) {
	GLOBAL
	if (Status_Gui_Hide != TRUE or state = "Hide") {
		ToolTip("Hide")
		Gui, Main:HIDE
		Status_Gui_Hide := TRUE
	} else if (Status_Gui_Hide == TRUE or state = "Show") {
		Status_Gui_Hide := FALSE
		ToolTip("Show")
		Gui, Main:Show, NoActivate
	}

	;~ if (winactive_tibia == true) {
		;~ WinActivate, ahk_id %active_id%	;fix bug on win7
	;~ }
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

RemoveToolTip:
	ToolTip
	ToolTip,,,, 2
	SetTimer, RemoveToolTip, OFF
RETURN