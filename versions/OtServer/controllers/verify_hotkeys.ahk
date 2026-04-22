Verify_All_Hotkeys(force:=false) {
    GLOBAL
	if (force != true) {
		if !(WinActive("ahk_class AutoHotkeyGUI")) {
			RETURN
		}
	}

	fix_bugs()
	; Hide_And_Show_MultiClient()
	Verify_ExpireDate()
    Verify_Hotkeys_Support()
    Verify_Hotkeys_TankMode()
    Verify_Hotkeys_Combo()
    Verify_Hotkeys_Looter()
    Verify_Hotkeys_PvP()
	Verify_Hotkeys_Timer()
	Verify_Hotkeys_RemapKeys()
    Verify_Hotkeys_CaveBot()
    Sleep 50
}

fix_bugs() {
    GLOBAL
    ;[fix Paladin energy ring]
	if (Vocation == "Paladin" or Vocation == "Knight") {
		OldUtamoVita := 1
	}
}

Hide_And_Show_MultiClient() {
	GLOBAL
	;auto hide/show gui multi-client
	if (WinActive("ahk_id " active_id)) {
		if (Status_Gui_Hide == TRUE) {
			Auto_Hide_Gui_MultiClient(state:="Show",winactive_tibia:=true)
		}
	} else if (WinActive("ahk_class AutoHotkeyGUI") == false && WinActive("ahk_group Tibia") > 0) {
		if (Status_Gui_Hide == FALSE) {
			Auto_Hide_Gui_MultiClient(state:="Hide",winactive_tibia:=false)
		}
	}
}

Verify_ExpireDate() {
	; no-op: license check removed in open-source release
}

Verify_Hotkeys_Support() {
    GLOBAL
    Gui, Support:Default
	Check_New_Hotkey_Script("KeyToActive_EquipAmulet", "KeyToActiveSupport")
	Check_New_Hotkey_Script("KeyToActive_EquipRing", "KeyToActiveSupport")
    
    
}


Verify_Hotkeys_TankMode() {
    GLOBAL
    Gui, TankMode:Default
	Check_New_Hotkey_Script("Key_Enable_SSA_Life", "KeyToActive")
	Check_New_Hotkey_Script("Key_Enable_SSA_Mana", "KeyToActive")


	Check_New_Hotkey_Script("Key_Enable_MightRing_Life", "KeyToActive")
	Check_New_Hotkey_Script("Key_Enable_MightRing_Mana", "KeyToActive")
    
}

Verify_Hotkeys_Combo() {
    GLOBAL
    Gui, Combo:Default
    Check_New_Hotkey_Script("Combo_PvE_Key_Enable", "AutoCombo_PvE")
    Check_New_Hotkey_Script("Combo_PvP_Key_Enable", "AutoCombo_PvP")
    
}

Verify_Hotkeys_Looter() {
	GLOBAL
	Gui, Looter:Default
	;[FIX BUG]
	GuiControlGet, Delay_Looter
	if (Delay_Looter > 200) {
		GuiControl,, Delay_Looter, 200
	} else if (Delay_Looter == "") {
		GuiControl,, Delay_Looter, 0
	}

	Check_New_Hotkey_Script("Hotkey_Looter", "LootearBox")
	;[MOUSE BUTTON LOOT]
	if (LooterMouseButton == "None" or LooterMouseButton == "ERROR") {
		LooterMouseButton := ""	;fix bug warning
	}
	Hotkey, ~%LooterMouseButton%, LootearBox, Off
	GuiControlGet, LooterMouseButton
	if (LooterMouseButton == "None" or LooterMouseButton == "ERROR") {
		LooterMouseButton := ""	;fix bug warning
	}
	if (LooterMouseButton != "None" && LooterMouseButton != "ERROR" && LooterMouseButton != "") {
		Hotkey, ~%LooterMouseButton%, LootearBox, On
	}

	;[HIDE BUTTON]
	GuiControlGet, Looter_Get_Coord_Manually
	if (Looter_Get_Coord_Manually != 1) {
		LootCords(change_gui_values:=true)
		GuiControl, Hide, Button_SelectCoordSQM9
		GuiControl, Hide, Button_SelectCoordSQM5
		GuiControl, Hide, Button_SelectCoordSQM1
	} else {
		GuiControl, SHOW, Button_SelectCoordSQM9
		GuiControl, SHOW, Button_SelectCoordSQM5
		GuiControl, SHOW, Button_SelectCoordSQM1
	}
}

