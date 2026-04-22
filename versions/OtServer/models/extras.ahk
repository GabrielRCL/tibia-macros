Verify_ChatOn(){
    GLOBAL
	;DONT NEED PRINTSCREEN DATA AGAIN
	GuiControlGet, Force_HP_Percent, Extras:
	GuiControlGet, Force_MP_Percent, Extras:
	if (Data.HP < Force_HP_Percent || Data.MP < Force_MP_Percent) {
		;~ TOOLTIP("[SKIP PAUSE] WARNING HP/MP < " Force_HP_Percent "/" Force_MP_Percent "%", -500)
		RETURN
	}

	;Andar Com WASD (8.6)
	if (State_Andar_Com_WASD == true) {

	}

	GuiControlGet, PauseMacro_ChatOn_CheckBox, Extras:
	if (PauseMacro_ChatOn_CheckBox == 1) {
		color := GetColorHex(Cords.Chat.2, Cords.Chat.3)
		if (color != "#727373" && color != "#655a50") {
			SearchPNG(PNG.Chat, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=15, Erro, Mode:=1), Cords.Chat := Erro
		}


		;if not chat OFF
		color := GetColorHex(Cords.Chat.2+46, Cords.Chat.3+5)
		if (color != "#c0c0c0" && color != "#424242"){
			ToolTip("[CHAT ON] Macro Paused", -300)
			State_Script := "OFF"
			EXIT
		} else if (State_Script != "ON") {
			State_Script := "ON"
            Verify_All_Hotkeys(force := true)
		}
	}
	if (State_Script == "OFF") {
		ToolTip("[CHAT ON] Macro PAUSED", -300)
		Verify_All_Hotkeys(force := true)
		EXIT
	}

}

Button_ChangeVocation:
	Save_And_Load_Configs("save_config")
	Gui, Extras:Default
	SetTimer, EngineLoop, OFF
	GuiControlGet, DropDownList_ChangeVocation
	IniWrite, %DropDownList_ChangeVocation%, %A_WorkingDir%\Configs\Login.ini, Login, Vocation
	MsgBox, Vocation updated. Please restart the macro to apply the change.
	EXITAPP
RETURN

Label_NoDelayActions:
	GuiControlGet, CheckBox_NoDelayActions, Extras:
	IniWrite, %CheckBox_NoDelayActions%, Configs\Login.ini, Extras, CheckBox_NoDelayActions

	Hide_All_GUI()	;HIDE ALL GUI
	Portugues := "Reinicie o macro para aplicar as alteracoes"
	English := "Restart the macro to apply the changes"
	MsgBox % %GlobalLanguage%
	Hide_All_GUI()	;HIDE ALL GUI
RETURN

Label_Transparent_Tibia_Client:
	GuiControlGet, Transparent_Tibia_Client, Extras:
	if (Transparent_Tibia_Client == 1) {
		WinSet, Transparent, 1, ahk_id %active_id%
	} else {
		WinSet, Transparent, 255, ahk_id %active_id%
	}
RETURN