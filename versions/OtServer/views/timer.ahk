Draw_Gui_Timer() {
    GLOBAL
	Load_Pre_Settings("Timer")
	;~ Gui, Add, Tab, x1 y1 w580 h420, Timer|Training

	; [Timer] Tab ===================================================================
	Gui, Add, GroupBox, x5 y29 w280 h85 , Hotkey1 Timer
	Gui, Add, DropDownList, x44 y80 w68 h20 r2 vTimer1Type Choose1, Keyboard|Mouse

	;[TIMER1]
	Gui, Add, Picture, x12 y59 w32 h32 , % "HBITMAP:* " Picture.Compass
	Gui, Add, CheckBox, x47 y59 w60 h20	vHotkey1TimerCheckBox, Timer1
	Gui, Add, GroupBox, x185 y50 w85 h42 , Time(ms)
	Gui, Font, cRed
	Gui, Add, Edit, x190 y66 w60 h20 +Right vHotkey1TimerDelay Number, 1000 ;%Hotkey1TimerDelay%
	Gui, Font, cWhite
	Gui, Add, Text, x252 y71 w15 h15 , ms
	;[Keyboard] Timer1
	Gui, Add, GroupBox, x113 y50 w70 h42 vGroupBoxHotkey1Timer, Hotkey
		Gui, Add, Hotkey, x119 y66 w60 h20 vHotkey1TimerHotkey, ;%Hotkey1TimerHotkey%
	;[Mouse] Timer1
	Gui, Add, GroupBox, x115 y40 w70 h70 vGroupBoxMouse1Timer, Coordinates
		Gui, Add, Text, x120 y60 w15 h15 vTextMouse1TimerX, X=
	Gui, Font, cRed
		Gui, Add, Edit, x135 y60 w45 h15 vTimer1X, 123
	Gui, Font, cWhite
		Gui, Add, Text, x120 y75 w15 h15 vTextMouse1TimerY, Y=
	Gui, Font, cRed
		Gui, Add, Edit, x135 y75 w45 h15 vTimer1Y, 321
	Gui, Font, cWhite
		Gui, Add, Button, x116 y92 w68 h15 vButtonMouse1Timer gSelectCoordTimer1, Select Coord
	GuiControl, Hide, GroupBoxMouse1Timer	;HIDE MOUSE GUI
	GuiControl, Hide, TextMouse1TimerX		;HIDE MOUSE GUI
	GuiControl, Hide, Timer1X				;HIDE MOUSE GUI
	GuiControl, Hide, TextMouse1TimerY		;HIDE MOUSE GUI
	GuiControl, Hide, Timer1Y				;HIDE MOUSE GUI
	GuiControl, Hide, ButtonMouse1Timer		;HIDE MOUSE GUI

	;[TIMER 3]
	Gui, Add, GroupBox, x292 y29 w280 h85 , Hotkey2 Timer
	Gui, Add, Picture, x302 y59 w32 h32 , % "HBITMAP:* " Picture.Compass
	Gui, Add, CheckBox, x337 y59 w60 h32 vHotkey2TimerCheckBox, Hotkey2
	Gui, Add, GroupBox, x403 y50 w70 h42 , Hotkey
	Gui, Add, Hotkey, x409 y66 w60 h20 vHotkey2TimerHotkey, ;%Hotkey2TimerHotkey%
	Gui, Add, GroupBox, x475 y50 w85 h42 , Time(ms)
	Gui, Font, cRed
	Gui, Add, Edit, x480 y66 w60 h20 +Right vHotkey2TimerDelay Number, 1000 ;%Hotkey2TimerDelay%
	Gui, Font, cWhite
	Gui, Add, Text, x542 y71 w15 h15 , ms

	;[TIMER 3]
	Gui, Add, GroupBox, x5 y119 w280 h85 , Hotkey3 Timer
	Gui, Add, Picture, x12 y149 w32 h32 , % "HBITMAP:* " Picture.Compass
	Gui, Add, CheckBox, x47 y149 w60 h32 vHotkey3TimerCheckBox, Hotkey3
	Gui, Add, GroupBox, x113 y140 w70 h42 , Hotkey
	Gui, Add, Hotkey, x119 y156 w60 h20 vHotkey3TimerHotkey, ;%Hotkey3TimerHotkey%
	Gui, Add, GroupBox, x185 y140 w85 h42 , Time(ms)
	Gui, Font, cRed
	Gui, Add, Edit, x190 y156 w60 h20 +Right vHotkey3TimerDelay Number, 1000 ;%Hotkey3TimerDelay%
	Gui, Font, cWhite
	Gui, Add, Text, x252 y161 w15 h15 , ms

	Gui, Add, GroupBox, x292 y119 w280 h85 , Hotkey4 Timer
	Gui, Add, Picture, x302 y149 w32 h32 , % "HBITMAP:* " Picture.Compass
	Gui, Add, CheckBox, x337 y149 w60 h32 vHotkey4TimerCheckBox, Hotkey4
	Gui, Add, GroupBox, x403 y140 w70 h42 , Hotkey
	Gui, Add, Hotkey, x409 y156 w60 h20 vHotkey4TimerHotkey, ;%Hotkey4TimerHotkey%,
	Gui, Add, GroupBox, x475 y140 w85 h42 , Time(ms)
	Gui, Font, cRed
	Gui, Add, Edit, x480 y156 w60 h20 +Right vHotkey4TimerDelay Number, 1000 ;%Hotkey4TimerDelay%
	Gui, Font, cWhite
	Gui, Add, Text, x542 y161 w15 h15 , ms

	;[Exercise Weapon]
	Gui, Add, GroupBox, section x5 y219 w450 h150 , Exercise Training
	Gui, Add, Picture, x15 y239 w148 h112 , % "HBITMAP:* " Picture.ExerciseTraining
	Gui, Add, CheckBox, x358 y309 w85 h20 vExerciseTrainingCheckBox, Start Training
	Gui, Add, GroupBox, x180 y259 w70 h55 +Center, Hotkey Exercise
	Gui, Add, Hotkey, x185 y284 w60 h20 vHotkeyExercise, ;%HotkeyExercise%
	Gui, Add, GroupBox, x265 y249 w80 h100 , Coordinates
	Gui, Add, Button, x275 y269 w60 h20 gGetCoordExerciseTraining, Get Coord.
	Gui, Font, cRed
	Gui, Add, Edit, x290 y294 w50 h20 vExerciseTrainingX Number, ;%ExerciseTrainingX%
	Gui, Add, Edit, x290 y319 w50 h20 vExerciseTrainingY Number, ;%ExerciseTrainingY%
	Gui, Font, cWhite
	Gui, Add, Text, x270 y297 w20 h15 , X=
	Gui, Add, Text, x270 y322 w20 h15 , Y=
	Gui, Add, GroupBox, x353 y259 w90 h42 , Time(segundos)
	Gui, Font, cRed
	Gui, Add, Edit, x358 y274 w60 h20 +Right vTimeExerciseTraining Number, 60 ;%TimeExerciseTraining%
	Gui, Font, cWhite
	Gui, Add, Text, x419 y278 w20 h20 , seg.

	;[Reconnect]
	Gui, Add, GroupBox, x465 y220 w110 h148 , Reconnect
	Gui, Add, CheckBox, x470 y240 w100 h20 vReconnectCheckBox, Auto Reconnect
	Gui, Add, Text, x470 y270 w100 h20 , Senha/Password:
    Gui, Font, cRed
	Gui, Add, Edit, x470 y290 w100 h20 vReconnect_Password Password,
    Gui, Font, cWhite
	Gui, Add, Text, x470 y323 w100 h20 , Time(Seconds):
    Gui, Font, cRed
	Gui, Add, Edit, x480 y340 w35 h20 vReconnectTimer +Right Number Limit3, 0
    Gui, Font, cWhite
	Gui, Add, Text, x516 y346 w43 h20, Seconds


	;[MANA BURN]
	Gui, Add, GroupBox, section xs y+10 w100 h140, Mana Burn
	Gui, Add, Picture, xs+34 ys+18 w32 h32, % "HBITMAP:* " Picture.Mana_Burn
	Gui, Add, CheckBox, xs+15 ys+50 w70 h20 vCheckBox_Mana_Burn +Center, Mana Burn
	Portugues := "Se MP% >"
	English := "When MP% >"
	Gui, Add, Text, xs+5 ys+74 w70 h20 +Center, % %GlobalLanguage%
    Gui, Font, cRed
	Gui, Add, Edit, xs+75 ys+71 w20 h20 vPercent_Mana_Burn +Center Number Limit2, 00
    Gui, Font, cWhite
	Gui, Add, Text, xs+15 ys+96 w70 h20 +Center, Press Hotkey:
	Gui, Add, Hotkey, xs+15 ys+113 w70 h20 vHotkey_Mana_Burn,

	;[Move Item]
	Gui, Font, Bold
		Gui, Add, GroupBox, xs+120 ys w450 h105 , Move Item to Position
	Gui, Font, Normal

		Gui, Add, Picture, section xp+10 yp+20 w32 h32, % "HBITMAP:* " Picture.MoveItemsBP
		Gui, Add, Picture, xs w32 h32, % "HBITMAP:* " Picture.MoveItemsMouse
		Gui, Add, CheckBox, xs+60 ys+5 vCheckBox_MoveItem, ENABLE

		Gui, Add, Text, xs+55 ys+35 , Repeat Every:
	Gui, Font, cRed
		Gui, Add, Edit, xs+58 ys+50 Limit2 Number vDelay_MoveItem, 15
	Gui, Font, cWhite
		Gui, Add, Text, xs+82 ys+54, seconds.

		Gui, Add, Text, section xs+175 ys-10, Coord. Start Position:
		Gui, Add, Text, xs-15 ys+20 , X =
		Gui, Add, Text, xs+55 ys+20 , Y =
		Gui, Add, Button, xs+120 ys+15 gMoveItem_SelectStartPosition, Select Start Position

		Gui, Add, Text, xs ys+50, Coord. Final Position:
		Gui, Add, Text, xs-15 ys+70 , X =
		Gui, Add, Text, xs+55 ys+70 , Y =
		Gui, Add, Button, xs+122 ys+65 gMoveItem_SelectFinalPosition, Select Final Position

	Gui, Font, cRed
		Gui, Add, Edit, xs+5 ys+18 Limit4 Number vCoord_MoveItem_StartPositionX, 1111
		Gui, Add, Edit, xs+75 ys+18 Limit4 Number vCoord_MoveItem_StartPositionY, 1111

		Gui, Add, Edit, xs+5 ys+68 Limit4 Number vCoord_MoveItem_FinalPositionX, 2222
		Gui, Add, Edit, xs+75 ys+68 Limit4 Number vCoord_MoveItem_FinalPositionY, 2222
	Gui, Font, cWhite





}
Draw_Gui_Timer:
	Gui, Timer:Show, % " w" 581 " h" 531, [Timer] %TrayName%	;NAME PROGRAMA