Verify_Hotkeys_PvP() {
	GLOBAL
	Gui, PvP:Default
	;[USED TO SWAP WARNING]
	GuiControlGet, LooterSQM_9X, Looter:
	GuiControlGet, LooterSQM_9Y, Looter:

	;[Flower]
		Check_New_Hotkey_Script("Key_Enable_Flower", "FlowerOnMouse")
	;[Trash 1 e Trash 2]
		Check_New_Hotkey_Script("Key_Enable_Trash", "TrashOnMouse")
	;[Push Item to Backpack]
		Check_New_Hotkey_Script("Key_Enable_PushItem", "PushItemOnBP")
	;[Instant MagicWall]
		Check_New_Hotkey_Script("Hotkey_MagicWall", "InstantMW")
	;[SWAP SQM MAGIC WALL]
		Check_New_Hotkey_Script("Key_Enable_SwapSqmWithMW", "SwapSqmWithMW")
		GuiControlGet, CheckBox_SwapSqmWithMW
		if (CheckBox_SwapSqmWithMW == 1) {
			if LooterSQM_9X is not number
				Swap_SQM_Warning_Coordinates()
			else if LooterSQM_9Y is not number
				Swap_SQM_Warning_Coordinates()
		}
	;[Instant Growth Rune]
		Check_New_Hotkey_Script("Hotkey_GrowthRune", "InstantGrowth")
	;[SWAP SQM GROWTH RUNE]
		Check_New_Hotkey_Script("Key_Enable_SwapSqmWithGrowth", "SwapSqmWithGrowth")
		GuiControlGet, CheckBox_SwapSqmWithGrowth
		if (CheckBox_SwapSqmWithGrowth == 1) {
			if LooterSQM_9X is not number
				Swap_SQM_Warning_Coordinates()
			if LooterSQM_9Y is not number
				Swap_SQM_Warning_Coordinates()
		}


	;[Auto Follow]
		Check_New_Hotkey_Script("HotkeyFollow", "AutoFollow")
}

Verify_Hotkeys_Timer() {
	GLOBAL
	Gui, Timer:Default
	GuiControlGet, Timer1Type
	if (Timer1Type == "Keyboard") {
		GuiControl, Hide, GroupBoxMouse1Timer	;HIDE MOUSE GUI
		GuiControl, Hide, TextMouse1TimerX		;HIDE MOUSE GUI
		GuiControl, Hide, Timer1X				;HIDE MOUSE GUI
		GuiControl, Hide, TextMouse1TimerY		;HIDE MOUSE GUI
		GuiControl, Hide, Timer1Y				;HIDE MOUSE GUI
		GuiControl, Hide, ButtonMouse1Timer		;HIDE MOUSE GUI

		GuiControl, Show, GroupBoxHotkey1Timer	;SHOW KEYBOARD GUI
		GuiControl, Show, Hotkey1TimerHotkey	;SHOW KEYBOARD GUI
	} else {
		GuiControl, Show, GroupBoxMouse1Timer	;SHOW MOUSE GUI
		GuiControl, Show, TextMouse1TimerX		;SHOW MOUSE GUI
		GuiControl, Show, Timer1X				;SHOW MOUSE GUI
		GuiControl, Show, TextMouse1TimerY		;SHOW MOUSE GUI
		GuiControl, Show, Timer1Y				;SHOW MOUSE GUI
		GuiControl, Show, ButtonMouse1Timer		;SHOW MOUSE GUI

		GuiControl, Hide, GroupBoxHotkey1Timer	;HIDE KEYBOARD GUI
		GuiControl, Hide, Hotkey1TimerHotkey	;HIDE KEYBOARD GUI
	}
}

