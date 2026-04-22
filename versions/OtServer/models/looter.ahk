Lootear() {
    GLOBAL
    Gui, Looter:Default
    GuiControlGet, Looter
	if (Looter == 1) {

		GuiControlGet, Delay_Looter
		GuiControlGet, Looter_Type_Coordinates
		GuiControlGet, Looter_Type_Coordinates_Preset
		if (Looter_Type_Coordinates == 1) {
			MouseGetPos, StartX, StartY	;get mouse position
			Sleep, 10

				GuiControlGet, Looter_Get_Coord_Manually
				if (Looter_Get_Coord_Manually != 1) {
					LootCords()
					Loop, 9 {
						Random, OutVarX, % -SQM_Size*0.35, % SQM_Size*0.35
						Random, OutVarY, % -SQM_Size*0.35, % SQM_Size*0.35
						Click_Looter_SQM(SQMLoot[A_Index]["x"]+OutVarX , SQMLoot[A_Index]["y"]+OutVarY, fix_coordinates:=true)
						Sleep %Delay_Looter%
					}
					SendInput, {Shift Up}

				} else {
					; [ MANUALLY LOOTER ]
					Loop, 9 {
						GuiControlGet, LooterSQM_%A_Index%X
						GuiControlGet, LooterSQM_%A_Index%Y
						Click_Looter_SQM(LooterSQM_%A_Index%X , LooterSQM_%A_Index%Y, fix_coordinates:=false)
						Sleep %Delay_Looter%
					}
					SendInput, {Shift Up}
				}

			Send, {Shift up}	;fix bug shift down
			GuiControlGet, Looter_Ghost_Mouse
			if (WinActive("ahk_id" . active_id) && Looter_Ghost_Mouse == 0) {
				MouseMove, %StartX%, %StartY%
			}

		} else {
			GuiControlGet, Looter_Type_Hotkey_Hotkey
			fix_Hotkey_to_ControlSend(Looter_Type_Hotkey_Hotkey, Looter_Type_Hotkey_HotkeyControlSend)
			ControlSend,, %Looter_Type_Hotkey_HotkeyControlSend%, ahk_id %active_id%	;Hotkey Looter (Item/Spell)
			Sleep %Delay_Looter%
		}
	}

}

