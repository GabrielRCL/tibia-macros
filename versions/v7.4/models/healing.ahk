; ============================================== [ Healing ] ==============================================
; ============================================== [ Healing ] ==============================================
; ============================================== [ Healing ] ==============================================

UseManaPotion() {
	GLOBAL
	GuiControlGet, CheckBox_Enable_Healing_Mana
	if (CheckBox_Enable_Healing_Mana == true) {
		Verify_MP_Color := GetColorHex(Coord_MP_Percent_x,Coord_MP_Percent_y)
		if (Verify_MP_Color != Color_MP_Percent) {
			ElapsedTime_ManaFluid := A_TickCount - StartTime_ManaFluid
			if (ElapsedTime_ManaFluid >= 1000 and Have_ManaFluid == true) {
				KeyWait, Control
				KeyWait, Shift
				Use_Item_On(state:="YourSelf", PosX:=ManaFluid.2, PosY:=ManaFluid.3)
				StartTime_ManaFluid := A_TickCount
			}
		}
	}
}

HealingHP() {
	GLOBAL
	GuiControlGet, CheckBox_Enable_Healing_Life
	GuiControlGet, CheckBox_Healing_Life_UseUH
	if (CheckBox_Enable_Healing_Life or CheckBox_Healing_Life_UseUH) {
		Verify_HP_Color := GetColorHex(Coord_HP_Percent_x,Coord_HP_Percent_y)
		if (Verify_HP_Color != Color_HP_Percent) {
			ElapsedTime_HP := A_TickCount - ElapsedTime_HP
			if ((ElapsedTime_HP >= 500 && (Have_ManaFluid == true or Have_UH != true or CheckBox_Healing_Life_UseUH != 1))) {
				KeyWait, Control
				KeyWait, Shift
				Press_Key("Hotkey_Healing_Life", Tab:="Main:")
				ElapsedTime_HP := A_TickCount

			} else if (ElapsedTime_HP >= 1000) {
				KeyWait, Control
				KeyWait, Shift
				Use_Item_On(state:="YourSelf", PosX:=UH.2, PosY:=UH.3)
				ElapsedTime_HP := A_TickCount
			}
		}
	}
}

GetPixelHP%:
	Get_Coord_And_Color(VarName:="HP_Percent",GuiTab:="Main",HUDcolor:="Green")
RETURN
GetPixelMP%:
	Get_Coord_And_Color(VarName:="MP_Percent",GuiTab:="Main",HUDcolor:="Green")
RETURN

GetPictureUH:
	Hide_All_GUI(state:="Hide")
	MsgBox, [BR] Use as setas do teclado para aumentar e diminuir o tamanho da captura de imagem. `n`n[EN] Use the arrow keys to increase and decrease the image capture size.
	take_screenshot("UH", 18, 18)
RETURN
GetPicture_ManaFluid:
	Hide_All_GUI(state:="Hide")
	MsgBox, [BR] Use as setas do teclado para aumentar e diminuir o tamanho da captura de imagem. `n`n[EN] Use the arrow keys to increase and decrease the image capture size.
	take_screenshot("ManaFluid", 18, 18)
RETURN

Enable_Healing:
RETURN