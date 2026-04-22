Show_Gui_Healing:
	Gui, Healing:Show, % " w" 581 " h" 421, [Healing] %TrayName%	;NAME PROGRAMA
RETURN

Draw_Gui_Healing() {
    GLOBAL
	Load_Pre_Settings("Healing")
	Gui, Add, Tab, section x1 y1 w581 h421 , Healing|Adv. Options

	; [Healing] Tab ====================================================================
	; [Healing] Tab ====================================================================
	; [Healing] Tab ====================================================================
	Gui, Tab, Healing

	;~ ; [Delay to Healing]
	;~ switch TibiaServer {
		;~ case "OtServer"	:	DefaultDelayToHealing := 50
		;~ case "Global"	:	DefaultDelayToHealing := 50
		;~ Default:			DefaultDelayToHealing := 50
	;~ }

	;~ Gui, Font, Bold
		;~ Gui, Add, GroupBox, x480 y350 w90 h65 +Center, Delay to Healing
	;~ Gui, Font, Normal
	;~ Gui, Font, cRed
		;~ Gui, Add, Edit, x495 y367 w50 h20 +Right vDelayToHealing Number Limit4, %DefaultDelayToHealing% ;%DelayToHealing%
	;~ Gui, Font, cWhite
		;~ Gui, Add, Text, x546 y372 w20 h20, ms
		;~ Gui, Add, Text, x495 y392 w70 h20, Default= %DefaultDelayToHealing%ms

	;[Drop Flask]
	Gui, Font, Bold
		Gui, Add, CheckBox, x230 y370 w90 h20 vCheckBox_DropFlask, Drop Flask

	;~ ;[Utito Tempo San - ONLY RP]
	;~ if (Vocation == "Paladin") {
		;~ ;Gui, Add, GroupBox, x5 y345 w190 h65 +Center, Ignore Healing if Utito Tempo San
		;~ Gui, Add, CheckBox, x10 y370 w190 h25 vUtitoIgnoreHealing,Ignore Healing`nif Utito Tempo San
	;~ }
	Gui, Font, Normal


	; ===== [LIFE] AutoHealing =====
	Gui, Font, Bold
	Gui, Add, GroupBox, x5 y25 w550 h185 , [LIFE] AutoHealing	;[LIFE] AutoHealing
		Gui, Add, Text, x27 y50 w45 h15 +Center, Stages ;-40
		Gui, Add, Text, x90 y50 w50 h15 +Center, Health `%
		Gui, Add, Text, x160 y50 w50 h15 +Center, Mana `%
		Gui, Add, Text, x260 y35 w135 h14 +Center, ===== [Hotkeys] =====
		Gui, Add, Text, x260 y50 w60 h15 Center, Potions
		Gui, Add, Text, x329 y50 w60 h15 Center, Spell 1
		Gui, Add, Text, x450 y120 w60 h15 Center, Spell 2
	Gui, Font, Normal
		;Gui, Add, Text, x485 y70 w15 h15 Center, or

	; ===== [LIFE] Stage1 =====
		Gui, Add, CheckBox, x22 y65 w55 h30 vCheckBox_Life_Stage1, Stage1
		;~ Gui, Add, Slider, x122 y65 w130 h30 vPercent_Life_Stage1 gPercent_Life_Stage1 +Range0-20 +TickInterval2 AltSubmit, ;%Percent_Life_Stage1%
	Gui Font, cRed Bold
		Gui, Add, Edit, section x103 y70 w20 h20 vPercent_Health_Life_Stage1 Number Limit2, 95 ;%Percent_Life_Stage1%
		Gui, Add, Text, xs-10 ys+3 w10 h15 +Center, >
		Gui, Add, Text, xs+20 ys+3 w10 h15 +Center, `%
	Gui Font, cBlue
		Gui, Add, Edit, section x172 y70 w20 h20 vPercent_Mana_Life_Stage1 Number Limit2, 00  ;%Percent_Life_Stage3%
		Gui, Add, Text, xs-10 ys+3 w10 h15 +Center, >
		Gui, Add, Text, xs+20 ys+3 w10 h15 +Center, `%
	Gui, Font, cBlack Normal
		Gui, Add, Hotkey, SECTION x260 y68 w60 h20 vHotkey_Potion_Life_Stage1, ;DISABLE
		Gui, Add, Picture, xs-37 ys-5 w32 h32 gHealing_Settings, % "HBITMAP:* " Picture.HealthPotion
		Gui, Add, Hotkey, SECTION x330 y68 w60 h20 vHotkey_Spell_Life_Stage1
		Gui, Add, Picture, xs+65 ys-5 w32 h32, % "HBITMAP:* " Picture.LightHealing
	Gui, Font, cWhite

	; ===== [LIFE] Stage 2 =====
		Gui, Add, CheckBox, x22 y100 w55 h30 vCheckBox_Life_Stage2, Stage2
		;~ Gui, Add, Slider, x122 y100 w130 h30 vPercent_Life_Stage2 gPercent_Life_Stage2 +Range0-20 +TickInterval2 AltSubmit, ;%Percent_Life_Stage2%
	Gui Font, cRed Bold
		Gui, Add, Edit, section x103 y105 w20 h20 vPercent_Health_Life_Stage2 Number Limit2, 80 ;%Percent_Life_Stage2%
		Gui, Add, Text, xs-10 ys+3 w10 h15 +Center, >
		Gui, Add, Text, xs+20 ys+3 w10 h15 +Center, `%
	Gui Font, cBlue
		Gui, Add, Edit, section x172 y105 w20 h20 vPercent_Mana_Life_Stage2 Number Limit2, 00  ;%Percent_Life_Stage3%
		Gui, Add, Text, xs-10 ys+3 w10 h15 +Center, >
		Gui, Add, Text, xs+20 ys+3 w10 h15 +Center, `%
	Gui, Font, cBlack Normal
		Gui, Add, Hotkey, SECTION x260 y103 w60 h20 vHotkey_Potion_Life_Stage2, ;%Hotkey1_Life_Stage2%
		Gui, Add, Picture, xs-37 ys-5 w32 h32 gHealing_Settings, % "HBITMAP:* " Picture.StrongHealthPotion
		Gui, Add, Hotkey, SECTION x330 y103 w60 h20 vHotkey_Spell_Life_Stage2, ;%Hotkey2_Life_Stage2%
		Gui, Add, Picture, xs+65 ys-5 w32 h32, % "HBITMAP:* " Picture.IntenseHealing
	Gui, Font, cWhite

	; ===== [LIFE] Stage 3 =====
		Gui, Add, CheckBox, x22 y135 w55 h30 vCheckBox_Life_Stage3, Stage3
		;~ Gui, Add, Slider, x122 y135 w130 h30 vPercent_Life_Stage3 gPercent_Life_Stage3 +Range0-20 +TickInterval2 AltSubmit, ;%Percent_Life_Stage3%
	Gui Font, cRed Bold
		Gui, Add, Edit, section x103 y140 w20 h20 vPercent_Health_Life_Stage3 Number Limit2, 60  ;%Percent_Life_Stage3%
		Gui, Add, Text, xs-10 ys+3 w10 h15 +Center, >
		Gui, Add, Text, xs+20 ys+3 w10 h15 +Center, `%
	Gui Font, cBlue
		Gui, Add, Edit, section x172 y140 w20 h20 vPercent_Mana_Life_Stage3 Number Limit2, 00  ;%Percent_Life_Stage3%
		Gui, Add, Text, xs-10 ys+3 w10 h15 +Center, >
		Gui, Add, Text, xs+20 ys+3 w10 h15 +Center, `%
	Gui, Font, cBlack Normal
		Gui, Add, Hotkey, SECTION x260 y138 w60 h20 vHotkey_Potion_Life_Stage3, ;%Hotkey1_Life_Stage3%
		Gui, Add, Picture, xs-37 ys-5 w32 h32 gHealing_Settings, % "HBITMAP:* " Picture.GreatHealthPotion
		Gui, Add, Hotkey, SECTION x330 y138 w60 h20 vHotkey_Spell_Life_Stage3, ;%Hotkey2_Life_Stage3%
		Gui, Add, Picture, xs+65 ys-5 w32 h32, % "HBITMAP:* " Picture.UltimateHealing
		Gui, Add, Hotkey, SECTION x450 y138 w60 h20 vHotkey_Others_Life_Stage3, ;%Hotkey3_Life_Stage3%
		Gui, Add, Picture, xs+65 ys-5 w32 h32, % "HBITMAP:* " Picture.HealingSpells
	Gui, Font, cWhite

	; ===== [LIFE] Stage 4 =====
		Gui, Add, CheckBox, x22 y170 w55 h30 vCheckBox_Life_Stage4, Stage4
		;~ Gui, Add, Slider, x122 y170 w130 h30 vPercent_Life_Stage4 gPercent_Life_Stage4 +Range0-20 +TickInterval2 AltSubmit, ;%Percent_Life_Stage4%
	Gui Font, cRed Bold
		Gui, Add, Edit, SECTION x103 y175 w20 h20 vPercent_Health_Life_Stage4 Number Limit2, 40 ;%Percent_Life_Stage4%
		Gui, Add, Text, xs-10 ys+3 w10 h15 +Center, >
		Gui, Add, Text, xs+20 ys+3 w10 h15 +Center, `%
	Gui Font, cBlue
		Gui, Add, Edit, SECTION x172 y175 w20 h20 vPercent_Mana_Life_Stage4 Number Limit2, 00 ;%Percent_Life_Stage4%
		Gui, Add, Text, xs-10 ys+3 w10 h15 +Center, >
		Gui, Add, Text, xs+20 ys+3 w10 h15 +Center, `%
	Gui, Font, cBlack Normal
		Gui, Add, Hotkey, SECTION x260 y173 w60 h20 vHotkey_Potion_Life_Stage4, ;%Hotkey1_Life_Stage4%
		Gui, Add, Picture, xs-37 ys-5 w32 h32 gHealing_Settings, % "HBITMAP:* " Picture.UltimateHealthPotion
		Gui, Add, Hotkey, SECTION x330 y173 w60 h20 vHotkey_Spell_Life_Stage4, ;%Hotkey2_Life_Stage4%
		Gui, Add, Picture, xs+65 ys-5 w32 h32, % "HBITMAP:* " Picture.Restoration
		Gui, Add, Hotkey, SECTION x450 y173 w60 h20 vHotkey_Others_Life_Stage4, ;%Hotkey3_Life_Stage4%
		Gui, Add, Picture, xs+65 ys-5 w32 h32, % "HBITMAP:* " Picture.HealingSpells
	Gui, Font, cWhite



	; ===== [MANA] AutoHealing =====
	Gui, Font, Bold
		Gui, Add, GroupBox, x5 y220 w550 h125 , [MANA] AutoHealing
		Gui, Add, Text, x72 y245 w45 h15 , Stages
		Gui, Add, Text, x122 y245 w130 h20 +Center, Mana `%
		;Gui, Add, Text, x260 y230 w60 h14 +Center, [Hotkey]
		Gui, Add, Text, x260 y245 w60 h15 Center, Hotkey
		switch GlobalLanguage {
			case "Portugues": 	Gui, Add, Text, x360 y285 w130 h20 +Center vTextIgnoreMana, Ignorar Mana se HP<
			case "English": 	Gui, Add, Text, x360 y285 w130 h20 +Center vTextIgnoreMana, Ignore Mana if HP<
		}

	Gui, Font, Normal
	; ===== [MANA] Stage 1 =====
		Gui, Add, Picture, x27 y259 w32 h32 gHealing_Settings, % "HBITMAP:* " Picture.ManaPotion
		Gui, Add, CheckBox, x62 y260 w55 h30 vCheckBox_Mana_Stage1, Stage1
		;~ Gui, Add, Slider, x122 y260 w130 h30 vPercent_Mana_Stage1 gPercent_Mana_Stage1 +Range0-20 +TickInterval2 AltSubmit, ;%Percent_Mana_Stage1%
	Gui, Font, cBlue Bold
		Gui, Add, Edit, SECTION x177 y266 w20 h20 vPercent_Mana_Stage1 Number Limit2, 75 ;%Percent_Mana_Stage1%
		Gui, Add, Text, xs-10 ys+3 w10 h15 +Center, >
		Gui, Add, Text, xs+20 ys+3 w10 h15 +Center, `%
	Gui, Font, cBlack Normal
		Gui, Add, Hotkey, x260 y266 w60 h20 vHotkey_Potion_Mana_Stage1, ;%Hotkey_Mana_Stage1%
	Gui, Font, cWhite
	; ===== [MANA] Stage 2 =====
		Gui, Add, Picture, x27 y294 w32 h32 gHealing_Settings, % "HBITMAP:* " Picture.StrongManaPotion
		Gui, Add, CheckBox, x62 y295 w55 h30 vCheckBox_Mana_Stage2, Stage2
		;~ Gui, Add, Slider, x122 y295 w130 h30 vPercent_Mana_Stage2 gPercent_Mana_Stage2 +Range0-20 +TickInterval2 AltSubmit, ;%Percent_Mana_Stage2%
	Gui, Font, cBlue Bold
		Gui, Add, Edit, SECTION x177 y301 w20 h20 vPercent_Mana_Stage2 Number Limit2, 50 ;%Percent_Mana_Stage2%
		Gui, Add, Text, xs-10 ys+3 w10 h15 +Center, >
		Gui, Add, Text, xs+20 ys+3 w10 h15 +Center, `%
	Gui, Font, cBlack Normal
		Gui, Add, Hotkey, x260 y301 w60 h20 vHotkey_Potion_Mana_Stage2, ;%Hotkey_Mana_Stage2%


	;[ignore mana if hp% < x%]
	;~ Gui, Add, Slider, x360 y285 w130 h30 vPercent_IgnoreMana_Stage1 gPercent_IgnoreMana_Stage1 +Range0-20 +TickInterval2 AltSubmit, ;%Percent_IgnoreMana_Stage1%
	Gui, Font, cRed Bold
	Gui, Add, Edit, SECTION x487 y282 w20 h20 vPercent_IgnoreMana_Stage1 Number Limit2, 5 ;%Percent_IgnoreMana_Stage1%
	Gui, Add, Text, xs+20 ys+3 w10 h15 vText_Percent_IgnoreMana_Stage1 +Center, `%
	Gui, Font, cWhite Normal
	if (Vocation == "Druid" or Vocation == "Sorcerer") {
		GuiControl,, Percent_IgnoreMana_Stage1, 1
		GuiControlGet, Percent_IgnoreMana_Stage1
		GuiControl, Hide, Percent_IgnoreMana_Stage1
		GuiControl, Hide, TextIgnoreMana
		GuiControl, Hide, Text_Percent_IgnoreMana_Stage1
	}	;pra não bugar com as vocações que nao tem o ignore mana


	; ==================== [ADV. OPTIONS] ====================
	Gui, Tab, Adv. Options
	Portugues := "Nao utilizar Healing Stage1 se Combo ON"
	English := "Dont Use Healing Stage1 if Combo ON"
	Gui, Add, CheckBox, x10 y25 h160 h20 vCheckBox_Dont_Use_Healing1_if_Combo_ON, % %GlobalLanguage%



}


DropFlask(){
	GLOBAL
	ElapsedTime_DropFlask := A_TickCount - StartTime_DropFlask
	GuiControlGet, CheckBox_DropFlask, Healing:
	if (CheckBox_DropFlask == 1 && ElapsedTime_DropFlask > 350) {
		DP++
		if DP is not number
			DP := 1
		if (DP > 3) {
			DP := 1
		}

		PrintScreenData()
		GuiControlGet, LooterSQM_9X, Looter:
		GuiControlGet, LooterSQM_9Y, Looter:

		if (DP = 1) {
			SearchPNG(PNG.FlaskMedium, 0,0,Cords.GameBorda_LeftBottom.2,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ControlClick(Erro.2,Erro.3, WhichButton:="LEFT", fix_coordinates:=true, ghost_mouse:=true, state:="D")
				ControlClick(LooterSQM_9X,LooterSQM_9Y, WhichButton:="LEFT", fix_coordinates:=false, ghost_mouse:=true, state:="U")
				;~ Sleep, 300
				PrintScreenData()
				StartTime_DropFlask := A_TickCount
			}
			SearchPNG(PNG.FlaskMedium, Cords.GameBorda_RightTop.2,0,WindowInfo.Client.w,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ControlClick(Erro.2,Erro.3, WhichButton:="LEFT", fix_coordinates:=true, ghost_mouse:=true, state:="D")
				ControlClick(LooterSQM_9X,LooterSQM_9Y, WhichButton:="LEFT", fix_coordinates:=false, ghost_mouse:=true, state:="U")
				;~ Sleep, 300
				PrintScreenData()
				StartTime_DropFlask := A_TickCount
			}
		}

		if (DP = 2) {
			SearchPNG(PNG.FlaskLarge, 0,0,Cords.GameBorda_LeftBottom.2,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ControlClick(Erro.2,Erro.3, WhichButton:="LEFT", fix_coordinates:=true, ghost_mouse:=true, state:="D")
				ControlClick(LooterSQM_9X,LooterSQM_9Y, WhichButton:="LEFT", fix_coordinates:=false, ghost_mouse:=true, state:="U")
				;~ Sleep, 300
				PrintScreenData()
				StartTime_DropFlask := A_TickCount
			}
			SearchPNG(PNG.FlaskLarge, Cords.GameBorda_RightTop.2,0,WindowInfo.Client.w,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ControlClick(Erro.2,Erro.3, WhichButton:="LEFT", fix_coordinates:=true, ghost_mouse:=true, state:="D")
				ControlClick(LooterSQM_9X,LooterSQM_9Y, WhichButton:="LEFT", fix_coordinates:=false, ghost_mouse:=true, state:="U")
				;~ Sleep, 300
				PrintScreenData()
				StartTime_DropFlask := A_TickCount
			}
		}

		if (DP = 3) {
			SearchPNG(PNG.FlaskSmall, 0,0,Cords.GameBorda_LeftBottom.2,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ControlClick(Erro.2,Erro.3, WhichButton:="LEFT", fix_coordinates:=true, ghost_mouse:=true, state:="D")
				ControlClick(LooterSQM_9X,LooterSQM_9Y, WhichButton:="LEFT", fix_coordinates:=false, ghost_mouse:=true, state:="U")
				;~ Sleep, 300
				StartTime_DropFlask := A_TickCount
			}
			SearchPNG(PNG.FlaskSmall, Cords.GameBorda_RightTop.2,0,WindowInfo.Client.w,WindowInfo.Client.h, Tole:=5 , Erro, Mode:=1)
			if (Erro.1 == 1) {
				ControlClick(Erro.2,Erro.3, WhichButton:="LEFT", fix_coordinates:=true, ghost_mouse:=true, state:="D")
				ControlClick(LooterSQM_9X,LooterSQM_9Y, WhichButton:="LEFT", fix_coordinates:=false, ghost_mouse:=true, state:="U")
				;~ Sleep, 300
				StartTime_DropFlask := A_TickCount
			}
		}

		StartTime_DropFlask := A_TickCount
	}
}



; GUI_SETTINGS (DEPRECATED)
Healing_Settings:
	if (A_GuiEvent = "DoubleClick") {
		Create_Gui_Settings("Healing")
	}
RETURN
Healing_Settings_OnClose:
	Gui_Settings_OnClose("Healing")
return
Healing_Settings_Default:	;disable gui control button
	Gui_Settings_ButtonSetDefault("Healing")
RETURN
Healing_Settings_GetCoord:
	Gui_Settings_ButtonGetCoord("Healing")
RETURN
Healing_Settings_GetNewImage:
	Gui, Healing_Settings:Destroy
	Gui, -AlwaysOnTop
	MsgBox, Coming Soon!
	Gui, +AlwaysOnTop
RETURN


