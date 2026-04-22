
Timer_Hotkey(){
    GLOBAL
	Gui, Timer:Default
	i := 0
	Loop, 4 {
		i++
		GuiControlGet, Hotkey%i%TimerCheckBox
		GuiControlGet, Hotkey%i%TimerDelay
		ElapsedTime_Timer%i% := A_TickCount - StartTime_Timer%i%
		if (ElapsedTime_Timer%i% > Hotkey%i%TimerDelay && Hotkey%i%TimerCheckBox == 1) {
			KeyWait, Control
			KeyWait, Shift
			if (Timer%i%Type == "Mouse") {	
				GuiControlGet, Timer%i%X
				GuiControlGet, Timer%i%Y
				ControlClick(Timer%i%X,Timer%i%Y,		WhichButton:="LEFT",fix_coordinates:=false,ghost_mouse:=true)

			} else {				
				tmpHotkey := "Hotkey" i "TimerHotkey"
				Press_Key(tmpHotkey)
				StartTime_Timer%i% := A_TickCount
			}
		}
	}

	; [Move Item]
	Gui, Timer:Default
	GuiControlGet, CheckBox_MoveItem
	GuiControlGet, Delay_MoveItem
	if StartTime_MoveItem is not number
		StartTime_MoveItem := -1
	ElapsedTime_MoveItem := (A_TickCount - StartTime_MoveItem)/1000
	if (CheckBox_MoveItem && ElapsedTime_MoveItem >= Delay_MoveItem) {
		GuiControlGet, Coord_MoveItem_StartPositionX
		GuiControlGet, Coord_MoveItem_StartPositionY
		GuiControlGet, Coord_MoveItem_FinalPositionX
		GuiControlGet, Coord_MoveItem_FinalPositionY
		ControlClick(Coord_MoveItem_StartPositionX,Coord_MoveItem_StartPositionY,		WhichButton:="LEFT",fix_coordinates:=false,ghost_mouse:=true,	state:="D")
		ControlClick(Coord_MoveItem_FinalPositionX,Coord_MoveItem_FinalPositionY,		WhichButton:="LEFT",fix_coordinates:=false,ghost_mouse:=true,	state:="U")
		StartTime_MoveItem := A_TickCount

		ControlClick(Coord_MoveItem_StartPositionX,Coord_MoveItem_StartPositionY,		WhichButton:="RIGHT",fix_coordinates:=false,ghost_mouse:=true)	;open next bp
	}
}
Exercise_AutoTrainer(){
    GLOBAL
	Gui, Timer:Default
	GuiControlGet, ExerciseTrainingCheckBox
	if (ExerciseTrainingCheckBox == 0 or WinActive!("ahk_id" . active_id) ) {
		ToolTip,,,, 5
	}
	;[Começa a contar]
	ExerciseTimer := Round( (A_TickCount - StartTimeTimer)/1000 )	;format time ms to second
	if (ExerciseTrainingCheckBox == 1) {
		GuiControlGet, ExerciseTrainingX
		GuiControlGet, ExerciseTrainingY
		if ( WinActive("ahk_id" . active_id) ) {	;tooltip apenas se o tibia tiver ativo
			;~ GuiControlGet, LooterSQM_9X, Looter:
			;~ GuiControlGet, LooterSQM_9Y, Looter:
			ToolTip(ExerciseTimer, Time:=-1000, X:=ExerciseTrainingX+5, Y:=ExerciseTrainingY+5, WhichToolTip:=04)
		}
		GuiControlGet, TimeExerciseTraining
		if (ExerciseTimer >= TimeExerciseTraining && (TimeExerciseTraining != 0 or Enable_Exercise_Reconnect == true)) {
			;~ if (TimeExerciseTraining == 0) {
				;~ Sleep 2500
			;~ }
			;[Start Trainer]
			GuiControlGet, HotkeyExercise
			if (HotkeyExercise = "" && false) {	;dev-only: split fishing rod
				SearchPNG(PNG.FishingRod, 0,0,Cords.GameBorda_LeftBottom.2,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
				if (Erro.1 == 1) {
					ControlClick(Erro.2,Erro.3,"RIGHT",fix_coordinates:=true,ghost_mouse:=true,state:="",zKeyWait:=true)
					Sleep 150
					ControlClick(ExerciseTrainingX,ExerciseTrainingY,WhichButton:="LEFT",fix_coordinates:=false,ghost_mouse:=true,state:="",zKeyWait:=true)
				}
				SearchPNG(PNG.FishingRod, Cords.GameBorda_RightTop.2,0,WindowInfo.Client.w,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
				if (Erro.1 == 1) {
					ControlClick(Erro.2,Erro.3,"RIGHT",fix_coordinates:=true,ghost_mouse:=true,state:="",zKeyWait:=true)
					Sleep 150
					ControlClick(ExerciseTrainingX,ExerciseTrainingY,WhichButton:="LEFT",fix_coordinates:=false,ghost_mouse:=true,state:="",zKeyWait:=true)
				}
			} else {
				Press_Key("HotkeyExercise")
				Press_Key("HotkeyExercise")
				Sleep 150
				ControlClick(ExerciseTrainingX,ExerciseTrainingY,WhichButton:="LEFT",fix_coordinates:=false,ghost_mouse:=true,state:="",zKeyWait:=true)
			}

			StartTimeTimer := A_TickCount	;reseta contagem
			Enable_Exercise_Reconnect := false ;reconnect exercise
		}
	}

}
ReloadAmmo(){
    GLOBAL
	Gui, Support:Default
	GuiControlGet, CheckBox_ConjureArrow
	GuiControlGet, CheckBox_EquipArrow
	if StartTime_ReloadAmmo is not number
		StartTime_ReloadAmmo := -1
	ElapsedTime_ReloadAmmo := A_TickCount - StartTime_ReloadAmmo
	if ( (CheckBox_ConjureArrow == 1 or CheckBox_EquipArrow == 1) && ElapsedTime_ReloadAmmo > 1500) {
		;~ StartTime_RefillAmmo := A_TickCount

		;~ Crop_And_Save_Haystack(Cords.Con.2+77, Cords.Con.3-71,4,8)
		;~ Crop_And_Save_Haystack(Cords.Con.2+84, Cords.Con.3-71,6,8)


		SearchPNG(PNG.QuiverOCR.5, Cords.Con.2+84, Cords.Con.3-71, Cords.Con.2+90, Cords.Con.3-63, Tole:=5, Erro, Mode:=1),	Data.QuiverOCR5:=Erro
		SearchPNG(PNG.QuiverOCR.6, Cords.Con.2+84, Cords.Con.3-71, Cords.Con.2+90, Cords.Con.3-63, Tole:=5, Erro, Mode:=1),	Data.QuiverOCR6:=Erro
		SearchPNG(PNG.QuiverOCR.1, Cords.Con.2+77, Cords.Con.3-71, Cords.Con.2+81, Cords.Con.3-63, Tole:=5, Erro, Mode:=1),	Data.QuiverOCR1:=Erro
		if (Data.QuiverOCR6.1 == 0 && Data.QuiverOCR1.1 == 0 && Data.QuiverOCR5.1 == 0) {
			Verify_Cap()
			if (OCR_Cap > 80) {
				if (CheckBox_EquipArrow == 1) {
					Press_Key("Hotkey_EquipArrow")
					Sleep 50
				}
				if (CheckBox_ConjureArrow == 1) {
					Press_Key("Hotkey_ConjureArrow")
					Sleep 50
				}
				if (CheckBox_EquipArrow == 1) {
					Press_Key("Hotkey_EquipArrow")
					Sleep 50
				}
			}

		}



		StartTime_ReloadAmmo := A_TickCount
		;~ ElapsedTime_RefillAmmo := A_TickCount - StartTime_RefillAmmo
		;~ TOOLTIP % ElapsedTime_RefillAmmo
	}

}
Mana_Burn(){
    GLOBAL
	Gui, Timer:Default
	GuiControlGet, CheckBox_Mana_Burn
	GuiControlGet, Percent_Mana_Burn
	ElapsedTime_Mana_Burn := A_TickCount - StartTime_Mana_Burn
	if (CheckBox_Mana_Burn == 1 && Data.MP > Percent_Mana_Burn && ElapsedTime_Mana_Burn > 500) {
		Press_Key("Hotkey_Mana_Burn")
		StartTime_Mana_Burn := A_TickCount
	}
}
Reconnect(){
    GLOBAL
	Gui, Timer:Default
	GuiControlGet, ReconnectTimer
	GuiControlGet, ReconnectCheckBox
	ElapsedTime_Reconnect := A_TickCount - StartTime_Reconnect
	if (ReconnectCheckBox == 1 && ElapsedTime_Reconnect > ReconnectTimer*1000) {

		Remove_All_Tooltips()	;remove tooltip do reonnect na label CheckOBS
		;[Login Screen]
		SearchPNG(PNG.LoginDetails, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, LoginDetails, Mode:=1)
		SearchPNG(PNG.WrongAccPass, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, WrongAccPass, Mode:=1)
		if (LoginDetails.1 == 1 || WrongAccPass.1 == 1){
			GuiControlGet, Reconnect_Password
			Send_Text(Reconnect_Password, 500)
			Return
		}

		;[Ok Button]
		SearchPNG(PNG.ConnectionFailed, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, ConnectionFailed, Mode:=1)
		SearchPNG(PNG.ConnectionLost, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, ConnectionLost, Mode:=1)
		SearchPNG(PNG.SorryError, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, SorryError, Mode:=1)
		SearchPNG(PNG.SelectCharacter, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, SelectCharacter, Mode:=1)
		;~ MSGBOX % ConnectionFailed.1 " | " ConnectionLost.1 " | " SorryError.1 " | " SelectCharacter.1
		If (ConnectionFailed.1 == 1 || ConnectionLost.1 == 1 || SorryError.1 == 1 || SelectCharacter.1 == 1) {
			SearchPNG(PNG.Ok, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Ok, Mode:=1)
			if (Ok.1 == 1) {
				ControlClick(Ok.2+5,Ok.3+5)
				StartTimeTimer := -9999	;bater exercise
				Enable_Exercise_Reconnect := true
			} else {
				ControlSend,, {Enter}, ahk_id %active_id% ;ahk_group Tibia
			}
			StartTime_Reconnect := A_TickCount
			Return
		}


	}
}
