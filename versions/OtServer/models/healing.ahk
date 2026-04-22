; READ DATA
LocateHPBar(){
	GLOBAL
	if (TibiaServer = "Shadow-Illusion") {
		Cords.CooldownBox := []
		Cords.CooldownBox.3 := 99999	;fix bug alarms in shadow-ilusion
		SearchPNG(PNG.HPBar.ShadowIllusion, WindowInfo.ClassNN.w/2, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=25, Erro, Mode:=1), Cords.HP:=Erro
		ArColor.Status := {HP: CorToDec("#FF5E5E"), MP: CorToDec("#5E5EFF")}
		; if (A_ScreenDPI/96 > 1) {
		; 	ArColor.Status := {HP: CorToDec("#F55959"), MP: CorToDec("#5959F5")}
		; }
		if (Cords.HP.1 == 1) {
			;~ Gui, Support:Default
			;~ GuiControl, Enable, DropDownList_EquipRing	;enable DropDownlist support equip ring
			GuiControl,Support:, DropDownList_EquipRing, BeginnerRing	;add Beginner Ring on DropDownlist equip ring
			GuiControl,Support:ChooseString, DropDownList_EquipRing, BeginnerRing
			GuiControl,Support:, Picture_EquipRing, % "HBITMAP:* " Picture["BeginnerRing"]

			Gui, TankMode:Default
			GuiControl,TankMode:, DropDownList_TankModeLife_Ring, EnergyRing	;add Energy Ring on DropDownlist TankMode Life
			load_config("DropDownList_TankModeLife_Ring", "Configs\" TibiaServer "\" Vocation "\TankMode.ini", "DropDownList_TankModeLife_Ring", "DropDownList")
			TOOLTIP ; remove tooltip load_config

			ColorHex_Validate_HPBar := GetColorHex(Cords.HP.2+1, Cords.HP.3+1)	;[GET ColorHex Validate HPBar]

			; ========================================= [ Conditions BAR ] =========================================
			; ========================================= [ Conditions BAR ] =========================================
			; ========================================= [ Conditions BAR ] =========================================
			; ArColor.Conditions is found in 12x8 (total: 18x18)
			SearchPNG(PNG.ConditionsBar.ShadowIllusion, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Cords.Con:=Erro
			if (Cords.Con.1 == 1) {
				ColorHex_Validate_ConditionsBar := GetColorHex(Cords.Con.2+1, Cords.Con.3+1)	;[GET ColorHEX Validate ConditionsBar]
			}

			;ARColor is found in coord: 12,8 (Total:18x18).
			ArColor.Conditions := {	EatFood: CorToDec("#F6D48F"),		Haste: CorToDec("#876a3d"),			EnergyRing: CorToDec("#272DCC"),	LogoutBlock: CorToDec("#7E7E83")
			,					CureParalyze: CorToDec("#E90404"),		CureBurning: CorToDec("#FECD0B"),	ProtectionZone: CorToDec("#FFFFFF")
			,					CureParalyze2: CorToDec("#FF0000"),		CureCurse: CorToDec("#0A0A0A"),		CurePoison: CorToDec("#35e24d")
			,					UtamoVita: CorToDec("#272DCC"), 		Strength: CorToDec("#233922")}

			return True
		}
		ToolTip("HPBar Not Found", Time:=-500, PosX:=,PosY:=, WhichToolTip:=20)
		return False
	}

	ArColor.Status := {}
	ArColor.Status := {HP: CorToDec("#f16161"), MP: CorToDec("#4340c0")}
	SearchPNG(PNG.HPBar.Default, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=30, Erro, Mode:=1), Cords.HP:=Erro
	if (Cords.HP.1 == 1) {
		ColorHex_Validate_HPBar := GetColorHex(Cords.HP.2+1, Cords.HP.3+1)	;[GET ColorHex Validate HPBar]
		return True
	} else {
		ToolTip("HPBar Not Found", Time:=-500, PosX:=,PosY:=, WhichToolTip:=20)
	}
	return False
}
Verify_HP(){
	GLOBAL

	if (TibiaServer = "Global" or TibiaServer = "OtServer") {
		1x := Cords.HP.2+13 , 1y := Cords.HP.3+5
		2x := 1x            , 2y := 1y+11
		HpMpPixels:=90
		
		PixelsRestantes := 1
		Loop, % HpMpPixels+1 {
			1gx:=1x-A_Index+HpMpPixels+1
			Color := GetColorDecimal(1gx, 1y)

			; ; [DEBUGGER] START
			; MouseMove, % 1gx + WindowInfo.ClassNN.x, % 1y + WindowInfo.ClassNN.y
			; TOOLTIP % Color
			; ClipBoard := Color
			; Sleep 25
			; KeyWait, Control
			; ; [DEBUGGER] FINISH 

			If (Color == ArColor.Status.HP){
				PixelsRestantes := HpMpPixels-A_Index+1
				Break 1
			}
		}

		Data.HP := Floor( (PixelsRestantes / HpMpPixels) * 100 )
		; ToolTip("Data.HP : " Data.HP "`nData.MP: " Data.MP,Time:=-500,X:=500,Y:=500,WhichToolTip:=04)
	}

	if (TibiaServer = "Shadow-Illusion") {
		1x := Cords.HP.2+3	, 1y := Cords.HP.3+1
		2x := 1x            , 2y := Cords.HP.3+18
		HpMpPixels:=175

		Loop, % HpMpPixels {
			1gx:=1x+HpMpPixels-A_Index
			Color := GetColorDecimal(1gx, 1y)
			MouseMove(1gx, 1y)
			ColorHex := GetColorHex(1gx, 1y)
			ClipBoard := ColorHex
			ToolTip(ColorHex)
			sleep 250

			If (Color = ArColor.Status.HP) {
				Data.HP := HpMpPixels-A_Index
				Break 1
			}
			Data.HP := 0

		}

		Data.HP := Floor( Data.HP / (174/100) )
	}


	; ToolTip("Data.HP : " Data.HP "`nData.MP: " Data.MP,Time:=-500,X:=500,Y:=500,WhichToolTip:=04)
	; HUD CAVEBOT STATUS
	GuiControl, HUD_CaveBot_Status:, HealthBar_CaveBot_HUD, % Data.HP
}
Verify_MP(){
	GLOBAL

	if (TibiaServer = "OTClient" or client_ahk_class = "DeusOT") {		
		Data.MP := 0
		found_pixel := False
		Loop, % HpMpPixels {			
			2gx:=2x+HpMpPixels-A_Index
			Color:=GetColorDecimal(2gx, 2y)
			
			; ~ [DEBUGGER] START
			; MouseMove, % 2gx + WindowInfo.ClassNN.x, % 2y + WindowInfo.ClassNN.y
			; TOOLTIP % Color
			; ClipBoard := Color
			; Sleep 25
			; KeyWait, Control
			; ~ [DEBUGGER] FINISH 

			Color_List_MP := [4281742247]	;cores que bugam no processo
			for Each, rColor in Color_List_MP {
				if (Color == rColor) {
					found_pixel := True
					Break 1
					; msgbox % "Color: " Color " && rColor: " rColor
				}
			}

			; A_Index precisa ser do Loop (2)
			if (found_pixel) {
				PixelsRestantes := HpMpPixels-A_Index+1		
				Break
			} 
		}	
		
		Data.MP := Floor( (PixelsRestantes / HpMpPixels) * 100 )
		; ToolTip("Data.HP : " Data.HP "`nData.MP: " Data.MP,Time:=-500,X:=500,Y:=500,WhichToolTip:=04)
		GuiControl, HUD_CaveBot_Status:, ManaBar_CaveBot_HUD, % Data.MP
		RETURN
	}

	if (TibiaServer = "Global" or TibiaServer = "OtServer") {
		
		PixelsRestantes := 1
		Loop, % HpMpPixels+1 {
			2gx:=2x+HpMpPixels-A_Index+1
			Color:=GetColorDecimal(2gx, 2y)

			; ~ [DEBUGGER] START
			; MouseMove, % 2gx + WindowInfo.ClassNN.x, % 2y + WindowInfo.ClassNN.y
			; TOOLTIP % Color
			; ClipBoard := Color
			; Sleep 25
			; KeyWait, Control
			; ~ [DEBUGGER] FINISH 

			If (Color == ArColor.Status.MP){
				PixelsRestantes := HpMpPixels-A_Index+1
				Break 1
			}
		}	
		

		Data.MP := Floor( (PixelsRestantes / HpMpPixels) * 100 )
		; ToolTip("Data.HP : " Data.HP "`nData.MP: " Data.MP,Time:=-500,X:=500,Y:=500,WhichToolTip:=04)
		GuiControl, HUD_CaveBot_Status:, ManaBar_CaveBot_HUD, % Data.MP
		RETURN
	}
	

	if (TibiaServer = "Shadow-Illusion") {
		Loop, % HpMpPixels {
			2gx:=2x+HpMpPixels-A_Index
			Color:=GetColorDecimal(2gx, 2y)

			if (Color = ArColor.Status.MP) {
				Data.MP := HpMpPixels-A_Index
				Break 1
			}
			Data.MP := 0

		}

		Data.MP := Floor( Data.MP / (174/100) )
	}


	; ToolTip("Data.HP : " Data.HP "`nData.MP: " Data.MP,Time:=-500,X:=500,Y:=500,WhichToolTip:=04)
	;~ msgbox % Color

	; HUD CAVEBOT STATUS
	GuiControl, HUD_CaveBot_Status:, ManaBar_CaveBot_HUD, % Data.MP
}

; AUTOMATION
Healing_Spells(){
	GLOBAL
	; Set Delay Spell's by TibiaServer
	switch TibiaServer {
		case "Global": Delay_Healing_Spells := 200
		case "OtServer": Delay_Healing_Spells := -1		;nenhum delay
		default: Delay_Healing_Spells := 200
	}

	; TOOLTIP, % Data.Group["Healing"]
	if (Data.Group["Healing"] == 0) {
		Gui, Healing:Default
		i := 4
		Loop, %i% {
			GuiControlGet, CheckBox_Life_Stage%i%

			;dont use healing stage 1 if combo ON
			GuiControlGet, CheckBox_Dont_Use_Healing1_if_Combo_ON	;SHADOW ILLUSION
			if (i == 1 && (CheckBox_Dont_Use_Healing1_if_Combo_ON && (State_Combo = "ON" or (isAttacking && %Type_Combo_Active%_CheckBox_Automatic_Combo) ) ) ) {
				BREAK
			}

			;use healing spell
			if (CheckBox_Life_Stage%i%) {
				GuiControlGet, Percent_Health_Life_Stage%i%
				GuiControlGet, Percent_Mana_Life_Stage%i%
				if (Data.HP < Percent_Health_Life_Stage%i% && Data.MP > Percent_Mana_Life_Stage%i%) {
					ElapsedTime_Healing_Spells := A_TickCount - StartTime_Healing_Spells
					if (ElapsedTime_Healing_Spells > Delay_Healing_Spells) {
						Press_Key("Hotkey_Spell_Life_Stage" i)	;SPELL 1
						Press_Key("Hotkey_Others_Life_Stage" i)	;SPELL 2
						StartTime_Healing_Spells := A_TickCount
					}
					if (TibiaServer = "Shadow-Illusion") {
						Data.Group["Healing"]	:= 1	;server delay
						Data.Group["Support"]	:= 1	;server delay
						Data.Group["Attack"]	:= 1	;server delay
					}
					BREAK
				}
			}
			i--
		}
	}
}
Healing_Potions(){
	GLOBAL
	; Set Delay Spell's by TibiaServer
	switch TibiaServer {
		case "Global": Delay_Healing_Potions := 400
		case "OtServer": Delay_Healing_Potions := 400
		default: Delay_Healing_Potions := 400
	}

	ElapsedTime_Healing_Potions := A_TickCount - StartTime_Healing_Potions
	if (ElapsedTime_Healing_Potions > 400) {
		;ignore potion if use avalanche rune
		GuiControlGet, CheckBox_Ignore_Potion_if_Use_Avalanche, Combo:
		if (CheckBox_Ignore_Potion_if_Use_Avalanche == 1) {
			GuiControlGet, CheckBox_Only_Use_Avalanche_if_Have_Target, Combo:
			if ( (CheckBox_Only_Use_Avalanche_if_Have_Target == 1 && isAttacking = True) OR CheckBox_Only_Use_Avalanche_if_Have_Target != 1) {
				if (State_Combo == "ON" && String_ListBox_Combo = "Attack_Rune" && Data.Group["Attack"] == 0) {
					RETURN
				}
			}
		}

		Gui, Healing:Default
		;[MANA HEALING]
		i := 2
		Loop, %i% {
			GuiControlGet, CheckBox_Mana_Stage%i%
			if (CheckBox_Mana_Stage%i%) {
				if (Vocation = "Druid" or Vocation = "Sorcerer") {
					Percent_IgnoreMana_Stage1 := -1 ;disable for sorc and druid
				} else {
					GuiControlGet, Percent_IgnoreMana_Stage1
				}
				GuiControlGet, Percent_Mana_Stage%i%
				if (Data.MP < Percent_Mana_Stage%i% && Data.HP > Percent_IgnoreMana_Stage1) {
					Press_Key("Hotkey_Potion_Mana_Stage" i)
					StartTime_Healing_Potions := A_TickCount
					RETURN
				}
			}
			i--
		}

		;[LIFE HEALING]
		i := 4
		Loop, %i% {
			GuiControlGet, CheckBox_Life_Stage%i%
			if (CheckBox_Life_Stage%i%) {
				GuiControlGet, Percent_Health_Life_Stage%i%
				if (Data.HP < Percent_Health_Life_Stage%i% ) {
					Press_Key("Hotkey_Potion_Life_Stage" i)
					StartTime_Healing_Potions := A_TickCount
					RETURN
				}
			}
			i--
		}
	}
}
