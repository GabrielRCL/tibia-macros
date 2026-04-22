DrawGuiTrash() {
    GLOBAL
	Gui, Add, GroupBox, x5 y99 w460 h130 , Trash (Mouse Cursor)
	
	; ===== [Trash1] ===== 
	Gui, Add, Text, x222 y114 w155 h20 +Center, Coordinates
	Gui, Add, Text, x222 y137 w20 h15 , X =
	Gui, Add, Text, x306 y137 w20 h15 , Y =
	Gui, Add, Text, x137 y139 w70 h20 , Key To active
		Gui, Add, Picture, x12 y129 w32 h32 , % "HBITMAP:* " Picture.Worm
		Gui, Add, CheckBox, x46 y129 w80 h32 vTrash1, Trash 1
	Gui, Font, cBlack
		Gui, Add, Hotkey, x137 y165 w70 h20 vKey_Enable_Trash,  ;%Key_Enable_Trash%
	Gui, Font, cRed
		Gui, Add, Edit, x243 y135 w50 h20 vTrash1X Number, ;%Trash1X%
		Gui, Add, Edit, x327 y135 w50 h20 vTrash1Y Number, ;%Trash1Y%
	Gui, Font, cWhite
		Gui, Add, Button, x382 y119 w75 h30 gSelectCoordinatesTrash1, Select Coordinates

	; ===== [Trash2] =====
	Gui, Add, Text, x222 y174 w155 h20 +Center, Coordinates
	Gui, Add, Text, x222 y197 w20 h15 , X =
	Gui, Add, Text, x306 y197 w20 h15 , Y =
		Gui, Add, Picture, x12 y169 w32 h32 , % "HBITMAP:* " Picture.Cherry
		Gui, Add, CheckBox, x46 y169 w80 h32 vTrash2, Trash 2
	Gui, Font, cRed
		Gui, Add, Edit, x243 y195 w50 h20 vTrash2X Number, ;%Trash2X%
		Gui, Add, Edit, x327 y195 w50 h20 vTrash2Y Number, ;%Trash2Y%
	Gui, Font, cWhite
		Gui, Add, Button, x382 y179 w75 h30 gSelectCoordinatesTrash2, Select Coordinates
}