; ============= [HEALING FRIEND] ===============
Verify_PartyList(){
    GLOBAL
	Gui, HealFriend:Default
	GuiControlGet, EK_ExuraSio
	GuiControlGet, EK_ExuraGranSio
	GuiControlGet, RP_ExuraSio
	GuiControlGet, RP_ExuraGranSio
	GuiControlGet, AutoFollowFriend
	if (EK_ExuraSio or EK_ExuraGranSio or RP_ExuraSio or RP_ExuraGranSio or AutoFollowFriend) {
		if (GetColorHex(Cords.Party.2+4, Cords.Party.3+4) != "#1e73ff")
			SearchPNG(PNG.Party.Default, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=25, Erro, Mode:=1), Cords.Party:=Erro
			if (Cords.Party.1 != 1) {
				SearchPNG(PNG.Party.Pagodera, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=25, Erro, Mode:=1), Cords.Party:=Erro
			}
		if (Cords.Party.1 != 1){
			English     := "Please open your Party List."
			Portugues  := "Por favor abra seu Party List."
			ToolTip(%GlobalLanguage%, Time:=-500, X:="", Y:="", WhichToolTip:=02)
			RETURN
		}
	}
}
Verify_FriendHP_FirstPlayer(){
    GLOBAL
	if (Data.Group["Healing"] == 0 && Cords.Party.1 == 1) {
		Gui, HealFriend:Default
		GuiControlGet, EK_ExuraSio
		GuiControlGet, EK_ExuraGranSio
		GuiControlGet, AutoFollowFriend

		if (EK_ExuraSio or EK_ExuraGranSio or AutoFollowFriend) {
			if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") { ;fix coordinates RTC
				ICONS := ((color := GetColorHex(Cords.Party.2+120, Cords.Party.3+3)) = "#626262") ? 30 : 0
				if (GetColorHex(Cords.Party.2+21, Cords.Party.3+31+ICONS) != "#000000"){
					Data.FriendHP.EK := ""
					return
				}
			} else {
				ICONS := ((color := GetColorHex(Cords.Party.2+129, Cords.Party.3+2)) = "#2C2C2C" or color = "#090808") ? 26 : 0
				if (GetColorHex(Cords.Party.2+20, Cords.Party.3+26+ICONS) != "#000000"){
					Data.FriendHP.EK := ""
					return
				}
			}

			if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") { ;fix coordinates RTC
				lifeColor := GetColorHex(Cords.Party.2+151, Cords.Party.3+31+ICONS), i := 137, Data.FriendHP.EK := 100
				loop, 19 {
					if (lifeColor = "#00C000" || lifeColor = "#60c060" || lifeColor = "#c0c000" || lifeColor = "#c03030" || lifeColor = "#c00000" || lifeColor = "#600000")
						Break
					Else if (lifeColor = "#707070"){
						lifeColor := GetColorHex(Cords.Party.2+22, Cords.Party.3+31+ICONS)
						if (lifeColor = "#707070"){
							Data.FriendHP.EK := ""
							return
						} Else
							Data.FriendHP.EK -= 5
					}
						Else
							Data.FriendHP.EK -= 5
					lifeColor := GetColorHex(Cords.Party.2+Ceil(i), Cords.Party.3+31+ICONS), i -= 6.5
				}
				If (Data.FriendHP.EK != ""){
					i:=22
					loop, 15 {
						NameColor := GetColorHex(Cords.Party.2+i, Cords.Party.3+23+ICONS), i++
						switch NameColor {
							case "#c0c0c0":
							return
							case "#808080":
								Data.FriendHP.EK := ""
							return
							case "#f7f7f7":
								;MouseGetPos, StartX, StartY
								;MouseMove, StartX, StartY-35
								;Data.FriendHP.EK := ""
							return
						}
					}
				}

				return
			}

			; DEFAULT TIBIA
			lifeColor := GetColorHex(Cords.Party.2+144, Cords.Party.3+28+ICONS), i := 137, Data.FriendHP.EK := 100
			loop, 19 {
				if (lifeColor = "#00C000" || lifeColor = "#60c060" || lifeColor = "#c0c000" || lifeColor = "#c03030" || lifeColor = "#c00000" || lifeColor = "#600000")
					Break
				Else if (lifeColor = "#707070"){
					lifeColor := GetColorHex(Cords.Party.2+21, Cords.Party.3+28+ICONS)
					if (lifeColor = "#707070"){
						Data.FriendHP.EK := ""
						return
					} Else
						Data.FriendHP.EK -= 5
				}
					Else
						Data.FriendHP.EK -= 5
				lifeColor := GetColorHex(Cords.Party.2+Ceil(i), Cords.Party.3+28+ICONS), i -= 6.5
			}
			If (Data.FriendHP.EK != ""){
				i:=22
				loop, 15 {
					NameColor := GetColorHex(Cords.Party.2+i, Cords.Party.3+22+ICONS), i++
					switch NameColor {
						case "#c0c0c0":
						return
						case "#808080":
							Data.FriendHP.EK := ""
						return
						case "#f7f7f7":
							;MouseGetPos, StartX, StartY
							;MouseMove, StartX, StartY-35
							;Data.FriendHP.EK := ""
						return
					}
				}
			}

			return
		}
	}
}
Verify_FriendHP_SecondPlayer(){
    GLOBAL
	if (Data.Group["Healing"] == 0 && Cords.Party.1 == 1) {
		Gui, HealFriend:Default
		GuiControlGet, RP_ExuraSio
		GuiControlGet, RP_ExuraGranSio

		if (RP_ExuraSio or RP_ExuraGranSio) {
			ICONS := GetColorHex(Cords.Party.2+129, Cords.Party.3+2) = "#2C2C2C" ? 26 : 0
			if (GetColorHex(Cords.Party.2+20, Cords.Party.3+26+26+ICONS) != "#000000"){
				Data.FriendHP.RP := ""
				return
			}
			lifeColor := GetColorHex(Cords.Party.2+144, Cords.Party.3+28+26+ICONS), i := 137, Data.FriendHP.RP := 100
			loop, 19 {
				if (lifeColor = "#00C000" || lifeColor = "#60c060" || lifeColor = "#c0c000" || lifeColor = "#c03030" || lifeColor = "#c00000" || lifeColor = "#600000")
				Break
				Else if (lifeColor = "#707070"){
					lifeColor := GetColorHex(Cords.Party.2+21, Cords.Party.3+28+ICONS)
					if (lifeColor = "#707070"){
						Data.FriendHP.RP := ""
						return
					} Else
						Data.FriendHP.RP -= 5
				}
					Else
						Data.FriendHP.RP -= 5
				lifeColor := GetColorHex(Cords.Party.2+Ceil(i), Cords.Party.3+28+26+ICONS), i -= 6.5
			}
			If (Data.FriendHP.RP != ""){
				i:=22
				loop, 15 {
					NameColor := GetColorHex(Cords.Party.2+i, Cords.Party.3+22+26+ICONS), i++
					switch NameColor {
						case "#c0c0c0":
						return
						case "#808080":
							Data.FriendHP.RP := ""
						return
						case "#f7f7f7":
							;MouseGetPos, StartX, StartY
							;MouseMove, StartX, StartY-35-26
							;Data.FriendHP.RP := ""
						return
					}
				}
			}
			return
		}
	}
}
Heal_Friend(){
    GLOBAL

	;AutoFollow Friend
	Gui, HealFriend:Default
	GuiControlGet, AutoFollowFriend
	if (AutoFollowFriend == true && Data.FriendHP.EK != "" && isAttacking != True) {
		Friend_isFollowing := GetColorHex(Cords.Party.2+17, Cords.Party.3+26+ICONS)
		if (Friend_isFollowing != "#80FF80" && Friend_isFollowing != "#00FF00") {
			;~ Send, {Control Down}
			ControlClick(Cords.Party.2+21, Cords.Party.3+28+ICONS,WhichButton:="RIGHT")
			;~ Send, {Control Up}
			Loop, 3 {
				Sleep 25
				PrintScreenData()
				SearchPNG(PNG.FollowText, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=50, Erro, Mode:=1)
				if (Erro.1 == 1) {
					ControlClick(Erro.2,Erro.3)
					BREAK
				}
			}
		}
	}

	if (Data.Group["Healing"] == 0 && Cords.Party.1 == 1) {
		Gui, HealFriend:Default

		GuiControlGet, EK_ExuraGranSio
		GuiControlGet, Percent_EK_ExuraGranSio
		intPercent_EK_ExuraGranSio := Percent_EK_ExuraGranSio*5

		GuiControlGet, EK_ExuraSio
		GuiControlGet, Percent_EK_ExuraSio
		intPercent_EK_ExuraSio := Percent_EK_ExuraSio*5

		GuiControlGet, RP_ExuraGranSio
		GuiControlGet, Percent_RP_ExuraGranSio
		intPercent_RP_ExuraGranSio := Percent_RP_ExuraGranSio*5

		GuiControlGet, RP_ExuraSio
		GuiControlGet, Percent_RP_ExuraSio
		intPercent_RP_ExuraSio := Percent_RP_ExuraSio*5

		;check if sio activated
		if NOT (EK_ExuraGranSio or EK_ExuraSio or RP_ExuraGranSio or RP_ExuraSio) {
			RETURN
		}

		;[Mas Res if EK and RP Low Life]
		GuiControlGet, MasRes
		GuiControlGet, Percent_MasRes_Stage1
		intPercent_MasRes_Stage1 := Percent_MasRes_Stage1*5
		if (Data.Skill["ExuraGranMasRes"] == 0 && MasRes == 1) {
			if (Data.HP <= intPercent_MasRes_Stage1) {
				Press_Key("Hotkey_MasRes")
				Data.Group["Healing"] := 1
				RETURN
			}
			if ( (EK_ExuraGranSio or EK_ExuraSio) && ( RP_ExuraGranSio or RP_ExuraSio ) ) {
				if (Data.FriendHP.EK != 100 && Data.FriendHP.EK != "" && Data.FriendHP.RP != 100 && Data.FriendHP.RP != "") {
					if ( ( Data.FriendHP.EK <= intPercent_EK_ExuraGranSio or Data.FriendHP.EK <= intPercent_EK_ExuraSio ) && ( Data.FriendHP.RP <= intPercent_RP_ExuraGranSio or Data.FriendHP.RP <= intPercent_RP_ExuraSio ) ){
						Press_Key("Hotkey_MasRes")
						Data.Group["Healing"] := 1
						RETURN
					}
				}
			}
		}


		;[HEAL FRIEND]
		GuiControlGet, checkBox_Inverter_Prioridade_HealFriend, HealFriend:
		if (checkBox_Inverter_Prioridade_HealFriend == true) {
			if ( Heal_Second_Player_On_Party_List() ) {
				RETURN
			}
			if ( Heal_First_Player_On_Party_List() ) {
				RETURN
			}
		} else {
			if ( Heal_First_Player_On_Party_List() ) {
				RETURN
			}
			if ( Heal_Second_Player_On_Party_List() ) {
				RETURN
			}
		}


	}
}

