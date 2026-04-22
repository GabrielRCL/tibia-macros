Draw_Gui_Combo() {
    GLOBAL

	Load_Pre_Settings("Combo")
	Gui, Add, Tab, x1 y1 w725 h490, Combo_PvE|Combo_PvP|Adv. Options
	Gui, Tab, Combo
	Array_Tab_List := ["Combo_PvE","Combo_PvP"]


	Loop, % Array_Tab_List.Length() {
		; GERAL ====================================================================
		if (true) {
				Name_Tab := Array_Tab_List[A_Index]
				Gui, Tab, % Name_Tab

				Gui, Font, Bold
					Portugues := "Iniciar Combo Automaticamente quando tiver target"
					English := "Start Combo Automatically when you have target"
						Gui, Add, CheckBox, SECTION x25 y380 w310 h20 +Center v%Name_Tab%_CheckBox_Automatic_Combo, % %GlobalLanguage%

					Portugues := "OU"
					English := "OR"
						Gui, Add, Text, xs+142 ys+28 w20 h20 +Center, % %GlobalLanguage%

					Portugues := "Hotkey para Iniciar Combo:"
					English := "Hotkey to Start Combo:"
						Gui, Add, Text, xs+110 ys+50 w85 h27 +Center, % %GlobalLanguage%
				Gui, Font, Normal
						Gui, Add, Hotkey, xs+110 ys+77 w85 h20 v%Name_Tab%_Key_Enable


				;GroupBox [Others]
				Gui, Add, GroupBox, section x500 y385 w215 h75 +Center, Others
					Portugues := "Combar enquanto Looteia"
					English := "Combo While Looting"
						Gui, Add, CheckBox, xs+5 ys+12 w175 h20 v%Name_Tab%_ComboWhileLooting, % %GlobalLanguage%

					Portugues := "Lootear Quando Parar Combo"
					English := "Looting When Stop Combo"
						Gui, Add, CheckBox, xs+5 ys+32 w175 h20 v%Name_Tab%_Looting_When_Stop_Combo_CheckBox, % %GlobalLanguage%

					Portugues := "Nao utilizar Haste quando Combo ON"
					English := "Disable Haste When Combo ON"
						Gui, Add, CheckBox, xs+5 ys+52 w200 h20 v%Name_Tab%_Disable_Haste_When_Combo_ON, % %GlobalLanguage%
		}


		if (Vocation == "Knight") {
				Name_Tab := Array_Tab_List[A_Index]
				Gui, Tab, % Name_Tab

				; ===== [Support Spell's] =====
				if (true) {
					Gui, Font, Bold
						Gui, Add, GroupBox, SECTION x5 y22 w710 h175 , Support Spell's
					Gui, Font, Normal

					;[Utito Tempo]
						Gui, Add, Picture, SECTION xs+40 ys+22 w32 h32 , % "HBITMAP:* " Picture.Utito_Tempo
						Gui, Add, CheckBox, xs-30 ys+35 w120 h20 v%Name_Tab%_CheckBox_UtitoTempo, Utito Tempo
					Gui, Font, Bold
						Gui, Add, Text, xs-17 ys+55 w70 h20 +Center, Hotkey
					Gui, Font, Normal
						Gui, Add, Hotkey, xs-17 ys+70 w70 h20 v%Name_Tab%_Hotkey_UtitoTempo, ;%Hotkey_UtitoTempo%
						Gui, Add, Text, xs-10 ys+98 w40 h20, % "HP% >"
						Gui, Add, Text, xs-10 ys+118 w40 h20, % "MP% >"
					Gui, Font, cRed Bold
						Gui, Add, Edit, xs+25 ys+97 w18 h15 Number Limit2, 15
						Gui, Add, Text, xs+43 ys+98 w15 h15, `%
					Gui, Font, cBlue
						Gui, Add, Edit, xs+25 ys+117 w18 h15 Number Limit2, 15
						Gui, Add, Text, xs+43 ys+118 w15 h15, `%
					Gui, Font, cWhite Normal

					;[Exeta]
						Gui, Add, Picture, SECTION xs+395 ys w32 h32 , % "HBITMAP:* " Picture.Exeta_Res
						Gui, Add, CheckBox, xs-19 ys+35 w70 h20 v%Name_Tab%_CheckBox_ExetaRes, Exeta Res
					Gui, Font, Bold
						Gui, Add, Text, xs-17 ys+55 w70 h20 +Center, Hotkey
					Gui, Font, Normal
						Gui, Add, Hotkey, xs-17 ys+70 w70 h20 v%Name_Tab%_Hotkey_ExetaRes, ;%Hotkey_ExetaRes%

						Gui, Add, Picture, SECTION xs+165 ys w32 h32 , %  "HBITMAP:* " Picture.Exeta_Amp_Res
						Gui, Add, CheckBox, xs-34 ys+35 w100 h20 v%Name_Tab%_CheckBox_ExetaAmpRes, Exeta Amp Res
					Gui, Font, Bold
						Gui, Add, Text, xs-17 ys+55 w70 h20 +Center, Hotkey
					Gui, Font, Normal
						Gui, Add, Hotkey, xs-17 ys+70 w70 h20 v%Name_Tab%_Hotkey_ExetaAmpRes, ;%ExetaAmpRes_Hotkey%

					Gui, Font, Bold
						Gui, Add, Text, SECTION xs-100 ys+95 w70 h20 +Center, Delay Exeta
						Gui, Add, Text, xs-80 ys+10 w70 h20 +Center, ==========>
						Gui, Add, Text, xs+80 ys+10 w70 h20 +Center, <==========
					Gui, Font, Normal
					Gui, Font, cRed
						Gui, Add, Edit, xs+15 ys+15 w30 h20 +Center Number Limit4 v%Name_Tab%_Delay_Exeta, 2500 ;delay exeta
					Gui, Font, cWhite
						Gui, Add, Text, xs+46 ys+17 w20 h15, ms
				}

				; ===== [Attack Spell's] =====
				if (true) {
					Gui, Font, Bold
						Gui, Add, GroupBox, section x5 y200 w710 h165, Attack Spell's
					Gui, Font, Normal

				;[Spell_1]
					Gui, Add, Picture, section xs+50 ys+20 w32 h32 v%Name_Tab%_Picture_Spell_1, % "HBITMAP:* " Picture.Exori
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_1,	;vMasSan, Mas San
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r8 Choose1 v%Name_Tab%_DropDownList_Spell_1 gRefresh_Images_GUI_Combo, Exori|Exori_Gran|Exori_Mas|Exori_Min|Exori_Amp_Kor|Exori_Gran_Ico|Exori_Ico|Exori_Hur
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_1	;vHotkey_MasSan, ;%Hotkey_MasSan%
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_1 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_1, 100`%|90`%|60`%|30`%|10`%

				;[Spell_2]
					Gui, Add, Picture, section xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_2, % "HBITMAP:* " Picture.Exori_Gran
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_2,	;vAvalanche , Any Rune
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r8 Choose2 v%Name_Tab%_DropDownList_Spell_2 gRefresh_Images_GUI_Combo, Exori|Exori_Gran|Exori_Mas|Exori_Min|Exori_Amp_Kor|Exori_Gran_Ico|Exori_Ico|Exori_Hur
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_2	;vHotkey_Avalanche, ;%Hotkey_Avalanche%
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_2 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_2, 100`%|90`%|60`%|30`%|10`%

				;[Spell_3]
					Gui, Add, Picture, section xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_3, % "HBITMAP:* " Picture.Exori_Mas
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_3, ;vExori_Gran_Con, Exori Gran Con
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r8 Choose3 v%Name_Tab%_DropDownList_Spell_3 gRefresh_Images_GUI_Combo, Exori|Exori_Gran|Exori_Mas|Exori_Min|Exori_Amp_Kor|Exori_Gran_Ico|Exori_Ico|Exori_Hur
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_3	;vHotkey_Exori_Gran_Con, ;%Hotkey_Exori_Gran_Con%
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_3 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_3, 100`%|90`%|60`%|30`%|10`%

				;[Spell_4]
					Gui, Add, Picture, section xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_4, % "HBITMAP:* " Picture.Exori_Min
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_4	;vExori_Con,
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r8 Choose4 v%Name_Tab%_DropDownList_Spell_4 gRefresh_Images_GUI_Combo, Exori|Exori_Gran|Exori_Mas|Exori_Min|Exori_Amp_Kor|Exori_Gran_Ico|Exori_Ico|Exori_Hur
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_4	;vHotkey_Exori_Con, ;%Hotkey_Exori_Con%
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_4 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_4, 100`%|90`%|60`%|30`%|10`%

					;[Priority Spell]
					Gui, Font, Bold
						Gui, Add, CheckBox, section xs+100 ys w100 h20 v%Name_Tab%_CheckBox_Priority_Spell g%Name_Tab%_CheckBox_Priority_Spell +Center Checked, Priority Spell:
					Gui, Font, Normal
					Gui,Font,cRed
						Gui, Add, ListBox, xs ys+20 w100 h60 r4 Multi v%Name_Tab%_ListBox_Priority_List, ;%Combo_Priority_List%
					Gui,Font,cWhite
						Gui, Add, Button, xs-5 ys+80 w50 h20 g%Name_Tab%_Button_Priority_Up, Priority++
						Gui, Add, Button, xs+55 ys+80 w50 h20 g%Name_Tab%_Button_Priority_Down, Priority--

				}

				;ADV. OPTIONS
				if (A_Index == 1) {
					Gui, Tab, Adv. Options
						Portugues := "Aguardar para usar Exori Gran se o cooldown estiver menor que 1segundo (Momentum)"
						English := "Wait to use Exori Gran if cooldown is less than 1second (Momentum)"
						Gui, Add, CheckBox, section x7 y30 h20 vForce_ExoriGran, % %GlobalLanguage%

						Portugues := "Usar Utito Tempo Apenas no ExoriGran"
						English := "Use Utito Tempo Only In ExoriGran Spell"
						Gui, Add, CheckBox, xs ys+82 w220 h20 v%Name_Tab%_CheckBox_Use_UtitoTempo_Only_In_ExoriGran, % %GlobalLanguage%

				}

		}

		if (Vocation == "Paladin") {
			Name_Tab := Array_Tab_List[A_Index]
			Gui, Tab, % Name_Tab

			; ===== [ Support Spell's ] =====
			if (true) {
				Gui, Font, Bold
					Gui, Add, GroupBox, section x5 y22 w710 h175 , Support Spell's
				Gui, Font, Normal

				;[Utito Tempo San]
					Gui, Add, Picture, SECTION xs+40 ys+22 w32 h32 , % "HBITMAP:* " Picture.Utito_Tempo_San
					Gui, Add, CheckBox, xs-30 ys+35 w120 h20 v%Name_Tab%_CheckBox_UtitoTempoSan, Utito Tempo San
				Gui, Font, Bold
					Gui, Add, Text, xs-17 ys+55 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-17 ys+70 w70 h20 v%Name_Tab%_Hotkey_UtitoTempoSan, ;%Utito_Tempo_San_Hotkey%
					Gui, Add, Text, xs-10 ys+98 w40 h20, % "HP% >"
					Gui, Add, Text, xs-10 ys+118 w40 h20, % "MP% >"
				Gui, Font, cRed Bold
					Gui, Add, Edit, xs+25 ys+97 w18 h15 v%Name_Tab%_HPpercent_UtitoTempoSan Number Limit2, 15
					Gui, Add, Text, xs+43 ys+98 w15 h15, `%
				Gui, Font, cBlue
					Gui, Add, Edit, xs+25 ys+117 w18 h15 v%Name_Tab%_MPpercent_UtitoTempoSan Number Limit2, 15
					Gui, Add, Text, xs+43 ys+118 w15 h15, `%
				Gui, Font, cWhite Normal

				;[Divine Empowerment]
					Gui, Add, Picture, SECTION xs+285 ys h32 w32, % "HBITMAP:* " Picture.Divine_Empowerment
					Gui, Add, CheckBox, xs-42 ys+35 w120 h20 v%Name_Tab%_CheckBox_DivineEmpowerment, Divine Empowerment
				Gui, Font, Bold
					Gui, Add, Text, xs-45 ys+55 w120 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-20 ys+70 w70 h20 +Center v%Name_Tab%_Hotkey_DivineEmpowerment, Hotkey
					Gui, Add, DropDownList, xs-20 ys+93 w30 h20 r10 Choose1 v%Name_Tab%_DropDownList_DivineEmpowerment_Qtd_Monster, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+12 ys+95 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+115, TargetHP >=
					Gui, Add, DropDownList, xs+23 ys+112 w50 h20 r5 Choose1 v%Name_Tab%_DropDownList_DivineEmpowerment_TargetHPpercent, 100`%|90`%|60`%|30`%|10`%

				;[Exeta Amp Res]
					Gui, Add, Picture, SECTION xs+305 ys w32 h32 , % "HBITMAP:* " Picture.Divine_Dazzle
					Gui, Add, CheckBox, xs-30 ys+35 w95 h20 v%Name_Tab%_CheckBox_ExetaAmpRes, Exeta Amp Res
				Gui, Font, Bold
					Gui, Add, Text, xs-45 ys+55 w120 h20 +Center, Hotkey
					Gui, Add, Text, xs-45 ys+100 w120 h20 +Center, Delay Exeta
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-20 ys+70 w70 h20 v%Name_Tab%_Hotkey_ExetaAmpRes, ;%ExetaAmpRes_Hotkey%
				Gui, Font, cRed
					Gui, Add, Edit, xs-5 ys+115 w30 h17 +Right Number Limit4 v%Name_Tab%_Support_Spell_Paladin_Delay, 2500 ;delay exeta
				Gui, Font, cWhite
					Gui, Add, Text, xs+26 ys+117 w20 h20 , ms
			}

			; ===== [Attack Spell's] =====
			if (true) {
				Gui, Font, Bold
					Gui, Add, GroupBox, section x5 y200 w710 h165 , Attack Spell's
				Gui, Font, Normal

				;[Spell_1]
					Gui, Add, Picture, section xs+50 ys+20 w32 h32 v%Name_Tab%_Picture_Spell_1, % "HBITMAP:* " Picture.Mas_San
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_1	;vMasSan, Mas San
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r5 Choose1 v%Name_Tab%_DropDownList_Spell_1 gRefresh_Images_GUI_Combo, Divine_Grenade|Mas_San|Attack_Rune|Exori_Gran_Con|Exori_Con
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_1	;vHotkey_MasSan, ;%Hotkey_MasSan%
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_1 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_1, 100`%|90`%|60`%|30`%|10`%

				;[Spell_2]
					Gui, Add, Picture, section xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_2, % "HBITMAP:* " Picture.AttackRune
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_2	;vAvalanche , Any Rune
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r5 Choose2 v%Name_Tab%_DropDownList_Spell_2 gRefresh_Images_GUI_Combo, Divine_Grenade|Mas_San|Attack_Rune|Exori_Gran_Con|Exori_Con
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_2	;vHotkey_Avalanche, ;%Hotkey_Avalanche%
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_2 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_2, 100`%|90`%|60`%|30`%|10`%

				;[Spell_3]
					Gui, Add, Picture, section xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_3, % "HBITMAP:* " Picture.Exori_Gran_Con
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_3 ;vExori_Gran_Con, Exori Gran Con
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r5 Choose3 v%Name_Tab%_DropDownList_Spell_3 gRefresh_Images_GUI_Combo, Divine_Grenade|Mas_San|Attack_Rune|Exori_Gran_Con|Exori_Con
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_3	;vHotkey_Exori_Gran_Con, ;%Hotkey_Exori_Gran_Con%
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_3 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_3, 100`%|90`%|60`%|30`%|10`%

				;[Spell_4]
					Gui, Add, Picture, section xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_4, % "HBITMAP:* " Picture.Exori_Con
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_4	;vExori_Con,
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r5 Choose4 v%Name_Tab%_DropDownList_Spell_4 gRefresh_Images_GUI_Combo, Divine_Grenade|Mas_San|Attack_Rune|Exori_Gran_Con|Exori_Con
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_4	;vHotkey_Exori_Con, ;%Hotkey_Exori_Con%
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_4 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_4, 100`%|90`%|60`%|30`%|10`%

				;[Priority Spell]
				Gui, Font, Bold
					Gui, Add, CheckBox, section xs+100 ys w100 h20 v%Name_Tab%_CheckBox_Priority_Spell g%Name_Tab%_CheckBox_Priority_Spell +Center Checked, Priority Spell:
				Gui, Font, Normal
				Gui,Font,cRed
					Gui, Add, ListBox, xs ys+20 w100 h60 r4 Multi v%Name_Tab%_ListBox_Priority_List, ;%Combo_Priority_List%
				Gui,Font,cWhite
					Gui, Add, Button, xs-5 ys+80 w50 h20 g%Name_Tab%_Button_Priority_Up, Priority++
					Gui, Add, Button, xs+55 ys+80 w50 h20 g%Name_Tab%_Button_Priority_Down, Priority--
			}

		}

		if (Vocation == "Druid") {
			Name_Tab := Array_Tab_List[A_Index]
			Gui, Tab, % Name_Tab

			; ===== [Support Spell's] =====
			Gui, Font, Bold
				Gui, Add, GroupBox, section x5 y85 w120 h120, Support Spell's
				;~ Gui, Add, Text, xs+10 ys+66 w90 h20 +Center, Hotkey	;Support spell text
			Gui, Font, Norm
				;~ Gui, Add, Picture, xs+20 ys+15 w32 h32, % "HBITMAP:* " Picture.Exori_Kor
				;~ Gui, Add, Picture, xs+55 ys+15 w32 h32, % "HBITMAP:* " Picture.Exori_Moe
				;~ Gui, Add, CheckBox, xs+10 ys+46 w95 h20 vCheckBox_Support_Spell_Sorcerer, Support Spell's
				;~ Gui, Add, Hotkey, xs+21 ys+86 w70 h20 vHotkey_Support_Spell_Sorcerer,



				; ===== [Attack Spell's] =====
			Gui, Font, Bold
				Gui, Add, GroupBox, SECTION xs+130 ys-60 w582 h340 , Attack Spell's
			Gui, Font, Norm

				;[Spell_1]
					Gui, Add, Picture, SECTION xs+50 ys+15 w32 h32 v%Name_Tab%_Picture_Spell_1, % "HBITMAP:* " Picture.Gran_Mas_Frigo
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_1	;vMasSan, Mas San
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r8 Choose1 v%Name_Tab%_DropDownList_Spell_1 gRefresh_Images_GUI_Combo, Gran_Mas_Frigo|Gran_Mas_Tera|Gran_Frigo_Hur|Exevo_Tera_Hur|Exevo_Ulus|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_1
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_1 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_1, 100`%|90`%|60`%|30`%|10`%


				;[Spell_2]
					Gui, Add, Picture, SECTION xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_2, % "HBITMAP:* " Picture.Gran_Mas_Tera
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_2	;vAvalanche , Any Rune
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r8 Choose2 v%Name_Tab%_DropDownList_Spell_2 gRefresh_Images_GUI_Combo, Gran_Mas_Frigo|Gran_Mas_Tera|Gran_Frigo_Hur|Exevo_Tera_Hur|Exevo_Ulus|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_2
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_2 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_2, 100`%|90`%|60`%|30`%|10`%

				;[Spell_3]
					Gui, Add, Picture, SECTION xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_3, % "HBITMAP:* " Picture.Gran_Frigo_Hur
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_3 ;vExori_Gran_Con, Exori Gran Con
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r8 Choose3 v%Name_Tab%_DropDownList_Spell_3 gRefresh_Images_GUI_Combo, Gran_Mas_Frigo|Gran_Mas_Tera|Gran_Frigo_Hur|Exevo_Tera_Hur|Exevo_Ulus|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_3
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_3 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_3, 100`%|90`%|60`%|30`%|10`%

				;[Spell_4]
					Gui, Add, Picture, SECTION xs-300 ys+175 w32 h32 v%Name_Tab%_Picture_Spell_4, % "HBITMAP:* " Picture.Exevo_Tera_Hur
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_4
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r8 Choose4 v%Name_Tab%_DropDownList_Spell_4 gRefresh_Images_GUI_Combo, Gran_Mas_Frigo|Gran_Mas_Tera|Gran_Frigo_Hur|Exevo_Tera_Hur|Exevo_Ulus|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_4
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_4 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_4, 100`%|90`%|60`%|30`%|10`%


				;[Spell_5]
					Gui, Add, Picture, SECTION xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_5, % "HBITMAP:* " Picture.AttackRune
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_5	;vAvalanche , Any Rune
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r8 Choose5 v%Name_Tab%_DropDownList_Spell_5 gRefresh_Images_GUI_Combo, Gran_Mas_Frigo|Gran_Mas_Tera|Gran_Frigo_Hur|Exevo_Tera_Hur|Exevo_Ulus|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_5
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_5 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_5, 100`%|90`%|60`%|30`%|10`%


				;[Spell_6]
					Gui, Add, Picture, SECTION xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_6, % "HBITMAP:* " Picture.Spell_Strike
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_6 ;vExori_Gran_Con, Exori Gran Con
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r8 Choose6 v%Name_Tab%_DropDownList_Spell_6 gRefresh_Images_GUI_Combo, Gran_Mas_Frigo|Gran_Mas_Tera|Gran_Frigo_Hur|Exevo_Tera_Hur|Exevo_Ulus|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_6
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_6 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_6, 100`%|90`%|60`%|30`%|10`%

				;PRIORITY SPELL [ ED ]
			Gui, Font, Bold
				Gui, Add, CheckBox, section xs+115 ys-75 w100 h20 v%Name_Tab%_CheckBox_Priority_Spell g%Name_Tab%_CheckBox_Priority_Spell +Center Checked, Priority Spell:
			Gui, Font, Normal
			Gui,Font,cRed
				Gui, Add, ListBox, xs ys+20 w100 h104 r6 Multi v%Name_Tab%_ListBox_Priority_List, ;%Combo_Priority_List%
			Gui,Font,cWhite
				Gui, Add, Button, xs-5 ys+102 w50 h20 g%Name_Tab%_Button_Priority_Up, Priority++
				Gui, Add, Button, xs+55 ys+102 w50 h20 g%Name_Tab%_Button_Priority_Down, Priority--
		}

		if (Vocation == "Sorcerer") {
			Name_Tab := Array_Tab_List[A_Index]
			Gui, Tab, % Name_Tab

			; ===== [Support Spell's] =====
			Gui, Font, Bold
				Gui, Add, GroupBox, section x5 y85 w120 h120, Support Spell's
				Gui, Add, Text, xs+10 ys+66 w90 h20 +Center, Hotkey	;Support spell text
			Gui, Font, Norm
				Gui, Add, Picture, xs+20 ys+15 w32 h32, % "HBITMAP:* " Picture.Exori_Kor
				Gui, Add, Picture, xs+55 ys+15 w32 h32, % "HBITMAP:* " Picture.Exori_Moe
				Gui, Add, CheckBox, xs+10 ys+46 w95 h20 v%Name_Tab%_CheckBox_Support_Spell_Sorcerer, Support Spell's
				Gui, Add, Hotkey, xs+21 ys+86 w70 h20 v%Name_Tab%_Hotkey_Support_Spell_Sorcerer,


			; ===== [Attack Spell's] =====
			Gui, Font, Bold
				Gui, Add, GroupBox, section xs+130 ys-60 w582 h290 , Attack Spell's
			Gui, Font, Norm

				;[Spell_1]
					Gui, Add, Picture, section xs+50 ys+15 w32 h32 v%Name_Tab%_Picture_Spell_1, % "HBITMAP:* " Picture.Exevo_Gran_Mas_Flam
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_1	;vMasSan, Mas San
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r7 Choose1 v%Name_Tab%_DropDownList_Spell_1 gRefresh_Images_GUI_Combo, Gran_Mas_Flam|Gran_Mas_Vis|Gran_Flam_Hur|Exevo_Vis_Hur|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_1
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_1 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_1, 100`%|90`%|60`%|30`%|10`%


				;[Spell_2]
					Gui, Add, Picture, section xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_2, % "HBITMAP:* " Picture.Exevo_Gran_Mas_Vis
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_2	;vAvalanche , Any Rune
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r7 Choose2 v%Name_Tab%_DropDownList_Spell_2 gRefresh_Images_GUI_Combo, Gran_Mas_Flam|Gran_Mas_Vis|Gran_Flam_Hur|Exevo_Vis_Hur|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_2
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_2 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_2, 100`%|90`%|60`%|30`%|10`%


				;[Spell_3]
					Gui, Add, Picture, section xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_3, % "HBITMAP:* " Picture.Exevo_Gran_Flam_Hur
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_3 ;vExori_Gran_Con, Exori Gran Con
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r7 Choose3 v%Name_Tab%_DropDownList_Spell_3 gRefresh_Images_GUI_Combo, Gran_Mas_Flam|Gran_Mas_Vis|Gran_Flam_Hur|Exevo_Vis_Hur|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_3
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_3 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_3, 100`%|90`%|60`%|30`%|10`%


				;[Spell_4]
					Gui, Add, Picture, section xs-300 ys+145 w32 h32 v%Name_Tab%_Picture_Spell_4, % "HBITMAP:* " Picture.Exevo_Vis_Hur
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_4
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r7 Choose4 v%Name_Tab%_DropDownList_Spell_4 gRefresh_Images_GUI_Combo, Gran_Mas_Flam|Gran_Mas_Vis|Gran_Flam_Hur|Exevo_Vis_Hur|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_4
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_4 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_4, 100`%|90`%|60`%|30`%|10`%


				;[Spell_5]
					Gui, Add, Picture, section xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_5, % "HBITMAP:* " Picture.Attack_Rune
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_5	;vAvalanche , Any Rune
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r7 Choose5 v%Name_Tab%_DropDownList_Spell_5 gRefresh_Images_GUI_Combo, Gran_Mas_Flam|Gran_Mas_Vis|Gran_Flam_Hur|Exevo_Vis_Hur|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_5
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_5 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_5, 100`%|90`%|60`%|30`%|10`%

				;[Spell_6]
					Gui, Add, Picture, section xs+150 ys w32 h32 v%Name_Tab%_Picture_Spell_6, % "HBITMAP:* " Picture.Spell_Strike
					Gui, Add, CheckBox, xs-40 ys+37 w15 h15 v%Name_Tab%_CheckBox_Spell_6 ;vExori_Gran_Con, Exori Gran Con
					Gui, Add, DropDownList, xs-25 ys+34 w100 h20 r7 Choose6 v%Name_Tab%_DropDownList_Spell_6 gRefresh_Images_GUI_Combo, Gran_Mas_Flam|Gran_Mas_Vis|Gran_Flam_Hur|Exevo_Vis_Hur|Attack_Rune|Spell_Strike
				Gui, Font, Bold
					Gui, Add, Text, xs-18 ys+59 w70 h20 +Center, Hotkey
				Gui, Font, Normal
					Gui, Add, Hotkey, xs-18 ys+74 w70 h20 v%Name_Tab%_Hotkey_Spell_6
					Gui, Add, DropDownList, xs-18 ys+96 w30 h20 Choose1 v%Name_Tab%_DropDownList_Qtd_Monster_Spell_6 r10, 0|1|2|3|4|5|6|7|8|9
					Gui, Add, Text, xs+15 ys+100 w50 h20 ,Monster(s)
					Gui, Add, Text, xs-40 ys+118, TargetHP <=
					Gui, Add, DropDownList, xs+23 ys+115 w50 h20 Choose1 r5 v%Name_Tab%_DropDownList_TargetHP_Spell_6, 100`%|90`%|60`%|30`%|10`%

				;PRIORITY SPELL [ MS ]
			Gui, Font, Bold
				Gui, Add, CheckBox, section xs+115 ys-75 w100 h20 v%Name_Tab%_CheckBox_Priority_Spell g%Name_Tab%_CheckBox_Priority_Spell +Center Checked, Priority Spell:
			Gui, Font, Normal
			Gui,Font,cRed
				Gui, Add, ListBox, xs ys+20 w100 h104 r6 Multi v%Name_Tab%_ListBox_Priority_List, ;%Combo_Priority_List%
			Gui,Font,cWhite
				Gui, Add, Button, xs-5 ys+102 w50 h20 g%Name_Tab%_Button_Priority_Up, Priority++
				Gui, Add, Button, xs+55 ys+102 w50 h20 g%Name_Tab%_Button_Priority_Down, Priority--
		}
	}



	;[Atack Exaust]
		;~ Gui, Add, GroupBox, section x182 y345 w380 h65 , Check Exaust
		;~ Gui, Add, Picture, xs+5 ys+12 y365 w32 h32 , % "HBITMAP:* " Picture.Attack_CD
		;~ Gui, Add, CheckBox, xs+39 ys+19 w100 h32 vAttackCooldown, Check Exaust
		;~ Gui, Add, Text, xs+146 ys+12 w230 h20 +Center, Hotkey's
	;~ Gui, Font, cBlack
		;~ Gui, Add, Hotkey, xs+146 ys+29 w70 h20 vHotkey1_AttackCooldown, ;%Hotkey1_AttackCooldown%
		;~ Gui, Add, Hotkey, xs+226 ys+29 w70 h20 vHotkey2_AttackCooldown, ;%Hotkey2_AttackCooldown%
		;~ Gui, Add, Hotkey, xs+306 ys+29 w70 h20 vHotkey3_AttackCooldown, ;%Hotkey3_AttackCooldown%
	;~ Gui, Font, cWhite

	;[ADV OPTIONS]
	Gui, Tab, Adv. Options
			Portugues := "Aguarde"
			English := "Wait"
			Gui, Add, CheckBox, section x7 y55 vCheckBox_Delay_Combo, % %GlobalLanguage%
		Gui,Font,cRed
			Gui, Add, Edit, xs+65 ys-3 w25 h20 vDelay_Combo Number Limit3, 000
		Gui,Font,cWhite
			Portugues := "ms. antes de usar magia"
			English := "ms. before using spell"
			Gui, Add, Text, xs+90 ys, % %GlobalLanguage%

	Portugues := "Ignorar Potion Quando Usar Qualquer Runa"
	English := "Ignore Potion if Use Any Rune"
	Gui, Add, CheckBox, x7 y75 vCheckBox_Ignore_Potion_if_Use_Avalanche, % %GlobalLanguage%

	Portugues := "Somente Usar Runa se Tiver Target"
	English := "Only Use Rune if Have Target"
	Gui, Add, CheckBox, x7 y95 vCheckBox_Only_Use_Avalanche_if_Have_Target Checked1, % %GlobalLanguage%

	if (Vocation = "Paladin") {
		Portugues := "Press ESC em Divine Empowerment (tapete)"
		English := "Press ESC in Divine Empowerment (tapestry)"
		Gui, Add, CheckBox, x7 y115 vCheckBox_PressEsc_DivineEmpowerment, % %GlobalLanguage%
	}

	Gui, Tab, Combo

}

Draw_Gui_Combo:
	Gui, Combo:Show, % " w" 725 " h" 491, [Combo] %TrayName%	;NAME PROGRAMA
RETURN


Refresh_Images_GUI_Combo: ;used in GUI gLabel
	switch Vocation {
		case "Knight":Refresh_Images_GUI_Combo(4)
		case "Paladin":Refresh_Images_GUI_Combo(4)
		case "Druid":Refresh_Images_GUI_Combo(6)
		case "Sorcerer":Refresh_Images_GUI_Combo(6)
	}
RETURN

Refresh_Images_GUI_Combo(i){
    GLOBAL
	Loop, %i% {
		Refresh_Picture_GUI("Combo_PvE_DropDownList_Spell_" A_Index,"Combo_PvE_Picture_Spell_" A_Index,"Combo")
		Refresh_Picture_GUI("Combo_PvP_DropDownList_Spell_" A_Index,"Combo_PvP_Picture_Spell_" A_Index,"Combo")
	}
	Refresh_Combo_Priority_List(i,"Combo_PvE")
	Refresh_Combo_Priority_List(i,"Combo_PvP")
}

Refresh_Combo_Priority_List(i,Tab){
    GLOBAL
	Combo_Priority_List := "" ;CLEAN VARIABLE
	Gui, Combo:Default
	Loop, %i% {
		GuiControlGet, %Tab%_DropDownList_Spell_%A_Index%
		if (A_Index == 1) {
			Combo_Priority_List .= %Tab%_DropDownList_Spell_%A_Index%
		} else {
			Combo_Priority_List .= "|" %Tab%_DropDownList_Spell_%A_Index%
		}
	}

	%Tab%_Priority_Array := StrSplit(Combo_Priority_List, "|") ;CREATE PRIORITY ARRAY

	GuiControl,, %Tab%_ListBox_Priority_List, |						;REMOVE ALL NameList in ListBox
	GuiControl,, %Tab%_ListBox_Priority_List, % Combo_Priority_List	;put the new NameList in ListBox

	if position_to_swap is number
	{
		GuiControl, Choose, %Tab%_ListBox_Priority_List, % position_to_swap			;change the selected string in listbox to new position
	}

}

;  [ Priority List Combo ]
Disable_Gui_ListBox_Combo(Tab) {
    GLOBAL
	Gui, Combo:Default
	Gui, Submit, NoHide
	PostMessage, 0x0185, 0, -1, ListBox1
	if (%Tab%_CheckBox_Priority_Spell) {
		GuiControl, Enable, %Tab%_ListBox_Priority_List
	} else {
		GuiControl, Disable, %Tab%_ListBox_Priority_List
	}
}
Combo_PvE_CheckBox_Priority_Spell:
Combo_PvP_CheckBox_Priority_Spell:
	Disable_Gui_ListBox_Combo(SubStr(A_ThisLabel, 1, 9))
RETURN

Transform_Array_to_ListBox(Tab) {
GLOBAL
	Combo_Priority_List := ""				;clean listbox
	for Each, Spell in %Tab%_Priority_Array	;search for each string in array
		Combo_Priority_List .= "|" Spell	;format array to listbox
}

Combo_Change_Priority(Action,Tab) {
    GLOBAL
    Gui, Combo:Default

	GuiControl, +AltSubmit, %Tab%_ListBox_Priority_List							; alternative submit to return position rather than name spell
	GuiControlGet, Combo_Priority_List_Position,, %Tab%_ListBox_Priority_List	;get position of selected string in listbox
	GuiControl, -AltSubmit, %Tab%_ListBox_Priority_List							; put off alternative submit

	if Combo_Priority_List_Position is not number
	{
		Hide_All_GUI()	;HIDE ALL GUI
		MsgBox, [BR] Escolha uma spell na lista antes de aumentar ou diminuir sua prioridade `n[EN] Choose a spell from the list before increasing or decreasing its priority
		Hide_All_GUI()	;UNHIDE ALL GUI
		Gui, Combo:Show
		RETURN
	}
	if (Action == "Up") {
		ActionNumber := -1
	} else {
		ActionNumber := 1
	}
	position_to_swap := Combo_Priority_List_Position + ActionNumber

	if ((Combo_Priority_List_Position != 1 && Action == "Up") or (Combo_Priority_List_Position < %Tab%_Priority_Array.Count() && Action == "Down")) {	;fix some bugs up and down blank string
		T := %Tab%_Priority_Array[position_to_swap]								;saves the name of the other string that will change its position
		GuiControlGet, %Tab%_Hotkey_Spell_%position_to_swap%					;get hotkey of other spell that will change its position
		GuiControlGet, %Tab%_CheckBox_Spell_%position_to_swap%					;get state checkbox of spell that will change its position
		GuiControlGet, %Tab%_DropDownList_Qtd_Monster_Spell_%position_to_swap%	;get qtd monster of other spell that will change its position
		GuiControlGet, %Tab%_DropDownList_TargetHP_Spell_%position_to_swap%		;get target HP of other spell that will change its position

		GuiControlGet, %Tab%_Hotkey_Spell_%Combo_Priority_List_Position%		;get hotkey of SELECTED spell
		GuiControlGet, %Tab%_CheckBox_Spell_%Combo_Priority_List_Position%		;get state checkbox of SELECTED spell
		GuiControlGet, %Tab%_DropDownList_Qtd_Monster_Spell_%Combo_Priority_List_Position%	;get qtd monster of SELECTED spell
		GuiControlGet, %Tab%_DropDownList_TargetHP_Spell_%Combo_Priority_List_Position%		;get target HP of SELECTED spell

		%Tab%_Priority_Array[position_to_swap] := %Tab%_Priority_Array[Combo_Priority_List_Position]								;change position string ListBox (1/2)
		GuiControl,ChooseString, %Tab%_DropDownList_Spell_%position_to_swap%, % %Tab%_Priority_Array[Combo_Priority_List_Position]	;change NAME DropDownList (1/2)
		GuiControl,, %Tab%_Hotkey_Spell_%position_to_swap%, % %Tab%_Hotkey_Spell_%Combo_Priority_List_Position%						;change Hotkey (1/2)
		GuiControl,, %Tab%_CheckBox_Spell_%position_to_swap%, % %Tab%_CheckBox_Spell_%Combo_Priority_List_Position%					;change checkbox (1/2)
		GuiControl,ChooseString, %Tab%_DropDownList_Qtd_Monster_Spell_%position_to_swap%, % %Tab%_DropDownList_Qtd_Monster_Spell_%Combo_Priority_List_Position%	;change qtd monster (1/2)
		GuiControl,ChooseString, %Tab%_DropDownList_TargetHP_Spell_%position_to_swap%, % %Tab%_DropDownList_TargetHP_Spell_%Combo_Priority_List_Position%			;change target HP (1/2)

		%Tab%_Priority_Array[Combo_Priority_List_Position] := T															;change position string ListBox (2/2)
		GuiControl,ChooseString, %Tab%_DropDownList_Spell_%Combo_Priority_List_Position%, %T%							;change NAME DropDownList (2/2)
		GuiControl,, %Tab%_Hotkey_Spell_%Combo_Priority_List_Position%, % %Tab%_Hotkey_Spell_%position_to_swap%			;change Hotkey (2/2)
		GuiControl,, %Tab%_CheckBox_Spell_%Combo_Priority_List_Position%, % %Tab%_CheckBox_Spell_%position_to_swap%		;change checkbox (2/2)
		GuiControl,ChooseString, %Tab%_DropDownList_Qtd_Monster_Spell_%Combo_Priority_List_Position%, % %Tab%_DropDownList_Qtd_Monster_Spell_%position_to_swap%	;change qtd monster (2/2)
		GuiControl,ChooseString, %Tab%_DropDownList_TargetHP_Spell_%Combo_Priority_List_Position%, % %Tab%_DropDownList_TargetHP_Spell_%position_to_swap%			;change target HP (2/2)

		;~ Transform_Array_to_ListBox(Tab)

		GuiControl,, %Tab%_ListBox_Priority_List, |									;REMOVE ALL NameList in ListBox
		GuiControl,, %Tab%_ListBox_Priority_List, % Combo_Priority_List				;REFRESH NameList in ListBox
		;~ GuiControl, Choose, %Tab%_ListBox_Priority_List, % position_to_swap			;change the selected string in listbox to new position
		gosub, Refresh_Images_GUI_Combo	;change the selected string in listbox to new position + REFRESH IMAGES
	}

}

Combo_PvE_Button_Priority_Up:
Combo_PvP_Button_Priority_Up:
	Combo_Change_Priority("Up",SubStr(A_ThisLabel, 1, 9))
RETURN

Combo_PvE_Button_Priority_Down:
Combo_PvP_Button_Priority_Down:
	Combo_Change_Priority("Down",SubStr(A_ThisLabel, 1, 9))
RETURN