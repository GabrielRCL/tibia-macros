Equip_Amulet(){
    GLOBAL
	ElapsedTime := A_TickCount - StartTime

	ElapsedTime_Equip_Amulet := A_TickCount - StartTime_Equip_Amulet
	if (ElapsedTime_Equip_Amulet > 100) {
		Gui, TankMode:Default
		GuiControlGet, SSA_Life
		GuiControlGet, Percent_SSA_Life
		intPercent_SSA_Life := Percent_SSA_Life+1   ;force equip hp99%
		GuiControlGet, HP_RemoveAutomaticallySSA
		if (SSA_Life == 1) {
			GuiControlGet, CheckBox_TankMode_Fear
			GuiControlGet, CheckBox_TankMode_Root
			if ( (Data.HP <= intPercent_SSA_Life or (CheckBox_TankMode_Fear == 1 && Data.Conditions.Fear == 1) or (CheckBox_TankMode_Root == 1 && Data.Conditions.Root == 1) ) && 				Data.TankModeLifeAmulet.1 != 1) {
				;~ MSGBOX, % "LIFE" Data.TankModeLifeAmulet.1
				Press_Key("Hotkey_SSA_Life")

				; Verify Exaust SSA to SWAP Default Amulet
				;~ attempt_try_equip_ssa++
				;~ Gui, Support:Default
				;~ GuiControlGet, CheckBox_UseSupportSpells_InProtectZone
				;~ GuiControlGet, EquipAmulet
				;~ if (EquipAmulet == 1 && Data.NoAmulet.1 == 1 && attempt_try_equip_ssa > 2) {
					;~ Press_Key("Hotkey_EquipAmulet")
					;~ attempt_try_equip_ssa := 0
				;~ }


				StartTime_Equip_Amulet := A_TickCount
				RETURN
			} else if (HP_RemoveAutomaticallySSA == 1 && Data.HP > intPercent_SSA_Life && Data.TankModeLifeAmulet.1 == 1) {
				;equip default amulet
				if (EquipAmulet == 1) {
					Gui, Support:Default
					Press_Key("Hotkey_EquipAmulet")
				} else {
					Press_Key("Hotkey_SSA_Life")
				}
				StartTime_Equip_Amulet := A_TickCount
				RETURN
			}
		}
		GuiControlGet, SSA_Mana
		GuiControlGet, Percent_SSA_Mana
		intPercent_SSA_Mana := Percent_SSA_Mana+1   ;force equip hp99%
		GuiControlGet, MP_RemoveAutomaticallySSA
		if (SSA_Mana == 1) {
			GuiControlGet, CheckBox_TankMode_Fear
			GuiControlGet, CheckBox_TankMode_Root
			if ( ( Data.MP <= intPercent_SSA_Mana or (CheckBox_TankMode_Fear == 1 && Data.Conditions.Fear == 1) or (CheckBox_TankMode_Root == 1 && Data.Conditions.Root == 1) ) && Data.TankModeManaAmulet.1 != 1) {
				;~ MSGBOX, % "MANA" Data.TankModeLifeAmulet.1
				Press_Key("Hotkey_SSA_Mana")

				; Verify Exaust TankMode Amulet to SWAP Default Amulet
				;~ attempt_try_equip_ssa++
				;~ Gui, Support:Default
				;~ GuiControlGet, CheckBox_UseSupportSpells_InProtectZone
				;~ GuiControlGet, EquipAmulet
				;~ if (EquipAmulet == 1 && Data.NoAmulet.1 == 1 && attempt_try_equip_ssa > 2) {
					;~ Press_Key("Hotkey_EquipAmulet")
					;~ attempt_try_equip_ssa := 0
				;~ }


				StartTime_Equip_Amulet := A_TickCount
				RETURN
			} else if (MP_RemoveAutomaticallySSA == 1 && Data.MP > intPercent_SSA_Mana && Data.TankModeManaAmulet.1 == 1) {
				;equip default amulet
				if (EquipAmulet == 1) {
					Gui, Support:Default
					Press_Key("Hotkey_EquipAmulet")
				} else {
					Press_Key("Hotkey_SSA_Mana")
				}
				StartTime_Equip_Amulet := A_TickCount
				RETURN
			}

		}


		Gui, Support:Default
		GuiControlGet, CheckBox_UseSupportSpells_InProtectZone
		GuiControlGet, EquipAmulet
		if (EquipAmulet == 1 && Data.NoAmulet.1 == 1 && (Data.Conditions.ProtectionZone != 1 or CheckBox_UseSupportSpells_InProtectZone) ) {
			Press_Key("Hotkey_EquipAmulet")
			StartTime_Equip_Amulet := A_TickCount
			RETURN
		}
	}
}

