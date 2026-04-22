Draw_Gui_TankMode() {
    GLOBAL
	Load_Pre_Settings("TankMode")

	Gui, Add, Tab, x1 y1 w650 h450, TankMode|Adv. Options
	; [TankMode] Tab ====================================================================
	; [TankMode] Tab ====================================================================
	; [TankMode] Tab ====================================================================

	Gui, Tab, TankMode
	if (true) {
		Gui, Font, Bold
			Gui, Add, GroupBox, x5 y25 w640 h220, [LIFE] TankMode
			Gui, Add, Text, x207 y55 w130 h20 +Center, Health `%
			Gui, Add, Text, x347 y55 w60 h20 +Center, Hotkey
			Gui, Add, Text, x532 y160 w60 h20 +Center vText_Hotkey_UtamoPotion, Hotkey	;UTAMO POTION x432 y180 w60 h20
			Gui, Add, Text, x448 y55 w85 h15 +Center, Key to Active
			;~ Gui, Add, Text, x355 y55 w60 h20 +Center, KeyBoard
			;~ Gui, Add, Text, x440 y55 w85 h20 Center, Mouse/Others
			Gui, Add, Text, x560 y45 w75 h25 +Center, Remove Automatically
		Gui, Font, Normal
			;~ Gui, Add, Text, x423 y77 w15 h15, or
			;~ Gui, Add, Text, x423 y112 w15 h15, or


		;~ ; [ DELAY TANKMODE ]
		;~ defaultDelayTankMode := 100 ; default is 100ms


		;~ Gui, Font, Bold
			;~ Gui, Add, GroupBox, x530 y155 w90 h65 +Center, Delay to Equip
		;~ Gui, Font, Normal
		;~ Gui, Font, cRed
			;~ Gui, Add, Edit, x545 y172 w50 h20 +Right vDelayTankMode Number Limit4, ;%DelayTankMode%
		;~ Gui, Font, cWhite
			;~ Gui, Add, Text, x596 y177 w20 h20, ms
			;~ Gui, Add, Text, x535 y197 w80 h20, Default= %defaultDelayTankMode%ms


		;[ Remove Automatically ]
			Gui, Add, CheckBox, x575 y75 w50 h20 vHP_RemoveAutomaticallySSA, SSA
			Gui, Add, CheckBox, x575 y110 w50 h20 vHP_RemoveAutomaticallyMight, Might


		; ===== [LIFE] SSA =====
			Gui, Add, Picture, x17 y65 w32 h32 vPicture_TankModeLife_Amulet, % "HBITMAP:* " Picture.SSA
			Gui, Add, CheckBox, section x52 y65 w15 h32 vSSA_Life
			Gui, Add, DropDownList, xs+17 ys+5 w125 r10 Choose1 vDropDownList_TankModeLife_Amulet gRefresh_All_Images_GUI_TankMode, % Amulets
			Gui Font, cRed Bold
				Gui, Add, Edit, xs+225 ys+6 w20 h20 vPercent_SSA_Life Number Limit2, 95 ;%Percent_Life_Stage1%
				Gui, Add, Text, xs+185 ys+9 w35 h15 +Center, HP <=
				Gui, Add, Text, xs+245 ys+9 w10 h15 +Center, `%
		Gui, Font, cBlack Normal
			Gui, Add, Hotkey, xs+295 ys+6 w60 h20 vHotkey_SSA_Life, 	 ;%Hotkey_SSA_Life%
			Gui, Add, Hotkey, xs+408 ys+6 w60 h20 vKey_Enable_SSA_Life, ;%Key_Enable_SSA_Life%
		Gui, Font, cWhite
			;~ Gui, Add, DropDownList, x560 y75 w85 h20 vMouse_Enable_SSA_Life r5, Nothing|WheelUp|WheelDown|XButton1|XButton2

		; ===== [LIFE] Might Ring =====
			Gui, Add, Picture, x17 y100 w32 h32 vPicture_TankModeLife_Ring, % "HBITMAP:* " Picture.MightRing
			Gui, Add, CheckBox, section x52 y100 w15 h32 vMightRing_Life
			Gui, Add, DropDownList, xs+17 ys+5 w125 r10 Choose1 vDropDownList_TankModeLife_Ring gRefresh_All_Images_GUI_TankMode, % Rings
			Gui Font, cRed Bold
				Gui, Add, Edit, xs+225 ys+6 w20 h20 vPercent_MightRing_Life Number Limit2, 50 ;%Percent_Life_Stage1%
				Gui, Add, Text, xs+185 ys+9 w35 h15 +Center, HP <=
				Gui, Add, Text, xs+245 ys+9 w10 h15 +Center, `%
		Gui Font, cBlack Normal
			Gui, Add, Hotkey, xs+295 ys+6 w60 h20 vHotkey_MightRing_Life, ;%Hotkey_MightRing_Life%
			Gui, Add, Hotkey, xs+408 ys+6 w60 h20 vKey_Enable_MightRing_Life, ;%Key_Enable_MightRing_Life%
		Gui Font, cWhite
		;~ Gui, Add, DropDownList, x440 y110 w85 h20 vMouse_Enable_MightRing_Life r5, Nothing|WheelUp|WheelDown|XButton1|XButton2

		; ===== [LIFE] Food =====
			Gui, Add, Picture, x17 y135 w32 h32 , % "HBITMAP:* " Picture.Rotworm_Stew
			Gui, Add, CheckBox, section x52 y135 w165 h32 vFood_Life, Special Food ==========>
			Gui Font, cRed Bold
				Gui, Add, Edit, xs+225 ys+6 w20 h20 vPercent_Food_Life Number Limit2, 50 ;%Percent_Life_Stage1%
				Gui, Add, Text, xs+185 ys+9 w35 h15 +Center, HP <=
				Gui, Add, Text, xs+245 ys+9 w10 h15 +Center, `%
		Gui Font, cBlack Normal
			Gui, Add, Hotkey, xs+295 ys+6 w60 h20 vHotkey_Food_Life, ;%Hotkey_Food_Life%
		Gui Font, cWhite


		; ===== [Life] Utamo Vita =====
		if (Vocation == "Druid" or Vocation == "Sorcerer") {
			;[UTAMO VITA SPELL]
			Gui, Add, Picture, x17 y170 w32 h32 vPictureUtamoVita, % "HBITMAP:* " Picture.UtamoVita
			Gui, Add, CheckBox, section x52 y170 w145 h32 vUtamoVita_Life, Utamo Vita ==========>
			Gui Font, cRed Bold
				Gui, Add, Edit, xs+225 ys+6 w20 h20 vPercent_UtamoVita_Life Number Limit2, 50 ;%Percent_Life_Stage1%
				Gui, Add, Text, xs+185 ys+9 w35 h15 +Center, HP <=
				Gui, Add, Text, xs+245 ys+9 w10 h15 +Center, `%
			Gui, Font, cBlack Normal
				Gui, Add, Hotkey, x347 y180 w60 h20 vHotkey_UtamoVita_Life, ;%Hotkey_UtamoVita_Life%
			Gui, Font, cWhite

			Gui, Add, Button, x442 y216 w140 h20 vNewUtamoVitaTankMode gActiveOldUtamoVita, Change to NEW Utamo Vita
			GuiControl, Hide, NewUtamoVitaTankMode
			Gui, Add, Button, x442 y216 w140 h20 vEnergyRingTankMode gActiveOldUtamoVita, Change to Energy Ring

			;[UTAMO POTION]
			Gui, Add, Picture, x442 y170 w32 h32 vPictureUtamoVitaPotion, % "HBITMAP:* " Picture.ManaShieldPotion
			Gui, Add, CheckBox, x477 y170 w55 h33 vUtamoVitaPotion_Life, Utamo Potion
			Gui, Add, Hotkey, x532 y180 w60 h20 vHotkey_UtamoVitaPotion_Life, ;%Hotkey_UtamoVitaPotion_Life%

			;[BREAK UTAMO]
			Gui, Add, Picture, x17 y205 w32 h32 vPicture_Cancel_Magic_Shield, % "HBITMAP:* " Picture.CancelUtamoVita
			Gui, Add, CheckBox, section x52 y205 w145 h32 vBreak_Utamo_CheckBox, Break Utamo =========>
			Gui Font, cRed Bold
				Gui, Add, Edit, xs+225 ys+6 w20 h20 vBreak_Utamo_Percent Number Limit2, 50 ;%Percent_Life_Stage1%
			Gui, Font, cBlack Normal
				Gui, Add, Hotkey, x347 y215 w60 h20 vBreak_Utamo_Hotkey,
			Gui, Font, cWhite
		}

		; ===== [Life] Energy Ring =====
		if (true) {
			; [ Equip Energy Ring ]
				Gui, Add, Picture, x17 y170 w32 h32 vPictureEnergyRing, % "HBITMAP:* " Picture.EnergyRing
				Gui, Add, CheckBox, section x52 y170 w145 h32 vEnergyRing_Life, Energy Ring =========>
				Gui Font, cRed Bold
					Gui, Add, Edit, xs+225 ys+6 w20 h20 vPercent_EnergyRing_Life Number Limit2, 50 ;%Percent_Life_Stage1%
					Gui, Add, Text, xs+185 ys+9 w35 h15 +Center, HP <=
					Gui, Add, Text, xs+245 ys+9 w10 h15 +Center, `%
			Gui Font, cBlack Normal
				Gui, Add, Hotkey, xs+295 ys+6 w60 h20 vHotkey_EnergyRing_Life, ;%Hotkey_EnergyRing_Life%
			Gui Font, cWhite

			;[ Remove Energy ]
				Gui, Add, Picture, x17 y205 w32 h32 vPicture_Remove_EnergyRing, % "HBITMAP:* " Picture.Remove_EnergyRing
				Gui, Add, CheckBox, section x52 y205 w145 h33 vRemove_EnergyRing_CheckBox, Remove Energy ======>
				Gui Font, cRed Bold
					Gui, Add, Edit, xs+225 ys+6 w20 h20 vRemove_EnergyRing_Percent Number Limit2, 50 ;%Percent_Life_Stage1%
					Gui, Add, Text, xs+185 ys+9 w35 h15 +Center, HP <=
					Gui, Add, Text, xs+245 ys+9 w10 h15 +Center, `%
			Gui Font, cBlack Normal
				Gui, Add, Hotkey, xs+295 ys+6 w60 h20 vRemove_EnergyRing_Hotkey,
			Gui Font, cWhite

			;fix bug gui OldUtamoVita
			if (Vocation == "Druid" or Vocation == "Sorcerer") {
				GuiControl, Hide, PictureEnergyRing ;Hide Picture Energy Ring
				GuiControl, Hide, EnergyRing_Life ;Hide CheckBox Energy Ring
				GuiControl, Hide, Percent_EnergyRing_Life ;Hide Slider Energy Ring
				GuiControl, Hide, Hotkey_EnergyRing_Life ;Hide Hotkey Energy Ring

				GuiControl, Hide, Picture_Remove_EnergyRing ;Hide Picture REMOVE Energy Ring
				GuiControl, Hide, Remove_EnergyRing_CheckBox ;Hide CheckBox REMOVE Energy Ring
				GuiControl, Hide, Remove_EnergyRing_Percent ;Hide Slider REMOVE Energy Ring
				GuiControl, Hide, Remove_EnergyRing_Hotkey ;Hide Hotkey REMOVE Energy Ring
			} else {
				GuiControl, Hide, Text_Hotkey_UtamoPotion ;Hide TEXT UTAMO POTION (FOR PALADIN)
			}

		}

		; ===== [Life] Utamo Tempo =====
		if (Vocation == "Knight") {
			; [ Utamo Tempo Spell ]
				Gui, Add, Picture, section x510 y140 w32 h32 , % "HBITMAP:*" Picture.UtamoTempo
				Gui, Add, CheckBox, xs-25 ys+35 w90 h20 vCheckBox_TankMode_UtamoTempo, Utamo Tempo
				Gui Font, cRed Bold
					Gui, Add, Text, xs-15 ys+58 w35 h15 +Center, HP <=
					Gui, Add, Edit, xs+22 ys+55 w20 h20 vPercent_TankMode_UtamoTempo Number Limit2, 50 ;%Percent_Life_Stage1%
					Gui, Add, Text, xs+43 ys+58 w10 h15 +Center, `%
			Gui Font, cWhite Normal
				Gui, Add, Text, xs-30 ys+80 w40 h20, Hotkey:
				Gui, Add, Hotkey, xs+10 ys+78 w60 h20 vHotkey_TankMode_UtamoTempo

		}

		;MANA TANKMODE GROUP BOX
		if (true) {	;Vocation != "Knight"

		Gui, Font, Bold
			Gui, Add, GroupBox, section x5 y255 w640 h180 , [MANA] TankMode
			Gui, Add, Text, x207 y280 w130 h15 +Center, Mana `%
			Gui, Add, Text, x347 y280 w60 h15 +Center, Hotkey
			Gui, Add, Text, x448 y280 w85 h15 Center, Key to Active
			;~ Gui, Add, Text, x325 y280 w60 h20 Center, KeyBoard
			;~ Gui, Add, Text, x410 y280 w85 h20 Center, Mouse/Others
			Gui, Add, Text, x560 y270 w73 h25 +Center, Remove Automatically
		Gui, Font, Normal
			;~ Gui, Add, Text, x393 y302 w15 h15, or
			;~ Gui, Add, Text, x393 y337 w15 h15, or

			;[ Remove Automatically ]
			Gui, Add, CheckBox, x575 y300 w50 h20 vMP_RemoveAutomaticallySSA, SSA
			Gui, Add, CheckBox, x575 y335 w50 h20 vMP_RemoveAutomaticallyMight, Might

			; ===== [MANA] SSA =====
			Gui, Add, Picture, section xs+12 ys+35 w32 h32 vPicture_TankModeMana_Amulet, % "HBITMAP:* " Picture.SSA
			Gui, Add, CheckBox, xs+35 ys w15 h32 vSSA_Mana
			Gui, Add, DropDownList, xs+52 ys+5 w125 r10 Choose1 vDropDownList_TankModeMana_Amulet gRefresh_All_Images_GUI_TankMode, % Amulets
			Gui Font, cBlue Bold
					Gui, Add, Edit, xs+260 ys+6 w20 h20 vPercent_SSA_Mana Number Limit2, 50 ;%Percent_Life_Stage1%
					Gui, Add, Text, xs+217 ys+9 w40 h15 +Center, MP <=
					Gui, Add, Text, xs+280 ys+9 w10 h15 +Center, `%
		Gui Font, cBlack Normal
			Gui, Add, Hotkey, xs+330 ys+6 w60 h20 vHotkey_SSA_Mana, ;%Hotkey_SSA_Mana%
			Gui, Add, Hotkey, xs+443 ys+6 w60 h20 vKey_Enable_SSA_Mana, ;%Key_Enable_SSA_Mana%
			;~ Gui, Add, DropDownList, x410 y300 w85 h20 vMouse_Enable_SSA_Mana r5, Nothing|WheelUp|WheelDown|XButton1|XButton2
		Gui Font, cWhite

			; ===== [MANA] MIGHT RING =====
			Gui, Add, Picture, section xs ys+35 w32 h32 vPicture_TankModeMana_Ring, % "HBITMAP:* " Picture.MightRing
			Gui, Add, CheckBox, xs+35 ys w15 h32 vMightRing_Mana
			Gui, Add, DropDownList, xs+52 ys+5 w125 r10 Choose1 vDropDownList_TankModeMana_Ring gRefresh_All_Images_GUI_TankMode, % Rings
			Gui Font, cBlue Bold
					Gui, Add, Edit, xs+260 ys+6 w20 h20 vPercent_MightRing_Mana Number Limit2, 50 ;%Percent_Life_Stage1%
					Gui, Add, Text, xs+217 ys+9 w40 h15 +Center, MP <=
					Gui, Add, Text, xs+280 ys+9 w10 h15 +Center, `%
		Gui Font, cBlack Normal
			Gui, Add, Hotkey, xs+330 ys+6 w60 h20 vHotkey_MightRing_Mana, ;%Hotkey_MightRing_Mana%
			Gui, Add, Hotkey, xs+443 ys+6 w60 h20 vKey_Enable_MightRing_Mana, ;%Key_Enable_MightRing_Mana%
			;~ Gui, Add, DropDownList, x410 y335 w85 h20 vMouse_Enable_MightRing_Mana r5, Nothing|WheelUp|WheelDown|XButton1|XButton2
		Gui Font, cWhite

			; ===== [MANA] SPECIAL FOOD =====
			Gui, Add, Picture, section xs ys+35 w32 h32 , % "HBITMAP:* " Picture.Blueberry_Cupcake
			Gui, Add, CheckBox, xs+35 ys w145 h32 vFood_Mana, Special Food =========>
			Gui Font, cBlue Bold
					Gui, Add, Edit, xs+260 ys+6 w20 h20 vPercent_Food_Mana Number Limit2, 50 ;%Percent_Life_Stage1%
					Gui, Add, Text, xs+217 ys+9 w40 h15 +Center, MP <=
					Gui, Add, Text, xs+280 ys+9 w10 h15 +Center, `%
		Gui Font, cBlack Normal
			Gui, Add, Hotkey, xs+330 ys+6 w60 h20 vHotkey_Food_Mana, ;%Hotkey_Food_Mana%
		Gui Font, cWhite

			; ===== [MANA] ENERGY RING =====
			Gui, Add, Picture, section xs ys+35 w32 h32, % "HBITMAP:* " Picture.Remove_EnergyRing
			Gui, Add, CheckBox, xs+35 ys w145 h33 vCheckBox_Remove_EnergyRing_Mana, Remove Energy ======>
			Gui Font, cBlue Bold
					Gui, Add, Edit, xs+260 ys+6 w20 h20 vPercent_Remove_EnergyRing_Mana Number Limit2, 50 ;%Percent_Life_Stage1%
					Gui, Add, Text, xs+217 ys+9 w40 h15 +Center, MP <=
					Gui, Add, Text, xs+280 ys+9 w10 h15 +Center, `%
		Gui Font, cBlack Normal
			Gui, Add, Hotkey, xs+330 ys+10 w60 h20 vHotkey_Remove_EnergyRing_Mana,
		Gui Font, cWhite
		}
	}

	Gui, Tab, Adv. Options
	if (true) {
		Gui, Font, Bold
		Portugues := "Ativar TankMode Automaticamente Quando:"
		English := "Enable TankMode Automatically When:"
		Gui, Add, GroupBox, x5 y25 w240 h120, % %GlobalLanguage%
		Gui, Font, Normal

		Gui, Add, CheckBox, section xp+5 yp+15 w43 h20 vCheckBox_TankMode_Fear, Fear
		Gui, Add, Picture, xs+45 ys+5 w10 h10, % "HBITMAP:* " Picture.Fear
		Gui, Add, CheckBox, section xs ys+20 w43 h20 vCheckBox_TankMode_Root, Root
		Gui, Add, Picture, xs+45 ys+5 w10 h10, % "HBITMAP:* " Picture.Root
	}
}


Draw_Gui_TankMode:
	Gui, TankMode:Show, % " w" 651 " h" 451, [TankMode] %TrayName%	;NAME PROGRAMA
RETURN


Refresh_All_Images_GUI_TankMode:
    Refresh_Picture_GUI("DropDownList_TankModeLife_Amulet", "Picture_TankModeLife_Amulet", "TankMode")
    Refresh_Picture_GUI("DropDownList_TankModeMana_Amulet", "Picture_TankModeMana_Amulet", "TankMode")
    Refresh_Picture_GUI("DropDownList_TankModeLife_Ring", "Picture_TankModeLife_Ring", "TankMode")
    Refresh_Picture_GUI("DropDownList_TankModeMana_Ring", "Picture_TankModeMana_Ring", "TankMode")
RETURN