GetColorDiff(x, y, CorArry){
    GLOBAL
	If ( ScanBit && StrideBit && X>=0 && Y>=0 && X < PNGScanWidth && Y < PNGScanHeight ){
		Color := Format("0x{:06X}", NumGet(ScanBit + 0, X * 4 + Y * StrideBit, "UInt") & 0xFFFFFF)
		R := (0xff0000 & Color) >> 16, G := (0x00ff00 & Color) >> 8, B :=  0x0000ff & Color
		CorDiff := sqrt((CorArry.R - R)**2+(CorArry.G - G)**2+(CorArry.B - B)**2)
		Return CorDiff
	}
}
LootCords(change_gui_values:=false){
    GLOBAL

    Height_GameBorda := Cords.GameBorda_LeftBottom[3] - Cords.GameBorda_RightTop[3]	;11 sqm total
    Width_GameBorda := Cords.GameBorda_RightTop[2] - Cords.GameBorda_LeftBottom[2]	;15 sqm total
    SQM_Size := Width_GameBorda/15

    ;fix coordinates 125%
    if (TibiaServer != "Global") {
        GameWindow_X1 := Round(Cords.GameBorda_LeftBottom[2])
        GameWindow_Y1 := Round( Cords.GameBorda_LeftBottom[3]-(SQM_Size*11) )

        GameWindow_X2 := Round(Cords.GameBorda_RightTop[2])
        GameWindow_Y2 := Round( Cords.GameBorda_RightTop[3]+(SQM_Size*11) )

        ;~ MouseMove(GameWindow_X1,GameWindow_Y1,fix_coordinates:=true)
        ;~ Sleep 1000
        ;~ MouseMove(GameWindow_X2,GameWindow_Y2,fix_coordinates:=true)
        ;~ Sleep 1000
        ;~ msgbox % "GameWindow_X1:" GameWindow_X1

        ;~ msgbox % "GameWindow_Y1:" GameWindow_Y1
        ;~ msgbox % "GameWindow_X2:" GameWindow_X2
        ;~ msgbox % "GameWindow_Y2:" GameWindow_Y2

    }

    SQMLoot.1 := {x:Cords.GameBorda_LeftBottom[2]+(SQM_Size*6.5) , y:Cords.GameBorda_RightTop[3]+(SQM_Size*4.5)}
    SQMLoot.2 := {x:Cords.GameBorda_LeftBottom[2]+(SQM_Size*7.5) , y:Cords.GameBorda_RightTop[3]+(SQM_Size*4.5)}
    SQMLoot.3 := {x:Cords.GameBorda_LeftBottom[2]+(SQM_Size*8.5) , y:Cords.GameBorda_RightTop[3]+(SQM_Size*4.5)}
    SQMLoot.4 := {x:Cords.GameBorda_LeftBottom[2]+(SQM_Size*8.5) , y:Cords.GameBorda_RightTop[3]+(SQM_Size*5.5)}
    SQMLoot.5 := {x:Cords.GameBorda_LeftBottom[2]+(SQM_Size*8.5) , y:Cords.GameBorda_RightTop[3]+(SQM_Size*6.5)}
    SQMLoot.6 := {x:Cords.GameBorda_LeftBottom[2]+(SQM_Size*7.5) , y:Cords.GameBorda_RightTop[3]+(SQM_Size*6.5)}
    SQMLoot.7 := {x:Cords.GameBorda_LeftBottom[2]+(SQM_Size*6.5) , y:Cords.GameBorda_RightTop[3]+(SQM_Size*6.5)}
    SQMLoot.8 := {x:Cords.GameBorda_LeftBottom[2]+(SQM_Size*6.5) , y:Cords.GameBorda_RightTop[3]+(SQM_Size*5.5)}
    SQMLoot.9 := {x:Cords.GameBorda_LeftBottom[2]+(SQM_Size*7.5) , y:Cords.GameBorda_RightTop[3]+(SQM_Size*5.5)}

    if (change_gui_values = true) {
        Loop, 9 {
            if (TibiaServer != "Global") {
                SQMLoot[A_Index]["x"] := Round( SQMLoot[A_Index]["x"]*(A_ScreenDPI/96) )
                SQMLoot[A_Index]["y"] := Round( SQMLoot[A_Index]["y"]*(A_ScreenDPI/96) )
            }
            GuiControl,, LooterSQM_%A_Index%X, % Round( SQMLoot[A_Index]["x"]+WindowInfo.ClassNN.x )
            GuiControl,, LooterSQM_%A_Index%Y, % Round( SQMLoot[A_Index]["Y"]+WindowInfo.ClassNN.y )
        }
    }

}

Click_Looter_SQM(x,y,fix_coordinates:=true) {
    GLOBAL
	;FIX COORDINATES
	if (fix_coordinates == true) {
		if (TibiaServer != "Global") {
			x := Round( x*(A_ScreenDPI/96) )
			y := Round( y*(A_ScreenDPI/96) )
		}
		x += WindowInfo.ClassNN.x
		y += WindowInfo.ClassNN.y
	}

	GuiControlGet, Looter_Type_Coordinates_Preset
	if (Looter_Type_Coordinates_Preset = "Shift+Right") {
		SendInput, {Shift down}
	}

	GuiControlGet, Looter_Ghost_Mouse
	if (WinActive("ahk_id" . active_id) && Looter_Ghost_Mouse == 0) {
		if (Looter_Type_Coordinates_Preset = "Left") {
			Click, %x%, %y%, Left
		} else {
			Click, %x%, %y%, Right
		}
	} else {
		if (Looter_Type_Coordinates_Preset = "Left") {
			ControlClick, x%x% y%y%, ahk_id %active_id%,, Left
		} else {
			ControlClick, x%x% y%y%, ahk_id %active_id%,, Right
		}
	}
}

LootearBox:
	Lootear()
return

