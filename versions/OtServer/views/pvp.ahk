Draw_Gui_PvP() {
    GLOBAL
	Load_Pre_Settings("PvP")

	; [ DELAY ]
	Gui, Font, Bold
		Gui, Add, Text, section x210 y11 w45 h20, DELAY:
	Gui, Font, Norm
	Gui, Font, cRed
		Gui, Add, Edit, xs+45 ys-1 w40 h20 Number Limit2 vDelay_PvP, 15
	Gui, Font, cWhite
		Gui, Add, Text, xs+90 ys-5 w70 h30, (MinDelay: 0 MaxDelay:99)

	; [PvP] Tab ====================================================================
	; ===== [Flower] =====

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

	; ===== [Trash1] =====

	Gui, Add, GroupBox, x5 y99 w460 h130 , Trash (Mouse Cursor)
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
	; ===== [Push Item] =====

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

	; ===== [Swap SQM With Rune] =====
	Gui, Add, GroupBox, x5 y299 w460 h119 , MagicWall Or GrowthRune Configs
	;[Magic Wall]
	Gui, Add, Picture, x12 y329 w32 h32 , % "HBITMAP:* " Picture.Magic_Wall_Rune
	Gui, Add, CheckBox, x46 y329 w80 h20 vInstantMagicWall, Instant MW
	Gui, Add, Text, x46 y349 w85 h15, (Automatic Click)
	;[Growth]
	Gui, Add, Picture, x12 y376 w32 h32, % "HBITMAP:* " Picture.Wild_Growth_Rune
	Gui, Add, CheckBox, x46 y376 w90 h20 vInstantGrowth, Instant Growth
	Gui, Add, Text, x46 y396 w85 h15, (Automatic Click)

	;[SWAP SQM]
	;[MW]
	Gui, Add, CheckBox, x142 y325 w75 h20 vCheckBox_SwapSqmWithMW , Swap SQM
	Gui, Add, DropDownList, x142 y345 w70 h21 r4 vKey_Enable_SwapSqmWithMW , Shift|Control|Alt
	;[Growth]
	Gui, Add, CheckBox, x142 y372 w75 h20 vCheckBox_SwapSqmWithGrowth , Swap SQM
	Gui, Add, DropDownList, x142 y392 w70 h15 r4 vKey_Enable_SwapSqmWithGrowth , Shift|Control|Alt


	;[MW]
	Gui, Add, Text, x222 y325 w70 h20 +Center, Hotkey Rune
	Gui, Add, Hotkey, x222 y345 w70 h20 vHotkey_MagicWall, ;%Hotkey_MagicWall%
	;[Growth]
	Gui, Add, Text, x222 y372 w70 h20 +Center, Hotkey Rune
	Gui, Add, Hotkey, x222 y392 w70 h20 vHotkey_GrowthRune, ;%Hotkey_GrowthRune%


	; ===== [Auto Follow] ====
	Gui, Add, GroupBox, x475 y29 w100 h75 +Center, Auto Follow
	Gui, Add, CheckBox, x480 y49 w88 h20 vCheckBoxAutoFollow, Hotkey Follow
	Gui, Add, Hotkey, x490 y71 w75 h20 vHotkeyFollow, +Space


	; ====== [ Click Right ] =======
		Gui, Add, GroupBox, x475 y105 w100 h165 +Center, Auto Click
		Gui, Add, CheckBox, x480 y125 w88 h20 vAutoClickCheckBox, Click Right
		Gui, Add, Text, x490 y150 w20 h15 , X=
		Gui, Add, Text, x490 y171 w20 h15 , Y=
	Gui, Font, cRed
		Gui, Add, Edit, x510 y146 w55 h20 vAutoClickPosX Number, 123
		Gui, Add, Edit, x510 y167 w55 h20 vAutoClickPosY Number, 123
	Gui, Font, cWhite
		Gui, Add, Button, x485 y192 w80 h20 gAutoClickCoordinates, Select Coord.
		Gui, Add, Text, x480 y220 w88 h20, Repeat Every:
	Gui, Font, cRed
		Gui, Add, Edit, x485 y240 w35 h20 vRepeatAutoClickTimer +Right Number, 12
	Gui, Font, cWhite
		Gui, Add, Text, x523 y246 w43 h20, Seconds


}
Draw_Gui_PvP:
	Gui, PvP:Show, % " w" 581 " h" 421, [PvP] %TrayName%	;NAME PROGRAMA
RETURN

Swap_SQM_Warning_Coordinates() {
    GLOBAL
	;~ Gui, -AlwaysOnTop
	ToolTip("[BR] Configure as coordenadas do Looter para utilizar o SWAP SQM",Time:=-500,X:="",Y:="",WhichToolTip:=07,Force:=True)
	;~ Gui, +AlwaysOnTop
	; Gui, Looter:Show, % " w" 581 " h" 421, %TrayName%	;NAME PROGRAMA
}

;[Flower]
SelectCoordinatesFlower:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, PvP:Default
	MsgBox, 64, Select Coordinates, [PT-BR] Clique com o botao ESQUERDO do mouse na Flower para capturar coordenadas. `n`n[EN] LEFT-click on the Flower to get coordinates.
	Get_Coordinates_Script("FlowerX","FlowerY")
	Hide_All_GUI()	;HIDE ALL GUI
return

;[Trash1 e Trash2]
SelectCoordinatesTrash1:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, PvP:Default
	MsgBox, 64, Select Coordinates, [PT-BR] Clique com o botao ESQUERDO do mouse no Trash1 para capturar coordenadas. `n`n[EN] LEFT-click on the Trash1 to get coordinates.
	Get_Coordinates_Script("Trash1X","Trash1Y")
	Hide_All_GUI()	;HIDE ALL GUI
return

SelectCoordinatesTrash2:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, PvP:Default
	MsgBox, 64, Select Coordinates, [PT-BR] Clique com o botao ESQUERDO do mouse no Trash2 para capturar coordenadas. `n`n[EN] LEFT-click on the Trash2 to get coordinates.
	Get_Coordinates_Script("Trash2X","Trash2Y")
	Hide_All_GUI()	;HIDE ALL GUI
return

;[PushItem]
SelectCoordinatesPushItem:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, PvP:Default
	MsgBox, 64, Select Coordinates, [PT-BR] Clique com o botao ESQUERDO do mouse na backpack para capturar coordenadas. `n`n[EN] LEFT-click on the backpack to get coordinates.
	Get_Coordinates_Script("PushItemX","PushItemY")
	Hide_All_GUI()	;HIDE ALL GUI
return