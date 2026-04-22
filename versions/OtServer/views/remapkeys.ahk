Draw_Gui_RemapKeys() {
    GLOBAL

	Load_Pre_Settings("RemapKeys")
	Gui, Add, Tab, x1 y1 w581 h420, Mouse|Teclado

	; [ Mouse ]
	Gui, Tab, Mouse
	Gui, Add, GroupBox, x12 y29 w270 h280, Mouse
		Gui, Add, Picture, x32 y49 w30 h40 ,  % "HBITMAP:* " Picture.WheelUp
		Gui, Add, Text, x67 y59 w70 h20 +Center, Scroll Up =
		Gui, Add, Hotkey, x142 y59 w60 h20 vDestinationKey_WheelUp_RemapKeys, ;%DestinationKey_WheelUp_RemapKeys%
		Gui, Add, Text, x210 y59 w10 h10, +
		Gui, Add, CheckBox, x222 y58 w50 h20 vWheelUp_RemapKeys_Click, Click

		Gui, Add, Picture, x32 y99 w30 h40 , % "HBITMAP:* " Picture.WheelDown
		Gui, Add, Text, x67 y109 w70 h20 +Center, Scroll Down =
		Gui, Add, Hotkey, x142 y109 w60 h20 vDestinationKey_WheelDown_RemapKeys, ;%DestinationKey_WheelDown_RemapKeys%
		Gui, Add, Text, x210 y109 w10 h10, +
		Gui, Add, CheckBox, x222 y108 w50 h20 vWheelDown_RemapKeys_Click, Click

		Gui, Add, Picture, x32 y169 w212 h69 , % "HBITMAP:* " Picture.MouseLado
		Gui, Add, Hotkey, x32 y239 w60 h20 vDestinationKey_BrowserForward_RemapKeys, ;%DestinationKey_BrowserForward_RemapKeys%	;XButton1 4th mouse button. Typically performs the same function as Browser_Back.
		Gui, Add, Text, x35 y261 w10 h10, +
		Gui, Add, CheckBox, x45 y259 w50 h20 vBrowserForward_RemapKeys_Click, Click

		Gui, Add, Hotkey, x192 y239 w60 h20 vDestinationKey_BrowserBack_RemapKeys, ;%DestinationKey_BrowserBack_RemapKeys%		;XButton2 5th mouse button. Typically performs the same function as Browser_Forward.
		Gui, Add, Text, x195 y261 w10 h10, +
		Gui, Add, CheckBox, x205 y259 w50 h20 vBrowserBack_RemapKeys_Click, Click

	; [ Teclado ]
	if (TibiaServer = "8.6") {
		Gui, Tab, Teclado

		;ANDAR COM WASD
		Gui, Add, CheckBox, section x25 y35 w170 h20 Checked vCheckBox_AndarComWASD, Andar com WASD (8.6)
		Gui, Font, Bold
		Gui, Add, Text, xs-15 ys+22 w85 h20, Key To Active:
		Gui, Font, Norm
		Gui, Add, Hotkey, xs+75 ys+20 w70 h20 vKeyToActive_AndarComWASD, ^Enter


		;RemapKeys Custom
		Gui, Add, Hotkey, section x10 y120 w25 h20 vHotkey_OriginKey_RemapKeys
		Gui, Add, Text, xs+27 ys+2 w15 h20, =>
		Gui, Add, Hotkey, xs+41 ys w25 h20 vHotkey_DestinationKey_RemapKeys
	}


}
Draw_Gui_RemapKeys:
	Gui, RemapKeys:Show, % " w" 581 " h" 421, [RemapKeys] %TrayName%	;NAME PROGRAMA
RETURN