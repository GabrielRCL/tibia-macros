; ============================================== [ RunaMaker ] ==============================================
; ============================================== [ RunaMaker ] ==============================================
; ============================================== [ RunaMaker ] ==============================================

EatFood() {
	GLOBAL
	GuiControlGet, CheckBox_EatFood
	ElapsedTime_EatFood := A_TickCount - StartTime_EatFood
	if (CheckBox_EatFood == true && ElapsedTime_EatFood > 60*1000) {
		KeyWait, Control
		KeyWait, Shift

		MouseMove_And_Click(X:=GetCoord_EatFood_X,Y:=GetCoord_EatFood_Y,Speed:=4,fix_coordinates:=false, Click:="Right")
		StartTime_EatFood := A_TickCount
	}
}

CastRune() {
	GLOBAL
	GuiControlGet, CheckBox_CastRune
	if (CheckBox_CastRune == true) {
		Verify_MP_Color := GetColorHex(Coord_MP_CastRune_X, Coord_MP_CastRune_Y)
		if (Verify_MP_Color == Color_MP_CastRune) {
			ElapsedTime_CastRune := A_TickCount - StartTime_CastRune
			if (ElapsedTime_CastRune >= 60*1000) {
				SearchPNG(PNG.LeftHand, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, LeftHand, Mode:=1)
				if (LeftHand.1 == 1) {	;encontrou
					LeftHand_X := LeftHand.2 + 15
					LeftHand_Y := LeftHand.3 + 15
				} else if (LeftHand_X == "" && LeftHand_Y == "") {
					ToolTip(Text:="Left Hand Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
				}
				SearchPNG(PNG.Club, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, BlankRune, Mode:=1)
				if (BlankRune.1 == 1 && LeftHand_X != "" && LeftHand_Y != "") {
					Mouse_Click_Drag(X1:=BlankRune.2+12,Y1:=BlankRune.3+12,X2:=LeftHand_X,Y2:=LeftHand_Y,Speed:=25,fix_coordinates_1:=true,fix_coordinates_2:=true, Click:="Left")
					Sleep 10000	;10 seg
					Press_Key("Hotkey_CastRune", Tab:="")
					StartTime_CastRune := A_TickCount
				} else if (BlankRune.1 == 0) {
					ToolTip(Text:="Blank Rune Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
				}
			}

		}
	}
}

EquipLifeRing() {
	GLOBAL
	GuiControlGet, CheckBox_EquipLifeRing
	ElapsedTime_CastRune := A_TickCount - StartTime_EquipLifeRing
	if (CheckBox_EquipLifeRing == true && ElapsedTime_CastRune >= 2000) {
		SearchPNG(PNG.NoAmulet, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, NoAmulet, Mode:=1)
		SearchPNG(PNG.LifeRing, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, LifeRing, Mode:=1)
		if (NoAmulet.1 == 1 && LifeRing.1 == 1) {	;SIM ENCONTROU
			Mouse_Click_Drag(X1:=LifeRing.2+8,Y1:=LifeRing.3+8,X2:=NoAmulet.2+8,Y2:=NoAmulet.3+8,Speed:=4,fix_coordinates_1:=true,fix_coordinates_2:=true, Click:="Left")
			StartTime_EquipLifeRing := A_TickCount
		} else if (LifeRing.1 == 0) {	;NAO ENCONTROU
			ToolTip(Text:="[Supply] Life Ring Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
		}
	}
}

AlertPlayer() {
	GLOBAL
	GuiControlGet, CheckBox_AlertPlayer
	if (CheckBox_AlertPlayer == true) {
		SearchPNG(PNG.BattleList, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, BattleList, Mode:=1)
		if (BattleList.1 == 1) {
			Pixel_PlayerOnScreen := GetColorHex(BattleList.2+31, BattleList.3+90)
			if (Pixel_PlayerOnScreen = "#000000") {
				SoundBeep, 750, 250
			}
		} else {
			ToolTip(Text:="Battle List Not Found.",Time:=-500,PosX:=A_ScreenWidth/2,PosY:=A_ScreenHeight-55,WhichToolTip:=01)
		}
	}
}


; LABELS ==========================================================================================
GetCoord_EatFood:
	Get_Coord_Mouse(VarName:="EatFood", HUDcolor:="Blue",Transparent:=180)
RETURN
GetPixel_MP_CastRune:
	Get_Coord_And_Color(VarName:="MP_CastRune",GuiTab:="Main",HUDcolor:="Green")
RETURN
