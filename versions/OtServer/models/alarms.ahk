Alarms(){
    GLOBAL
	Gui, Alarms:Default
	ElapsedTime_Alarm := A_TickCount - StartTime_Alarm

	; [ CHECK CAVEBOT IS ENABLE ]
	GuiControlGet, CheckBox_Play_Alarms_Only_if_CaveBot_Enable
	if (WalkerEnable != 1 && CheckBox_Play_Alarms_Only_if_CaveBot_Enable) {
		RETURN	;NOT PLAY ALARM
	}

	; [ ANTI - AFK ]
	GuiControlGet, CheckBox_AlarmSound_AntiAFK
	GuiControlGet, CheckBox_FocusTibia_AntiAFK
	GuiControlGet, CheckBox_TelegramBot_AntiAFK
	if (CheckBox_AlarmSound_AntiAFK or CheckBox_FocusTibia_AntiAFK or CheckBox_TelegramBot_AntiAFK) {
		Array_PNG_Image := ["Pise_ArcanaOT","SetinhaP_ArcanaOT","SetinhaG_ArcanaOT","AntiBot_ForteraOT","AntiBot_Molten"]	;"PNG.AntiBot_CalmeraOT"	;Array_PNG_Image[counter_AntiAFK]
		if counter_AntiAFK is not number
			counter_AntiAFK := 1
		if (counter_AntiAFK > Array_PNG_Image.Count()) {
			counter_AntiAFK := 1
		}
		;SearchPNG( PNG[Array_PNG_Image[counter_AntiAFK]], Cords.GameBorda_LeftBottom[2],Cords.GameBorda_LeftBottom[3]-(SQM_Size*11), Cords.GameBorda_RightTop[2],Cords.GameBorda_RightTop[3]+(SQM_Size*11), Tole:=20, Erro, Mode:=1)
		SearchPNG( PNG[Array_PNG_Image[counter_AntiAFK]], GameWindow_X1,GameWindow_Y1, GameWindow_X2,GameWindow_Y2, Tole:=20, Erro, Mode:=1)
		if (Erro.1 == 1) {
			if (CheckBox_AlarmSound_AntiAFK && ElapsedTime_Alarm > 1200) {
				SoundPlay, Configs\Others\Sound\PlayerDetected.mp3
				StartTime_Alarm := A_TickCount
			}
			if (CheckBox_FocusTibia_AntiAFK) {
				WinActivate, ahk_id %active_id%
			}
			if (CheckBox_TelegramBot_AntiAFK) {
				TelegramBot()
			}
		}
		counter_AntiAFK++
	}

	; [ PLAYER ON SCREEN ]
	GuiControlGet, CheckBox_AlarmSound_PlayerOnScreen
	GuiControlGet, CheckBox_FocusTibia_PlayerOnScreen
	GuiControlGet, CheckBox_TelegramBot_PlayerOnScreen
	if (WalkerEnable != 1 && ( CheckBox_AlarmSound_PlayerOnScreen or CheckBox_FocusTibia_PlayerOnScreen or CheckBox_TelegramBot_PlayerOnScreen) ) {
		New_VerifyPlayerList()	;verifica player list se o cavebot nao estiver ativado.
	}
	if (Player_On_Screen == true) {
		GuiControlGet, CheckBox_AlarmSound_PlayerOnScreen
		if ( (CheckBox_AlarmSound_PlayerOnScreen or CheckBox_PlayerAlarm) && ElapsedTime_Alarm > 1200) {
			SoundPlay, Configs\Others\Sound\PlayerDetected.mp3
			StartTime_Alarm := A_TickCount
		}

		GuiControlGet, CheckBox_FocusTibia_PlayerOnScreen
		if (CheckBox_FocusTibia_PlayerOnScreen) {
			WinActivate, ahk_id %active_id%
		}

		GuiControlGet, CheckBox_TelegramBot_PlayerOnScreen
		if (CheckBox_TelegramBot_PlayerOnScreen) {
			TelegramBot()
		}
	}



	; [ LOCAL MESSAGE ]
	GuiControlGet, CheckBox_AlarmSound_LocalMSG
	GuiControlGet, CheckBox_FocusTibia_LocalMSG
	GuiControlGet, CheckBox_TelegramBot_LocalMSG
	if (CheckBox_AlarmSound_LocalMSG or CheckBox_FocusTibia_LocalMSG or CheckBox_TelegramBot_LocalMSG) {
		Convert_Incoming_Message_to_Binary("#F0F000")
		if ( NEW_MESSAGE_ID != OLD_LOCAL_MESSAGE_ID or Search_For_New_Message = "#F86060") {
			if (CheckBox_AlarmSound_LocalMSG && ElapsedTime_Alarm > 1500) {
				SoundPlay, Configs\Others\Sound\NewMessage.mp3
				StartTime_Alarm := A_TickCount
			}
			if (CheckBox_FocusTibia_LocalMSG) {
				WinActivate, ahk_id %active_id%
			}
			if (CheckBox_TelegramBot_LocalMSG) {
				TelegramBot()
			}
		}
		OLD_LOCAL_MESSAGE_ID := ""
		OLD_LOCAL_MESSAGE_ID .= NEW_MESSAGE_ID
	}


	; [ PRIVATE MESSAGE]
	GuiControlGet, CheckBox_AlarmSound_PrivateMSG
	GuiControlGet, CheckBox_FocusTibia_PrivateMSG
	GuiControlGet, CheckBox_TelegramBot_PrivateMSG
	if (CheckBox_AlarmSound_PrivateMSG or CheckBox_FocusTibia_PrivateMSG or CheckBox_TelegramBot_PrivateMSG) {
		Convert_Incoming_Message_to_Binary("#60F8F8")
		if ( NEW_MESSAGE_ID != OLD_PRIVATE_MESSAGE_ID or Search_For_New_Message = "#F86060" ) {
			if (CheckBox_AlarmSound_PrivateMSG && ElapsedTime_Alarm > 1500) {
				SoundPlay, Configs\Others\Sound\NewMessage.mp3
				StartTime_Alarm := A_TickCount
			}
			if (CheckBox_FocusTibia_PrivateMSG) {
				WinActivate, ahk_id %active_id%
			}
			if (CheckBox_TelegramBot_PrivateMSG) {
				TelegramBot()
			}
		}
		OLD_PRIVATE_MESSAGE_ID := ""
		OLD_PRIVATE_MESSAGE_ID .= NEW_MESSAGE_ID
	}

	; [ Died or Disconnect ]
	if (Cords.HP.1 != 1) {
		GuiControlGet, CheckBox_AlarmSound_Disconnect
		if (CheckBox_AlarmSound_Disconnect && ElapsedTime_Alarm > 1200) {
			SoundPlay, Configs\Others\Sound\Disconnected.mp3
			StartTime_Alarm := A_TickCount
		}

		GuiControlGet, CheckBox_FocusTibia_Disconnect
		if (CheckBox_FocusTibia_Disconnect) {
			WinActivate, ahk_id %active_id%
		}

		GuiControlGet, CheckBox_TelegramBot_Disconnect
		if (CheckBox_TelegramBot_Disconnect) {
			TelegramBot()
		}
	}



}
Convert_Incoming_Message_to_Binary(color_msg) {
    GLOBAL
	i := 48
	Loop, {
		Search_For_New_Message := GetColorHex(Cords.CooldownBox.2+23,Cords.CooldownBox.3+i)
		if (Search_For_New_Message = color_msg or Search_For_New_Message = "#F86060") { ;#F86060 = mensagem vermelha antibot
			NEW_MESSAGE_ID := i	;valor do eixo Y que foi encontrado a imagem
			k := 1
			Loop, {
				transform_message_in_binary := GetColorHex(Cords.CooldownBox.2+23+k,Cords.CooldownBox.3+i)
				if (transform_message_in_binary = color_msg) {
					NEW_MESSAGE_ID .= "Y"
				} else {
					NEW_MESSAGE_ID .= "N"
				}
				if (k >= 200) {
					BREAK 2
				}
				k++
			}
		} else if (Cords.CooldownBox.3+i >= A_ScreenHeight or Cords.HP.1 != 1) {
			BREAK
		}
		i++
	}
	RETURN	;, % NEW_MESSAGE_ID
}
