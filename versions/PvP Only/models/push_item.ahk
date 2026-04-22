PushItemOnBP:
    Gui, Main:Default
	GuiControlGet, PushItem
	if (PushItem == 1) {
		GuiControlGet, PushItemX
		GuiControlGet, PushItemY
		MouseGetPos, StartX, StartY

		KeyWait, Alt
		If WinActive("ahk_id " active_id) {
			if (TibiaServer != "OtServer" && TibiaServer != "Global") {
				SendMode, Event
				BlockInput, ON
					Send, {Control Down}


					GuiControlGet, Delay_PvP
				MouseClickDrag, Left, %StartX%, %StartY%, %PushItemX%, %PushItemY%, % Delay_PvP
				MouseMove, %StartX%, %StartY%

					Sleep 150
					Send, {Control Up}
					Send, {Alt Up}
					Send, {Shift Up}

				BlockInput, OFF
			} else {
				ControlClick, x%StartX% y%StartY%, ahk_id %active_id%,,,, D
				ControlClick, x%PushItemX% y%PushItemY%, ahk_id %active_id%,,,, U
			}
		}

	}
return

SelectCoordinatesPushItem:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Main:Default
	MsgBox, 64, Select Coordinates, [PT-BR] Clique com o botao ESQUERDO do mouse na backpack para capturar coordenadas. `n`n[EN] LEFT-click on the backpack to get coordinates.
	Get_Coordinates_Script("PushItemX","PushItemY")
	Hide_All_GUI()	;HIDE ALL GUI
return