Verify_Hotkeys_RemapKeys() {
	GLOBAL
	Gui, RemapKeys:Default

	; ##### MOUSE #####
	Hotkey, IfWinActive, AHK_GROUP TibiaVM ; "ahk_id " active_id	;Hotkeys works only in Tibia and VM and explorer.exe
	;[Mouse Wheel]
	if (DestinationKey_WheelUp_RemapKeys != "" && DestinationKey_WheelUp_RemapKeys != "ERROR") {
		Hotkey, ~WheelUp, WheelUp_RemapKeys, OFF
	}
	GuiControlGet, DestinationKey_WheelUp_RemapKeys
	if (DestinationKey_WheelUp_RemapKeys != "" && DestinationKey_WheelUp_RemapKeys != "ERROR") {
		Hotkey, ~WheelUp, WheelUp_RemapKeys, On, P6
	}

	if (DestinationKey_WheelDown_RemapKeys != "" && DestinationKey_WheelDown_RemapKeys != "ERROR") {
		Hotkey, ~WheelDown, WheelDown_RemapKeys, OFF
	}
	GuiControlGet, DestinationKey_WheelDown_RemapKeys
	if (DestinationKey_WheelDown_RemapKeys != "" && DestinationKey_WheelDown_RemapKeys != "ERROR") {
		Hotkey, ~WheelDown, WheelDown_RemapKeys, On, P6
	}

	;[Mouse Web Button]
	if (DestinationKey_BrowserBack_RemapKeys != "" && DestinationKey_BrowserBack_RemapKeys != "ERROR") {
		Hotkey, ~XButton1, BrowserBack_RemapKeys, OFF
	}
	GuiControlGet, DestinationKey_BrowserBack_RemapKeys
	if (DestinationKey_BrowserBack_RemapKeys != "" && DestinationKey_BrowserBack_RemapKeys != "ERROR") {
		Hotkey, ~XButton1, BrowserBack_RemapKeys, On, P6
	}

	if (DestinationKey_BrowserForward_RemapKeys != "" && DestinationKey_BrowserForward_RemapKeys != "ERROR") {
		Hotkey, ~XButton2, BrowserForward_RemapKeys, OFF
	}
	GuiControlGet, DestinationKey_BrowserForward_RemapKeys
	if (DestinationKey_BrowserForward_RemapKeys != "" && DestinationKey_BrowserForward_RemapKeys != "ERROR") {
		Hotkey, ~XButton2, BrowserForward_RemapKeys, On, P6
	}

	;#### TECLADO #####
	Check_New_Hotkey_Script(GuiControl:="KeyToActive_AndarComWASD", Label:="Label_AndarComWASD")	
}

Verify_Hotkeys_CaveBot() {
    GLOBAL    
    Gui, Gui_CaveBot:Default
    Check_New_Hotkey_Script("Key_Enable_Walker", "Walker")

    GuiControlGet, CheckBox_DropFlask, Healing:
	if (CheckBox_DropFlask == 1) {
		if LooterSQM_9X is not number
			DropFlask_Warning_Coordinates()
		else if LooterSQM_9Y is not number
			DropFlask_Warning_Coordinates()
	}
}
DropFlask_Warning_Coordinates() {
    GLOBAL
	;~ Gui, -AlwaysOnTop
	ToolTip("[BR] Configure as coordenadas do Looter para utilizar o DropFlask",Time:=-500,X:="",Y:="",WhichToolTip:=01)
	;~ Gui, +AlwaysOnTop

	Gui, Looter:Show, % " w" 581 " h" 421, %TrayName%	;NAME PROGRAMA
}

Check_New_Hotkey_Script(GuiControl, Label) {
    GLOBAL

	;DISABLE OLD HOTKEY
	if (%GuiControl% != "ERROR" && %GuiControl% != "" && %GuiControl% != "Nothing") {
		Hotkey, % "~" %GuiControl%, %Label%, Off
	}

	;MACRO PAUSED - REMOVE ALL HOTEKYS
	if (State_Script == "OFF" && Label != "Hide_All_Gui_Label" && Label != "PauseScript") {
		RETURN
	}

	;GET NEW HOTKEY
	GuiControlGet, %GuiControl%
	
	
	;ENABLE NEW HOTKEY
	if (%GuiControl% != "ERROR" && %GuiControl% != "" && %GuiControl% != "Nothing") {
		Hotkey, % "~" %GuiControl%, %Label%, ON
	}   

}

Auto_Hide_Gui_MultiClient(state:="",winactive_tibia:=true) {
	GLOBAL
	if (Status_Gui_Hide == FALSE or state = "Hide") {
		ToolTip("Hide")
		Gui, Main:HIDE
		Gui, Healing:HIDE
		Gui, TankMode:HIDE
		Gui, Support:HIDE
		Gui, PvP:HIDE
		Gui, Timer:HIDE
		Gui, Looter:HIDE
		Gui, Combo:HIDE
		Gui, HealFriend:HIDE
		Gui, RemapKeys:HIDE
		Gui, Gui_CaveBot:HIDE
		Gui, Alarms:HIDE
		Gui, Extras:HIDE
		Status_Gui_Hide := TRUE
	} else if (Status_Gui_Hide != FALSE or state = "Show") {
		if (Status_Gui_Hide = "HIDE") {
			Gui, Main:Show, NoActivate
		} else {
			Gui, Main:Show, Minimize
		}
		Status_Gui_Hide := FALSE
		ToolTip("Show")
	}

	if (winactive_tibia == true) {
		WinActivate, ahk_id %active_id%	;fix bug on win7
	}
}