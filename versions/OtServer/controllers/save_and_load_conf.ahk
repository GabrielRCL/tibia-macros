Save_And_Load_Configs(function) {
    GLOBAL
    FileCreateDir, %A_WorkingDir%\Configs\%TibiaServer%\%Vocation%

	; ======================= [ Extras - TAB ] ===========================
	Gui, Extras:Default
		%function%("Disable_PrintScreen", "Configs\Login.ini", "Disable_PrintScreen")
		%function%("KeyPauseMacro", "Configs\Login.ini", "Pause")
		%function%("Hide_All_Gui_Hotkey", "Configs\Login.ini", "Extras")
		%function%("PauseMacro_ChatOn_CheckBox", "Configs\Login.ini", "Extras")
		;~ %function%("Force_HP_Percent", "Configs\Login.ini", "Extras")
		;~ %function%("Force_MP_Percent", "Configs\Login.ini", "Extras")
		if (TibiaServer != "Global") {
			%function%("CheckBox_NoDelayActions", "Configs\Login.ini", "Extras")
		} else {
			%function%("Delay_PressHotkey", "Configs\Login.ini", "Extras")
		}
		%function%("Delay_Ping", "Configs\Login.ini", "Extras")
		%function%("CheckBox_ShowToolTip", "Configs\Login.ini", "Extras")

	; ======================= [ HOTKEY 7.4 - TAB ] ===========================
	Gui, Support:Default
	i := -1
	Loop, 10 {
		i++
		%function%("Support_Hotkey74_Hotkey"i, 	"Configs\" TibiaServer "\" Vocation "\Hotkey74.ini", "Hotkey"i)
		%function%("CheckBox_Hotkey74_Hotkey"i, "Configs\" TibiaServer "\" Vocation "\Hotkey74.ini", "Hotkey"i)
		%function%("Delay_Hotkey74_Hotkey"i, 	"Configs\" TibiaServer "\" Vocation "\Hotkey74.ini", "Hotkey"i)
	}

	i:=0
	Loop, 4 {
		i++
		%function%("Hotkey_Hotkeys74_PushItem"i, "Configs\" TibiaServer "\" Vocation "\Hotkey74.ini", "PushItem"i)
		%function%("PosX_Hotkeys74_PushItem"i,	 "Configs\" TibiaServer "\" Vocation "\Hotkey74.ini", "PushItem"i)
		%function%("PosY_Hotkeys74_PushItem"i,	 "Configs\" TibiaServer "\" Vocation "\Hotkey74.ini", "PushItem"i)
	}


	; ======================= [ HEALING - TAB ] ===========================
	Gui, Healing:Default
	if (true) {
		;[Utito Tempo San - ignore Healing]
		if (Vocation == "Paladin") {
			%function%("UtitoIgnoreHealing", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Others")
		}
		;[Delay to Healing]
			%function%("DelayToHealing", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Delay")

		;[Drop flask]
			%function%("CheckBox_DropFlask", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Utilities")

		;[Adv. Options]
			%function%("CheckBox_Dont_Use_Healing1_if_Combo_ON", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Adv. Options")


	;[ LIFE Healing ]
		;[Stage 1]
			%function%("CheckBox_Life_Stage1", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage1")
			%function%("Percent_Health_Life_Stage1", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage1")
			%function%("Percent_Mana_Life_Stage1", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage1")
			%function%("Hotkey_Potion_Life_Stage1", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage1")
			%function%("Hotkey_Spell_Life_Stage1", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage1")
		;[Stage 2]
			%function%("CheckBox_Life_Stage2", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage2")
			%function%("Percent_Health_Life_Stage2", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage2")
			%function%("Percent_Mana_Life_Stage2", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage2")
			%function%("Hotkey_Potion_Life_Stage2", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage2")
			%function%("Hotkey_Spell_Life_Stage2", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage2")
		;[Stage 3]
			%function%("CheckBox_Life_Stage3", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage3")
			%function%("Percent_Health_Life_Stage3", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage3")
			%function%("Percent_Mana_Life_Stage3", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage3")
			%function%("Hotkey_Potion_Life_Stage3", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage3")
			%function%("Hotkey_Spell_Life_Stage3", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage3")
			%function%("Hotkey_Others_Life_Stage3", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage3")
		;[Stage 4]
			%function%("CheckBox_Life_Stage4", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage4")
			%function%("Percent_Health_Life_Stage4", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage4")
			%function%("Percent_Mana_Life_Stage4", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage4")
			%function%("Hotkey_Potion_Life_Stage4", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage4")
			%function%("Hotkey_Spell_Life_Stage4", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage4")
			%function%("Hotkey_Others_Life_Stage4", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Life_Stage4")

	;[ MANA HEALING ]
		;[Stage 1]
			%function%("CheckBox_Mana_Stage1", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Mana_Stage1")
			%function%("Percent_Mana_Stage1", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Mana_Stage1")
			%function%("Hotkey_Potion_Mana_Stage1", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Mana_Stage1")
		;[Stage 2]
			%function%("CheckBox_Mana_Stage2", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Mana_Stage2")
			%function%("Percent_Mana_Stage2", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Mana_Stage2")
			%function%("Hotkey_Potion_Mana_Stage2", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Mana_Stage2")
		;[IGNORE]
			%function%("Percent_IgnoreMana_Stage1", "Configs\" TibiaServer "\" Vocation "\Healing.ini", "Mana_Stage1")
			if (Percent_IgnoreMana_Stage1 == 0 or Percent_IgnoreMana_Stage1 == "ERROR") {	;fix bug
				Percent_IgnoreMana_Stage1 := 1
			}

	}

	; ======================= [ TANK MODE - TAB ] ===========================
	Gui, TankMode:Default
	if (true) {
	;[ DELAY ]
		%function%("DelayTankMode", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Delay")
		if DelayTankMode is not number
			GuiControl,, DelayTankMode, %defaultDelayTankMode%	;valor está na DraW_GUI

	; [ ADV. OPTIONS ]
		%function%("CheckBox_TankMode_Fear", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Adv_Options")
		%function%("CheckBox_TankMode_Root", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Adv_Options")

	;[ TankMode - Amulet ]
		;[Life]
			%function%("SSA_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "SSA_Life")
			%function%("DropDownList_TankModeLife_Amulet", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "DropDownList_TankModeLife_Amulet", "DropDownList")
			%function%("Key_Enable_SSA_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "SSA_Life")
			%function%("Percent_SSA_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "SSA_Life")
			%function%("Hotkey_SSA_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "SSA_Life")
			%function%("HP_RemoveAutomaticallySSA", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "SSA_Life")
		;[Mana]
			%function%("SSA_Mana", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "SSA_Mana")
			%function%("DropDownList_TankModeMana_Amulet", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "DropDownList_TankModeMana_Amulet", "DropDownList")
			%function%("Key_Enable_SSA_Mana", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "SSA_Mana")
			%function%("Percent_SSA_Mana", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "SSA_Mana")
			%function%("Hotkey_SSA_Mana", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "SSA_Mana")
			%function%("MP_RemoveAutomaticallySSA", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "SSA_Mana")

	;[ TankMode - Ring ]
		;[Life]
			%function%("MightRing_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "MightRing_Life")
			%function%("DropDownList_TankModeLife_Ring", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "DropDownList_TankModeLife_Ring", "DropDownList")
			%function%("Key_Enable_MightRing_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "MightRing_Life")
			%function%("Percent_MightRing_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "MightRing_Life")
			%function%("Hotkey_MightRing_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "MightRing_Life")
			%function%("HP_RemoveAutomaticallyMight", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "MightRing_Life")
		;[Mana]
			%function%("MightRing_Mana", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "MightRing_Mana")
			%function%("DropDownList_TankModeMana_Ring", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "DropDownList_TankModeMana_Ring", "DropDownList")
			%function%("Key_Enable_MightRing_Mana", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "MightRing_Mana")
			%function%("Percent_MightRing_Mana", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "MightRing_Mana")
			%function%("Hotkey_MightRing_Mana", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "MightRing_Mana")
			%function%("MP_RemoveAutomaticallyMight", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "MightRing_Mana")

	;[ SPECIAL FOOD ]
		;[Life]
			%function%("Food_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Food_Life")
			%function%("Percent_Food_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Food_Life")
			%function%("Hotkey_Food_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Food_Life")
		;[Mana]
			%function%("Food_Mana", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Food_Mana")
			%function%("Percent_Food_Mana", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Food_Mana")
			%function%("Hotkey_Food_Mana", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Food_Mana")

	;[ Utamo Vita TANKMODE ]
		;[Life] ONLY MAGE
			if (Vocation == "Druid" or Vocation == "Sorcerer") {
				%function%("UtamoVita_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "UtamoVita_Life")
				%function%("Percent_UtamoVita_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "UtamoVita_Life")
				%function%("Hotkey_UtamoVita_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "UtamoVita_Life")

				;[UTAMO POTION TANKMODE]
				%function%("UtamoVitaPotion_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "UtamoVita_Life")
				%function%("Hotkey_UtamoVitaPotion_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "UtamoVita_Life")


				;[BREAK UTAMO VITA]
				%function%("Break_Utamo_CheckBox", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "UtamoVita_Life")
				%function%("Break_Utamo_Percent", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "UtamoVita_Life")
				%function%("Break_Utamo_Hotkey", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "UtamoVita_Life")


				;[Others]
				;GuiControlGet, OldUtamoVita ;nao ta na gui
				IniWrite, %OldUtamoVita%, Configs\%TibiaServer%\%Vocation%\TankMode.ini, Others, OldUtamoVita
				%function%("RenewOnlyWhenDontHave", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Others")
			} else {
				OldUtamoVita := 1
				IniWrite, %OldUtamoVita%, Configs\%TibiaServer%\%Vocation%\TankMode.ini, Others, OldUtamoVita
			}


		;[ Energy Ring ]
			;Equip Energy Ring
			%function%("EnergyRing_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "EnergyRing_Life")
			%function%("Percent_EnergyRing_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "EnergyRing_Life")
			%function%("Hotkey_EnergyRing_Life", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "EnergyRing_Life")

			;REMOVE ENERGY RING LIFE
			%function%("Remove_EnergyRing_CheckBox", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "EnergyRing_Life")
			%function%("Remove_EnergyRing_Percent", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "EnergyRing_Life")
			%function%("Remove_EnergyRing_Hotkey", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "EnergyRing_Life")

			;REMOVE ENERGY RING MANA
			%function%("CheckBox_Remove_EnergyRing_Mana", 	"Configs\" TibiaServer "\" Vocation "\TankMode.ini", "EnergyRing_Life")
			%function%("Percent_Remove_EnergyRing_Mana", 	"Configs\" TibiaServer "\" Vocation "\TankMode.ini", "EnergyRing_Life")
			%function%("Hotkey_Remove_EnergyRing_Mana", 	"Configs\" TibiaServer "\" Vocation "\TankMode.ini", "EnergyRing_Life")


	;[ Utamo Tempo TankMode]
		if (Vocation == "Knight") {
			%function%("CheckBox_TankMode_UtamoTempo", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "CheckBox_TankMode_UtamoTempo")
			%function%("Percent_TankMode_UtamoTempo", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Percent_TankMode_UtamoTempo")
			%function%("Hotkey_TankMode_UtamoTempo", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "Hotkey_TankMode_UtamoTempo")
		}

	}
	; ======================= [ SUPPORT - TAB ] ===========================
	Gui, Support:Default
	if (true) {
	;[ Haste ]
		%function%("Haste", "Configs\" TibiaServer "\" Vocation "\Support.ini", "Haste")
		%function%("Hotkey_Haste", "Configs\" TibiaServer "\" Vocation "\Support.ini", "Haste")

	;[ Heal Paralyze ]
		%function%("HealParalyze", "Configs\" TibiaServer "\" Vocation "\Support.ini", "HealParalyze")
		%function%("Hotkey_HealParalyze", "Configs\" TibiaServer "\" Vocation "\Support.ini", "Hotkey_HealParalyze")

	;[ Strengthen ]
		%function%("Strengthen", "Configs\" TibiaServer "\" Vocation "\Support.ini", "Strengthen")
		%function%("Hotkey_Strengthen", "Configs\" TibiaServer "\" Vocation "\Support.ini", "Strengthen")

	;[ Eat Food ]
		%function%("EatFood", "Configs\" TibiaServer "\" Vocation "\Support.ini", "EatFood")
		%function%("Hotkey_EatFood", "Configs\" TibiaServer "\" Vocation "\Support.ini", "EatFood")

	;[ Equip Amulet ]
		%function%("EquipAmulet", "Configs\" TibiaServer "\" Vocation "\Support.ini", "EquipAmulet")
		%function%("Hotkey_EquipAmulet", "Configs\" TibiaServer "\" Vocation "\Support.ini", "EquipAmulet")
		%function%("KeyToActive_EquipAmulet", "Configs\" TibiaServer "\" Vocation "\Support.ini", "EquipAmulet")

	;[ Equip Ring ]
		%function%("EquipRing", "Configs\" TibiaServer "\" Vocation "\Support.ini", "EquipRing")
		%function%("Hotkey_EquipRing", "Configs\" TibiaServer "\" Vocation "\Support.ini", "EquipRing")
		%function%("KeyToActive_EquipRing", "Configs\" TibiaServer "\" Vocation "\Support.ini", "EquipRing")

	;[ Reload AMMO ]
		if (Vocation == "Paladin") {
			%function%("CheckBox_ConjureArrow", "Configs\" TibiaServer "\" Vocation "\Support.ini", "RefillAmmo")
			%function%("Hotkey_ConjureArrow",	"Configs\" TibiaServer "\" Vocation "\Support.ini", "RefillAmmo")
			%function%("CheckBox_EquipArrow",	"Configs\" TibiaServer "\" Vocation "\Support.ini", "RefillAmmo")
			%function%("Hotkey_EquipArrow",		"Configs\" TibiaServer "\" Vocation "\Support.ini", "RefillAmmo")
		}

	;[ Mana Shield Support]
		if (Vocation == "Druid" or Vocation == "Sorcerer") {
		;[Spell ManaShield]
			%function%("ManaShield", "Configs\" TibiaServer "\" Vocation "\Support.ini", "ManaShield")
			%function%("Hotkey_ManaShield", "Configs\" TibiaServer "\" Vocation "\Support.ini", "ManaShield")

		;[Potion ManaShield]
			%function%("ManaShieldPotion", "Configs\" TibiaServer "\" Vocation "\Support.ini", "ManaShield")
			%function%("Hotkey_ManaShieldPotion", "Configs\" TibiaServer "\" Vocation "\Support.ini", "ManaShield")
		;[Radio Buttons]
			%function%("RenewEveryTime", "Configs\" TibiaServer "\" Vocation "\Support.ini", "RadioButtons")
			%function%("RenewOnlyWhenDontHave", "Configs\" TibiaServer "\" Vocation "\Support.ini", "RadioButtons")

		;Others
			;OLD UTAMO VITA NAO TA NA GUI
			IniWrite, %OldUtamoVita%, Configs\%TibiaServer%\%Vocation%\Support.ini, Others, OldUtamoVita
		} else {
			OldUtamoVita := 1
			IniWrite, %OldUtamoVita%, Configs\%TibiaServer%\%Vocation%\Support.ini, Others, OldUtamoVita
		}

	; [ DRUNK ]
		%function%("Drunk_CheckBox", "Configs\" TibiaServer "\" Vocation "\Support.ini", "Drunk")
		%function%("Drunk_Hotkey", "Configs\" TibiaServer "\" Vocation "\Support.ini", "Drunk")

	; [ AUTO BLESS ]
		%function%("CheckBox_AutoBless", "Configs\" TibiaServer "\" Vocation "\Support.ini", "AutoBless")
		%function%("Hotkey_AutoBless", "Configs\" TibiaServer "\" Vocation "\Support.ini", "AutoBless")

	}
	; ======================= [ HEAL FRIEND - TAB ] ===========================
	Gui, HealFriend:Default
	if (true) {
		if (Vocation != "Knight") {
			; [Others]
				%function%("checkBox_Inverter_Prioridade_HealFriend", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "Others")

			;[ [EK] Sio Friend ]
				;[Stage1]
					%function%("EK_ExuraSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "EK_ExuraSio")
					%function%("Hotkey_EK_ExuraSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "EK_ExuraSio")
					%function%("Percent_EK_ExuraSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "EK_ExuraSio")
				;[OLD]
					%function%("EK_ExuraSioX", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "EK_ExuraSio")
					%function%("EK_ExuraSioY", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "EK_ExuraSio")

			;[ [RP] Sio Friend ]
				;[Stage1]
					%function%("RP_ExuraSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "RP_ExuraSio")
					%function%("Hotkey_RP_ExuraSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "RP_ExuraSio")
					%function%("Percent_RP_ExuraSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "RP_ExuraSio")
				;[OLD]
					%function%("RP_ExuraSioX", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "RP_ExuraSio")
					%function%("RP_ExuraSioY", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "RP_ExuraSio")

		}
	;[DRUID] Heal Friend  ===================================
		if (Vocation == "Druid") {
			;[ [EK] Sio Friend ]
				;[Stage2]
					%function%("EK_ExuraGranSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "EK_ExuraGranSio")
					%function%("Hotkey_EK_ExuraGranSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "EK_ExuraGranSio")
					%function%("Percent_EK_ExuraGranSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "EK_ExuraGranSio")

				;[OLD]
					%function%("EK_ExuraGranSioX", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "EK_ExuraGranSio")
					%function%("EK_ExuraGranSioY", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "EK_ExuraGranSio")

			; [RP] Sio Friend ===============================
				;[Stage2]
					%function%("RP_ExuraGranSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "RP_ExuraGranSio")
					%function%("Hotkey_RP_ExuraGranSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "RP_ExuraGranSio")
					%function%("Percent_RP_ExuraGranSio", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "RP_ExuraGranSio")
				;[OLD]
					%function%("RP_ExuraGranSioX", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "RP_ExuraGranSio")
					%function%("RP_ExuraGranSioY", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "RP_ExuraGranSio")

			; [MASS HEALING] Exura Gran mas Res ============================
				;[Stage1]
					%function%("MasRes", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "MasRes")
					%function%("Percent_MasRes_Stage1", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "MasRes")
					%function%("Hotkey_MasRes", "Configs\" TibiaServer "\" Vocation "\HealFriend.ini", "MasRes")
		}

	}
	; ======================= [ COMBO - TAB ] ===========================
	Gui, Combo:Default
	if (true) {
	;[ADV. OPTIONS]
		%function%("CheckBox_Delay_Combo",								"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Adv. Options")
		%function%("Delay_Combo", 										"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Adv. Options")
		%function%("CheckBox_Ignore_Potion_if_Use_Avalanche",			"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Adv. Options")
		%function%("CheckBox_Only_Use_Avalanche_if_Have_Target",		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Adv. Options")

	;[KEY TO ACTIVE]
		%function%("Combo_PvE_Key_Enable", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")
		%function%("Combo_PvP_Key_Enable", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")

		%function%("Combo_PvE_CheckBox_Automatic_Combo", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")
		%function%("Combo_PvP_CheckBox_Automatic_Combo", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")

	;[ OTHERS ]
		%function%("Combo_PvE_ComboWhileLooting",						"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")
		%function%("Combo_PvP_ComboWhileLooting",						"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")

		%function%("Combo_PvE_Looting_When_Stop_Combo_CheckBox",		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")
		%function%("Combo_PvP_Looting_When_Stop_Combo_CheckBox",		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")

		%function%("Combo_PvE_Disable_Haste_When_Combo_ON", 			"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")
		%function%("Combo_PvP_Disable_Haste_When_Combo_ON", 			"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")

		%function%("Combo_PvE_CheckBox_Priority_Spell", 				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")
		%function%("Combo_PvP_CheckBox_Priority_Spell", 				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Others")

		Disable_Gui_ListBox_Combo("Combo_PvE")	;CheckBox_Priority_Spell
		Disable_Gui_ListBox_Combo("Combo_PvP")	;CheckBox_Priority_Spell

	;[EK] Auto Combo =====================================
		if (Vocation == "Knight") {
			;[Adv.Options]
				%function%("Force_ExoriGran",					"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Adv. Options")

			;[Support]
				;[Utito Tempo]
					%function%("Combo_PvE_CheckBox_UtitoTempo", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempo")
					%function%("Combo_PvP_CheckBox_UtitoTempo", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempo")

					%function%("Combo_PvE_Hotkey_UtitoTempo", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempo")
					%function%("Combo_PvP_Hotkey_UtitoTempo", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempo")

					%function%("Combo_PvE_Percent_Use_UtitoTempo", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempo")
					%function%("Combo_PvP_Percent_Use_UtitoTempo", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempo")

					%function%("Combo_PvE_Percent_Use_UtitoTempo", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempo")
					%function%("Combo_PvP_Percent_Use_UtitoTempo", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempo")

					%function%("Combo_PvE_CheckBox_Use_UtitoTempo_Only_In_ExoriGran", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempo")
					%function%("Combo_PvP_CheckBox_Use_UtitoTempo_Only_In_ExoriGran", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempo")

				;[Exeta Res]
					%function%("Combo_PvE_CheckBox_ExetaRes", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaRes")
					%function%("Combo_PvP_CheckBox_ExetaRes", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaRes")

					%function%("Combo_PvE_Hotkey_ExetaRes", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaRes")
					%function%("Combo_PvP_Hotkey_ExetaRes", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaRes")

					%function%("Combo_PvE_CheckBox_ExetaAmpRes", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaRes")
					%function%("Combo_PvP_CheckBox_ExetaAmpRes", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaRes")

					%function%("Combo_PvE_Hotkey_ExetaAmpRes", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaRes")
					%function%("Combo_PvP_Hotkey_ExetaAmpRes", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaRes")

					%function%("Combo_PvE_Delay_Exeta", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaRes")
					%function%("Combo_PvP_Delay_Exeta", "Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaRes")
			;[Attack]
				;[SPELL's]
				i := 1
				Loop, 4 {
					%function%("Combo_PvE_CheckBox_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)
					%function%("Combo_PvP_CheckBox_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)

					%function%("Combo_PvE_Hotkey_Spell_" i,					"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)
					%function%("Combo_PvP_Hotkey_Spell_" i,					"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)

					%function%("Combo_PvE_DropDownList_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvP_DropDownList_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")

					%function%("Combo_PvE_DropDownList_Qtd_Monster_Spell_" i, 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvP_DropDownList_Qtd_Monster_Spell_" i, 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")

					%function%("Combo_PvP_DropDownList_TargetHP_Spell_" i, 		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvE_DropDownList_TargetHP_Spell_" i, 		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					i++
				}
		}

	;[RP] Auto Combo =====================================
		if (Vocation == "Paladin") {
			;[Support Spells]
				;[Utito Tempo San]
					%function%("Combo_PvE_CheckBox_UtitoTempoSan",	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempoSan")
					%function%("Combo_PvP_CheckBox_UtitoTempoSan",	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempoSan")

					%function%("Combo_PvE_Hotkey_UtitoTempoSan",	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempoSan")
					%function%("Combo_PvP_Hotkey_UtitoTempoSan",	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempoSan")

					%function%("Combo_PvE_Percent_HP_UtitoTempoSan", 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempoSan")
					%function%("Combo_PvP_Percent_HP_UtitoTempoSan", 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "UtitoTempoSan")

				;[Exeta Amp Res]
					%function%("Combo_PvE_CheckBox_ExetaAmpRes",		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaAmpRes")
					%function%("Combo_PvP_CheckBox_ExetaAmpRes",		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaAmpRes")

					%function%("Combo_PvE_Hotkey_ExetaAmpRes",			"Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaAmpRes")
					%function%("Combo_PvP_Hotkey_ExetaAmpRes",			"Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaAmpRes")

					%function%("Combo_PvE_Support_Spell_Paladin_Delay",	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaAmpRes")
					%function%("Combo_PvP_Support_Spell_Paladin_Delay",	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "ExetaAmpRes")

				;[Divine Empowerment]
					%function%("Combo_PvE_CheckBox_DivineEmpowerment",			"Configs\" TibiaServer "\" Vocation "\Combo.ini", "DineEmpowerment")
					%function%("Combo_PvP_CheckBox_DivineEmpowerment",			"Configs\" TibiaServer "\" Vocation "\Combo.ini", "DineEmpowerment")

					%function%("Combo_PvE_Hotkey_DivineEmpowerment",			"Configs\" TibiaServer "\" Vocation "\Combo.ini", "DineEmpowerment")
					%function%("Combo_PvP_Hotkey_DivineEmpowerment",			"Configs\" TibiaServer "\" Vocation "\Combo.ini", "DineEmpowerment")

					%function%("Combo_PvE_DropDownList_DivineEmpowerment_Qtd_Monster",	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "DineEmpowerment", "DropDownList")
					%function%("Combo_PvP_DropDownList_DivineEmpowerment_Qtd_Monster",	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "DineEmpowerment", "DropDownList")


					%function%("Combo_PvE_DropDownList_DivineEmpowerment_TargetHPpercent",	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "DineEmpowerment", "DropDownList")
					%function%("Combo_PvP_DropDownList_DivineEmpowerment_TargetHPpercent",	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "DineEmpowerment", "DropDownList")


					%function%("CheckBox_PressEsc_DivineEmpowerment",	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "DineEmpowerment")


			;[Attack]
				;[SPELL's]
				i := 1
				Loop, 4 {
					%function%("Combo_PvE_CheckBox_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)
					%function%("Combo_PvP_CheckBox_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)

					%function%("Combo_PvE_Hotkey_Spell_" i,					"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)
					%function%("Combo_PvP_Hotkey_Spell_" i,					"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)

					%function%("Combo_PvE_DropDownList_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvP_DropDownList_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")

					%function%("Combo_PvE_DropDownList_Qtd_Monster_Spell_" i, 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvP_DropDownList_Qtd_Monster_Spell_" i, 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")

					%function%("Combo_PvP_DropDownList_TargetHP_Spell_" i, 		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvE_DropDownList_TargetHP_Spell_" i, 		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					i++
				}

		}

	;[ED] Auto Combo =====================================
		if (Vocation == "Druid") {
			;[Attack]
				;[SPELL's]
				i := 1
				Loop, 6 {
					%function%("Combo_PvE_CheckBox_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)
					%function%("Combo_PvP_CheckBox_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)

					%function%("Combo_PvE_Hotkey_Spell_" i,					"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)
					%function%("Combo_PvP_Hotkey_Spell_" i,					"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)

					%function%("Combo_PvE_DropDownList_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvP_DropDownList_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")

					%function%("Combo_PvE_DropDownList_Qtd_Monster_Spell_" i, 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvP_DropDownList_Qtd_Monster_Spell_" i, 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")

					%function%("Combo_PvP_DropDownList_TargetHP_Spell_" i, 		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvE_DropDownList_TargetHP_Spell_" i, 		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					i++
				}
		}

	;[MS] Auto Combo =====================================
		if (Vocation == "Sorcerer") {
			;[Support Spells]
				%function%("Combo_PvE_CheckBox_Support_Spell_Sorcerer", 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Support")
				%function%("Combo_PvP_CheckBox_Support_Spell_Sorcerer", 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Support")

				%function%("Combo_PvE_Hotkey_Support_Spell_Sorcerer", 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Support")
				%function%("Combo_PvP_Hotkey_Support_Spell_Sorcerer", 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Support")

			;[Attack]
				;[SPELL's]
				i := 1
				Loop, 6 {
					%function%("Combo_PvE_CheckBox_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)
					%function%("Combo_PvP_CheckBox_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)

					%function%("Combo_PvE_Hotkey_Spell_" i,					"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)
					%function%("Combo_PvP_Hotkey_Spell_" i,					"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i)

					%function%("Combo_PvE_DropDownList_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvP_DropDownList_Spell_" i,				"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")

					%function%("Combo_PvE_DropDownList_Qtd_Monster_Spell_" i, 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvP_DropDownList_Qtd_Monster_Spell_" i, 	"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")

					%function%("Combo_PvE_DropDownList_TargetHP_Spell_" i, 		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					%function%("Combo_PvP_DropDownList_TargetHP_Spell_" i, 		"Configs\" TibiaServer "\" Vocation "\Combo.ini", "Spell_" i, "DropDownList")
					i++
				}
		}
	}


	; ======================= [ PvP - TAB ] ===========================
	Gui, PvP:Default
	if (true) {
		%function%("Delay_PvP", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Delay_PvP")
		;[ AUTO FOLLOW ]
			%function%("CheckBoxAutoFollow", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "CheckBoxAutoFollow")
		;[ FLOWER ]
			%function%("Flower", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Flower")
			%function%("Key_Enable_Flower", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Flower")
			%function%("FlowerX", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Flower")
			%function%("FlowerY", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Flower")
		;[ Trash 1 e Trash 2 ]
			%function%("Trash1", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Trash")
			%function%("Trash2", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Trash")
			%function%("Key_Enable_Trash", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Trash")
			%function%("Trash1X", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Trash")
			%function%("Trash1Y", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Trash")
			%function%("Trash2X", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Trash")
			%function%("Trash2Y", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Trash")
		;[ PUSH ITEM ]
			%function%("PushItem", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "PushItem")
			%function%("Key_Enable_PushItem", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "PushItem")
			%function%("PushItemX", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "PushItem")
			%function%("PushItemY", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "PushItem")

		;[ SWAP RUNE ]
			;[MagicWall]
				%function%("InstantMagicWall", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "MagicWall")
				%function%("CheckBox_SwapSqmWithMW", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "MagicWall")
				%function%("Hotkey_MagicWall", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "MagicWall")

				;[FIX THIS]
				%function%("Key_Enable_SwapSqmWithMW", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "MagicWall", "DropDownList")


			;[Growth]
				%function%("InstantGrowth", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Growth")
				%function%("CheckBox_SwapSqmWithGrowth", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Growth")
				%function%("Hotkey_GrowthRune", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Growth")

				;FIX THIS
				%function%("Key_Enable_SwapSqmWithGrowth", "Configs\" TibiaServer "\" Vocation "\PvP.ini", "Growth", "DropDownList")
	}
	; ======================= [ REMAPKEYS - TAB ] ===========================
	Gui, RemapKeys:Default
	if (true) {
		;[Wheel Up]
			%function%("DestinationKey_WheelUp_RemapKeys", "Configs\" TibiaServer "\" Vocation "\RemapKeys.ini", "WheelUp")
			%function%("WheelUp_RemapKeys_Click", "Configs\" TibiaServer "\" Vocation "\RemapKeys.ini", "WheelUp")
		;[Wheel Down]
			%function%("DestinationKey_WheelDown_RemapKeys", "Configs\" TibiaServer "\" Vocation "\RemapKeys.ini", "WheelDown")
			%function%("WheelDown_RemapKeys_Click", "Configs\" TibiaServer "\" Vocation "\RemapKeys.ini", "WheelDown")
		;[BrowserForward - Xbutton2]
			%function%("DestinationKey_BrowserForward_RemapKeys", "Configs\" TibiaServer "\" Vocation "\RemapKeys.ini", "XButton2")
			%function%("BrowserForward_RemapKeys_Click", "Configs\" TibiaServer "\" Vocation "\RemapKeys.ini", "XButton2")
		;[BrowserForward - Xbutton1]
			%function%("DestinationKey_BrowserBack_RemapKeys", "Configs\" TibiaServer "\" Vocation "\RemapKeys.ini", "XButton1")
			%function%("BrowserBack_RemapKeys_Click", "Configs\" TibiaServer "\" Vocation "\RemapKeys.ini", "XButton1")
	}

	; =========================== [ ALARMS ] ===========================
	Gui, Alarms:Default
	if (true) {
		;[Alarms]
			;[Player On Screen]
			%function%("CheckBox_AlarmSound_PlayerOnScreen", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PlayerOnScreen")
			%function%("CheckBox_FocusTibia_PlayerOnScreen", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PlayerOnScreen")
			%function%("CheckBox_TelegramBot_PlayerOnScreen", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PlayerOnScreen")

			;[Private Message]
			%function%("CheckBox_AlarmSound_PrivateMSG", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PrivateMessage")
			%function%("CheckBox_FocusTibia_PrivateMSG", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PrivateMessage")
			%function%("CheckBox_TelegramBot_PrivateMSG", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PrivateMessage")

			;[Local Message]
			%function%("CheckBox_AlarmSound_LocalMSG", 							"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PlayerOnScreen")
			%function%("CheckBox_FocusTibia_LocalMSG", 							"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PlayerOnScreen")
			%function%("CheckBox_TelegramBot_LocalMSG", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PlayerOnScreen")

			;[Disconnect]
			%function%("CheckBox_AlarmSound_Disconnect", 							"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PlayerOnScreen")
			;~ %function%("CheckBox_FocusTibia_Disconnect", 							"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PlayerOnScreen")
			%function%("CheckBox_TelegramBot_Disconnect", 							"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "PlayerOnScreen")

			;[Anti-AFK]
			%function%("CheckBox_AlarmSound_AntiAFK", 							"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "Anti-AFK")
			%function%("CheckBox_FocusTibia_AntiAFK", 							"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "Anti-AFK")
			%function%("CheckBox_TelegramBot_AntiAFK", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "Anti-AFK")

		;[Telegram Bot]
		%function%("CheckBox_TelegramBot", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "TelegramBot")
		%function%("Delay_TelegramBot", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "TelegramBot")
		%function%("botToken_TelegramBot", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "TelegramBot")
		%function%("chatID_TelegramBot", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "TelegramBot")

		;[ADV. OPTIONS]
		%function%("CheckBox_Play_Alarms_Only_if_CaveBot_Enable", 						"Configs\" TibiaServer "\" Vocation "\Alarms.ini", "Adv. Options")
	}

	; ======================= [ LOOTER - TAB ] ===========================
	Gui, Looter:Default
	if (true) {
		;[Ghost Mouse]
			%function%("Looter_Ghost_Mouse", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "Others")
		;[Looter Type]
			%function%("Looter_Type_Coordinates", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "LooterType")
			%function%("Looter_Type_Hotkey", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "LooterType")
			%function%("Looter_Type_Hotkey_Hotkey", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "LooterType")
			gosub, Looter_Type_GuiControl	;change gui control on GUI
		;[ DELAY ]
			%function%("Delay_Looter", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "Delay")
			if Delay_Looter is not number
				GuiControl,, Delay_Looter, 27
		;[ LOOTEAR BOX ]
			%function%("Looter", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "Looter")
			%function%("Hotkey_Looter", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "Looter")
		;[MOUSE BUTTON LOOTER]
			GuiControlGet,LooterMouseButton
			if (LooterMouseButton == "XButton1") {
				Choose_LooterMouseButton := 2
			} else if (LooterMouseButton == "XButton2") {
				Choose_LooterMouseButton := 3
			} else if (LooterMouseButton == "WheelUp") {
				Choose_LooterMouseButton := 4
			} else if (LooterMouseButton == "WheelDown") {
				Choose_LooterMouseButton := 5
			} else {
				Choose_LooterMouseButton := 1
			}
				IniWrite, %Choose_LooterMouseButton%, Configs\%TibiaServer%\%Vocation%\Looter.ini, Looter, Choose_LooterMouseButton
		;[ SQM ]
			%function%("LooterSQM_1X", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")
			%function%("LooterSQM_1Y", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")

			%function%("LooterSQM_2X", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")
			%function%("LooterSQM_2Y", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")

			%function%("LooterSQM_3X", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")
			%function%("LooterSQM_3Y", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")

			%function%("LooterSQM_4X", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")
			%function%("LooterSQM_4Y", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")

			%function%("LooterSQM_5X", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")
			%function%("LooterSQM_5Y", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")

			%function%("LooterSQM_6X", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")
			%function%("LooterSQM_6Y", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")

			%function%("LooterSQM_7X", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")
			%function%("LooterSQM_7Y", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")

			%function%("LooterSQM_8X", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")
			%function%("LooterSQM_8Y", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")

			%function%("LooterSQM_9X", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")
			%function%("LooterSQM_9Y", "Configs\" TibiaServer "\" Vocation "\Looter.ini", "SQM")
	}

	; ======================= [ TIMER - TAB ] ===========================
	Gui, Timer:Default
	if (true) {
		;[ Timer 1 ]
			%function%("Hotkey1TimerCheckBox", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer1")
			%function%("Hotkey1TimerHotkey", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer1")
			%function%("Hotkey1TimerDelay", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer1")

		;[ Timer 2 ]
			%function%("Hotkey2TimerHotkey", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer2")
			%function%("Hotkey2TimerCheckBox", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer2")
			%function%("Hotkey2TimerDelay", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer2")

		;[ Timer 3]
			%function%("Hotkey3TimerHotkey", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer3")
			%function%("Hotkey3TimerCheckBox", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer3")
			%function%("Hotkey3TimerDelay", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer3")

		;[ Timer 4 ]
			%function%("Hotkey4TimerHotkey", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer4")
			%function%("Hotkey4TimerCheckBox", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer4")
			%function%("Hotkey4TimerDelay", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "Timer4")

		;[ Reconnect ]
			%function%("ReconnectCheckBox", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "ReconnectCheckBox")
			%function%("ReconnectTimer", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "ReconnectCheckBox")

		;[ Exercise Training ]
			;[Hotkey]
				%function%("HotkeyExercise", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "ExerciseTraining")
			;[Posicao]
				%function%("ExerciseTrainingX", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "ExerciseTraining")
				%function%("ExerciseTrainingY", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "ExerciseTraining")
			;[Timer]
				%function%("TimeExerciseTraining", "Configs\" TibiaServer "\" Vocation "\Timer.ini", "ExerciseTraining")

		;[ MANA BURN ]
		%function%("CheckBox_Mana_Burn",	"Configs\" TibiaServer "\" Vocation "\Timer.ini", "Mana_Burn")
		%function%("Percent_Mana_Burn",		"Configs\" TibiaServer "\" Vocation "\Timer.ini", "Mana_Burn")
		%function%("Hotkey_Mana_Burn",		"Configs\" TibiaServer "\" Vocation "\Timer.ini", "Mana_Burn")

		;[ Move Item ]
		%function%("CheckBox_MoveItem",					"Configs\" TibiaServer "\" Vocation "\Timer.ini", "MoveItem")
		%function%("Delay_MoveItem",					"Configs\" TibiaServer "\" Vocation "\Timer.ini", "MoveItem")
		%function%("Coord_MoveItem_StartPositionX",		"Configs\" TibiaServer "\" Vocation "\Timer.ini", "MoveItem")
		%function%("Coord_MoveItem_StartPositionY",		"Configs\" TibiaServer "\" Vocation "\Timer.ini", "MoveItem")
		%function%("Coord_MoveItem_FinalPositionX",		"Configs\" TibiaServer "\" Vocation "\Timer.ini", "MoveItem")
		%function%("Coord_MoveItem_FinalPositionY",		"Configs\" TibiaServer "\" Vocation "\Timer.ini", "MoveItem")
	}

	;================================= [Walker] =================================
	Gui, Gui_CaveBot:Default
	if (true) {
	;[Hotkey to Active]
		%function%("Key_Enable_Walker", "Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "CaveBot")
		%function%("Delay_CaveBot", 	"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "CaveBot")

	;[Targeting]
		%function%("CheckBox_AutoAttack", 		"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Targeting")
		%function%("LureMonsterDropDownList", 	"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Targeting", "DropDownList")
		%function%("StopAttackWhenHave", 		"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Targeting", "DropDownList")

		%function%("Start_Combo_CheckBox", 				"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Targeting")
		%function%("Start_Combo_Delay", 				"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Targeting")
		%function%("CheckBox_LootWhenChangeTargeting", 	"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Targeting")
	;[Utilities]

		;[Others]
		%function%("CheckBox_ChangeGold", 		"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Utilities")

		;[Player On Screen]
			%function%("CheckBox_ChangeAttackMode", 			"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Utilities")
			%function%("CheckBox_StopCombo_AntiRed", 			"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Utilities")
			%function%("CheckBox_PlayerAlarm", 					"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Utilities")
			%function%("CheckBox_NextWayPoint_PlayerScreen", 	"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Utilities")
			%function%("CheckBox_StopAttack_AntiRed", 			"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Utilities")
			%function%("CheckBox_Deslogar_PlayerScreen", 		"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Utilities")

	;[Adv. Options]
		%function%("Total_Time_Stuck_Targeting",				"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options")
		%function%("Total_Attempt_Target",						"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options")
		%function%("Total_Time_Walker", 						"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options")
		%function%("Attempt_to_Check_Trap", 						"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options")
		%function%("Press_Esc_Cavebot_CheckBox", 				"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options")
		%function%("Sleep_Press_ESC", 							"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options")
		%function%("Priority_Monster_CheckBox", 				"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options")
		%function%("Priority_Number_Position_DropDownList", 	"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options", "DropDownList")
		%function%("CheckBox_GhostMouse_ClickOnMinimap",		"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options")
		%function%("CheckBox_Attack_With_Space",				"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options")
		%function%("CheckBox_Show_HUD_CaveBot_Status",			"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options")
		%function%("CheckBox_Lure_Mode",						"Configs\" TibiaServer "\" Vocation "\CaveBot.ini", "Adv. Options")

	}

	;[Refresh Images]
	GoSub, Refresh_Images_GUI_Combo
	GoSub, Refresh_Image_EquipAmulet
	GoSub, Refresh_Image_EquipRing
	GoSub, Refresh_All_Images_GUI_TankMode
}

save_config(gui_Var, dir_FileName, section, mode:="Default") {
    GLOBAL
	GuiControlGet, %gui_Var%

	if (%gui_Var% != "ERROR") {
		IniWrite,% %gui_Var%, %dir_FileName%, %section%, %gui_Var%
	} else {
		TOOLTIP, [save_config] %gui_Var% is not definied
	}
}

load_config(gui_Var, dir_FileName, section, mode:="Default") {
    GLOBAL
	IniRead, %gui_Var%, %dir_FileName%, %section%, %gui_Var%
	if ( (%gui_Var% != "ERROR" && %gui_Var% != "") ) {
		switch mode {
			case "DropDownList":
				GuiControl, ChooseString, %gui_Var%,% %gui_Var%
				GuiControlGet, %gui_Var%
			RETURN

			Default:
				GuiControl,, %gui_Var%,% %gui_Var%
				GuiControlGet, %gui_Var%
			RETURN
		}


	} else if (%gui_Var% == "ERROR") {
		TOOLTIP, [load_config] %gui_Var% is not definied
		;GuiControl,, %gui_Var%,
	}

}


