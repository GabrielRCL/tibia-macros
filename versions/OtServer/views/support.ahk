Draw_Gui_Support() {
    GLOBAL
	Load_Pre_Settings("Support")

	Gui, Add, Tab, x1 y1 w580 h420, Support|Adv. Options	;|Hotkeys 7.4|PushItem 7.4


	; [Hotkeys7.4] Tab ====================================================================
	if (false) {
		Gui, Tab, Hotkeys 7.4
		; ==== [ Hotkeys ] ====
		Support_GroupBox_HotkeyX := 12
		Support_Picture_HotkeyX := 42
		Support_Button_HotkeyX := 28
		Support_Text_HotkeyX := 22
		Support_Hotkey_HotkeyX := 22
		CheckBox_Hotkey74_PosX := 17
		Delay_Hotkey74_PosX := 17
		TextSeconds_Hotkey74_PosX := 65
		i := -1
		Loop, 5 {
			i++
			Gui, Font, Bold
				Gui, Add, GroupBox, x%Support_GroupBox_HotkeyX% y29 w100 h170 +Center, Hotkey%i%
			Gui, Font, Norm
				Gui, Add, Picture, x%Support_Picture_HotkeyX% y49 w32 h32 vHotkeys74_Picture_Hotkey%i%, Imagens\Hotkeys74\Hotkey%i%.png
				Gui, Add, Button, x%Support_Button_HotkeyX% y84 w60 h20 gSupport_Hotkeys74_GetPic_Hotkey%i%, Get Pic.
				Gui, Add, Text, x%Support_Text_HotkeyX% y109 w80 h20 +Center, Key to Active
				Gui, Add, Hotkey, x%Support_Hotkey_HotkeyX% y129 w80 h20 vSupport_Hotkey74_Hotkey%i%,
				Gui, Add, CheckBox, x%CheckBox_Hotkey74_PosX% y154 w90 h20 vCheckBox_Hotkey74_Hotkey%i%, Repeat Every:
			Gui, Font, cRed
				Gui, Add, Edit, x%Delay_Hotkey74_PosX% y174 w45 h20 vDelay_Hotkey74_Hotkey%i%, 123456
			Gui, Font, cWhite
				Gui, Add, Text, x%TextSeconds_Hotkey74_PosX% y179 w42 h15, ms.
			Support_GroupBox_HotkeyX += 115
			Support_Picture_HotkeyX += 115
			Support_Button_HotkeyX += 115
			Support_Text_HotkeyX += 115
			Support_Hotkey_HotkeyX += 115
			CheckBox_Hotkey74_PosX += 115
			Delay_Hotkey74_PosX += 115
			TextSeconds_Hotkey74_PosX += 115
		}

		; ==== [ Hotkeys ] ====
		Support_GroupBox_HotkeyX := 12
		Support_Picture_HotkeyX := 42
		Support_Button_HotkeyX := 28
		Support_Text_HotkeyX := 22
		Support_Hotkey_HotkeyX := 22
		CheckBox_Hotkey74_PosX := 17
		Delay_Hotkey74_PosX := 17
		TextSeconds_Hotkey74_PosX := 65
		Loop, 5 {
			i++
			Gui, Font, Bold
				Gui, Add, GroupBox, x%Support_GroupBox_HotkeyX% y209 w100 h170 +Center, Hotkey%i%
			Gui, Font, Norm
				Gui, Add, Picture, x%Support_Picture_HotkeyX% y229 w32 h32 vHotkeys74_Picture_Hotkey%i%, Imagens\Hotkeys74\Hotkey%i%.png
				Gui, Add, Button, x%Support_Button_HotkeyX% y264 w60 h20 gSupport_Hotkeys74_GetPic_Hotkey%i%, Get Pic.
				Gui, Add, Text, x%Support_Text_HotkeyX% y289 w80 h20 +Center, Key to Active
				Gui, Add, Hotkey, x%Support_Hotkey_HotkeyX% y309 w80 h20 vSupport_Hotkey74_Hotkey%i%,
				Gui, Add, CheckBox, x%CheckBox_Hotkey74_PosX% y334 w90 h20 vCheckBox_Hotkey74_Hotkey%i%, Repeat Every:
			Gui, Font, cRed
				Gui, Add, Edit, x%Delay_Hotkey74_PosX% y354 w45 h20 vDelay_Hotkey74_Hotkey%i%, 123456
			Gui, Font, cWhite
				Gui, Add, Text, x%TextSeconds_Hotkey74_PosX% y359 w42 h15, ms.
			Support_GroupBox_HotkeyX += 115
			Support_Picture_HotkeyX += 115
			Support_Button_HotkeyX += 115
			Support_Text_HotkeyX += 115
			Support_Hotkey_HotkeyX += 115
			CheckBox_Hotkey74_PosX += 115
			Delay_Hotkey74_PosX += 115
			TextSeconds_Hotkey74_PosX += 115
		}



		; [ PUSH ITEM 7.4 ]
		Gui, Tab, PushItem 7.4
		GroupBox_PushItem74_PosX := 12
		Picture_PushItem74_PosX := 49
		Button_PushItem74_PosX := 35
		TextXY_PushItem74_PosX := 22
		EditXY_PushItem74_PosX := 42
		Hotkey_PushItem74_PosX := 22
		i := 0
		Loop, 4 {
			i++
			Gui, Font, Bold
				Gui, Add, GroupBox, x%GroupBox_PushItem74_PosX% y29 w110 h180 +Center, Push Item%i%
			Gui, Font, Norm
				Gui, Add, Picture, x%Picture_PushItem74_PosX% y49 w32 h32, Imagens\Hotkeys74\Spear.gif
				Gui, Add, Button, x%Button_PushItem74_PosX% y82 w60 h20 gGetCoord_Hotkeys74_PushItem%i%, Get Coord.
				Gui, Add, Text, x%TextXY_PushItem74_PosX% y109 w20 h20 , X=
				Gui, Add, Text, x%TextXY_PushItem74_PosX% y132 w20 h20 , Y=
			Gui, Font, cRed
				Gui, Add, Edit, x%EditXY_PushItem74_PosX% y109 w60 h20 vPosX_Hotkeys74_PushItem%i%, 1234
				Gui, Add, Edit, x%EditXY_PushItem74_PosX% y132 w60 h20 vPosY_Hotkeys74_PushItem%i%, 4312
			Gui, Font, cWhite
				Gui, Add, Text, x%Hotkey_PushItem74_PosX% y164 w80 h20 +Center, Key to Active
				Gui, Add, Hotkey, x%Hotkey_PushItem74_PosX% y184 w80 h20 vHotkey_Hotkeys74_PushItem%i%,

			GroupBox_PushItem74_PosX += 115
			Picture_PushItem74_PosX += 115
			Button_PushItem74_PosX += 115
			TextXY_PushItem74_PosX += 115
			EditXY_PushItem74_PosX += 115
			Hotkey_PushItem74_PosX += 115
		}
	}

	; [Default] Tab ====================================================================
	Gui, Tab, Support
	if (true) {
		; ===== [Haste] =====
		Gui, Font, Bold
			Gui, Add, GroupBox, x10 y30 w120 h95 , Haste
		Gui, Font, Normal
			Gui, Add, Picture, section xp+44 yp+15 w32 h32 , % "HBITMAP:* " Picture.Haste
			Gui, Add, CheckBox, xs-11 ys+37 w50 vHaste, Haste
			Gui, Add, Text, section xs-39 ys+58, Hotkey:
			Gui, Add, Hotkey, xp+41 ys-1 w70 h20 vHotkey_Haste,
		; ===== [Cure Paralyze] =====
		Gui, Font, Bold
			Gui, Add, GroupBox, x140 y30 w120 h95 , Cure Paralyze
		Gui, Font, Normal
			Gui, Add, Picture, section xp+44 yp+15 w32 h32 , % "HBITMAP:* " Picture.CureParalyze
			Gui, Add, CheckBox, xs-26 ys+32 w85 vHealParalyze, Cure Paralyze
			Gui, Add, Text, section xs-39 ys+58, Hotkey:
			Gui, Add, Hotkey, xp+41 ys-1 w70 h20 vHotkey_HealParalyze,
		; ===== [Strengthen] =====
		Gui, Font, Bold
			Gui, Add, GroupBox, x270 y30 w120 h95 +Center, Strengthen (Potion)
		Gui, Font, Normal
			Gui, Add, Picture, section xp+44 yp+15 w32 h32 , % "HBITMAP:* " Picture.SpecialPotion
			Gui, Add, CheckBox, xs-20 ys+37 w50 vStrengthen, Strengthen
			Gui, Add, Text, section xs-39 ys+58, Hotkey:
			Gui, Add, Hotkey, xp+41 ys-1 w70 h20 vHotkey_Strengthen,
		; ===== [Eat Food] =====
		Gui, Font, Bold
			Gui, Add, GroupBox, x400 y30 w120 h95 , Eat Food
		Gui, Font, Normal
			Gui, Add, Picture, section xp+44 yp+15 w32 h32 , % "HBITMAP:* " Picture.EatFood
			Gui, Add, CheckBox, xs-15 ys+37 w65 vEatFood, Eat Food
			Gui, Add, Text, section xs-39 ys+58, Hotkey:
			Gui, Add, Hotkey, xp+41 ys-1 w70 h20 vHotkey_EatFood,
		;~ ; ===== [Equip Amulet] =====
		Gui, Font, Bold
			Gui, Add, GroupBox, x10 y135 w145 h125 , Equip Amulet
		Gui, Font, Normal
			Gui, Add, Picture, section xp+55 yp+15 w32 h32 vPicture_EquipAmulet, % "HBITMAP:* " Picture.NoAmulet
			Gui, Add, CheckBox, xs-50 ys+37 w15 h20 vEquipAmulet
			Gui, Add, DropDownList, xs-35 ys+37 r10 vDropDownList_EquipAmulet gRefresh_Image_EquipAmulet, % Amulets
			GuiControl, ChooseString, DropDownList_EquipAmulet,NoAmulet
			GuiControl, Disable, DropDownList_EquipAmulet
			Gui, Add, Text, section xs-39 ys+63, Hotkey:
			Gui, Add, Hotkey, xp+41 ys-1 w70 h20 vHotkey_EquipAmulet,
			Gui, Add, Text, section xs-12 ys+24, Key to Active:
			Gui, Add, Hotkey, xs+67 ys-2 w70 h20 vKeyToActive_EquipAmulet,
		;~ ; ===== [Equip Ring] =====
		Gui, Font, Bold
			Gui, Add, GroupBox, x165 y135 w145 h125, Equip Ring
		Gui, Font, Norm
			Gui, Add, Picture, section xp+55 yp+15 w32 h32 vPicture_EquipRing, % "HBITMAP:* " Picture.NoRing
			Gui, Add, CheckBox, xs-50 ys+37 w15 h20 vEquipRing
			Gui, Add, DropDownList, xs-35 ys+37 r10 Choose10 vDropDownList_EquipRing gRefresh_Image_EquipRing, % Rings
			GuiControl, ChooseString, DropDownList_EquipRing, NoRing
			GuiControl, Disable, DropDownList_EquipRing
			Gui, Add, Text, section xs-39 ys+63, Hotkey:
			Gui, Add, Hotkey, xp+41 ys-1 w70 h20 vHotkey_EquipRing,
			Gui, Add, Text, section xs-12 ys+24, Key to Active:
			Gui, Add, Hotkey, xs+67 ys-1 w70 h20 vKeyToActive_EquipRing,

		; ===== [Mana Shield] =====
		if (Vocation == "Druid" or Vocation == "Sorcerer") {
		Gui, Font, Bold
			Gui, Add, GroupBox, x10 y265 w562 h95 , Mana Shield
		Gui, Font, Normal

			Gui, Add, Picture, section xp+10 yp+20 w32 h32 vOldUtamoPicture, % "HBITMAP:* " Picture.EnergyRing
			Gui, Add, Picture, section xp yp w32 h32 vMagicShieldPicture, % "HBITMAP:* " Picture.UtamoVita
			Gui, Add, Picture, xs w32 h32 vMagicShieldPotionPicture, % "HBITMAP:* " Picture.ManaShieldPotion
			Gui, Add, CheckBox, xs+35 ys+9 vManaShield, Mana Shield
			Gui, Add, CheckBox, xs+35 ys+50 vManaShieldPotion, ManaShield Potion
			Gui, Add, Text, xs+169 ys-10, Hotkey:
			Gui, Add, Hotkey, xs+155 ys+6 w70 h20 vHotkey_ManaShield, ;%Hotkey_ManaShield%
			Gui, Add, Hotkey, xs+155 ys+47 w70 h20 vHotkey_ManaShieldPotion, ;%Hotkey_ManaShieldPotion%

			Gui, Add, Radio, xs+240 ys vRenewEveryTime Checked, Renew ManaShield every 13seconds.				;checked%RenewEveryTime%
			Gui, Add, Radio, xs+240 ys+20 vRenewOnlyWhenDontHave, Renew only when don't have ManaShield.			;checked%RenewOnlyWhenDontHave%
			Gui, Add, Button, xs+300 ys+40 vNewUtamoVita gActiveOldUtamoVita, New Utamo Vita
			GuiControl, Hide, NewUtamoVita
			Gui, Add, Button, xs+300 ys+40 vOldUtamoVita gActiveOldUtamoVita, Old Utamo Vita

		} else if (Vocation == "Paladin") {
			Gui, Font, Bold
				Gui, Add, GroupBox, section x140 y270 w285 h135 , Refill Ammo
			Gui, Font, Normal

			Gui, Add, Picture, section xp+50 yp+20 w32 h32, % "HBITMAP:* " Picture.ConjureDiamondArrow
			Gui, Add, CheckBox, xs-25 ys+35 vCheckBox_ConjureArrow, Conjure Arrow
			Gui, Add, Text, xs-40 ys+55, Hotkey:
			Gui, Add, Hotkey, xs ys+53 w70 h20 vHotkey_ConjureArrow,

			Gui, Add, Picture, section xs+150 ys w32 h32, % "HBITMAP:* " Picture.Ammo
			Gui, Add, CheckBox, xs-20 ys+35 vCheckBox_EquipArrow, Equip Arrow
			Gui, Add, Text, xs-40 ys+55, Hotkey:
			Gui, Add, Hotkey, xs ys+53 w70 h20 vHotkey_EquipArrow,

			Gui, Font, Bold
				Portugues := "OBS:"
				English := "NOTE:"
				Gui, Add, Text, xs-150 ys+85 w40 h20, % %GlobalLanguage%

				Portugues := "Nao coloque mais de 599 municoes no Quiver"
				English := "Do not place more than 599 ammunition in the Quiver"
				;~ Gui, Add, Text, xs-110 ys+80 w160 h30, % %GlobalLanguage%
			Gui, Font, Normal
		}

		; ===== [Eat Food] =====
		Gui, Font, Bold
			Gui, Add, GroupBox, x320 y150 w120 h95 +Center , Auto Bless
		Gui, Font, Normal
			Gui, Add, Picture, section xp+44 yp+15 w32 h32 , % "HBITMAP:* " Picture.AutoBless
			Gui, Add, CheckBox, xs-20 ys+37 w85 vCheckBox_AutoBless, Auto Bless
			Gui, Add, Text, section xs-39 ys+58, Hotkey:
			Gui, Add, Hotkey, xp+41 ys-1 w70 h20 vHotkey_AutoBless,

		; ===== [Drunk] =====
		Gui, Font, Bold
			Gui, Add, GroupBox, x450 y150 w120 h95 +Center, Drunk (Dwarven Ring)
		Gui, Font, Normal
			Gui, Add, Picture, section xp+44 yp+15 w32 h32, % "HBITMAP:* " Picture.Drunk
			Gui, Add, CheckBox, xs-15 ys+37 w65 vDrunk_CheckBox, Drunk
			Gui, Add, Text, section xs-39 ys+58, Hotkey:
			Gui, Add, Hotkey, xp+41 ys-1 w70 h20 vDrunk_Hotkey,


		/*
		; ===== [Soul War] =======
		;[Fear]

		Gui, Add, GroupBox, x5 y323 w280 h65 , Fear (Soul War)
		Gui, Add, Text, x122 y339 w70 h20 +Center, Hotkey
			Gui, Add, Picture, x12 y344 w32 h32 , ICONS\ALL\Fear.png
			Gui, Add, CheckBox, x47 y344 w72 h32 vFear, Fear
		Gui, Font, cBlack
			Gui, Add, Hotkey, x122 y360 w70 h20 vHotkey_Fear, %Hotkey_Fear%
		Gui, Font, cWhite
		;[Root]

		Gui, Add, GroupBox, x287 y323 w280 h65 , Root (Soul War)
		Gui, Add, Text, x382 y339 w70 h20 +Center, Hotkey
			Gui, Add, Picture, x292 y344 w32 h32 , ICONS\ALL\Root.png
			Gui, Add, CheckBox, x326 y344 w50 h32 vRoot, Root
		Gui, Font, cBlack
		Gui, Add, Hotkey, x382 y360 w70 h20 vHotkey_Root, %Hotkey_Root%
		Gui, Font, cWhite
		*/
	}

	; [Adv. Options] Tab ====================================================================
	Gui, Tab, Adv. Options
	if (true) {
		Portugues := "Utilizar magias de Support na Protect Zone (RuneMaker)"
		English := "Use Support spells in Protect Zone (RuneMaker)"
		Gui, Add, CheckBox, x5 y25 w350 h20 vCheckBox_UseSupportSpells_InProtectZone, % %GlobalLanguage%
	}
}

