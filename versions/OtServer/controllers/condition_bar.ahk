LocateConditionBar() {
    GLOBAL
    SearchPNG(PNG.ConditionsBar, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Cords.Con:=Erro
    if (Cords.Con.1 == 1) {
        ColorHex_Validate_ConditionsBar := GetColorHex(Cords.Con.2+1, Cords.Con.3+1)	;[GET ColorHEX Validate ConditionsBar]
    }
    ArColor.Conditions := {	EatFood: CorToDec("#F6D48F"),			Haste: CorToDec("#B08B50"),			EnergyRing: CorToDec("#272DCC"),	LogoutBlock: CorToDec("#7E7E83")
        ,					EatFood2: CorToDec("#362605"),			CureParalyze: CorToDec("#E90404"),	Medusa: CorToDec("#808087"),		CureBurning: CorToDec("#FECD0B")
        ,					ProtectionZone: CorToDec("#FFFFFF"),	MedusaV: CorToDec("#254423"),		CurePoison: CorToDec("#A8FFB5"),	CureCurse: CorToDec("#0A0A0A")
        ,					UtamoVita: CorToDec("#9a1a37"),			Drunk: CorToDec("#764800"), 		Strength: CorToDec("#233922"), 		Fear: CorToDec("#202121")
        ,					Root: CorToDec("#573C36")}
}

Verify_Conditions(){
    GLOBAL

	if (TibiaServer = "Global" or TibiaServer = "OtServer") {
		1x := Cords.Con.2+6 , 1y := Cords.Con.3+7, ConRead:=[]
		i := 1 ;debugger
		loop, 10 {
			;~ Crop_And_Save_Haystack(1x,1y,50,50)
			debugger_color_%i% := GetColorHex(1x, 1y)	;debugger
			Color := GetColorDecimal(1x, 1y)
			for ConditionsName, ConditionsCor in ArColor.Conditions {
				If (ConRead[A_Index] != A_Index)
					If (Color = ConditionsCor){
						;~ Msgbox % "ConditionsName: " ConditionsName "`nColorDec: " Color ;debugger
						;~ msgbox % ConditionsName " + i=" A_Index
						Data.Conditions[ConditionsName] := 1
						ConRead[A_Index] := A_Index
						Break 1
					} else
						Data.Conditions[ConditionsName] := 0
			}
			1x := 1x + 10
			if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") {
				1x++	;fix bug rubinot RTC
			}
			i++	;debugger
		}


		if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") { ;fix coordinate dinamica rubinot RTC
			1x := Cords.Con.2+6 , 1y := Cords.Con.3+7, ConRead:=[]
			1x += 2 ;fix coordinate dinamica rubinot RTC
			loop, 10 {
				Color := GetColorDecimal(1x, 1y)
				for ConditionsName, ConditionsCor in ArColor.Conditions {
					If (ConRead[A_Index] != A_Index)
						If (Color = ConditionsCor){
							Data.Conditions[ConditionsName] := 1
							ConRead[A_Index] := A_Index
							Break 1
						}
				}
				1x := 1x + 10
				if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") {
					1x++	;fix bug rubinot RTC
				}
			}
		}


		;~ msgbox % "i: " i "`nfixbug_rtc_conditions: " fixbug_rtc_conditions
		;~ tooltip(debugger_color_1 "`n" debugger_color_2 "`n" debugger_color_3 "`n" debugger_color_4 "`n" debugger_color_5 "`n" debugger_color_6) ;debugger

		;[fix bug old utamo vita]
		if (Data.Conditions.EnergyRing == 1) {
			Data.Conditions.UtamoVita := 1
		}

		;[fix bug eatfood new version]
		if (Data.Conditions.EatFood2 == 1) {
			Data.Conditions.EatFood := 1
		}

	}

	if (TibiaServer = "Shadow-Illusion") {
		1x := Cords.Con.2+16-9 , 1y := Cords.Con.3+157-6+1, ConRead:=[]

		debugger_color := []
		i := 0	;use in debugger color

		loop, 7 {
			;~ Crop_And_Save_Haystack(1x,1y,50,50)
			Found_Condition := false
			debugger_color[i] := GetColorHex(1x, 1y)
			Color := GetColorDecimal(1x, 1y)
			for ConditionsName, ConditionsCor in ArColor.Conditions {
				If (ConRead[A_Index] != A_Index)
					If (Color = ConditionsCor){
						;~ Msgbox % "ConditionsName: " ConditionsName "`nColorDec: " Color
						Data.Conditions[ConditionsName] := 1
						ConRead[A_Index] := A_Index
						Found_Condition := true
						Break 1
					} else
						Data.Conditions[ConditionsName] := 0
			}
			1xk := 1x
			Loop, 3 {
				if (Found_Condition != true) {
					1xk++
					i++
					debugger_color[i] := GetColorHex(1xk, 1y)
					Color := GetColorDecimal(1xk, 1y)
					for ConditionsName, ConditionsCor in ArColor.Conditions {
						If (ConRead[A_Index] != A_Index)
							If (Color = ConditionsCor){
								Data.Conditions[ConditionsName] := 1
								ConRead[A_Index] := A_Index
								Found_Condition := true
								1x := 1xk
								Break 2
							}
					}
				}
			}
			1x := 1x + 10
			i := Ceil((i+1) / 10) * 10	;increase i pora dezena pra cima mais proxima
		}

		;~ tooltip(debugger_color[0] " " debugger_color[1] " " debugger_color[2] "`n" debugger_color[10] " " debugger_color[11] " " debugger_color[12] "`n" debugger_color[20] " " debugger_color[21] " " debugger_color[22] "`n" debugger_color[30] " " debugger_color[31] " " debugger_color[32] "`n" debugger_color[40] " " debugger_color[41] " " debugger_color[42] "`n" debugger_color[50] " " debugger_color[51] " " debugger_color[52] "`n" debugger_color[60] " " debugger_color[61] " " debugger_color[62] "`n" debugger_color[70] " " debugger_color[71] " " debugger_color[72])

		;[fix bug old utamo vita]
		if (Data.Conditions.EnergyRing == 1) {
			Data.Conditions.UtamoVita := 1
		}
	}

	if (TibiaServer = "Shadow-Illusion-OLD") {
		1x := Cords.Con.2+16 , 1y := Cords.Con.3+157, ConRead:=[]

		;~ i := 1
		loop, 6 {
			;~ test_color_%i% := GetColorHex(1x, 1y)
			Color := GetColorDecimal(1x, 1y)
			for ConditionsName, ConditionsCor in ArColor.Conditions {
				If (ConRead[A_Index] != A_Index)
					If (Color = ConditionsCor){
						;~ Msgbox % "ConditionsName: " ConditionsName "`nColorDec: " Color
						Data.Conditions[ConditionsName] := 1
						ConRead[A_Index] := A_Index
						Break 1
					} else
						Data.Conditions[ConditionsName] := 0
			}
			1x := 1x + 20
			;~ i++	;increase i
		}
		;~ tooltip(test_color_1 "`n" test_color_2 "`n" test_color_3 "`n" test_color_4 "`n" test_color_5 "`n" test_color_6)

		;[fix bug old utamo vita]
		if (Data.Conditions.EnergyRing == 1) {
			Data.Conditions.UtamoVita := 1
		}
	}


}
