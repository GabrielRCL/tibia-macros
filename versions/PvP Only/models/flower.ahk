FlowerOnMouse:
    Gui, Main:Default
	GuiControlGet, Flower
	if (Flower == 1) {

		MouseGetPos, StartX, StartY
		GuiControlGet, FlowerX
		GuiControlGet, FlowerY
		Send, {Shift Down}

		if (TibiaServer != "OtServer" && TibiaServer != "Global") {
			SendMode, Event
			BlockInput, ON
			Send, {Shift Down}
				GuiControlGet, Delay_PvP
			MouseClickDrag, Left, %FlowerX% , %FlowerY%, %StartX%, %StartY%, % Delay_PvP
				Sleep 150
			BlockInput, OFF
		} else {
			ControlClick, x%FlowerX% y%FlowerY%, ahk_id %active_id%,,,, D
			ControlClick, x%StartX% y%StartY%, ahk_id %active_id%,,,, U
		}
		Send, {Shift Up}
	}
return

SelectCoordinatesFlower:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Main:Default
	MsgBox, 64, Select Coordinates, [PT-BR] Clique com o botao ESQUERDO do mouse na Flower para capturar coordenadas. `n`n[EN] LEFT-click on the Flower to get coordinates.
	Get_Coordinates_Script("FlowerX","FlowerY")
	Hide_All_GUI(state:="show")	;HIDE ALL GUI
return