Equip_Ring(){
    GLOBAL
	ElapsedTime_Equip_Ring := A_TickCount - StartTime_Equip_Ring
	if (ElapsedTime_Equip_Ring > 100) {
		Gui, TankMode:Default


		; SHADOW ILLUSION
		if (TibiaServer = "Shadow-Illusion") {

			;[EnergyRing FULL TIME]
			GuiControlGet, MightRing_Life
			GuiControlGet, Percent_MightRing_Life
			intPercent_MightRing_Life := Percent_MightRing_Life+1   ;force equip hp99%
			GuiControlGet, DropDownList_TankModeLife_Ring
			if (MightRing_Life == 1 && intPercent_MightRing_Life > 99 && DropDownList_TankModeLife_Ring == "EnergyRing") {
				if (Data.Conditions.EnergyRing != 1) {
					;verifica coordenada do EnergyRing na BP
					if (GetColorHex(Coord_EnergyRing_X,Coord_EnergyRing_Y) != "#2D2F34") {
						SearchPNG(PNG.Rings.EnergyRing, WindowInfo.ClassNN.w/2, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Data.BPEnergyRing := Erro
						if (Data.BPEnergyRing.1 == 1) {
							Coord_EnergyRing_X := Data.BPEnergyRing.2+8
							Coord_EnergyRing_Y := Data.BPEnergyRing.3+8
						} else {
							Coord_EnergyRing_X := ""
							Coord_EnergyRing_Y := ""
							ToolTip("EnergyRing Not Found.",Time:=-500,X:="",Y:="",WhichToolTip:=10)
							RETURN
						}
					}
					Mouse_Click_Drag(Coord_EnergyRing_X,Coord_EnergyRing_Y, Coord_RingSlot_X,Coord_RingSlot_Y, Speed:=5,fix_coordinates_1:=true,fix_coordinates_2:=true, variation:=5,Click:="Left")
					StartTime_Equip_Ring := A_TickCount+350+Delay_Ping	;add more delay
				}
				RETURN
			}

			;[MANA - REMOVE ENERGY RING]
			GuiControlGet, CheckBox_Remove_EnergyRing_Mana
			if ( CheckBox_Remove_EnergyRing_Mana == 1 && OldUtamoVita == 1 ) {
				GuiControlGet, Percent_Remove_EnergyRing_Mana
				MP_Percent_to_Remove_EnergyRing := Percent_Remove_EnergyRing_Mana
				if (Data.Conditions.EnergyRing == 1 && Data.MP < MP_Percent_to_Remove_EnergyRing) {
					Mouse_Click_Drag(Coord_RingSlot_X,Coord_RingSlot_Y, Coord_EnergyRing_X,Coord_EnergyRing_Y, Speed:=5,fix_coordinates_1:=true,fix_coordinates_2:=true, variation:=5,Click:="Left")
					StartTime_Equip_Ring := A_TickCount+350+Delay_Ping	;add more delay
				}
			} else {
				MP_Percent_to_Remove_EnergyRing := 15
			}

			; [ LIFE - EQUIP ENERGY RING ]
			GuiControlGet, EnergyRing_Life
			GuiControlGet, Percent_EnergyRing_Life
			intPercent_EnergyRing_Life := Percent_EnergyRing_Life+1   ;force equip hp99%
			if (EnergyRing_Life == 1 && Data.HP <= intPercent_EnergyRing_Life  && Data.MP > MP_Percent_to_Remove_EnergyRing && OldUtamoVita == 1) {
				if (Data.Conditions.EnergyRing != 1) {
					;verifica coordenada do EnergyRing na BP
					if (GetColorHex(Coord_EnergyRing_X,Coord_EnergyRing_Y) != "#2D2F34") {
						SearchPNG(PNG.Rings.EnergyRing, WindowInfo.ClassNN.w/2, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Data.BPEnergyRing := Erro
						if (Data.BPEnergyRing.1 == 1) {
							Coord_EnergyRing_X := Data.BPEnergyRing.2+8
							Coord_EnergyRing_Y := Data.BPEnergyRing.3+8
						} else {
							Coord_EnergyRing_X := ""
							Coord_EnergyRing_Y := ""
							ToolTip("EnergyRing Not Found.",Time:=-500,X:="",Y:="",WhichToolTip:=10)
							RETURN
						}
					}
					Mouse_Click_Drag(Coord_EnergyRing_X,Coord_EnergyRing_Y, Coord_RingSlot_X,Coord_RingSlot_Y, Speed:=5,fix_coordinates_1:=true,fix_coordinates_2:=true, variation:=5,Click:="Left")
					StartTime_Equip_Ring := A_TickCount+350+Delay_Ping	;add more delay
					RETURN
				}
				RETURN
			}


			; [ LIFE - REMOVE ENERGY RING ]
			Gui, TankMode:Default
			GuiControlGet, Remove_EnergyRing_CheckBox
			GuiControlGet, Remove_EnergyRing_Percent
			GuiControlGet, Remove_EnergyRing_Hotkey
			intRemove_EnergyRing_Percent := Remove_EnergyRing_Percent+1   ;force equip hp99%
			if (Remove_EnergyRing_CheckBox == 1 && Data.HP >= intRemove_EnergyRing_Percent && Data.Conditions.EnergyRing == 1 && OldUtamoVita == 1) {
				;Put Default Ring
				GuiControlGet, EquipRing, Support:
				SearchPNG(PNG.Rings.BeginnerRing, WindowInfo.ClassNN.w/2, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Data.SupportRing:=Erro
				if (EquipRing == 1 && Data.SupportRing.1 == 1) {
					Mouse_Click_Drag(Data.SupportRing.2,Data.SupportRing.3, Coord_RingSlot_X,Coord_RingSlot_Y, Speed:=5,fix_coordinates_1:=true,fix_coordinates_2:=true, variation:=5,Click:="Left")
				} else {
					Mouse_Click_Drag(Coord_RingSlot_X,Coord_RingSlot_Y, Coord_EnergyRing_X,Coord_EnergyRing_Y, Speed:=5,fix_coordinates_1:=true,fix_coordinates_2:=true, variation:=5,Click:="Left")
				}
				StartTime_Equip_Ring := A_TickCount+350+Delay_Ping	;add more delay
				RETURN

			} else if (Remove_EnergyRing_CheckBox == 0 && EnergyRing_Life == 1 && Data.HP > intPercent_EnergyRing_Life && Data.Conditions.EnergyRing == 1 && OldUtamoVita == 1) {
				;Put Default Ring
				GuiControlGet, EquipRing, Support:
				SearchPNG(PNG.Rings.BeginnerRing, WindowInfo.ClassNN.w/2, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Data.SupportRing:=Erro
				if (EquipRing == 1 && Data.SupportRing.1 == 1) {
					Mouse_Click_Drag(Data.SupportRing.2,Data.SupportRing.3, Coord_RingSlot_X,Coord_RingSlot_Y, Speed:=5,fix_coordinates_1:=true,fix_coordinates_2:=true, variation:=5,Click:="Left")
				} else {
					Mouse_Click_Drag(Coord_RingSlot_X,Coord_RingSlot_Y, Coord_EnergyRing_X,Coord_EnergyRing_Y, Speed:=5,fix_coordinates_1:=true,fix_coordinates_2:=true, variation:=5,Click:="Left")
				}
				StartTime_Equip_Ring := A_TickCount+350+Delay_Ping	;add more delay
				RETURN
			}
			RETURN
		}

		; ALL OTHERS TIBIA SERVER
		if (true) {
			;[MANA - REMOVE ENERGY RING]
			GuiControlGet, CheckBox_Remove_EnergyRing_Mana
			if ( CheckBox_Remove_EnergyRing_Mana == 1 && OldUtamoVita == 1 ) {
				GuiControlGet, Percent_Remove_EnergyRing_Mana
				MP_Percent_to_Remove_EnergyRing := Percent_Remove_EnergyRing_Mana
				if (Data.EnergyRing.1 == 1 && Data.MP < MP_Percent_to_Remove_EnergyRing) {
					Press_Key("Hotkey_EnergyRing_Life")
					StartTime_Equip_Ring := A_TickCount
				}
			} else {
				MP_Percent_to_Remove_EnergyRing := 15
			}

			;[LIFE - EQUIP ENERGY RING]
			GuiControlGet, EnergyRing_Life
			GuiControlGet, Percent_EnergyRing_Life
			intPercent_EnergyRing_Life := Percent_EnergyRing_Life+1   ;force equip hp99%
			if (EnergyRing_Life == 1 && Data.HP <= intPercent_EnergyRing_Life && Data.MP > MP_Percent_to_Remove_EnergyRing && OldUtamoVita == 1) {
				if (Data.EnergyRing.1 != 1) {
					Press_Key("Hotkey_EnergyRing_Life")
					StartTime_Equip_Ring := A_TickCount
				}
				RETURN
			}

			;[LIFE AND MANA - EQUIP MIGHT RING]
			GuiControlGet, MightRing_Life
			GuiControlGet, Percent_MightRing_Life
			intPercent_MightRing_Life := Percent_MightRing_Life+1   ;force equip hp99%
			GuiControlGet, HP_RemoveAutomaticallyMight
			if (MightRing_Life == 1) {
				GuiControlGet, CheckBox_TankMode_Fear
				GuiControlGet, CheckBox_TankMode_Root
				if ( ( Data.HP <= intPercent_MightRing_Life or (CheckBox_TankMode_Fear == 1 && Data.Conditions.Fear == 1) or (CheckBox_TankMode_Root == 1 && Data.Conditions.Root == 1) ) && Data.TankModeLifeRing.1 != 1) {
					Press_Key("Hotkey_MightRing_Life")

					; Verify Exaust TankMode Amulet to SWAP Default Amulet
					;~ attempt_try_equip_mightring++
					;~ Gui, Support:Default
					;~ GuiControlGet, EquipRing
					;~ if (EquipRing == 1 && Data.NoRing.1 == 1 && attempt_try_equip_mightring > 2) {
						;~ Press_Key("Hotkey_EquipRing")
						;~ attempt_try_equip_mightring := 0
					;~ }

					StartTime_Equip_Ring := A_TickCount
					RETURN
				} else if (HP_RemoveAutomaticallyMight == 1 && Data.HP > intPercent_MightRing_Life && Data.TankModeLifeRing.1 == 1) {
					;Put Default Ring
					if (EquipRing == 1) {
						Gui, Support:Default
						Press_Key("Hotkey_EquipRing")
					} else {
						Press_Key("Hotkey_MightRing_Life")
					}
					StartTime_Equip_Ring := A_TickCount
					RETURN
				}
			}
			GuiControlGet, MightRing_Mana
			GuiControlGet, Percent_MightRing_Mana
			intPercent_MightRing_Mana := Percent_MightRing_Mana+1   ;force equip hp99%
			GuiControlGet, MP_RemoveAutomaticallyMight
			if (MightRing_Mana == 1){
				GuiControlGet, CheckBox_TankMode_Fear
				GuiControlGet, CheckBox_TankMode_Root
				if ( ( Data.MP <= intPercent_MightRing_Mana or (CheckBox_TankMode_Fear == 1 && Data.Conditions.Fear == 1) or (CheckBox_TankMode_Root == 1 && Data.Conditions.Root == 1) ) && Data.TankModeManaRing.1 != 1) {
					Press_Key("Hotkey_MightRing_Mana")

					; Verify Exaust TankMode Amulet to SWAP Default Amulet
					;~ attempt_try_equip_mightring++
					;~ Gui, Support:Default
					;~ GuiControlGet, EquipRing
					;~ if (EquipRing == 1 && Data.NoRing.1 == 1 && attempt_try_equip_mightring > 2) {
						;~ Press_Key("Hotkey_EquipRing")
						;~ attempt_try_equip_mightring := 0
					;~ }

					StartTime_Equip_Ring := A_TickCount
					RETURN
				} else if (MP_RemoveAutomaticallyMight == 1 && Data.MP > intPercent_MightRing_Mana && Data.TankModeManaRing.1 == 1) {
					;Put Default Ring
					if (EquipRing == 1) {
						Gui, Support:Default
						Press_Key("Hotkey_EquipRing")
					} else {
						Press_Key("Hotkey_MightRing_Mana")
					}
					StartTime_Equip_Ring := A_TickCount
					RETURN
				}
			}

			;REMOVE ENERGY RING
			Gui, TankMode:Default
			GuiControlGet, Remove_EnergyRing_CheckBox
			GuiControlGet, Remove_EnergyRing_Percent
			GuiControlGet, Remove_EnergyRing_Hotkey
			intRemove_EnergyRing_Percent := Remove_EnergyRing_Percent+1   ;force equip hp99%
			if (Remove_EnergyRing_CheckBox == 1 && Data.HP >= intRemove_EnergyRing_Percent && Data.EnergyRing.1 == 1 && OldUtamoVita == 1) {
				;Put Default Ring
				if (EquipRing == 1) {
					Gui, Support:Default
					Press_Key("Hotkey_EquipRing")
				} else {
					Press_Key("Remove_EnergyRing_Hotkey")
				}
				StartTime_Equip_Ring := A_TickCount
				RETURN
			} else if (Remove_EnergyRing_CheckBox == 0 && EnergyRing_Life == 1 && Data.HP > intPercent_EnergyRing_Life && Data.EnergyRing.1 == 1 && OldUtamoVita == 1) {
				;Put Default Ring
				if (EquipRing == 1) {
					Gui, Support:Default
					Press_Key("Hotkey_EquipRing")
				} else {
					Press_Key("Hotkey_EnergyRing_Life")
				}
				StartTime_Equip_Ring := A_TickCount
				RETURN
			}

			Gui, Support:Default
			GuiControlGet, CheckBox_UseSupportSpells_InProtectZone
			GuiControlGet, EquipRing
			if (EquipRing == 1 && Data.NoRing.1 == 1 && (Data.Conditions.ProtectionZone != 1 or CheckBox_UseSupportSpells_InProtectZone) ) {
				Press_Key("Hotkey_EquipRing")
				StartTime_Equip_Ring := A_TickCount
				RETURN
			}
		}
	}
}

Special_Foods() {
    GLOBAL
	Gui, TankMode:Default
	GuiControlGet, Food_Life
	if (Food_Life == 1) {
		ElapsedTime_SpecialFoods_Life := A_TickCount - StartTime_SpecialFoods_Life
		GuiControlGet, Percent_Food_Life
		intPercent_Food_Life := Percent_Food_Life+1   ;force equip hp99%
		if (Data.HP < intPercent_Food_Life && ElapsedTime_SpecialFoods_Life > 300) {
			Press_Key("Hotkey_Food_Life")
			StartTime_SpecialFoods_Life := A_TickCount
			;~ RETURN
		}
	}

	GuiControlGet, Food_Mana
	if (Food_Mana == 1) {
		ElapsedTime_SpecialFoods_Mana := A_TickCount - StartTime_SpecialFoods_Mana
		GuiControlGet, Percent_Food_Mana
		intPercent_Food_Mana := Percent_Food_Mana+1   ;force equip hp99%
		if (Data.MP < intPercent_Food_Mana && ElapsedTime_SpecialFoods_Mana > 300) {
			Press_Key("Hotkey_Food_Mana")
			StartTime_SpecialFoods_Mana := A_TickCount
			;~ RETURN
		}
	}
}



;SSA e MIGHT RING
KeyToActive:
	Gui, TankMode:Default
	;[Check Keys]
	GuiControlGet, Key_Enable_SSA_Life
	Key_Enable_SSA_Life := RegExReplace(Key_Enable_SSA_Life, "[\+\^\!]", "") ;remove caracteres especiais (fix bug Control, Shift, Alt)
	GuiControlGet, Key_Enable_MightRing_Life
	Key_Enable_MightRing_Life := RegExReplace(Key_Enable_MightRing_Life, "[\+\^\!]", "") ;remove caracteres especiais (fix bug Control, Shift, Alt)
	GuiControlGet, Key_Enable_SSA_Mana
	Key_Enable_SSA_Mana := RegExReplace(Key_Enable_SSA_Mana, "[\+\^\!]", "") ;remove caracteres especiais (fix bug Control, Shift, Alt)
	GuiControlGet, Key_Enable_MightRing_Mana
	Key_Enable_MightRing_Mana := RegExReplace(Key_Enable_MightRing_Mana, "[\+\^\!]", "") ;remove caracteres especiais (fix bug Control, Shift, Alt)

	KeyState_SSA_Life := GetKeyState(Key_Enable_SSA_Life, "P")	; 1 = pressionada / 0 = despressionada
	KeyState_MightRing_Life := GetKeyState(Key_Enable_MightRing_Life, "P")
	KeyState_SSA_Mana := GetKeyState(Key_Enable_SSA_Mana, "P")
	KeyState_MightRing_Mana := GetKeyState(Key_Enable_MightRing_Mana, "P")

	;[LIFE]
	if (KeyState_SSA_Life) {
		Toggle_KeyToActive("SSA_Life")
	}
	if (KeyState_MightRing_Life) {
		Toggle_KeyToActive("MightRing_Life")
	}

	;[MANA]
	if (KeyState_SSA_Mana) {
		Toggle_KeyToActive("SSA_Mana")
	}
	if (KeyState_MightRing_Mana) {
		Toggle_KeyToActive("MightRing_Mana")
	}

RETURN

