Verify_Equips(){
    GLOBAL
	;[Amulets]
	SearchPNG(PNG.Amulet.NoAmulet, AConBarX, AConBarY, AConBarX+OffSet, AConBarY+OffSet, Tole:=20, Erro, Mode:=1), 																				Data.TankModeLifeAmulet:=0, Data.TankModeManaAmulet:=0, Data.NoAmulet:=Erro
	if (Erro.1 != 1){
		Gui, TankMode:Default
		GuiControlGet, SSA_Life
		GuiControlGet, SSA_Mana
		if (SSA_Life == 1) {
			GuiControlGet, DropDownList_TankModeLife_Amulet
			SearchPNG(PNG.Amulet[DropDownList_TankModeLife_Amulet], AConBarX, AConBarY, AConBarX+OffSet, AConBarY+OffSet, Tole:=20, Erro, Mode:=1),												Data.TankModeLifeAmulet:=Erro
			if (Data.TankModeLifeAmulet.1 != 1 && DropDownList_TankModeLife_Amulet = "ShockwaveAmulet")
				SearchPNG(PNG.ShockwaveAmulet1, AConBarX, AConBarY, AConBarX+OffSet, AConBarY+OffSet, Tole:=20, Erro, Mode:=1),	Data.TankModeLifeAmulet:=Erro
			if (Data.TankModeLifeAmulet.1 != 1 && DropDownList_TankModeLife_Amulet = "ShockwaveAmulet")
				SearchPNG(PNG.ShockwaveAmulet2, AConBarX, AConBarY, AConBarX+OffSet, AConBarY+OffSet, Tole:=20, Erro, Mode:=1),	Data.TankModeLifeAmulet:=Erro
			if (Data.TankModeLifeAmulet.1 != 1 && DropDownList_TankModeLife_Amulet = "ShockwaveAmulet")
				SearchPNG(PNG.ShockwaveAmulet3, AConBarX, AConBarY, AConBarX+OffSet, AConBarY+OffSet, Tole:=20, Erro, Mode:=1),	Data.TankModeLifeAmulet:=Erro
			if (Data.TankModeLifeAmulet.1 == 1) {
				attempt_try_equip_ssa := 0
			}
		}
		if (SSA_Mana == 1) {
			GuiControlGet, DropDownList_TankModeMana_Amulet
			SearchPNG(PNG.Amulet[DropDownList_TankModeMana_Amulet], AConBarX, AConBarY, AConBarX+OffSet, AConBarY+OffSet, Tole:=20, Erro, Mode:=1), 											Data.TankModeManaAmulet:=Erro
			if (Data.TankModeManaAmulet.1 != 1 && DropDownList_TankModeMana_Amulet = "ShockwaveAmulet")
				SearchPNG(PNG.ShockwaveAmulet1, AConBarX, AConBarY, AConBarX+OffSet, AConBarY+OffSet, Tole:=20, Erro, Mode:=1),	Data.TankModeManaAmulet:=Erro
			if (Data.TankModeManaAmulet.1 != 1 && DropDownList_TankModeMana_Amulet = "ShockwaveAmulet")
				SearchPNG(PNG.ShockwaveAmulet2, AConBarX, AConBarY, AConBarX+OffSet, AConBarY+OffSet, Tole:=20, Erro, Mode:=1),	Data.TankModeManaAmulet:=Erro
			if (Data.TankModeManaAmulet.1 != 1 && DropDownList_TankModeMana_Amulet = "ShockwaveAmulet")
				SearchPNG(PNG.ShockwaveAmulet3, AConBarX, AConBarY, AConBarX+OffSet, AConBarY+OffSet, Tole:=20, Erro, Mode:=1),	Data.TankModeManaAmulet:=Erro
			if (Data.TankModeManaAmulet.1 == 1) {
				attempt_try_equip_ssa := 0
			}
		}
	}
	; Crop_And_Save_Haystack(AConBarX,AConBarY, OffSet+200,OffSet+200)





	;[Rings]
	if (TibiaServer = "Shadow-Illusion") {
		RConBarX := Cords.Con.2+2+7, RConBarY := Cords.Con.3+87+6	;Rings
		Coord_RingSlot_X := Cords.Con.2 + 9
		Coord_RingSlot_Y := Cords.Con.3 + 94
		RETURN
	}

	;[Rings]
	SearchPNG(PNG.Rings.NoRing, RConBarX, RConBarY, RConBarX+OffSet, RConBarY+OffSet, Tole:=20, Erro, Mode:=1), 																				Data.TankModeLifeRing:=0, Data.TankModeManaRing:=0, Data.NoRing:=Erro, Data.EnergyRing:=0
	if (Data.NoRing.1 != 1){
		Gui, TankMode:Default
		GuiControlGet, MightRing_Life
		GuiControlGet, MightRing_Mana
		if (MightRing_Life == 1) {
			GuiControlGet, DropDownList_TankModeLife_Ring
			if (PNG.Rings[DropDownList_TankModeLife_Ring].Length() > 0) {	;verifica imagens dinamicas ex: Prismatic Ring
				for Each, Image in PNG.Rings[DropDownList_TankModeLife_Ring] {
					SearchPNG(Image, RConBarX, RConBarY, RConBarX+OffSet, RConBarY+OffSet, Tole:=20, Erro, Mode:=1),																			Data.TankModeLifeRing:=Erro
					if (Data.TankModeLifeRing.1 == 1) {
						BREAK
					}
				}
			} else {	;verifica imagens estaticas
				SearchPNG(PNG.Rings[DropDownList_TankModeLife_Ring], RConBarX, RConBarY, RConBarX+OffSet, RConBarY+OffSet, Tole:=20, Erro, Mode:=1),											Data.TankModeLifeRing:=Erro
			}

			if (Data.TankModeLifeRing.1 == 1) {
				attempt_try_equip_mightring := 0
			}
		}
		if (MightRing_Mana == 1) {
			GuiControlGet, DropDownList_TankModeMana_Ring
			if (PNG.Rings[DropDownList_TankModeMana_Ring].Length() > 0) {
				for Each, Image in PNG.Rings[DropDownList_TankModeMana_Ring] { ;verifica imagens dinamicas
					SearchPNG(Image, RConBarX, RConBarY, RConBarX+OffSet, RConBarY+OffSet, Tole:=20, Erro, Mode:=1),																			Data.TankModeManaRing:=Erro
					if (Data.TankModeManaRing.1 == 1) {
						BREAK
					}
				}
			} else { ;verifica imagens estaticas
				SearchPNG(PNG.Rings[DropDownList_TankModeMana_Ring], RConBarX, RConBarY, RConBarX+OffSet, RConBarY+OffSet, Tole:=20, Erro, Mode:=1),											Data.TankModeManaRing:=Erro
			}

			if (Data.TankModeManaRing.1 == 1) {
				attempt_try_equip_mightring := 0
			}
		}

		GuiControlGet, EnergyRing_Life
		if (EnergyRing_Life == 1) {
			SearchPNG(PNG.Rings.EnergyRing, RConBarX, RConBarY, RConBarX+OffSet, RConBarY+OffSet, Tole:=20, Erro, Mode:=1), 																	 Data.EnergyRing:=Erro
			if (Data.EnergyRing.1 == 1) {
				attempt_try_equip_mightring := 0
			}
			RETURN
		}
	}


}
