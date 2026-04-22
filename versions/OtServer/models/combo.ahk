Auto_Combo() {
    GLOBAL
	; Set Delay Spell's by TibiaServer
	switch TibiaServer {
		case "Global": Delay_Combo_Spells_Attack := 200
		case "OtServer": Delay_Combo_Spells_Attack := -1		;nenhum delay
		default: Delay_Combo_Spells_Attack := 200
	}

	;fix delay on otserver v7
	if ( ( Data.Conditions.CureParalyze or Data.Conditions.CureParalyze2 ) && TibiaServer == "Shadow-Illusion" ) {
		RETURN
	}

	Gui, Combo:Default
	GuiControlGet, %Type_Combo_Active%_CheckBox_Automatic_Combo
	if (State_Combo == "ON" or (isAttacking && %Type_Combo_Active%_CheckBox_Automatic_Combo) ) {
		ElapsedTime_Combo_Spells_Attack := A_TickCount - StartTime_Combo_Spells_Attack
		if (ElapsedTime_Combo_Spells_Attack > Delay_Combo_Spells_Attack) {
			switch Vocation {
				case "Knight": Combo_Spells_Support_Knight()
				case "Paladin": Combo_Spells_Support_Paladin()
				case "Druid":
				case "Sorcerer": Combo_Spells_Support_Sorcerer()
				Default: TOOLTIP, ERROR AUTO COMBO
			}
			Combo_Spells_Attack()
		}
	}
}

