Draw_Gui_Alarms() {
    GLOBAL
	Load_Pre_Settings("Alarms")
	Gui, Add, Tab, section x1 y1 w581 h421 , Alarms|TelegramBot|Adv. Options

	Gui, Tab, Alarm
	;[Alarm] If Have Player On Screen
	Gui, Font, Bold
	Portugues := "Player na Tela"
	English := "Player on Screen"
	Gui, Add, GroupBox, section xs+15 ys+25 w140 h100 +Center, % %GlobalLanguage%
	Gui, Font, Normal
	Gui, Add, CheckBox, xs+15 ys+15 w120 h20 vCheckBox_AlarmSound_PlayerOnScreen, Alarm (Sound)
	Gui, Add, CheckBox, xs+15 ys+40 w120 h20 vCheckBox_FocusTibia_PlayerOnScreen, Focus Tibia
	Gui, Add, CheckBox, xs+15 ys+65 w120 h20 vCheckBox_TelegramBot_PlayerOnScreen, TelegramBot

	Gui, Font, Bold
	Portugues := "Receber Mensagem Privada"
	English := "Receive Private Message"
	Gui, Add, GroupBox, section xs+200  ys w140 h100 +Center, % %GlobalLanguage%
	Gui, Font, Normal
	Gui, Add, CheckBox, xs+15 ys+15 w120 h20 vCheckBox_AlarmSound_PrivateMSG, Alarm (Sound)
	Gui, Add, CheckBox, xs+15 ys+40 w120 h20 vCheckBox_FocusTibia_PrivateMSG, Focus Tibia
	Gui, Add, CheckBox, xs+15 ys+65 w120 h20 vCheckBox_TelegramBot_PrivateMSG, TelegramBot

	Gui, Font, Bold
	Portugues := "Receber Mensagem Local"
	English := "Receive Local Message"
	Gui, Add, GroupBox, section xs+200  ys w140 h100 +Center, % %GlobalLanguage%
	Gui, Font, Normal
	Gui, Add, CheckBox, xs+15 ys+15 w120 h20 vCheckBox_AlarmSound_LocalMSG, Alarm (Sound)
	Gui, Add, CheckBox, xs+15 ys+40 w120 h20 vCheckBox_FocusTibia_LocalMSG, Focus Tibia
	Gui, Add, CheckBox, xs+15 ys+65 w120 h20 vCheckBox_TelegramBot_LocalMSG, TelegramBot

	Gui, Font, Bold
	Portugues := "Desconectar/Morrer"
	English := "Disconnect/Died"
	Gui, Add, GroupBox, section xs-400 ys+140 w140 h100 +Center, % %GlobalLanguage%
	Gui, Font, Normal
	Gui, Add, CheckBox, xs+15 ys+15 w120 h20 vCheckBox_AlarmSound_Disconnect, Alarm (Sound)
	Gui, Add, CheckBox, xs+15 ys+40 w120 h20 Checked vCheckBox_FocusTibia_Disconnect, Focus Tibia
	Gui, Add, CheckBox, xs+15 ys+65 w120 h20 vCheckBox_TelegramBot_Disconnect, TelegramBot

	Gui, Font, Bold
	Portugues := "Anti-AFK"
	English := "Anti-AFK"
	Gui, Add, GroupBox, section xs+200 ys w140 h100 +Center, % %GlobalLanguage%
	Gui, Font, Normal
	Gui, Add, CheckBox, xs+15 ys+15 w120 h20 vCheckBox_AlarmSound_AntiAFK, Alarm (Sound)
	Gui, Add, CheckBox, xs+15 ys+40 w120 h20 vCheckBox_FocusTibia_AntiAFK, Focus Tibia
	Gui, Add, CheckBox, xs+15 ys+65 w120 h20 vCheckBox_TelegramBot_AntiAFK, TelegramBot

	; ================  [ TELEGRAM BOT  ] ================
	Gui, Tab, TelegramBot
		Gui, Add, GroupBox, section x10 y25 w425 h130 , GERAL CONFIG
		Gui, Add, CheckBox, xs+10 ys+15 w70 h20 vCheckBox_TelegramBot, ENABLE
		Gui, Add, Button, xs+85 ys+15 w45 h20 gTelegramBot_GetID, GET ID
		Gui, Add, Text, xs+10 ys+50 w50 h20, Delay:
		Gui, Add, Text, xs+10 ys+70 w50 h20, botToken:
		Gui, Add, Text, xs+10 ys+90 w50 h20, chatID:
	Gui,Font,cRed
		Gui, Add, Edit, xs+60 ys+50 w30 h20 +Right vDelay_TelegramBot, 15
		Gui, Add, Edit, xs+60 ys+70 w350 h20 vbotToken_TelegramBot, Enter Your BotToken
		Gui, Add, Edit, xs+60 ys+90 w350 h20 vchatID_TelegramBot, Enter Your ChatID
	Gui,Font,cWhite
		Gui, Add, Text, xs+90 ys+54 w50 h15 , seconds.

	; ================  [ ADV OPTIONS ] ================
	Gui, Tab, Adv. Options
	Portugues := "Reproduzir Alarmes Apenas se o CaveBot Estiver Habilitado"
	English := "Play Alarms Only if CaveBot is Enabled"
	Gui, Add, CheckBox, section x10 y25 w400 h20 vCheckBox_Play_Alarms_Only_if_CaveBot_Enable, % %GlobalLanguage%


}
Draw_Gui_Alarms:
	Gui, Alarms:Show, % " w" 581 " h" 421, [Alarms] %TrayName%	;NAME PROGRAMA
RETURN