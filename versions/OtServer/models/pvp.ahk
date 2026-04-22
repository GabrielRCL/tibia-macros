Get_Ghost_Mouse() {
    GLOBAL  
    if (TibiaServer = "OtServer" or TibiaServer = "Global") {
        ghost_mouse := true
    } else {
        ghost_mouse := false
    }

    ; EXCEPTIONS (OVERRIDE)
    if (client_ahk_class = "DeusOT") {
        ghost_mouse := false
    }

    return ghost_mouse
}

FlowerOnMouse:
    Gui, PvP:Default
	GuiControlGet, Flower
	if (Flower == 1) {
		MouseGetPos, StartX, StartY
		GuiControlGet, FlowerX
		GuiControlGet, FlowerY

		Send, {Shift Down}
        ghost_mouse := Get_Ghost_Mouse()
		if (ghost_mouse) {
			ControlClick, x%FlowerX% y%FlowerY%, ahk_id %active_id%,,,, D
			ControlClick, x%StartX% y%StartY%, ahk_id %active_id%,,,, U
		} else {
			SendMode, Event
			BlockInput, ON
			Send, {Shift Down}
				GuiControlGet, Delay_PvP
			MouseClickDrag, Left, %FlowerX% , %FlowerY%, %StartX%, %StartY%, % Delay_PvP
				Sleep 150
			BlockInput, OFF
		} 
		Send, {Shift Up}
	}
return

