TrashOnMouse:
    Gui, Main:Default
	ToolTip, Trashando...,,, 3
	MouseGetPos, StartX, StartY
	GuiControlGet, Trash1
	if (Trash1 == 1) {
		GuiControlGet, Trash1X
		GuiControlGet, Trash1Y

		if (TibiaServer != "OtServer" && TibiaServer != "Global") {
			SendMode, Event
			BlockInput, ON
			Send, {Shift Down}
				GuiControlGet, Delay_PvP
			MouseClickDrag, Left, %Trash1X%, %Trash1Y%, %StartX%, %StartY%, % Delay_PvP
				Sleep 75
			BlockInput, OFF
		} else {
			ControlClick, x%Trash1X% y%Trash1Y%, ahk_id %active_id%,,,, D
			Send, {Shift Down}
			ControlClick, x%StartX% y%StartY%, ahk_id %active_id%,,,, U
		}
		Send, {Shift Up}
	}
	if (TibiaServer != "7.4" or TibiaServer != "8.6") {	;delay pro taleon
		Sleep 135
	}
	GuiControlGet, Trash2
	if (Trash2 == 1) {
		GuiControlGet, Trash2X
		GuiControlGet, Trash2Y
		if (TibiaServer != "OtServer" && TibiaServer != "Global") {
			SendMode, Event
			BlockInput, ON
			Send, {Shift Down}
				GuiControlGet, Delay_PvP
			MouseClickDrag, Left, %Trash2X%, %Trash2Y%, %StartX%, %StartY%, % Delay_PvP
				Sleep 75
			BlockInput, OFF
		} else {
			ControlClick, x%Trash2X% y%Trash2Y%, ahk_id %active_id%,,,, D
			Send, {Shift Down}
			ControlClick, x%StartX% y%StartY%, ahk_id %active_id%,,,, U
		}
		Send, {Shift Up}
	}
	ToolTip,,,, 3
return

SelectCoordinatesTrash1:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Main:Default
	MsgBox, 64, Select Coordinates, [PT-BR] Clique com o botao ESQUERDO do mouse no Trash1 para capturar coordenadas. `n`n[EN] LEFT-click on the Trash1 to get coordinates.
	Get_Coordinates_Script("Trash1X","Trash1Y")
	Hide_All_GUI()	;HIDE ALL GUI
return

SelectCoordinatesTrash2:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Main:Default
	MsgBox, 64, Select Coordinates, [PT-BR] Clique com o botao ESQUERDO do mouse no Trash2 para capturar coordenadas. `n`n[EN] LEFT-click on the Trash2 to get coordinates.
	Get_Coordinates_Script("Trash2X","Trash2Y")
	Hide_All_GUI()	;HIDE ALL GUI
return