RETURN

SelectCoordTimer1:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Timer:Default
	MsgBox, 64, Select Coordinates, [BR] Clique com o botao ESQUERDO o mouse na posição onde voce quer auto clicar. `n`n[EN] LEFT-click to get coordinates for Click Timer.
	Get_Coordinates_Script("Timer1X","Timer1Y")
	Hide_All_GUI()	;HIDE ALL GUI
RETURN

GetCoordExerciseTraining:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Timer:Default
	MsgBox, 64, Select Coordinates, [BR] Clique com o botao ESQUERDO o mouse no **DUMMY** para capturar coordenadas. `n`n[EN] LEFT-click on the **DUMMY** to get coordinates.
	Get_Coordinates_Script("ExerciseTrainingX","ExerciseTrainingY")
	Hide_All_GUI()	;HIDE ALL GUI
return

AutoClickCoordinates:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, PvP:Default
	MsgBox, 64, Select Coordinates, [BR] Clique com o botao ESQUERDO o mouse na posição onde voce quer auto clicar. `n`n[EN] LEFT-click to get coordinates for AutoClick.
	Get_Coordinates_Script("AutoClickPosX","AutoClickPosY")
	Hide_All_GUI()	;HIDE ALL GUI
RETURN

MoveItem_SelectStartPosition:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Timer:Default
	Portugues := "Clique com o botao ESQUERDO o mouse na posicao inicial para capturar coordenadas"
	English := "LEFT-click on the start position to get coordinates."
	MsgBox, 64, Select Coordinates, % %GlobalLanguage%
	Get_Coordinates_Script("Coord_MoveItem_StartPositionX","Coord_MoveItem_StartPositionY")
	Hide_All_GUI()	;HIDE ALL GUI
RETURN
MoveItem_SelectFinalPosition:
	Hide_All_GUI()	;HIDE ALL GUI
	Gui, Timer:Default
	Portugues := "Clique com o botao ESQUERDO o mouse na posicao final para capturar coordenadas"
	English := "LEFT-click on the final position to get coordinates."
	MsgBox, 64, Select Coordinates, % %GlobalLanguage%
	Get_Coordinates_Script("Coord_MoveItem_FinalPositionX","Coord_MoveItem_FinalPositionY")
	Hide_All_GUI()	;HIDE ALL GUI
RETURN