;USED IN HEAL_FRIEND()
Heal_First_Player_On_Party_List(){
    GLOBAL
	;[Exura Sio - First Player on Battle]
	if (Data.FriendHP.EK != 100 && Data.FriendHP.EK != "") {
		if ( EK_ExuraGranSio && Data.FriendHP.EK <= intPercent_EK_ExuraGranSio && Data.Skill["ExuraGranSio"] == 0) {
			Press_Key("Hotkey_EK_ExuraGranSio")
			Data.Group["Healing"] := 1
			RETURN TRUE
		} else if ( EK_ExuraSio && Data.FriendHP.EK <= intPercent_EK_ExuraSio ) {
			Press_Key("Hotkey_EK_ExuraSio")
			if (Vocation != "Druid") {
				Sleep 35
				ControlClick(Cords.Party.2+20,Cords.Party.3+26+ICONS)
			}
			Data.Group["Healing"] := 1
			RETURN TRUE
		}
	}
	RETURN FALSE
}
Heal_Second_Player_On_Party_List(){
    GLOBAL
	;[Exura Sio - Second Player on Battle]
	if (Data.FriendHP.RP != 100 && Data.FriendHP.RP != "") {
		if ( RP_ExuraGranSio && Data.FriendHP.RP <= intPercent_RP_ExuraGranSio && Data.Skill["ExuraGranSio"] == 0) {
			Press_Key("Hotkey_RP_ExuraGranSio")
			Data.Group["Healing"] := 1
			RETURN TRUE
		} else if ( RP_ExuraSio && Data.FriendHP.RP <= intPercent_RP_ExuraSio ) {
			Press_Key("Hotkey_RP_ExuraSio")
			if (Vocation != "Druid") {
				Sleep 35
				ControlClick(Cords.Party.2+20,Cords.Party.3+26+26+ICONS)
			}
			Data.Group["Healing"] := 1
			RETURN TRUE
		}
	}
	RETURN FALSE
}
