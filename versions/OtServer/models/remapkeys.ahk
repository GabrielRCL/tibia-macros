Label_AndarComWASD:
	if (TibiaServer = "8.6") {
		GuiControlGet, CheckBox_AndarComWASD, RemapKeys:
		if (CheckBox_AndarComWASD == 1 && State_Andar_Com_WASD != true) {
			GuiControlGet, Hotkey_OriginKey_RemapKeys, RemapKeys:
			Check_New_Hotkey_Script(GuiControl:="Hotkey_OriginKey_RemapKeys", Label:="Label_CustomRemapKeys")


			Tooltip, [RemapKeys: ENABLE], 0, WindowInfo.Window.h, 15
			State_Andar_Com_WASD := true
		} else {
			Tooltip,,,, 15
			State_Andar_Com_WASD := false
		}



		#if State_Andar_Com_WASD == true && WinActive("ahk_group Tibia")
		q::NumpadHome			; Diagonal Esquerda Cima
		w::Up					; Cima
		e::NumpadPgUp			; Diagonal Direita Cima
		a::Left					; Esquerda
		s::Down					; Baixo
		d::Right				; Direita
		z::NumpadEnd			; Diagonal Esquerda Baixo
		c::NumpadPgDn			; Diagonal Direita Baixo

		#if State_Andar_Com_WASD == false && WinActive("ahk_group Tibia")
		~q::return			; Default Key
		~w::return			; Default Key
		~e::return			; Default Key
		~a::return			; Default Key
		~s::return			; Default Key
		~d::return			; Default Key
		~z::return			; Default Key
		~c::return			; Default Key


	}
RETURN

Label_CustomRemapKeys:
	GuiControlGet, Hotkey_DestinationKey_RemapKeys, RemapKeys:
	fix_Hotkey_to_ControlSend(Hotkey_DestinationKey_RemapKeys, Hotkey_DestinationKey_RemapKeys)
	Send, %Hotkey_DestinationKey_RemapKeys%
RETURN

WheelUp_RemapKeys:
Gui, RemapKeys:Default
Sleep 50
	Send, {%DestinationKey_WheelUp_RemapKeys%}
	GuiControlGet, WheelUp_RemapKeys_Click
	if (WheelUp_RemapKeys_Click == 1) {
		Sleep 50
		Click
	}
RETURN

WheelDown_RemapKeys:
Gui, RemapKeys:Default
Sleep 50
	Send, {%DestinationKey_WheelDown_RemapKeys%}
	GuiControlGet, WheelDown_RemapKeys_Click
	if (WheelDown_RemapKeys_Click == 1) {
		Sleep 50
		Click
	}
RETURN

BrowserBack_RemapKeys:
Gui, RemapKeys:Default
Sleep 50
	Send, {%DestinationKey_BrowserBack_RemapKeys%}
	GuiControlGet, BrowserBack_RemapKeys_Click
	if (BrowserBack_RemapKeys_Click == 1) {
		Sleep 50
		Click
	}
RETURN

BrowserForward_RemapKeys:
Gui, RemapKeys:Default
Sleep 50
	Send, {%DestinationKey_BrowserForward_RemapKeys%}
	GuiControlGet, BrowserForward_RemapKeys_Click
	if (BrowserForward_RemapKeys_Click == 1) {
		Sleep 50
		Click
	}
RETURN
