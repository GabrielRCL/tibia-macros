LocateCooldownBar() {
    GLOBAL
    SearchPNG(PNG.CooldownBox, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=10, Erro, Mode:=1), Cords.CooldownBox:=Erro
		if (Cords.CooldownBox.1 == 1) {
			ColorHex_Validate_CooldownBox := GetColorHex(Cords.CooldownBox.2,Cords.CooldownBox.3)	;[GET ColorHEX Validate CooldownBox]
			tmp_color := GetColorHex(Cords.CooldownBox.2+1,Cords.CooldownBox.3+1)
			if (tmp_color = "#EF5406" or tmp_color = "#481902" or tmp_color = "#4b3328" or tmp_color = "#4a3327") {
				Cords.CooldownBar := {}
				Cords.CooldownBar.Attack := { 2: Cords.CooldownBox.2+1, 3: Cords.CooldownBox.3+1}	;inicio cooldown bar - Attack BOX
				; ===================== [ COOLDOWN DIV ] =====================
				SearchPNG(PNG.CooldownDiv, Cords.CooldownBox.2,Cords.CooldownBox.3, WindowInfo.ClassNN.w,WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Cords.CooldownDiv:=Erro
			}
		}
		;ARColor is found in coord: 7,8 (Total:20x20)
		ArColor.Cooldown := {					ExuraGranMasRes: CorToDec("#D5EFFA"),		MagicShield: CorToDec("#C4C764"),		ExuraGranSio: CorToDec("#5F64EC")
		, UturaGran: CorToDec("#B9D9EB"),		Utura: CorToDec("#D6EFFA"),					UtitoTempoSan: CorToDec("#BECAD3"),		ExuraGranIco: CorToDec("#939ADF")
		, ExuraMaxVita: CorToDec("#DAEDFE"),	Mas_San: CorToDec("#FEFAC2"),				ExetaAmpRes: CorToDec("#D3AD9B"),		Exori: CorToDec("#D2A16F")
		, Exori_Gran: CorToDec("#8A4D9C"),		Exori_Min: CorToDec("#A7A8A8"), 			Exori_Mas: CorToDec("#33281F"),			Gran_Mas_Tera: CorToDec("#8C2A14")
		, Gran_Mas_Frigo: CorToDec("#2E628F"),	Gran_Mas_Flam: CorToDec("#FAC567"),			Gran_Mas_Vis: CorToDec("#F2E4F6"),		Exori_Gran_Con: CorToDec("#39DEEE")
		, Exori_Hur: CorToDec("#757574"),		ExoriGranIco: CorToDec("#856C59"),			Exori_Ico: CorToDec("#D6946E"),			ExoriGranFrigo: CorToDec("#93B1CA")
		, ExoriMaxFrigo: CorToDec("#7493AD"),	ExoriGranTera: CorToDec("#4A2B16"),			ExoriMaxTera: CorToDec("#371D05"),		Gran_Frigo_Hur: CorToDec("#0B4D7C")
		, ExevoFrigoHur: CorToDec("#459CC3"),	Exevo_Tera_Hur: CorToDec("#017A03"),		ExoriAmpVis: CorToDec("#B288B8"),		ExoriGranVis: CorToDec("#FA7CDA")
		, ExoriMaxVis: CorToDec("#FEDCF6"),		ExoriGranFlam: CorToDec("#EE9231"),			ExoriMaxFlam: CorToDec("#F6971E"),		ExevoGranVisLux: CorToDec("#FFFDFE")
		, Exevo_Vis_Hur: CorToDec("#A6A0CD"),	ExevoFlamHur: CorToDec("#460701"),			ExevoVisLux: CorToDec("#A56FC0"),		Gran_Flam_Hur: CorToDec("#B71701")
		, Exori_Moe: CorToDec("#2E321F"),		Exori_Kor: CorToDec("#333722"),				UtamoTempo: CorToDec("#44544D"),		UtitoTempo : CorToDec("#944238")
		, Divine_Grenade: CorToDec("#B67632"),	Divine_Empowerment: CorToDec("#82795B"),	Exori_Amp_Kor: CorToDec("#7C2033"),		Exori_Gran_Ico: CorToDec("#856C59")}

		;ARColorV is found in coord: 12,13 (Total:20x20)
		ArColor.CooldownV:= {					ExuraGranMasRes: CorToDec("#BCD9D9"),		MagicShield: CorToDec("#6F6634"),		ExuraGranSio: CorToDec("#F2F2EC")
		, UturaGran: CorToDec("#CCCBB7"),		Utura: CorToDec("#E4F6FE"),					UtitoTempoSan: CorToDec("#92A0A4"),		ExuraGranIco: CorToDec("#F0EFE8")
		, ExuraMaxVita: CorToDec("#D6D8FF"),	Mas_San: CorToDec("#F5E4A6"),				ExetaAmpRes: CorToDec("#F1F1F1"),		Exori: CorToDec("#7B432E")
		, Exori_Gran: CorToDec("#860B06"),		Exori_Min: CorToDec("#414343"),				Exori_Mas: CorToDec("#4A2815"),			Gran_Mas_Tera: CorToDec("#D5C090")
		, Gran_Mas_Frigo: CorToDec("#99CDDD"),	Gran_Mas_Flam: CorToDec("#FBC882"),			Gran_Mas_Vis: CorToDec("#925499"),		Exori_Gran_Con: CorToDec("#19A8CD")
		, Exori_Hur: CorToDec("#8B8786"),		ExoriGranIco: CorToDec("#EFBC87"),			Exori_Ico: CorToDec("#8A8A8A"),			ExoriGranFrigo: CorToDec("#BDE4F2")
		, ExoriMaxFrigo: CorToDec("#7397C1"),	ExoriGranTera: CorToDec("#4F2914"),			ExoriMaxTera: CorToDec("#F04905"),		Gran_Frigo_Hur: CorToDec("#59A0BF")
		, ExevoFrigoHur: CorToDec("#215882"),	Exevo_Tera_Hur: CorToDec("#489420"),		ExoriAmpVis: CorToDec("#481C4F"),		ExoriGranVis: CorToDec("#D6189C")
		, ExoriMaxVis: CorToDec("#F6C7EC"),		ExoriGranFlam: CorToDec("#F4D57A"),			ExoriMaxFlam: CorToDec("#FACE75"),		ExevoGranVisLux: CorToDec("#308FEF")
		, Exevo_Vis_Hur: CorToDec("#125EE0"),	ExevoFlamHur: CorToDec("#7A1E00"),			ExevoVisLux: CorToDec("#DDA8DE"),		Gran_Flam_Hur: CorToDec("#ED5A0A")
		, Exori_Moe: CorToDec("#494E3D"),		Exori_Kor: CorToDec("#191919"),				UtamoTempo: CorToDec("#283C3F"),		UtitoTempo : CorToDec("#670402")
		, Divine_Grenade: CorToDec("#F9E3BD"),	Divine_Empowerment: CorToDec("#B1A87D"),	Exori_Amp_Kor: CorToDec("#8C2C34"),		Exori_Gran_Ico: CorToDec("#EFBC87")}
}

Verify_CooldownBar(){
    GLOBAL

	; coord = 0x0 (ref 20x20) = updated to 9x1 ref(20x20)
	CooldownBar_X := Cords.CooldownBar.Attack.2+9
	CooldownBar_Y := Cords.CooldownBar.Attack.3+1
	If (GetColorHex(CooldownBar_X, CooldownBar_Y) = "#B84114")
		Data.Group["Attack"]:=1
	else
		Data.Group["Attack"]:=0

	If (GetColorHex(CooldownBar_X+25 , CooldownBar_Y) = "#5D97BE")
		Data.Group["Healing"]:=1
	else
		Data.Group["Healing"]:=0

	If (GetColorHex(CooldownBar_X+25+25 , CooldownBar_Y) = "#00E3DC")
		Data.Group["Support"]:=1
	else
		Data.Group["Support"]:=0
	;~ ToolTip, % Data.Group["Attack"] " + " Data.Group["Healing"] " + " Data.Group["Support"]



	; SKILLS VERIFY
	xSkill_Exori_Gran := ""
	xSkill :=  Cords.CooldownDiv.2+17, ySkill := Cords.CooldownDiv.3+9, CDSkills:=[]
	if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe")
		xSkill += 3
	loop, 10 {
		  Color := GetColorDecimal(xSkill,  ySkill)
		  ;~ Temp  := GetColorHex(xSkill,  ySkill)
		  for SkillName, SkillCor in ArColor.Cooldown {
				if (CDSkills[A_Index] != A_Index)
					  if (Color = SkillCor){
						;~ msgbox % SkillName
							Color := GetColorDecimal(xSkill+5,  ySkill+5)
							if (Color = ArColor.CooldownV[SkillName]){
								  ;~ Msgbox % "V" SkillName
								  Data.Skill[SkillName] := 1
								  CDSkills[A_Index] := A_Index
								  xSkill_%SkillName% := xSkill	;exori gran momentum
								  Break 1
							} else
								  Data.Skill[SkillName] := 0
					  }   else
							Data.Skill[SkillName] := 0
		  }
		  xSkill +=  25
		  if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe")
			xSkill -= 2
	}
	Data.Skill["Avalanche"] := 0
	Data.Skill["Exori_Con"] := 0
	Data.Skill["SpellStrike"] := 0

	; EXEVO ULUS
	If (GetColorHex(Cords.CooldownBar.Attack.2+200 , Cords.CooldownBar.Attack.3) = "#85888B")
		Data.Skill["Exevo_Ulus"] := 1
	else
		Data.Skill["Exevo_Ulus"] := 0


}

