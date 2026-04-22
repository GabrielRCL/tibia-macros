
TelegramBot() {
GLOBAL
	Gui, Alarms:Default
	GuiControlGet, Delay_TelegramBot
	GuiControlGet, CheckBox_TelegramBot
	Delay_TelegramBot *= 1000
	ElapsedTime_TelegramBot := A_TickCount - StartTime_TelegramBot

	if (CheckBox_TelegramBot == 1 && ElapsedTime_TelegramBot > Delay_TelegramBot) {
		IniWrite, %Name_Haystack%, Configs\Others.ini, Geral, Name_Haystack	;Multi-Scripts Config
		IniWrite, %active_id%, Configs\Others.ini, Geral, active_id			;Multi-Scripts Config

		GuiControlGet, botToken_TelegramBot
		IniWrite, %botToken_TelegramBot%, Configs\Others.ini, TelegramBot, botToken_TelegramBot
		GuiControlGet, chatID_TelegramBot
		IniWrite, %chatID_TelegramBot%, Configs\Others.ini, TelegramBot, chatID_TelegramBot

		if FileExist(A_WorkingDir "\Configs\Others\Lib\TelegramBot.exe") {
			Run, Configs\Others\Lib\TelegramBot.exe
		}

		StartTime_TelegramBot := A_TickCount
	}

}

Telegram_FirstCFG() {
GLOBAL
	Gui, Gui_CaveBot:-AlwaysOnTop

	msgbox [PT-BR] Abra um chat com o "BotFather" no telegram e crie um bot, após criar o bot copie e cole o Token que o "BotFather" lhe enviou.`n`n[EN] Create Bot with "BotFather" in telegram and Copy+Paste Token in next step.
	loop
	{
		InputBox, botToken, enter the in telegram indicated bot token,
		MsgBox, 4, , Bot Token correct?:`n%botToken%
			IfMsgBox Yes
				break
	}

	Random, SecurityCode, 1000, 9999

	msgbox [PT-BR]Agora, abra um chat com o Bot que voce acabou de criar e envie a mensagem %SecurityCode% `nPRESSIONE OK QUANDO TERMINAR. `n`n[EN]now open a new chat with your new created bot (search for @*yourbotname* and start a new chat) and enter this number %SecurityCode% and send it via telegram `npress OK, when done.
	UrlDownloadToFile https://api.telegram.org/bot%BotToken%/getupdates , %A_Temp%\findChatID.txt
	sleep 2000

	run %A_Temp%\findChatID.txt
	msgbox, [PT-BR]Procure pelo seu ID, ele vem depois do "chat":`{"id":782163891 `n`n[EN]now search for the number %SecurityCode% and on the same line there should be something like: "chat":`{"id":782163891`n`nfound it? press ok

	InputBox ChatID, enter the number after "chat":`{"id": here:
	IniWrite, %botToken%, Configs\Others.ini, TelegramBot, botToken_TelegramBot
	IniWrite, %chatID%, Configs\Others.ini, TelegramBot, chatID_TelegramBot

	GuiControl,, botToken_TelegramBot, %botToken%
	GuiControl,, chatID_TelegramBot, %chatID%

	MsgBox, Done.
	Gui, Gui_CaveBot:+AlwaysOnTop
}
TelegramBot_GetID:
	Telegram_FirstCFG()
RETURN
