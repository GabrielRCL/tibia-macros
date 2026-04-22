Support_Spells(){
    GLOBAL
	ElapsedTime_Support_Spells := A_TickCount - StartTime_Support_Spells
	if (ElapsedTime_Support_Spells > 300) {
		Gui, Support:Default
		GuiControlGet, CheckBox_UseSupportSpells_InProtectZone ;use support spell in protect zone

		GuiControlGet, Checkbox_AutoBless
		if (CheckBox_AutoBless == 1) {
			color_BlessIcon := GetColorHex(Cords.Con.2+19,Cords.Con.3-138)
			if (color_BlessIcon = "#424242") {
				Press_Key("Hotkey_AutoBless")
			}
		}

		GuiControlGet, EatFood
		if (EatFood == 1 && Data.Conditions.EatFood == 1 && (Data.Conditions.ProtectionZone != 1 or CheckBox_UseSupportSpells_InProtectZone) ) {
			;~ ToolTip("Eating Food...")
			Press_Key("Hotkey_EatFood")
			StartTime_Support_Spells := A_TickCount
		}

		GuiControlGet, HealParalyze
		if (HealParalyze == 1 && Data.Group["Healing"] == 0) {
			if (Data.Conditions.CureParalyze == 1 ) {
				Press_Key("Hotkey_HealParalyze")
				StartTime_Support_Spells := A_TickCount
			} else if (TibiaServer = "Shadow-Illusion" && Data.Conditions.CureParalyze2 == 1) {
				Press_Key("Hotkey_HealParalyze")
				StartTime_Support_Spells := A_TickCount
			}
		}


		Gui, TankMode:Default
		GuiControlGet, CheckBox_TankMode_UtamoTempo, TankMode:
		ElapsedTime_UtamoTempo := A_TickCount - StartTime_UtamoTempo
		if (CheckBox_TankMode_UtamoTempo && ElapsedTime_UtamoTempo > 10000 && Data.Group["Support"] == 0) {
			GuiControlGet, Percent_TankMode_UtamoTempo, TankMode:
			intPercent_TankMode_UtamoTempo := Percent_TankMode_UtamoTempo
			if (Data.HP <= intPercent_TankMode_UtamoTempo) {
				Press_Key("Hotkey_TankMode_UtamoTempo")
				Data.Group["Support"] := 1
				StartTime_Support_Spells := A_TickCount
				StartTime_UtamoTempo := A_TickCount
				RETURN
			}
		}
		Gui, Support:Default

		GuiControlGet, ManaShield
		GuiControlGet, ManaShieldPotion
		GuiControlGet, UtamoVita_Life, TankMode:
		GuiControlGet, UtamoVitaPotion_Life, TankMode:
		GuiControlGet, Percent_UtamoVita_Life, TankMode:
		intPercent_UtamoVita_Life := Percent_UtamoVita_Life
		GuiControlGet, Break_Utamo_CheckBox, TankMode:
		GuiControlGet, Break_Utamo_Percent, TankMode:
		intBreak_Utamo_Percent := Break_Utamo_Percent
		if (ManaShield == 1 && Data.Conditions.ProtectionZone != 1 && Data.MP > 20) {
			GuiControlGet, RenewEveryTime	;renew every 14seconds utamo vita
			if (Data.Skill.MagicShield != 1 && (Data.Conditions.UtamoVita != 1 or RenewEveryTime) && Data.Group["Support"] == 0) {
				Press_Key("Hotkey_ManaShield")
				Data.Group["Support"] := 1
				StartTime_Support_Spells := A_TickCount
				RETURN
			}
			if (ManaShieldPotion == 1 && Data.Conditions.UtamoVita != 1) {
				;~ Verify_Conditions()
				if (Data.Conditions.UtamoVita != 1) {
					Press_Key("Hotkey_ManaShieldPotion")
					StartTime_Support_Spells := A_TickCount
				}
			}
		} else if (UtamoVita_Life == 1 && Data.Conditions.UtamoVita != 1 && Data.HP <= intPercent_UtamoVita_Life && Data.MP > 20) {
			Gui, TankMode:Default
			if (Data.Skill.MagicShield != 1 && Data.Group["Support"] == 0) {
				Press_Key("Hotkey_UtamoVita_Life")
				StartTime_Support_Spells := A_TickCount
				Data.Group["Support"] := 1
				RETURN
			}
			if (UtamoVitaPotion_Life == 1) {
				;~ Verify_Conditions()
				if (Data.Conditions.UtamoVita != 1) {
					Press_Key("Hotkey_UtamoVitaPotion_Life")
					StartTime_Support_Spells := A_TickCount
				}
			}
		} else if (Break_Utamo_CheckBox == 1 && Data.Conditions.UtamoVita == 1 && Data.HP >= intBreak_Utamo_Percent && ManaShield != 1 && Data.Group["Support"] == 0) {
			Gui, TankMode:Default
			Press_Key("Break_Utamo_Hotkey")
			StartTime_Support_Spells := A_TickCount
			Data.Group["Support"] := 1
			RETURN
		}

		Gui, Support:Default
		GuiControlGet, Haste
		GuiControlGet, %Type_Combo_Active%_Disable_Haste_When_Combo_ON, Combo:
		if (Haste == 1 && Data.Conditions.Haste != 1 && Data.Conditions.ProtectionZone != 1 && Data.Group["Support"] == 0) {
			if (State_Combo != "ON" or %Type_Combo_Active%_Disable_Haste_When_Combo_ON != 1) {	;para nao usar utani hur no combo!
				Press_Key("Hotkey_Haste")
				StartTime_Support_Spells := A_TickCount
				Data.Group["Support"] := 1
				if (TibiaServer == "Shadow-Illusion") {
					StartTime_Combo_Spells_Attack := A_TickCount + 999	;priority on Combo ON v7.x
				}
				RETURN
			}
		}

		GuiControlGet, Strengthen
		if (Strengthen == 1 && Data.Conditions.Strength != 1 && Data.Conditions.ProtectionZone != 1) {
			Press_Key("Hotkey_Strengthen")
			StartTime_Support_Spells := A_TickCount
		}


		GuiControlGet, Drunk_CheckBox
		if (Drunk_CheckBox == 1) {
			if StartTime_Equip_DwarvenRing is not number
				StartTime_Equip_DwarvenRing := 999999999999999	;disable

			ElapsedTime_Equip_DwarvenRing := A_TickCount - StartTime_Equip_DwarvenRing
			if ( Data.Conditions.Drunk == 1 ) {
				Press_Key("Drunk_Hotkey")
				StartTime_Support_Spells := A_TickCount
				StartTime_Equip_DwarvenRing := A_TickCount
				RETURN
			} else if (ElapsedTime_Equip_DwarvenRing > 61*1000) {
				StartTime_Equip_DwarvenRing := 999999999999999	;disable
				SearchPNG(PNG.Rings["DwarvenRing"], RConBarX, RConBarY, RConBarX+OffSet, RConBarY+OffSet, Tole:=20, Erro, Mode:=1),	Data.DwarvenRing_Eqquiped:=Erro
				if (Data.DwarvenRing_Eqquiped.1 == 1) {	;encontrou
					Press_Key("Drunk_Hotkey")
				}
			}
		}
	}
}

KeyToActiveSupport:
	Gui, Support:Default
	GuiControlGet, KeyToActive_EquipAmulet
	KeyToActive_EquipAmulet := RegExReplace(KeyToActive_EquipAmulet, "[\+\^\!]", "") ;remove caracteres especiais (fix bug Control, Shift, Alt)
	GuiControlGet, KeyToActive_EquipRing
	KeyToActive_EquipRing := RegExReplace(KeyToActive_EquipRing, "[\+\^\!]", "") ;remove caracteres especiais (fix bug Control, Shift, Alt)

	KeyState_EquipAmulet := GetKeyState(KeyToActive_EquipAmulet, "P")
	KeyState_EquipRing := GetKeyState(KeyToActive_EquipRing, "P")

	;Amulet
	if (KeyState_EquipAmulet) {
		Toggle_KeyToActive("EquipAmulet")
	}

	;Ring
	if (KeyState_EquipRing) {
		Toggle_KeyToActive("EquipRing")
	}
RETURN