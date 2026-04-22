Renew_Growth_Function() {
GLOBAL

	;~ StartTime_Growth := A_TickCount

	Renew_Growth_Stop_Combo := false
	i := 0
	Loop, 4 {
		i++
		Gui, Gui_CaveBot:Default
		GuiControlGet, Enable_Renew_Growth%i%_CheckBox
		if (Enable_Renew_Growth%i%_CheckBox) {
			GuiControlGet, Renew_Growth%i%_Hotkey
			GuiControlGet, Renew_Growth%i%_X1
			GuiControlGet, Renew_Growth%i%_Y1
			GuiControlGet, Renew_Growth%i%_X2
			GuiControlGet, Renew_Growth%i%_Y2
			Renew_Growth_Click_X := (Renew_Growth%i%_X1 + Renew_Growth%i%_X2)/2
			Renew_Growth_Click_Y := (Renew_Growth%i%_Y1 + Renew_Growth%i%_Y2)/2
			Renew_Growth%i%_X2 -= Renew_Growth%i%_X1	;fix coordinates to use in pixel search addapted
			Renew_Growth%i%_Y2 -= Renew_Growth%i%_Y1	;fix coordinates to use in pixel search addapted
			if (PixelSearch(Renew_Growth%i%_X1,Renew_Growth%i%_Y1,Renew_Growth%i%_X2,Renew_Growth%i%_Y2, "5B3B23",0, "growthX","growthY") != 0) {	;não encontrou
				Renew_Growth_Stop_Combo := true	;para o combo para usar Growth

				if (Data.Group["Attack"] == 0) {
					;~ if (WinActive("ahk_id " active_id)) {
						;~ BlockInput, ON
					;~ }

					Press_Key("Renew_Growth" i "_Hotkey")

					Sleep 50

					CoordMode, Mouse, Client
					ControlClick(Renew_Growth_Click_X,Renew_Growth_Click_Y,WhichButton:="LEFT",fix_coordinates:=true,ghost_mouse:=true,state:="",zKeyWait:=true)
					CoordMode, Mouse, Window

					;~ BlockInput, OFF
				}
			}
		}
	}

	;~ TOOLTIP,% ElapsedTime_Growth := A_TickCount - StartTime_Growth
}

Renew_Growth1_GetArea:
Renew_Growth2_GetArea:
Renew_Growth3_GetArea:
Renew_Growth4_GetArea:
GetArea_Script("Gui_CaveBot", "Renew_Growth" SubStr(A_ThisLabel, -8, 1) "_X1","Renew_Growth" SubStr(A_ThisLabel, -8, 1) "_Y1","Renew_Growth" SubStr(A_ThisLabel, -8, 1) "_X2","Renew_Growth" SubStr(A_ThisLabel, -8, 1) "_Y2")
RETURN

GetArea_Script(GuiTab, GuiControlX1,GuiControlY1,GuiControlX2,GuiControlY2) {	;
GLOBAL
	Hide_All_GUI()	;HIDE ALL GUI

	;CREATE GUI RED
	Gui, GetArea:New
	Gui, GetArea:-Caption +Border +AlwaysOnTop +LastFound
	Gui, GetArea:Color, RED
	WinSet, Transparent, 80

	Loop, {
		ToolTip, Selecione uma área
		if (GetKeyState("LButton", "P")) {
			;Select x1, y1 (Pixel Search)
			CoordMode, Mouse, Client
			MouseGetPos, x1, y1
			x1 := Round( x1/(A_ScreenDPI/96) )
			y1 := Round( y1/(A_ScreenDPI/96) )
			x2:=""
			y2:=""

			;Select x1, y1, (GUI AREA)
			CoordMode, Mouse, Screen
			MouseGetPos, GUI_x1, GUI_y1
			BREAK
		}
	}

	While (GetKeyState("LButton", "P")) {
		;SELECT x2, y2 (Pixel Search)
		CoordMode, Mouse, Client
		MouseGetPos, x2, y2
		x2 := Round( x2/(A_ScreenDPI/96) )
		y2 := Round( y2/(A_ScreenDPI/96) )

		;FIX BUG PRA QUEM NAO SABE USAR
		if (x1+15 > x2) {
			MouseMove, 1,0 ,5, R
		}
		if (y1+15 > y2) {
			MouseMove, 0,1 ,5, R
		}

		;SELECT x2, y2 (GUI AREA)
		CoordMode, Mouse, Screen
		MouseGetPos, GUI_x2, GUI_y2

		GUI_x3 := GUI_x2 - GUI_x1
		GUI_x3 := Round( GUI_x3/(A_ScreenDPI/96) )
		GUI_y3 := GUI_y2 - GUI_y1
		GUI_y3 := Round( GUI_y3/(A_ScreenDPI/96) )
		Gui, GetArea:Show, x%GUI_x1% y%GUI_y1% w%GUI_x3% h%GUI_y3% NoActivate
		ToolTip, %x1%`, %y1%`, %x2%`, %y2%

		CoordMode, Mouse, Window	;VOLTA AO DEFAULT
	}
	;FIX BUG PRA QUEM NAO SABE USAR
	if (x1+15 > x2) {
		x2 := x1+15
	}
	if (y1+15 > y2) {
		y2 := y1+15
	}

	;GREEN COLOR BOX (SUCESS)
	Gui, GetArea: Color, Green
	Sleep 250
	Gui, GetArea:Destroy

	;PUT NEW COORDINATES IN GUI CONTROL
	Gui, %GuiTab%:Default
	GuiControl,, %GuiControlX1%, %x1%
	GuiControl,, %GuiControlY1%, %y1%
	GuiControl,, %GuiControlX2%, %x2%
	GuiControl,, %GuiControlY2%, %y2%

	;DONE!
	ToolTip, DONE !
    Sleep, 500
    ToolTip
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Show
	CoordMode, Mouse, Window	;VOLTA AO DEFAULT
}