Draw_Gui_Support:
	Gui, Support:Show, % " w" 581 " h" 421, [Support] %TrayName%	;NAME PROGRAMA
RETURN

Refresh_Image_EquipAmulet:
	Gui, Support:Default
	GuiControlGet, DropDownList_EquipAmulet
	tmp_picture := Picture[DropDownList_EquipAmulet]
	GuiControl,, Picture_EquipAmulet, % "HBITMAP:* " tmp_picture
RETURN
Refresh_Image_EquipRing:
	Gui, Support:Default
	GuiControlGet, DropDownList_EquipRing
	tmp_picture := Picture[DropDownList_EquipRing]
	GuiControl,, Picture_EquipRing, % "HBITMAP:* " tmp_picture
RETURN


ActiveOldUtamoVita:
if (OldUtamoVita == 0) {
	;[Hide Default Utamo Vita]
	Gui, TankMode:Default
	GuiControl, Hide, PictureUtamoVita
	GuiControl, Hide, UtamoVita_Life
	GuiControl, Hide, Percent_UtamoVita_Life
	GuiControl, Hide, Hotkey_UtamoVita_Life

	Gui, Support:Default
	GuiControl, Hide, MagicShieldPicture
	GuiControl, Hide, RenewEveryTime
	GuiControl, Hide, RenewOnlyWhenDontHave

	;[TANKMODE BREAK UTAMO]
	Gui, TankMode:Default
	GuiControl, Hide, Picture_Cancel_Magic_Shield
	GuiControl, Hide, Break_Utamo_CheckBox
	GuiControl, Hide, Break_Utamo_Percent
	GuiControl, Hide, Break_Utamo_Hotkey

	;[TANKMODE Life Utamo Potion]
	Gui, TankMode:Default
	GuiControl, Hide, PictureUtamoVitaPotion
	GuiControl, Hide, UtamoVitaPotion_Life
	GuiControl, Hide, Hotkey_UtamoVitaPotion_Life
	GuiControl, Hide, Text_Hotkey_UtamoPotion


	;[Support Manashield Potion]
	Gui, Support:Default
	GuiControl, Hide, MagicShieldPotionPicture
	GuiControl, Hide, ManaShieldPotion
	GuiControl, Hide, Hotkey_ManaShieldPotion

	;[Show Old Utamo Vita]
	Gui, TankMode:Default
	GuiControl, Show, PictureEnergyRing ;Hide Picture Energy Ring
	GuiControl, Show, EnergyRing_Life ;Hide CheckBox Energy Ring
	GuiControl, Show, Percent_EnergyRing_Life ;Hide Slider Energy Ring
	GuiControl, Show, Hotkey_EnergyRing_Life ;Hide Hotkey Energy Ring

	;[REMOVE ENERGY RING]
	Gui, TankMode:Default
	GuiControl, Show, Picture_Remove_EnergyRing ;Hide Picture REMOVE Energy Ring
	GuiControl, Show, Remove_EnergyRing_CheckBox ;Hide CheckBox REMOVE Energy Ring
	GuiControl, Show, Remove_EnergyRing_Percent ;Hide Slider REMOVE Energy Ring
	GuiControl, Show, Remove_EnergyRing_Hotkey ;Hide Hotkey REMOVE Energy Ring

	Gui, Support:Default
	GuiControl, Show, OldUtamoPicture ;Show Picture OLD UTAMO in Support Tab

	;[Change Button]
	Gui, Support:Default
	GuiControl, Hide, OldUtamoVita
	GuiControl, Show, NewUtamoVita

	Gui, TankMode:Default
	GuiControl, Hide, EnergyRingTankMode
	GuiControl, Show, NewUtamoVitaTankMode


	OldUtamoVita := 1	;set enable
} else {
	;[Hide Old Utamo Vita]
	Gui, TankMode:Default
	GuiControl, Hide, PictureEnergyRing ;Hide Picture Energy Ring
	GuiControl, Hide, EnergyRing_Life ;Hide CheckBox Energy Ring
	GuiControl, Hide, Percent_EnergyRing_Life ;Hide Slider Energy Ring
	GuiControl, Hide, Hotkey_EnergyRing_Life ;Hide Hotkey Energy Ring

	;[REMOVE ENERGY RING]
	Gui, TankMode:Default
	GuiControl, Hide, Picture_Remove_EnergyRing ;Hide Picture REMOVE Energy Ring
	GuiControl, Hide, Remove_EnergyRing_CheckBox ;Hide CheckBox REMOVE Energy Ring
	GuiControl, Hide, Remove_EnergyRing_Percent ;Hide Slider REMOVE Energy Ring
	GuiControl, Hide, Remove_EnergyRing_Hotkey ;Hide Hotkey REMOVE Energy Ring

	Gui, Support:Default
	GuiControl, Hide, OldUtamoPicture ;HIDE Picture OLD UTAMO in Support Tab

	;[Show New Utamo Vita]
	Gui, TankMode:Default
	GuiControl, Show, PictureUtamoVita
	GuiControl, Show, UtamoVita_Life
	GuiControl, Show, Percent_UtamoVita_Life
	GuiControl, Show, Hotkey_UtamoVita_Life

	Gui, Support:Default
	GuiControl, Show, MagicShieldPicture
	GuiControl, Show, RenewEveryTime
	GuiControl, Show, RenewOnlyWhenDontHave

	;[TANKMODE BREAK UTAMO]
	Gui, TankMode:Default
	GuiControl, Show, Picture_Cancel_Magic_Shield
	GuiControl, Show, Break_Utamo_CheckBox
	GuiControl, Show, Break_Utamo_Percent
	GuiControl, Show, Break_Utamo_Hotkey

	;[TANKMODE Life Utamo Potion]
	Gui, TankMode:Default
	GuiControl, Show, PictureUtamoVitaPotion
	GuiControl, Show, UtamoVitaPotion_Life
	GuiControl, Show, Hotkey_UtamoVitaPotion_Life
	GuiControl, Show, Text_Hotkey_UtamoPotion


	;[Support ManaShield Potion]
	Gui, Support:Default
	GuiControl, Show, MagicShieldPotionPicture
	GuiControl, Show, ManaShieldPotion
	GuiControl, Show, Hotkey_ManaShieldPotion


	;[Change Button]
	Gui, Support:Default
	GuiControl, Show, OldUtamoVita
	GuiControl, Hide, NewUtamoVita

	Gui, TankMode:Default
	GuiControl, Show, EnergyRingTankMode
	GuiControl, Hide, NewUtamoVitaTankMode


	OldUtamoVita := 0	;set disable
}
return