Combo_Spells_Attack(){
    GLOBAL
	;~ Type_Combo_Active := "Combo_PvE"

	;~  [ Change to Combo PvP (AntiRed) ]
	GuiControlGet, CheckBox_StopCombo_AntiRed, Gui_CaveBot:
	if (CheckBox_StopCombo_AntiRed) {
		switch Player_On_Screen {
			case true:	Type_Combo_Active := "Combo_PvP"
			case false:	Type_Combo_Active := "Combo_PvE"
			default:	Type_Combo_Active := "Combo_PvE"
		}
	}
	;~ [ Verify Growth Renew ]
	if (Renew_Growth_Stop_Combo == true) {
		RETURN
	}
	;~ [ Start Variable Rotacao Spell ]
	if (%Type_Combo_Active%_CheckBox_Priority_Spell) {
		g := 1
	} else {
		if g is not number
			g := 1
		if (g >= %Type_Combo_Active%_Priority_Array.Length())
			g := 1
	}



	;~ [ Auto Combo Attack ]
	if (Data.Group["Attack"] == 0) {
		While (g <= %Type_Combo_Active%_Priority_Array.Length()) {
			String_ListBox_Combo := %Type_Combo_Active%_Priority_Array[g]		;get string in listbox
			GuiControlGet, %String_ListBox_Combo%


			GuiControlGet, %Type_Combo_Active%_CheckBox_Spell_%g%
			CheckBox_Spell := %Type_Combo_Active%_CheckBox_Spell_%g%
			GuiControlGet, %Type_Combo_Active%_DropDownList_Qtd_Monster_Spell_%g%
			Qtd_Monster_Spell := %Type_Combo_Active%_DropDownList_Qtd_Monster_Spell_%g%
			GuiControlGet, %Type_Combo_Active%_DropDownList_TargetHP_Spell_%g%
			TargetHP_Spell := %Type_Combo_Active%_DropDownList_TargetHP_Spell_%g%
			TargetHP_Spell := SubStr(TargetHP_Spell, 1, StrLen(TargetHP_Spell)-1)	;remove o caractere % dropdownlist
			;~ TOOLTIP % "CheckBox_Combo_Spell_" g ": " CheckBox_Combo_Spell_%g% "`n String_ListBox_Combo: " String_ListBox_Combo "`n :"
			if (CheckBox_Spell == 1 && AutoHunt.MonsterQuantity >= Qtd_Monster_Spell && Data.InfoMobs[PositionTargetMob]["HP"] <= TargetHP_Spell) {
				;MOMENTUN EXORI GRAN EK
				GuiControlGet, Force_ExoriGran
				if (String_ListBox_Combo == "Exori_Gran" && xSkill_Exori_Gran != "" && Force_ExoriGran == 1) {
					tmp_color := GetColorHex(xSkill_Exori_Gran-3,ySkill+12)
					if (tmp_color = "#000000") {
						BREAK
					}
				}

				;NOT USE RUNE IF DOESNT ATTACK MONSTER
				GuiControlGet, CheckBox_Only_Use_Avalanche_if_Have_Target
				if (CheckBox_Only_Use_Avalanche_if_Have_Target == 1 && String_ListBox_Combo = "Attack_Rune" && isAttacking = False) {
					BREAK
				}

				;USE SPELL
				if (Data.Skill[String_ListBox_Combo] != 1) {
					;DELAY
					GuiControlGet, CheckBox_Delay_Combo
					if (CheckBox_Delay_Combo == 1) {
						GuiControlGet, Delay_Combo
						Sleep, %Delay_Combo%
					}
					Press_Key(Type_Combo_Active "_Hotkey_Spell_" g)
					g++
					StartTime_Combo_Spells_Attack := A_TickCount
					BREAK
				}
			}
			g++
		}

		; [ Loot When Combo ]
		GuiControlGet, %Type_Combo_Active%_ComboWhileLooting
		if (%Type_Combo_Active%_ComboWhileLooting) {
			Lootear()
			Gui, Combo:Default
		}
	}


}
Combo_Spells_Support_Knight(){
    GLOBAL
	;~ Type_Combo_Active := "Combo_PvE"

	if (Data.Group["Support"] == 0) {
		;[Exeta Res]
		GuiControlGet, %Type_Combo_Active%_Delay_Exeta
		ElapsedTime_ExetaRes := A_TickCount - StartTime_ExetaRes
		if (ElapsedTime_ExetaRes > %Type_Combo_Active%_Delay_Exeta) {
			GuiControlGet, %Type_Combo_Active%_CheckBox_ExetaRes
			GuiControlGet, %Type_Combo_Active%_CheckBox_ExetaAmpRes
			if (%Type_Combo_Active%_CheckBox_ExetaRes == 1 && (%Type_Combo_Active%_CheckBox_ExetaAmpRes == 0 or NextExeta == "ExetaRes") ) {
				Press_Key(Type_Combo_Active "_Hotkey_ExetaRes")
				NextExeta := "ExetaAmpRes"
				StartTime_ExetaRes := A_TickCount
				RETURN
			} else if (%Type_Combo_Active%_CheckBox_ExetaAmpRes == 1 && (%Type_Combo_Active%_CheckBox_ExetaRes == 0 or NextExeta == "ExetaAmpRes") ) {
				Press_Key(Type_Combo_Active "_Hotkey_ExetaAmpRes")
				NextExeta := "ExetaRes"
				StartTime_ExetaRes := A_TickCount
				RETURN
			}
		}

		;[Utito Tempo]
		ElapsedTime_UtitoTempo := A_TickCount - StartTime_UtitoTempo
		GuiControlGet, %Type_Combo_Active%_CheckBox_UtitoTempo
		if ( (ElapsedTime_UtitoTempo > 10000 or Data.Conditions.Strength != 1) && %Type_Combo_Active%_CheckBox_UtitoTempo == 1) {	;10000ms = 10segundos = utito tempo
			GuiControlGet, %Type_Combo_Active%_Percent_Use_UtitoTempo
			intPercent_EK_UtitoTempo := %Type_Combo_Active%_Percent_Use_UtitoTempo
			if (Data.MP > intPercent_EK_UtitoTempo) {
				GuiControlGet, %Type_Combo_Active%_CheckBox_Use_UtitoTempo_Only_In_ExoriGran
				if (%Type_Combo_Active%_CheckBox_Use_UtitoTempo_Only_In_ExoriGran != 1) {
					Press_Key(Type_Combo_Active "_Hotkey_UtitoTempo")
					StartTime_UtitoTempo := A_TickCount
					RETURN
				} else if (Data.Skill["Exori_Gran"] == 0) {
					Press_Key(Type_Combo_Active "_Hotkey_UtitoTempo")
					StartTime_UtitoTempo := A_TickCount
					RETURN
				}
			}
		}
	}

}
Combo_Spells_Support_Paladin(){
    GLOBAL
	;~ Type_Combo_Active := "Combo_PvE"

	if (Data.Group["Support"] == 0) {
		;[Divine Empowerment]
		GuiControlGet, %Type_Combo_Active%_CheckBox_DivineEmpowerment
		if (%Type_Combo_Active%_CheckBox_DivineEmpowerment == 1 && Data.Skill.Divine_Empowerment == 0) {
			GuiControlGet, %Type_Combo_Active%_DropDownList_DivineEmpowerment_Qtd_Monster
			DivineEmpowerment_Qtd_Monster := %Type_Combo_Active%_DropDownList_DivineEmpowerment_Qtd_Monster
			if (DivineEmpowerment_Qtd_Monster <= AutoHunt.MonsterQuantity) {
				GuiControlGet, %Type_Combo_Active%_DropDownList_DivineEmpowerment_TargetHPpercent
				DivineEmpowerment_TargetHPpercent := %Type_Combo_Active%_DropDownList_DivineEmpowerment_TargetHPpercent
				DivineEmpowerment_TargetHPpercent := SubStr(DivineEmpowerment_TargetHPpercent, 1, StrLen(DivineEmpowerment_TargetHPpercent)-1)	;remove o caractere % dropdownlist
				if (Data.InfoMobs[PositionTargetMob]["HP"] >= DivineEmpowerment_TargetHPpercent ) {
					GuiControlGet, CheckBox_PressEsc_DivineEmpowerment
					if (CheckBox_PressEsc_DivineEmpowerment == 1) {
						ControlSend,, {Esc}, ahk_id %active_id%
						Sleep, 50
					}
					Press_Key(Type_Combo_Active "_Hotkey_DivineEmpowerment")
					RETURN
				}
			}
		}

		;~ [ Verify TargetHP ]
		;~ GuiControlGet, %Type_Combo_Active%_TargetHP_to_UseCombo
		;~ %Type_Combo_Active%_TargetHP_to_UseCombo := SubStr(%Type_Combo_Active%_TargetHP_to_UseCombo, 1, StrLen(%Type_Combo_Active%_TargetHP_to_UseCombo)-1)	;remove o caractere %
		;~ if (%Type_Combo_Active%_TargetHP_to_UseCombo < 100) {
			;~ if (isAttacking = False) {
				;~ RETURN
			;~ }
			;~ if not (Data.InfoMobs[PositionTargetMob]["HP"] <= %Type_Combo_Active%_TargetHP_to_UseCombo) {
				;~ RETURN
			;~ }
		;~ }

		;[Exeta Res]
		GuiControlGet, %Type_Combo_Active%_Support_Spell_Paladin_Delay
		ElapsedTime_ExetaRes := A_TickCount - StartTime_ExetaRes
		if (ElapsedTime_ExetaRes > %Type_Combo_Active%_Support_Spell_Paladin_Delay) {
			GuiControlGet, %Type_Combo_Active%_CheckBox_ExetaAmpRes
			if (%Type_Combo_Active%_CheckBox_ExetaAmpRes == 1) {
				Press_Key(Type_Combo_Active "_Hotkey_ExetaAmpRes")
				StartTime_ExetaRes := A_TickCount
				RETURN
			}
		}

		;[Utito Tempo San]
		ElapsedTime_UtitoTempo := A_TickCount - StartTime_UtitoTempo
		if (ElapsedTime_UtitoTempo > 10000 or Data.Conditions.Strength != 1) {	;10000ms = 10segundos = utito tempo
			GuiControlGet, %Type_Combo_Active%_CheckBox_UtitoTempoSan
			GuiControlGet, %Type_Combo_Active%_HPpercent_UtitoTempoSan
			GuiControlGet, %Type_Combo_Active%_MPpercent_UtitoTempoSan

			if (%Type_Combo_Active%_CheckBox_UtitoTempoSan == 1 && Data.HP >= %Type_Combo_Active%_HPpercent_UtitoTempoSan && Data.MP >= %Type_Combo_Active%_MPpercent_UtitoTempoSan) {
				Press_Key(Type_Combo_Active "_Hotkey_UtitoTempoSan")
				StartTime_UtitoTempo := A_TickCount
				RETURN
			}
		}
	}
}
Combo_Spells_Support_Sorcerer(){
    GLOBAL
	;~ Type_Combo_Active := "Combo_PvE"

	if (Data.Group["Support"] == 0) {
		GuiControlGet, %Type_Combo_Active%_CheckBox_Support_Spell_Sorcerer
		if (%Type_Combo_Active%_CheckBox_Support_Spell_Sorcerer && ( Data.Skill.Exori_Moe != 1 && Data.Skill.Exori_Kor != 1 )) {
			Press_Key(Type_Combo_Active "_Hotkey_Support_Spell_Sorcerer")
		}
	}

}


;	[ Enable And Disable Combo ]
AutoCombo_PvE:
AutoCombo_PvP:
Type_Combo_Active := SubStr(A_ThisLabel, -8)	;ativa o Combo PvE ou PvP
AutoCombo:
if (State_Combo != "ON") {
	Turn_Combo("ON")
} else {
	Turn_Combo("OFF")
}
return

Turn_Combo(State) {
    GLOBAL
	Gui, Combo:Default
	switch State {
		case "ON":
			State_Combo:="ON"
			FindMonsterOnBattleY := "NULL"	;pra não desativar o combo no fix_Bug_CaveBot_ComboON() quando tomar TRAP

			ToolTip("[" Type_Combo_Active "] Auto Combo !![ON]!!",-500,,,03)
			RETURN

		case "OFF":
			State_Combo:="OFF"

			ToolTip("Auto Combo !![OFF]!!",-500,,,03)

			GuiControlGet, Looting_When_Stop_Combo_CheckBox
			if (Looting_When_Stop_Combo_CheckBox == 1) {
				gosub, LootearBox
			}
			RETURN

		default:
			ToolTip("State Combo not definied",-500,,,03)
			RETURN
	}
}