TrashOnMouse:
    Gui, PvP:Default
	ToolTip, Trashando...,,, 3
	MouseGetPos, StartX, StartY
	GuiControlGet, Trash1
	if (Trash1 == 1) {
		GuiControlGet, Trash1X
		GuiControlGet, Trash1Y

        ghost_mouse := Get_Ghost_Mouse()
		if (ghost_mouse) {
			ControlClick, x%Trash1X% y%Trash1Y%, ahk_id %active_id%,,,, D
			Send, {Shift Down}
			ControlClick, x%StartX% y%StartY%, ahk_id %active_id%,,,, U
		} else {
			SendMode, Event
			BlockInput, ON
			Send, {Shift Down}
				GuiControlGet, Delay_PvP
			MouseClickDrag, Left, %Trash1X%, %Trash1Y%, %StartX%, %StartY%, % Delay_PvP
				Sleep 75
			BlockInput, OFF
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
		
        ghost_mouse := Get_Ghost_Mouse()
        if (ghost_mouse) {
			ControlClick, x%Trash2X% y%Trash2Y%, ahk_id %active_id%,,,, D
			Send, {Shift Down}
			ControlClick, x%StartX% y%StartY%, ahk_id %active_id%,,,, U
		} else {
			SendMode, Event
			BlockInput, ON
			Send, {Shift Down}
				GuiControlGet, Delay_PvP
			MouseClickDrag, Left, %Trash2X%, %Trash2Y%, %StartX%, %StartY%, % Delay_PvP
				Sleep 75
			BlockInput, OFF
		}
		Send, {Shift Up}
	}
	ToolTip,,,, 3
return

PushItemOnBP:
    Gui, PvP:Default
	GuiControlGet, PushItem
	if (PushItem == 1) {
		GuiControlGet, PushItemX
		GuiControlGet, PushItemY
		MouseGetPos, StartX, StartY

        
		KeyWait, Alt
		If WinActive("ahk_id " active_id) {
            ghost_mouse := Get_Ghost_Mouse()
			if (ghost_mouse) {
				ControlClick, x%StartX% y%StartY%, ahk_id %active_id%,,,, D
				ControlClick, x%PushItemX% y%PushItemY%, ahk_id %active_id%,,,, U
			} else {
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
			}
		}

	}
return



SwapSQMWithMW:
    Gui, PvP:Default
    GuiControlGet, Key_Enable_SwapSqmWithMW
    Loop {
        ToolTip, [MW] Swap,,, 2

        if !(GetKeyState(Key_Enable_SwapSQMWithMW)) {
            break
        }

        ;[Up]
        if ( GetKeyState(Key_Enable_SwapSqmWithMW) && (GetKeyState("Up") or GetKeyState("w")) ) {
            if (OTClient == true) {
                KeyWait, %Key_Enable_SwapSqmWithMW%
            }
            Send, {Up}
            GuiControlGet, Hotkey_MagicWall
            fix_Hotkey_to_ControlSend(Hotkey_MagicWall, HotkeyControlSend_MagicWall)
            Send, %HotkeyControlSend_MagicWall%

            GuiControlGet, Delay_PvP
            Sleep %Delay_PvP%

            MouseGetPos, StartX, StartY
            GuiControlGet, LooterSQM_9X, Looter:
            GuiControlGet, LooterSQM_9Y, Looter:

            Click, %LooterSQM_9X%, %LooterSQM_9Y%
            MouseMove, %StartX%, %StartY%
            Sleep 200
            break
        }

        ;[Down]
        if ( GetKeyState(Key_Enable_SwapSqmWithMW) && (GetKeyState("Down") or GetKeyState("s")) ) {
            if (OTClient == true) {
                KeyWait, %Key_Enable_SwapSqmWithMW%
            }
            Send, {Down}
            GuiControlGet, Hotkey_MagicWall
            fix_Hotkey_to_ControlSend(Hotkey_MagicWall, HotkeyControlSend_MagicWall)
            Send, %HotkeyControlSend_MagicWall%

            GuiControlGet, Delay_PvP
            Sleep %Delay_PvP%

            MouseGetPos, StartX, StartY
            GuiControlGet, LooterSQM_9X, Looter:
            GuiControlGet, LooterSQM_9Y, Looter:
            Click, %LooterSQM_9X%, %LooterSQM_9Y%
            MouseMove, %StartX%, %StartY%
            Sleep 200
            break
        }

        ;[Left]
        if ( GetKeyState(Key_Enable_SwapSqmWithMW) && (GetKeyState("Left") or GetKeyState("a")) ) {
            if (OTClient == true) {
                KeyWait, %Key_Enable_SwapSqmWithMW%
            }
            Send, {Left}
            GuiControlGet, Hotkey_MagicWall
            fix_Hotkey_to_ControlSend(Hotkey_MagicWall, HotkeyControlSend_MagicWall)
            Send, %HotkeyControlSend_MagicWall%

            GuiControlGet, Delay_PvP
            Sleep %Delay_PvP%

            MouseGetPos, StartX, StartY
            GuiControlGet, LooterSQM_9X, Looter:
            GuiControlGet, LooterSQM_9Y, Looter:
            Click, %LooterSQM_9X%, %LooterSQM_9Y%
            MouseMove, %StartX%, %StartY%
            Sleep 200
            break
        }

        ;[Right]
        if ( GetKeyState(Key_Enable_SwapSqmWithMW) && (GetKeyState("Right") or GetKeyState("d")) ) {
            if (OTClient == true) {
                KeyWait, %Key_Enable_SwapSqmWithMW%
            }
            Send, {Right}
            GuiControlGet, Hotkey_MagicWall
            fix_Hotkey_to_ControlSend(Hotkey_MagicWall, HotkeyControlSend_MagicWall)
            Send, %HotkeyControlSend_MagicWall%

            GuiControlGet, Delay_PvP
            Sleep %Delay_PvP%

            MouseGetPos, StartX, StartY
            GuiControlGet, LooterSQM_9X, Looter:
            GuiControlGet, LooterSQM_9Y, Looter:
            Click, %LooterSQM_9X%, %LooterSQM_9Y%
            MouseMove, %StartX%, %StartY%
            Sleep 200
            break
        }

    }
    ToolTip,,,, 2
return
InstantMW:
	Click
return


SwapSQMWithGrowth:
    Gui, PvP:Default
    GuiControlGet, Key_Enable_SwapSQMWithGrowth
    Loop {

        ToolTip, [Growth] SWAP,,, 2

        if !(GetKeyState(Key_Enable_SwapSQMWithGrowth)) {
            break
        }

        ;[Up]
        if ( GetKeyState(Key_Enable_SwapSqmWithGrowth) && (GetKeyState("Up") or GetKeyState("w")) ) {
            if (OTClient == true) {
                KeyWait, %Key_Enable_SwapSqmWithGrowth%
            }
            Send, {Up}
            GuiControlGet, Hotkey_GrowthRune
            fix_Hotkey_to_ControlSend(Hotkey_GrowthRune, HotkeyControlSend_GrowthRune)
            Send, %HotkeyControlSend_GrowthRune%

            GuiControlGet, Delay_PvP
            Sleep %Delay_PvP%

            MouseGetPos, StartX, StartY
            GuiControlGet, LooterSQM_9X, Looter:
            GuiControlGet, LooterSQM_9Y, Looter:
            Click, %LooterSQM_9X%, %LooterSQM_9Y%
            MouseMove, %StartX%, %StartY%
            break
        }

        ;[Down]
        if ( GetKeyState(Key_Enable_SwapSqmWithGrowth) && (GetKeyState("Down") or GetKeyState("s")) ) {
            if (OTClient == true) {
                KeyWait, %Key_Enable_SwapSqmWithGrowth%
            }
            Send, {Down}
            GuiControlGet, Hotkey_GrowthRune
            fix_Hotkey_to_ControlSend(Hotkey_GrowthRune, HotkeyControlSend_GrowthRune)
            Send, %HotkeyControlSend_GrowthRune%

            GuiControlGet, Delay_PvP
            Sleep %Delay_PvP%

            MouseGetPos, StartX, StartY
            GuiControlGet, LooterSQM_9X, Looter:
            GuiControlGet, LooterSQM_9Y, Looter:
            Click, %LooterSQM_9X%, %LooterSQM_9Y%
            MouseMove, %StartX%, %StartY%
            Sleep 200
            break
        }

        ;[Left]
        if ( GetKeyState(Key_Enable_SwapSqmWithGrowth) && (GetKeyState("Left") or GetKeyState("a")) ) {
            if (OTClient == true) {
                KeyWait, %Key_Enable_SwapSqmWithGrowth%
            }
            Send, {Left}
            GuiControlGet, Hotkey_GrowthRune
            fix_Hotkey_to_ControlSend(Hotkey_GrowthRune, HotkeyControlSend_GrowthRune)
            Send, %HotkeyControlSend_GrowthRune%

            GuiControlGet, Delay_PvP
            Sleep %Delay_PvP%

            MouseGetPos, StartX, StartY
            GuiControlGet, LooterSQM_9X, Looter:
            GuiControlGet, LooterSQM_9Y, Looter:
            Click, %LooterSQM_9X%, %LooterSQM_9Y%
            MouseMove, %StartX%, %StartY%
            Sleep 200
            break
        }

        ;[Right]
        if ( GetKeyState(Key_Enable_SwapSqmWithGrowth) && (GetKeyState("Right") or GetKeyState("d")) ) {
            if (OTClient == true) {
                KeyWait, %Key_Enable_SwapSqmWithGrowth%
            }
            Send, {Right}
            GuiControlGet, Hotkey_GrowthRune
            fix_Hotkey_to_ControlSend(Hotkey_GrowthRune, HotkeyControlSend_GrowthRune)
            Send, %HotkeyControlSend_GrowthRune%

            GuiControlGet, Delay_PvP
            Sleep %Delay_PvP%

            MouseGetPos, StartX, StartY
            GuiControlGet, LooterSQM_9X, Looter:
            GuiControlGet, LooterSQM_9Y, Looter:
            Click, %LooterSQM_9X%, %LooterSQM_9Y%
            MouseMove, %StartX%, %StartY%
            Sleep 200
            break
        }

    }
    ToolTip,,,, 2
return
InstantGrowth:
	Click
return


AutoFollow:
    Gui, PvP:Default
    Send, ^{Click, Right}
    Loop, 10 {
        Sleep 25
        PrintScreenData()
        SearchPNG(PNG.FollowText, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=50, Erro, Mode:=1)
        if (Erro.1 == 1) {
            ControlClick(Erro.2,Erro.3,WhichButton:="LEFT",fix_coordinates:=true,ghost_mouse:=true,state:="",zKeyWait:=false)
            BREAK
        }
    }
return
