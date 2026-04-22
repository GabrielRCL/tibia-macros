Draw_Gui_Looter() {
    GLOBAL
	Load_Pre_Settings("Looter")

 	; [Looter] Tab ====================================================================
		;[Geral]
		Gui, Add, CheckBox, x30 y40 w70 h20 vLooter, Looter
	Gui, Font, Bold
		Gui, Add, GroupBox, x10 y70 w100 h135 +Center, Key to Active
		Gui, Add, Text, x25 y90 w70 h20 +Center, KeyBoard:
		Gui, Add, Text, x18 y155 w85 h20 +Center, Mouse/Others:
		Gui, Add, GroupBox, x10 y215 w100 h115 +Center, Looter Type
		Gui, Add, Text, x25 y284 w70 h20 +Center vText_Hotkey, Hotkey:
		Gui, Add, Text, x13 y335 w90 h40 +Center, RECOMENDED = Shift+Right	;RECOMENDAÇÃO
	GuiControl, Hide, Text_Hotkey
	Gui, Font, Normal
		Gui, Add, Hotkey, x25 y108 w70 h20 vHotkey_Looter, ;%Hotkey_Looter%
		Gui, Add, Text, x50 y135 w15 h15, or
		Gui, Add, DropDownList, x18 y172 w85 h20 +Center vLooterMouseButton r5, None|XButton1|XButton2|WheelUp|WheelDown
		Gui, Add, Radio, x18 y235 w85 h20 Checked vLooter_Type_Coordinates gLooter_Type_GuiControl, Coordinates
		Gui, Add, Radio, x18 y255 w85 h20 vLooter_Type_Hotkey gLooter_Type_GuiControl, Hotkey
		Gui, Add, DropDownList, x18 y290 w85 h20 vLooter_Type_Coordinates_Preset r3, Right|Shift+Right||Left|
		Gui, Add, Hotkey, x25 y300 w70 h20 vLooter_Type_Hotkey_Hotkey, ;%Looter_Type_Hotkey_Hotkey%
	GuiControl, Hide, Looter_Type_Hotkey_Hotkey

		;[Delay]
	Gui, Font, Bold
		Gui, Add, GroupBox, x480 y345 w90 h65 +Center, Delay to Looting
	Gui, Font, Normal
		Gui, Add, Text, x546 y367 w20 h20, ms
		Gui, Add, Text, x490 y387 w75 h20, Default = 27ms
		;Gui, Add, Text, x485 y402 w90 h15, 1000ms = 1second
	Gui, Font, cRed
		Gui, Add, Edit, x495 y362 w50 h20 +Right vDelay_Looter Number Limit3, ;%Delay_Looter%
	Gui, Font, cWhite

	;[Looter]
		Gui, Add, Picture, x115 y35 w350 h350 ,  % "HBITMAP:* " Picture.LooterPic
		Gui, Add, Text, x137 y66 w20 h16 , X=
		Gui, Add, Text, x137 y86 w20 h16 , Y=
		Gui, Add, Button, x130 y106 w86 h30 gSelectCoordinatesLooterSQM1 vButton_SelectCoordSQM1, Select Coordinates
	Gui, Font, cRed
		Gui, Add, Edit, x157 y64 w50 h20 vLooterSQM_1X +Center Number, ;%LooterSQM_1X%
		Gui, Add, Edit, x157 y84 w50 h20 vLooterSQM_1Y +Center Number, ;%LooterSQM_1Y%
	Gui, Font, cWhite
		Gui, Add, Text, x257 y69 w20 h16 , X=
		Gui, Add, Text, x257 y99 w20 h16 , Y=
	Gui, Font, cRed
		Gui, Add, Edit, x277 y67 w50 h20 vLooterSQM_2X +Center Number, ;%LooterSQM_2X%
		Gui, Add, Edit, x277 y97 w50 h20 vLooterSQM_2Y +Center Number, ;%LooterSQM_2Y%
	Gui, Font, cWhite
		Gui, Add, Text, x377 y69 w20 h16 , X=
		Gui, Add, Text, x377 y99 w20 h16 , Y=
	Gui, Font, cRed
		Gui, Add, Edit, x397 y67 w50 h20 vLooterSQM_3X +Center Number, ;%LooterSQM_3X%
		Gui, Add, Edit, x397 y97 w50 h20 vLooterSQM_3Y +Center Number, ;%LooterSQM_3Y%
	Gui, Font, cWhite
		Gui, Add, Text, x377 y189 w20 h16 , X=
		Gui, Add, Text, x377 y219 w20 h16 , Y=
	Gui, Font, cRed
		Gui, Add, Edit, x397 y187 w50 h20 vLooterSQM_4X +Center Number, ;%LooterSQM_4X%
		Gui, Add, Edit, x397 y217 w50 h20 vLooterSQM_4Y +Center Number, ;%LooterSQM_4Y%
	Gui, Font, cWhite
		Gui, Add, Text, x377 y299 w20 h16 , X=
		Gui, Add, Text, x377 y319 w20 h16 , Y=
		Gui, Add, Button, x370 y339 w86 h30 gSelectCoordinatesLooterSQM5 vButton_SelectCoordSQM5, Select Coordinates
	Gui, Font, cRed
		Gui, Add, Edit, x397 y297 w50 h20 vLooterSQM_5X +Center Number, ;%LooterSQM_5X%
		Gui, Add, Edit, x397 y317 w50 h20 vLooterSQM_5Y +Center Number, ;%LooterSQM_5Y%
	Gui, Font, cWhite
		Gui, Add, Text, x257 y299 w20 h16 , X=
		Gui, Add, Text, x257 y329 w20 h16 , Y=
	Gui, Font, cRed
		Gui, Add, Edit, x277 y297 w50 h20 vLooterSQM_6X +Center Number, ;%LooterSQM_6X%
		Gui, Add, Edit, x277 y327 w50 h20 vLooterSQM_6Y +Center Number, ;%LooterSQM_6Y%
	Gui, Font, cWhite
		Gui, Add, Text, x137 y299 w20 h16 , X=
		Gui, Add, Text, x137 y329 w20 h16 , Y=
	Gui, Font, cRed
		Gui, Add, Edit, x157 y297 w50 h20 vLooterSQM_7X +Center Number, ;%LooterSQM_7X%
		Gui, Add, Edit, x157 y327 w50 h20 vLooterSQM_7Y +Center Number, ;%LooterSQM_7Y%
	Gui, Font, cWhite
		Gui, Add, Text, x137 y184 w20 h16 , X=
		Gui, Add, Text, x137 y214 w20 h16 , Y=
	Gui, Font, cRed
		Gui, Add, Edit, x157 y182 w50 h20 vLooterSQM_8X +Center Number, ;%LooterSQM_8X%
		Gui, Add, Edit, x157 y212 w50 h20 vLooterSQM_8Y +Center Number, ;%LooterSQM_8Y%
	Gui, Font, cWhite
		Gui, Add, Text, x257 y184 w20 h16 , X=
		Gui, Add, Text, x257 y204 w20 h16 , Y=
		Gui, Add, Button, x250 y224 w86 h30 gSelectCoordinatesLooterSQM9 vButton_SelectCoordSQM9, Select Coordinates
	Gui, Font, cRed
		Gui, Add, Edit, x277 y182 w50 h20 vLooterSQM_9X +Center Number, ;%LooterSQM_9X%
		Gui, Add, Edit, x277 y202 w50 h20 vLooterSQM_9Y +Center Number, ;%LooterSQM_9Y%
	Gui, Font, cWhite

	;[GHOST MOUSE]
	Gui, Font, Bold
		Gui, Add, CheckBox, x15 y375 w95 h20 vLooter_Ghost_Mouse, Ghost Mouse

	;[GET COORDINATES MANUALLY]
		Gui, Add, CheckBox, x220 y10 w170 h20 vLooter_Get_Coord_Manually, Get Coordinates Manually
	Gui, Font, Normal

}
Draw_Gui_Looter:
	Gui, Looter:Show, % " w" 581 " h" 421, [Looter] %TrayName%	;NAME PROGRAMA
