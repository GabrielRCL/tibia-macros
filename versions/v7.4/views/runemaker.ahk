DrawGuiRuneMaker() {
    GLOBAL
		Gui, Font, Bold
			Gui, Add, GroupBox, SECTION x5 y360 w490 h120 +Center, RuneMaker
		Gui, Font, Normal


        ;EAT FOOD
        Gui, Add, Picture, xs+30 ys+15, % "HBITMAP:* " Picture.BrownMushroom
        Gui, Add, CheckBox, xs+15 ys+44 w70 h20 vCheckBox_EatFood, Eat Food
        Gui, Add, Button, xs+17 ys+65 w60 h15 gGetCoord_EatFood, Get Coord.
        Gui, Add, Text, xs+10 ys+85 w52 h20 vGetCoord_EatFood_X, X = ?
        Gui, Add, Text, xs+62 ys+85 w52 h20 vGetCoord_EatFood_Y, Y = ?

        ;Cast Rune
        Gui, Add, Picture, xs+164 ys+15, % "HBITMAP:* " Picture.BlankRune
        Gui, Add, CheckBox, xs+145 ys+44 w70 h20 vCheckBox_CastRune, Cast Rune
        Gui, Add, Button, xs+150 ys+67 w80 h15 gGetPixel_MP_CastRune, GetPixel MP`%
        Gui, Add, Picture, xs+128 ys+65 w20 h20 vPicture_GetPixel_MP_CastRune
        Gui, Add, Text, xs+128 ys+89 w40 h20, Hotkey:
        Gui, Add, Hotkey, xs+168 ys+87 w60 h20 vHotkey_CastRune,

        ;Equip Life Ring
        Gui, Add, Picture, xs+309 ys+15, % "HBITMAP:* " Picture.LifeRing
        Gui, Add, CheckBox, xs+340 ys+19 w90 h20 vCheckBox_EquipLifeRing, Equip LifeRing

        ;Player Alert
        Gui, Add, Picture, xs+309 ys+65, % "HBITMAP:* " Picture.WhiteSkull
        Gui, Add, CheckBox, xs+340 ys+69 w90 h25 vCheckBox_AlertPlayer, Alert Player (SOUND)

	}