Change_Gold(){
	GLOBAL
	ElapsedTime_Change_Gold := A_TickCount - StartTime_Change_Gold
	GuiControlGet, CheckBox_ChangeGold, Gui_CaveBot:
	if (CheckBox_ChangeGold == 1 && ElapsedTime_Change_Gold > 250) {
		CG++
		if CG is not number
			CG := 1
		if (CG > 4) {
			CG := 1
		}

		;~ Crop_And_Save_Haystack(0,0,Cords.GameBorda_LeftBottom.2,WindowInfo.Client.h)
		;~ dbg_weight := WindowInfo.Client.w - Cords.GameBorda_RightTop.2
		;~ Crop_And_Save_Haystack(Cords.GameBorda_RightTop.2,0,dbg_weight,WindowInfo.Client.h)

		if (CG == 1) {
			SearchPNG(PNG.GoldCoinConverter, 0,0,Cords.GameBorda_LeftBottom.2,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ToolTip("Change Gold...", Time:=-500, X:="", Y:="", WhichToolTip:=20)
				GuiControlGet, Hotkey_GoldConverter, Gui_CaveBot:
				if (Hotkey_GoldConverter == "" or Hotkey_GoldConverter == "ERROR") {
					ControlClick(Erro.2,Erro.3,"RIGHT")
				} else {
					Press_Key("Hotkey_GoldConverter", "Gui_CaveBot")
					Sleep 50
					ControlClick(Erro.2,Erro.3,"LEFT")
				}
				StartTime_Change_Gold := A_TickCount
			}
			SearchPNG(PNG.GoldCoinConverter, Cords.GameBorda_RightTop.2,0,WindowInfo.Client.w,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ToolTip("Change Gold...", Time:=-500, X:="", Y:="", WhichToolTip:=20)
				GuiControlGet, Hotkey_GoldConverter, Gui_CaveBot:
				if (Hotkey_GoldConverter == "" or Hotkey_GoldConverter == "ERROR") {
					ControlClick(Erro.2,Erro.3,"RIGHT")
				} else {
					Press_Key("Hotkey_GoldConverter", "Gui_CaveBot")
					Sleep 50
					ControlClick(Erro.2,Erro.3,"LEFT")
				}
				StartTime_Change_Gold := A_TickCount
			}
		}

		if (CG == 2) {
			SearchPNG(PNG.PlatinumCoinConverter, 0,0,Cords.GameBorda_LeftBottom.2,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ToolTip("Change Platinum...", Time:=-500, X:="", Y:="", WhichToolTip:=20)
				GuiControlGet, Hotkey_GoldConverter, Gui_CaveBot:
				if (Hotkey_GoldConverter == "" or Hotkey_GoldConverter == "ERROR") {
					ControlClick(Erro.2,Erro.3,"RIGHT")
				} else {
					Press_Key("Hotkey_GoldConverter", "Gui_CaveBot")
					Sleep 50
					ControlClick(Erro.2,Erro.3,"LEFT")
				}
				StartTime_Change_Gold := A_TickCount
			}
			SearchPNG(PNG.PlatinumCoinConverter, Cords.GameBorda_RightTop.2,0,WindowInfo.Client.w,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ToolTip("Change Platinum...", Time:=-500, X:="", Y:="", WhichToolTip:=20)
				GuiControlGet, Hotkey_GoldConverter, Gui_CaveBot:
				if (Hotkey_GoldConverter == "" or Hotkey_GoldConverter == "ERROR") {
					ControlClick(Erro.2,Erro.3,"RIGHT")
				} else {
					Press_Key("Hotkey_GoldConverter", "Gui_CaveBot")
					Sleep 50
					ControlClick(Erro.2,Erro.3,"LEFT")
				}
				StartTime_Change_Gold := A_TickCount
			}
		}

		if (CG == 3) {
			SearchPNG(PNG.DustsForge, 0,0,Cords.GameBorda_LeftBottom.2,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ToolTip("Change Dust...", Time:=-500, X:="", Y:="", WhichToolTip:=20)
				GuiControlGet, Hotkey_GoldConverter, Gui_CaveBot:
				if (Hotkey_GoldConverter == "" or Hotkey_GoldConverter == "ERROR") {
					ControlClick(Erro.2,Erro.3,"RIGHT")
				} else {
					Press_Key("Hotkey_GoldConverter", "Gui_CaveBot")
					Sleep 50
					ControlClick(Erro.2,Erro.3,"LEFT")
				}
				StartTime_Change_Gold := A_TickCount
			}
			SearchPNG(PNG.DustsForge, Cords.GameBorda_RightTop.2,0,WindowInfo.Client.w,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ToolTip("Change Dust...", Time:=-500, X:="", Y:="", WhichToolTip:=20)
				GuiControlGet, Hotkey_GoldConverter, Gui_CaveBot:
				if (Hotkey_GoldConverter == "" or Hotkey_GoldConverter == "ERROR") {
					ControlClick(Erro.2,Erro.3,"RIGHT")
				} else {
					Press_Key("Hotkey_GoldConverter", "Gui_CaveBot")
					Sleep 50
					ControlClick(Erro.2,Erro.3,"LEFT")
				}
				StartTime_Change_Gold := A_TickCount
			}
		}

		if (CG == 4 && Data.Conditions.ProtectionZone != 1) {
			SearchPNG(PNG.CrystalCoinConverter, 0,0,Cords.GameBorda_LeftBottom.2,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ToolTip("Change Crystal...", Time:=-500, X:="", Y:="", WhichToolTip:=20)
				GuiControlGet, Hotkey_GoldConverter, Gui_CaveBot:
				if (Hotkey_GoldConverter == "" or Hotkey_GoldConverter == "ERROR") {
					ControlClick(Erro.2,Erro.3,"RIGHT")
				} else {
					Press_Key("Hotkey_GoldConverter", "Gui_CaveBot")
					Sleep 50
					ControlClick(Erro.2,Erro.3,"LEFT")
				}
				StartTime_Change_Gold := A_TickCount
			}
			SearchPNG(PNG.CrystalCoinConverter, Cords.GameBorda_RightTop.2,0,WindowInfo.Client.w,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ToolTip("Change Crystal...", Time:=-500, X:="", Y:="", WhichToolTip:=20)
				GuiControlGet, Hotkey_GoldConverter, Gui_CaveBot:
				if (Hotkey_GoldConverter == "" or Hotkey_GoldConverter == "ERROR") {
					ControlClick(Erro.2,Erro.3,"RIGHT")
				} else {
					Press_Key("Hotkey_GoldConverter", "Gui_CaveBot")
					Sleep 50
					ControlClick(Erro.2,Erro.3,"LEFT")
				}
				StartTime_Change_Gold := A_TickCount
			}
		}

		StartTime_Change_Gold := A_TickCount
	}
}