RETURN


Looter_Type_GuiControl:
	Gui, Looter:Default
	GuiControlGet, Looter_Type_Hotkey
	if (Looter_Type_Hotkey == 1) {
		GuiControl, Show, Looter_Type_Hotkey_Hotkey
		GuiControl, Show, Text_Hotkey
		GuiControl, Hide, Looter_Type_Coordinates_Preset
	} else {
		GuiControl, Hide, Looter_Type_Hotkey_Hotkey
		GuiControl, Hide, Text_Hotkey
		GuiControl, Show, Looter_Type_Coordinates_Preset
	}
RETURN


SelectCoordinatesLooterSQM1:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Looter:Default
	MsgBox, 64, Select Coordinates, [BR] Clique com o botao ESQUERDO do mouse no SQM para capturar as coordenadas. `n`n[EN] LEFT-click on SQM to capture coordinates.uepa
	Get_Coordinates_Looter_Script("LooterSQM_1X", "LooterSQM_8X", "LooterSQM_7X", "LooterSQM_1Y", "LooterSQM_2Y", "LooterSQM_3Y")
	Hide_All_GUI()	;HIDE ALL GUI
return

SelectCoordinatesLooterSQM5:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Looter:Default
	MsgBox, 64, Select Coordinates, [BR] Clique com o botao ESQUERDO do mouse no SQM para capturar as coordenadas. `n`n[EN] LEFT-click on SQM to capture coordinates.
	Get_Coordinates_Looter_Script("LooterSQM_3X", "LooterSQM_4X", "LooterSQM_5X", "LooterSQM_5Y", "LooterSQM_6Y", "LooterSQM_7Y")
	Hide_All_GUI()	;HIDE ALL GUI
return

SelectCoordinatesLooterSQM9:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Looter:Default
	MsgBox, 64, Select Coordinates, [BR] Clique com o botao ESQUERDO do mouse no SQM para capturar as coordenadas. `n`n[EN] LEFT-click on SQM to capture coordinates.
	Get_Coordinates_Looter_Script("LooterSQM_2X", "LooterSQM_9X", "LooterSQM_6X", "LooterSQM_4Y", "LooterSQM_9Y", "LooterSQM_8Y")
	Hide_All_GUI()	;HIDE ALL GUI
return

Get_Coordinates_Looter_Script(sqm1X, sqm2X, sqm3X, sqm1Y, sqm2Y, sqm3Y) {
    GLOBAL
    WinActivate, ahk_id %active_id%
    Loop, {
        ToolTip, Click to get coordinates...
        if ( GetKeyState("LButton") ) {
            MouseGetPos, MouseX, MouseY

            ;[LooterX1Y1]
                GuiControl,, %sqm1X%, %MouseX%
                GuiControl,, %sqm1Y%, %MouseY%
            ;[LooterX2Y2]
                GuiControl,, %sqm2X%, %MouseX%
                GuiControl,, %sqm2Y%, %MouseY%
            ;[LooterX3Y3]
                GuiControl,, %sqm3X%, %MouseX%
                GuiControl,, %sqm3Y%, %MouseY%


            ToolTip, Coordenada Configurada!
            SetTimer, RemoveToolTip, 1000
            Gui, Show
            BREAK
        }
    }

}

