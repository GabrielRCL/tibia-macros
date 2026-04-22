Verify_BattleList(){
    GLOBAL
	if (TibiaServer = "OtServer" or TibiaServer = "Global") {
		if (GetColorHex(Cords.BattleListDefault.2+2, Cords.BattleListDefault.3+2) != "#919191"){
			SearchPNG(PNG.BattleListDefault, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Cords.BattleListDefault:=Erro
			if (Erro.1 != 1)
				SearchPNG(PNG.BattleListPagodera, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Cords.BattleListDefault:=Erro
		}
		if (Cords.BattleListDefault.1 == 1){
				if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") { ;fix coordinates RTC
					icon_color := GetColorHex(Cords.BattleListDefault.2+119, Cords.BattleListDefault.3+4)
					Filtro := (icon_color = "#131313") ? 48+10+1 : 0+3
				} else {
					icon_color := GetColorHex(Cords.BattleListDefault.2+131, Cords.BattleListDefault.3+4)
					Filtro := (icon_color = "#2C2C2C" or icon_color = "#090808") ? 48 : 0
				}
				;~ TOOLTIP % "icon_color: " icon_color "|" " Filtro: " Filtro
				isAttacking := False
				, emptyBattle := False
				, Data.InfoMobs:=[]
				, TargetY := Cords.BattleListDefault.3+28+Filtro
				, TargetX := Cords.BattleListDefault.2+24
				, TargetColorX := Cords.BattleListDefault.2+19
				, TargetColorY := TargetY+4

				if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") {
					TargetY += 2		;fix bug rubinot RTC
					TargetX -= 1		;fix bug rubinot RTC
					TargetColorX += 1	;fix bug rubinot RTC
					TargetColorY -= 1	;fix bug rubinot RTC
				}
				;~ Crop_And_Save_Haystack(TargetColorX,TargetColorY+22, 150,150)
				;~ Tooltip % GetColorHex(TargetColorX, TargetColorY+22)

				TargetLife := GetColorHex(TargetX, TargetY)
				if (TargetLife == "#000000"){
					CountMobs := 1
					PositionTargetMob := 1
					while (TargetLife == "#000000" && CountMobs <= 10){
						TMobHP := GetColorHex(TargetX+1, TargetY+1)
						MobHP := TMobHP="#00C000"?100:TMobHP="#60c060"?90:TMobHP="#c0c000"?60:TMobHP="#c03030"?30:TMobHP="#c00000"?10:TMobHP="#600000"?5:0
						TargetMob := False

						TargetColor := GetColorHex(TargetColorX, TargetColorY)
						if (TargetColor == "#ff8080" || TargetColor == "#ff0000" || TargetColor == "#df3f3f" || TargetColor == "#f7a3a3"){
							isAttacking := True
							TargetMob := True
							PositionTargetMob := CountMobs
						}
						Data.InfoMobs[CountMobs] := {HP:MobHP,x:TargetX,y:TargetY,Target:TargetMob}
						;~ Crop_And_Save_Haystack(TargetX, TargetY, 50,300)

						TargetY += 22
						TargetColorY += 22
						if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") {
							TargetY -= 1		;fix bug rubinot RTC
							TargetColorY -= 1	;fix bug rubinot RTC
						}

						TargetLife := GetColorHex(TargetX, TargetY)
						if (TargetLife == "#000000")
							CountMobs++
					}
					AutoHunt.MonsterQuantity := CountMobs
				} else {
					AutoHunt.MonsterQuantity := 0
					emptyBattle := True
				}
		} else if (WalkerEnable == 1 or State_Combo == "ON") {
			English     := "Please open your Battle List to use Auto Attack."
			Portugues  := "Por favor, abra seu Battle List para usar o Auto Attack."
			ToolTip(%GlobalLanguage%,Time:=-500,X:="",Y:="",WhichToolTip:=10)
			RETURN
		}
	}

	if (TibiaServer = "Shadow-Illusion") {
		if (GetColorHex(Cords.BattleListDefault.2+2, Cords.BattleListDefault.3+2) != "#5B5B5B"){
			SearchPNG(PNG.BattleListDefault, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Cords.BattleListDefault:=Erro
		}
		if (Cords.BattleListDefault.1 == 1){
			Filtro := ((tmpcolor := GetColorHex(Cords.BattleListDefault.2+9, Cords.BattleListDefault.3+24)) = "#19CA19" or tmpcolor = "#1E1E1E") ? 113 : 63
			isAttacking := False
				, emptyBattle := False
				, Data.InfoMobs:=[]
				, TargetY := Cords.BattleListDefault.3+Filtro
				, TargetLife := GetColorHex(Cords.BattleListDefault.2+24, TargetY)


			; Crop_And_Save_Haystack(Cords.BattleListDefault.2+10, TargetY-7, 150,150)
			; Tooltip % GetColorHex(TargetColorX, TargetColorY+22)

			if (TargetLife == "#000000"){
				CountMobs := 1
				PositionTargetMob := 1
				while (TargetLife == "#000000" && CountMobs <= 10){
					TMobHP := GetColorHex(Cords.BattleListDefault.2+24+1, TargetY)
					MobHP := TMobHP="#00BC00"?100:TMobHP="#60c060"?90:TMobHP="#c0c000"?60:TMobHP="#c03030"?30:TMobHP="#c00000"?10:TMobHP="#600000"?5:0
					TargetMob := False
					TargetColor := GetColorHex(Cords.BattleListDefault.2+24-4, TargetY-17)
					if (TargetColor == "#ff8888" || TargetColor == "#ff0000"){
						isAttacking := True
						TargetMob := True
						PositionTargetMob := CountMobs
					}
					Data.InfoMobs[CountMobs] := {HP:MobHP,x:Cords.BattleListDefault.2+10,y:TargetY-7,Target:TargetMob}
					TargetY += 25, TargetLife := GetColorHex(Cords.BattleListDefault.2+24, TargetY)
					If (TargetLife == "#000000")
					CountMobs++
				}
				AutoHunt.MonsterQuantity := CountMobs
			} else {
				AutoHunt.MonsterQuantity := 0
				emptyBattle := True
			}

		} else if (WalkerEnable == 1 or State_Combo == "ON") {
			English     := "Please open your Battle List to use Auto Attack."
			Portugues  := "Por favor, abra seu Battle List para usar o Auto Attack."
			ToolTip(%GlobalLanguage%, Time:=-500, X:="", Y:="", WhichToolTip:=10)
			RETURN
		}
	}


	; #DEBUGGER
	; tooltip, % "AutoHunt.MonsterQuantity: " AutoHunt.MonsterQuantity "`nisAttacking :" isAttacking
}
