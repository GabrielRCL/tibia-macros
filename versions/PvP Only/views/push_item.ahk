DrawGuiPushItem() {
    GLOBAL
	
	Gui, Add, GroupBox, x5 y234 w460 h65 , Push item to Backpack
	Gui, Add, Text, x222 y244 w155 h20 +Center, Coordinates
	Gui, Add, Text, x222 y267 w20 h15 , X =
	Gui, Add, Text, x306 y267 w20 h15 , Y =
	Gui, Add, Text, x132 y249 w70 h20 , Key To active
		Gui, Add, Picture, x12 y254 w32 h32 , % "HBITMAP:* " Picture.Backpack_of_Holding
		Gui, Add, CheckBox, x46 y254 w80 h32 vPushItem, Push item
	Gui, Font, cBlack
		Gui, Add, Hotkey, x132 y270 w70 h20 vKey_Enable_PushItem, ;%Key_Enable_PushItem%
	Gui, Font, cRed
		Gui, Add, Edit, x243 y265 w50 h20 vPushItemX Number, ;%PushItemX%
		Gui, Add, Edit, x327 y265 w50 h20 vPushItemY Number, ;%PushItemY%
	Gui, Font, cWhite
		Gui, Add, Button, x382 y249 w75 h30 gSelectCoordinatesPushItem, Select Coordinates
}