DrawGuiFlower() {
    GLOBAL
    Gui, Add, GroupBox, x5 y29 w460 h65 +Left, Flower (Mouse Cursor)
	Gui, Add, Text, x222 y44 w155 h20 +Center, Coordinates
	Gui, Add, Text, x222 y67 w20 h15 , X =
	Gui, Add, Text, x306 y67 w20 h15 , Y =
	Gui, Add, Text, x137 y44 w70 h20 +Center, Key To active
		Gui, Add, Picture, x12 y49 w32 h32 , % "HBITMAP:* " Picture.God_Flower
		Gui, Add, CheckBox, x46 y49 w80 h32 vFlower, Flower
		Gui, Add, Hotkey, x137 y65 w70 h20 vKey_Enable_Flower, ;%Key_Enable_Flower%
	Gui, Font, cRed
		Gui, Add, Edit, x243 y65 w50 h20 r1 vFlowerX Number, ;%FlowerX%
		Gui, Add, Edit, x327 y65 w50 h20 r1 vFlowerY Number, ;%FlowerY%
	Gui, Font, cWhite
		Gui, Add, Button, x382 y49 w75 h30 gSelectCoordinatesFlower, Select Coordinates
}