LocateGameBorda() {
	GLOBAL 
	SearchPNG(PNG.GameBorda_LeftBottom, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, Erro, Mode:=1), Cords.GameBorda_LeftBottom:=Erro
	;~ TOOLTIP % Cords.GameBorda_LeftBottom.2 " + " Cords.GameBorda_LeftBottom.3
	if (Cords.GameBorda_LeftBottom.1 == 1) {
		Cords.GameBorda_LeftBottom[3] += 199	;Eixo Y fix coordinates
		ColorHex_Validate_GameBorda_LeftBottom := GetColorHex(Cords.GameBorda_LeftBottom.2, Cords.GameBorda_LeftBottom.3)	;[GET ColorHex Validate GameBorda]
	}
	SearchPNG(PNG.GameBorda_RightTop, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, Erro, Mode:=1), Cords.GameBorda_RightTop:=Erro
	;~ TOOLTIP % Cords.GameBorda_RightTop.2 " + " Cords.GameBorda_RightTop.3
	if (Cords.GameBorda_RightTop.1 == 1) {
		Cords.GameBorda_RightTop[2] += 199 		;Eixo X fix coordinates
		ColorHex_Validate_GameBorda_RightTop := GetColorHex(Cords.GameBorda_RightTop.2, Cords.GameBorda_RightTop.3)			;[GET ColorHex Validate GameBorda]
	}
}
