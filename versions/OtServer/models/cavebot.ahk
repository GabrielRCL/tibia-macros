CaveBot() {
	GLOBAL

	;CaveBot
	ElapsedTime_CaveBot := A_TickCount - StartTime_CaveBot
	if ( WalkerEnable == 1 && ElapsedTime_CaveBot > Delay_CaveBot+(Sleep_Walker*1000) ) {
		fix_Bug_CaveBot_ComboON()

		; WALKER:
		Gui, Gui_CaveBot:Default
			Gui Submit, NoHide	;ALL GUI CONTROL GET
		if (Start_Round_Attack != true or CheckBox_AutoAttack != true or Press_Esc_Cavebot_CheckBox != true or (CheckBox_NextWayPoint_PlayerScreen && Player_On_Screen) or Data.Conditions.ProtectionZone == 1) {
			GetCoordenates_Walker()
			CaveBot_Action()
		}

		;~ Targeting:
		Gui, Gui_CaveBot:Default
		Gui Submit, NoHide	;ALL GUI CONTROL GET
			GuiControlGet, CheckBox_AutoAttack
			if ( (CheckBox_AutoAttack or WayPoint_on_Center or Start_Round_Attack == true) && Data.Conditions.ProtectionZone != 1) {
				New_VerifyPlayerList()
				New_Targeting()
			}

		;~ Others:
		;~ StarTime_Others := A_TickCount
			Renew_Growth_Function()
		;~ ElapsedTime_Others := A_TickCount - StarTime_Others
		;~ TOOLTIP % "Walker: " ElapsedTime_Walker "`nTargeting: " ElapsedTime_Targeting "`n Others: " ElapsedTime_Others,,,, 2
		StartTime_CaveBot := A_TickCount
	}

	;HUD CaveBot
	Refresh_CaveBot_Stats()
}


Walker:
	Toggle_State_CaveBot()
RETURN


Toggle_State_CaveBot() {
	GLOBAL
	Gui, Gui_CaveBot:Default
	Check_AdvConfig()
	StartTimeCheckTrap := A_TickCount	;reseta contagem check trap
	WalkerEnable++
	if (WalkerEnable == 1) {
		FirstTime_WalkToWaypoint := true
		ToolTip("CaveBot !![ON]!!",Time:=-500,X:="",Y:="",WhichToolTip:=10)

		GuiControlGet, Delay_CaveBot

		;Show Gui CaveBot Status
		GuiControlGet, CheckBox_Show_HUD_CaveBot_Status
		if (CheckBox_Show_HUD_CaveBot_Status == 1) {
			;~ Gui, HUD_CaveBot_Status:Show, w175 h100, CaveBot Stats
			Gui, HUD_CaveBot_Status:Show, AutoSize NoActivate, CaveBot Status
			If not WinActive("ahk_id " active_id) {
				ActiveHwnd := WinExist("A")
				WinActivate, ahk_id %active_id%
			}
		}

	} else {
		ControlSend,, {ESC}, ahk_id %active_id%
		WalkerEnable := 0
		ToolTip("CaveBot !![OFF]!!",Time:=-500,X:="",Y:="",WhichToolTip:=10)

		State_Combo:="OFF"
		Renew_Growth_Stop_Combo := false
		Player_On_Screen := false
		GotoProtectZone := false

		ToolTip("",-1,X:="",Y:="",WhichToolTip:=18)	;remove tooltip waiting goto hunting again...
		Gui, HUD_CaveBot_Status:Hide
	}
}

GetCoordenates_Walker(){
	GLOBAL

	;MapHunt
	if( GetColorHex(Cords.MapHunt.2+1, Cords.MapHunt.3+1) != ColorHex_Validate_MapHunt ) {
		SearchPNG(PNG.MapHunt, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, MapHunt, Mode:=1,1)
		if (MapHunt.1 == 1) {
			ColorHex_Validate_MapHunt := GetColorHex(Cords.MapHunt.2+1, Cords.MapHunt.3+1)	;[GET ColorHex Validate MapHunt]
			if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") { ;fix coordinates RTC
				SearchPNG(PNG.EstrelaCardial, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, EstrelaCardial, Mode:=1,1)

				Inicio_MiniMap_X := MapHunt.2
				Inicio_MiniMap_Y := EstrelaCardial.3

				Final_MiniMap_X := EstrelaCardial.2 + 46
				Final_MiniMap_Y := MapHunt.3 + 62

				Center_MiniMap_X := 1
				Center_MiniMap_Y := 1

			} else {
				Inicio_MiniMap_X := MapHunt.2 - 123
				Inicio_MiniMap_Y := MapHunt.3 - 95

				Final_MiniMap_X := MapHunt.2
				Final_MiniMap_Y := MapHunt.3 + 20

				Center_MiniMap_X := MapHunt.2 - 71
				Center_MiniMap_Y := MapHunt.3 - 41


			}

		} else {
			ToolTip("Nao foi possivel encontrar o MiniMap",Time:=-500,X:="",Y:="",WhichToolTip:=10)
			EXIT
		}
	}

	;estrela cardial (OTC)
	if (TibiaServer = "Shadow-Illusion") {
		if( GetColorHex(Cords.EstrelaCardial.2+1, Cords.EstrelaCardial.3+1) != ColorHex_Validate_EstrelaCardial ) {
			SearchPNG(PNG.EstrelaCardial, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, EstrelaCardial, Mode:=1,1)
			if (EstrelaCardial.1 == 1) {
				ColorHex_Validate_EstrelaCardial := GetColorHex(Cords.EstrelaCardial.2+1, Cords.EstrelaCardial.3+1)

				Inicio_MiniMap_X := MapHunt.2
				Inicio_MiniMap_Y := MapHunt.3

				Final_MiniMap_X := EstrelaCardial.2 + 44
				Final_MiniMap_Y := EstrelaCardial.3 + 44

				Center_MiniMap_X := 1
				Center_MiniMap_Y := 1
			} else {
				ToolTip("Nao foi possivel encontrar a EstrelaCardial",Time:=-500,X:="",Y:="",WhichToolTip:=10)
				EXIT
			}

		}
	}
	
}

Walk_to_WayPoint(){
	GLOBAL
	;~ tooltip(Previous_Mark.2 " + " Mark.2 " `n" Previous_Mark.3 " + " Mark.3)

	;[Disable Goto ProtectZone]
	if (GotoProtectZone == true && Data.Conditions.ProtectionZone == 1) {
		GotoProtectZone := false
		Delay_CaveBot := 10*60*1000 ;10 minutos
		ToolTip("Waiting 10minutes to go hunt again...",-1*Delay_CaveBot,X:="",Y:="",WhichToolTip:=18)
		EXIT	;use exit to fix bug
	}

	;[Excedeu Tentativas Walker -> Goto Next Waypoint]
	ElapsedTime_Walker := (A_TickCount - StartTime_Walker)/1000
	if (ElapsedTime_Walker >= Total_Time_Walker && Total_Time_Walker != 0) {
		StartTime_Walker := A_TickCount

		GuiControlGet, CheckBox_Lure_Mode, Gui_CaveBot:
		if not (CheckBox_Lure_Mode) {
			GuiControl,, WayPoint, % WayPoint+1
		} else if (IgnoreTargeting_Walker) {
			GuiControl,, WayPoint, % WayPoint+1
		}

		ThereIsNoWay := False
		EXIT
	}

	; OFFSET
	OffSet_X := 2
	OffSet_Y := 2

	;~ LV_GetText(Walk_To_Mark,WayPoint,2)	;pega o texto da linha 1, coluna 2 (Action)
	;~ Walk_To_Mark := SubStr(Walk_To_Mark, InStr(Walk_To_Mark, "(")+1, InStr(Walk_To_Mark, ")")-InStr(Walk_To_Mark, "(")-1)	;FORMAT STRING
	Walk_To_Mark := SubStr(LV_CaveBot_Action, InStr(LV_CaveBot_Action, "(")+1, InStr(LV_CaveBot_Action, ")")-InStr(LV_CaveBot_Action, "(")-1)	;FORMAT STRING

	PrintScreenData()
	SearchPNG(PNG.Mark[Walk_To_Mark], Inicio_MiniMap_X,Inicio_MiniMap_Y, Final_MiniMap_X,Final_MiniMap_Y, Tole:=15, Mark, Mode:=1)
	if ( (Mark.1 == 1 && Mark.2 == Previous_Mark.2 && Mark.3 == Previous_Mark.3) ) {

		; verifica se chegou ao centro do minimap
		if ( (Mark.2 == Center_MiniMap_X or Mark.2 == Center_MiniMap_X+1) && (Mark.3 == Center_MiniMap_Y or Mark.3 == Center_MiniMap_Y-1)) {
			StartTime_Walker := A_TickCount

			; verifica se matou os monstros para ir pro proximo waypoint (e outras coisas)
			if ( AutoHunt.MonsterQuantity <= StopAttackWhenHave	or 																																  (Start_Round_Attack == False && AutoHunt.MonsterQuantity < LureMonsterDropDownList )	or 																							IgnoreTargeting_Walker > 0 or 																																								Data.Conditions.ProtectionZone == 1 ) {
				GuiControl,, WayPoint, % WayPoint+1	;goto next waypoint
				;~ deSelect_AllLines_ListView()	;deseleciona todas as linhas
				;~ LV_Modify(WayPoint, "+Select")	;seleciona celula step atual
				ThereIsNoWay := False

			} else if ( (CheckBox_NextWayPoint_PlayerScreen == 1 && Player_On_Screen == true) or GotoProtectZone == true) {	;GO TO NEXT WAYPOINT IF HAVE PLAYER
				ToolTip("`nPlayer Detected, Goto Next Waypoint...",Time:=-500,X:="",Y:="",WhichToolTip:=10)
				GuiControl,, WayPoint, % WayPoint+1	;goto next waypoint
				;~ deSelect_AllLines_ListView()	;deseleciona todas as linhas
				;~ LV_Modify(WayPoint, "+Select")	;seleciona celula step atual
				ThereIsNoWay := False
			}

			GuiControlGet, Delay_CaveBot
			Return, TRUE
		} else if (CheckBox_ChangeAttackMode != true or Player_On_Screen != true or Start_Round_Attack != true) {

			;check trap
			if (Check_Trap_Walker() == true) {
				;ANTICHEAT CLICK ON MINIMAP
				GuiControlGet, CheckBox_GhostMouse_ClickOnMinimap
				if (CheckBox_GhostMouse_ClickOnMinimap == False) {
					MouseMove(Mark.2,Mark.3,fix_coordinates:=true)
				}

				ControlClick(Mark.2,Mark.3, WhichButton:="LEFT",fix_coordinates:=true,ghost_mouse:=true,state:="",zKeyWait:=true,variation:=2,delay_after_click:=100)
				Delay_CaveBot := 200	;click fast
				RETURN, TRUE
			}

			ElapsedTime_ThereIsNoWay := A_TickCount - StartTime_ThereIsNoWay
			SearchPNG(PNG.ThereIsNoWay, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1)
			if (Erro.1 == 1) {
				ThereIsNoWay := True
				StartTime_ThereIsNoWay := A_TickCount
			}
			if (ThereIsNoWay == True && ElapsedTime_ThereIsNoWay < 2500) {
				;~ MSGBOX, % "Mark.2: " Mark.2 "`n Mark.3: " Mark.3 "`nCenter MiniMapX: " Center_MiniMap_X "`nCenter_MiniMap_Y: " Center_MiniMap_Y

				PosX_Mark_Center := Mark.2 - Center_MiniMap_X
				if (PosX_Mark_Center > 1) {
					;~ GuiControl, Main:, tmpHotkey, Right
					;~ Press_Key("tmpHotkey", "Main:")
					GuiControlGet, LooterSQM_4X, Looter:
					GuiControlGet, LooterSQM_4Y, Looter:
					if LooterSQM_4X is number
					{
						;~ msgbox, click RIGHT
						ControlClick(LooterSQM_4X,LooterSQM_4Y,WhichButton:="LEFT",fix_coordinates:=false)
						Sleep 75
					}
				} else if (PosX_Mark_Center < 0 && PosX_Mark_Center != -1) {
					;~ GuiControl, Main:, tmpHotkey, Left
					;~ Press_Key("tmpHotkey", "Main:")
					GuiControlGet, LooterSQM_8X, Looter:
					GuiControlGet, LooterSQM_8Y, Looter:
					if LooterSQM_8X is number
					{
						;~ msgbox, click LEFT
						ControlClick(LooterSQM_8X,LooterSQM_8Y,WhichButton:="LEFT",fix_coordinates:=false)
						Sleep 75
					}
				}

				PosY_Mark_Center := Mark.3 - Center_MiniMap_Y
				if (PosY_Mark_Center > 1) {
					;~ GuiControl, Main:, tmpHotkey, Down
					;~ Press_Key("tmpHotkey", "Main:")
					GuiControlGet, LooterSQM_6X, Looter:
					GuiControlGet, LooterSQM_6Y, Looter:
					if LooterSQM_6X is number
					{
						;~ msgbox, click DOWN
						ControlClick(LooterSQM_6X,LooterSQM_6Y,WhichButton:="LEFT",fix_coordinates:=false)
						Sleep 75
					}

				} else if (PosY_Mark_Center < 0 && PosY_Mark_Center != -1) {
					;~ GuiControl, Main:, tmpHotkey, Up
					;~ Press_Key("tmpHotkey", "Main:")
					GuiControlGet, LooterSQM_2X, Looter:
					GuiControlGet, LooterSQM_2Y, Looter:
					if LooterSQM_2X is number
					{
						;~ msgbox, click UP
						ControlClick(LooterSQM_2X,LooterSQM_2Y,WhichButton:="LEFT",fix_coordinates:=false)
						Sleep 75
					}
				}


				Delay_CaveBot := 75
			} else {
				ThereIsNoWay == False 				;fix bug elapsed time out

				;ANTICHEAT CLICK ON MINIMAP
				GuiControlGet, CheckBox_GhostMouse_ClickOnMinimap
				if (CheckBox_GhostMouse_ClickOnMinimap == False) {
					MouseMove(Mark.2+2,Mark.3+2,fix_coordinates:=true)
				}
				ControlClick(Mark.2,Mark.3,WhichButton:="LEFT",fix_coordinates:=true,ghost_mouse:=true,state:="",zKeyWait:=true,variation:=2,delay_after_click:=100)

				GuiControlGet, Delay_CaveBot

			}
			Attempt_CheckTrap += 1
			Refresh_CaveBot_Stats("Walker")
		}
		RETURN, false
	}

	;RTC FIX BUG
	if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") {
		if (Mark.1 == 1) {
			; salva coordenadas da marcaçao para checagem se esta andando
			Previous_Mark.2 := Mark.2
			Previous_Mark.3 := Mark.3
			Attempt_CheckTrap := 0

			;~ tooltip(Previous_Mark.2 " + " Mark.2 " `n" Previous_Mark.3 " + " Mark.3)
			RETURN, False
		} else {
			; verifica se matou os monstros para ir pro proximo waypoint (e outras coisas)
			if ( AutoHunt.MonsterQuantity <= StopAttackWhenHave	or 																																  (Start_Round_Attack == False && AutoHunt.MonsterQuantity < LureMonsterDropDownList )	or 																							IgnoreTargeting_Walker > 0 or 																																								Data.Conditions.ProtectionZone == 1 ) {
				GuiControl,, WayPoint, % WayPoint+1	;goto next waypoint
				;~ deSelect_AllLines_ListView()	;deseleciona todas as linhas
				;~ LV_Modify(WayPoint, "+Select")	;seleciona celula step atual
				ThereIsNoWay := False

			} else if ( (CheckBox_NextWayPoint_PlayerScreen == 1 && Player_On_Screen == true) or GotoProtectZone == true) {	;GO TO NEXT WAYPOINT IF HAVE PLAYER
				ToolTip("`nPlayer Detected, Goto Next Waypoint...",Time:=-500,X:="",Y:="",WhichToolTip:=10)
				GuiControl,, WayPoint, % WayPoint+1	;goto next waypoint
				;~ deSelect_AllLines_ListView()	;deseleciona todas as linhas
				;~ LV_Modify(WayPoint, "+Select")	;seleciona celula step atual
				ThereIsNoWay := False
			}

			GuiControlGet, Delay_CaveBot
			Return, TRUE
		}
	}

	; se nao encontrar
	if (Mark.1 != 1) {
		ElapsedTime_Alarm := A_TickCount - StartTime_Alarm
		if (ElapsedTime_Alarm > 1200 && (TibiaServer == "OtServer" or TibiaServer == "Global")) {
			;~ msgbox % "Walk_To_Mark: " Walk_To_Mark "`nWayPoint: " WayPoint "`nLV_CaveBot_Action:" LV_CaveBot_Action
			SoundPlay, Configs\Others\Sound\WalkerStuck.mp3
			StartTime_Alarm := A_TickCount
		}
		GuiControl,, WayPoint, % WayPoint+1
		;~ deSelect_AllLines_ListView()	;deseleciona todas as linhas
		;~ LV_Modify(WayPoint, "+Select")	;seleciona celula step atual
	}


	; salva coordenadas da marcaçao para checagem se esta andando
	Previous_Mark.2 := Mark.2
	Previous_Mark.3 := Mark.3
	Attempt_CheckTrap := 0
	Refresh_CaveBot_Stats("Walker")

	;~ tooltip(Previous_Mark.2 " + " Mark.2 " `n" Previous_Mark.3 " + " Mark.3)
	RETURN, False
}


CaveBot_Action() {
	GLOBAL
	Gui, Gui_CaveBot:Default
	Gui, ListView, ListView_Walker
	Gui Submit, NoHide	;ALL GUI CONTROL GET
	List_Number_Lines := LV_GetCount()	;numero de linhas da lista
	if List_Number_Lines is not number
		RETURN, FALSE

	;~ Line_Selected := LV_GetNext("F")
	;~ if (Line_Selected > 0) {	;fix bug select Step
		;~ GuiControl,, WayPoint, % Line_Selected
	;~ }
	GuiControlGet, WayPoint
	if ( WayPoint > List_Number_Lines) {
		GuiControl,, WayPoint, 1
		deSelect_AllLines_ListView()	;deseleciona todas as linhas
		LV_Modify(WayPoint, "+Select")	;seleciona celula step 1
		StartTime_Walker := A_TickCount
	} else {
		deSelect_AllLines_ListView()
		LV_Modify(WayPoint, "+Select")	;seleciona celula step atual
	}


	;[IGNORE TARGETING]
	LV_GetText(IgnoreTargeting_Walker,WayPoint,4)	;pega o texto da linha atual, coluna 4 (Ignore Targeting)
	IgnoreTargeting_Walker := InStr(IgnoreTargeting_Walker, "Ignore Targeting = TRUE")
	;disable combo
	if (IgnoreTargeting_Walker && State_Combo != "OFF") {
		Turn_Combo("OFF")
	}

	;[SLEEP]
	LV_GetText(Sleep_Walker,WayPoint,3)	;pega o texto da linha atual, coluna 3 (Sleep Walker)


	LV_GetText(LV_CaveBot_Action,WayPoint,2)	;pega o texto da linha 1, coluna 2 (Action)
	if (InStr(LV_CaveBot_Action, "Click Map")) {
		WayPoint_on_Center := Walk_to_WayPoint()

	} else if (InStr(LV_CaveBot_Action, "Press Hotkey")) {
		LV_GetText(CaveBot_PressHotkey,WayPoint,2)	;pega o texto da linha 1, coluna 2 (Action)
		CaveBot_PressHotkey := SubStr(CaveBot_PressHotkey, InStr(CaveBot_PressHotkey, "(")+1, InStr(CaveBot_PressHotkey, ")")-InStr(CaveBot_PressHotkey, "(")-1)	;FORMAT STRING
		GuiControl, Main:, tmpHotkey, %CaveBot_PressHotkey%
		Press_Key("tmpHotkey", "Main:")
		GuiControl,, WayPoint, % WayPoint+1 ;go to next waypoint
		;~ deSelect_AllLines_ListView()	;deseleciona todas as linhas
		;~ LV_Modify(WayPoint, "+Select")	;seleciona celula step atual


	} else if (InStr(LV_CaveBot_Action, "Click On Coordinate")) {
		LV_GetText(tmp_MouseType_Walker,WayPoint,4)	;pega o texto da linha atual, coluna 4 (Mouse Type)
		MouseType_Walker := InStr(tmp_MouseType_Walker, "Left")
		if (MouseType_Walker > 0) {
			MouseType_Walker := "Left"
		} else {
			MouseType_Walker := "Right"
		}

		LV_GetText(tmp_Action_Walker,WayPoint,2)	;pega o texto da linha atual, coluna 2 (Action)
		Offset_StartX_ClickOnCoord_Walker := InStr(tmp_Action_Walker, "X= ")
		Offset_Div_ClickOnCoord_Walker := InStr(tmp_Action_Walker, "|")
		Offset_EndX_ClickOnCoord_Walker := Offset_Div_ClickOnCoord_Walker-Offset_StartX_ClickOnCoord_Walker-4
		ClickOnCoord_Walker_PosX := SubStr(tmp_Action_Walker, Offset_StartX_ClickOnCoord_Walker+3, Offset_EndX_ClickOnCoord_Walker)

		Offset_StartY_ClickOnCoord_Walker := InStr(tmp_Action_Walker, "Y= ")
		ClickOnCoord_Walker_PosY := SubStr(tmp_Action_Walker, Offset_StartY_ClickOnCoord_Walker+3)
		ClickOnCoord_Walker_PosY := SubStr(ClickOnCoord_Walker_PosY, 1, StrLen(ClickOnCoord_Walker_PosY)-1)	;remove last character ")"

		ControlClick(ClickOnCoord_Walker_PosX,ClickOnCoord_Walker_PosY, MouseType_Walker,fix_coordinates:=false,ghost_mouse:=true,state:="D")
		Sleep, 500
		ControlClick(ClickOnCoord_Walker_PosX,ClickOnCoord_Walker_PosY, MouseType_Walker,fix_coordinates:=false,ghost_mouse:=true,state:="U")

		GuiControl,, WayPoint, % WayPoint+1 ;go to next waypoint
		;~ deSelect_AllLines_ListView()	;deseleciona todas as linhas
		;~ LV_Modify(WayPoint, "+Select")	;seleciona celula step atual

	} else if (InStr(LV_CaveBot_Action, "if Cap")) {
		LV_GetText(tmp_Action_Walker,WayPoint,2)	;pega o texto da linha atual, coluna 2 (Action)
		Offset_StartCap_ifCap_Walker := InStr(tmp_Action_Walker, ">")
		Offset_EndCap_ifCap_Walker := InStr(tmp_Action_Walker, "g")
		ifCap_ActionCap := SubStr(tmp_Action_Walker, Offset_StartCap_ifCap_Walker+2, Offset_EndCap_ifCap_Walker-Offset_StartCap_ifCap_Walker-3)

		Offset_StartStep_ifCap_Walker := InStr(tmp_Action_Walker, "Step")
		ifCap_gotoStep := SubStr(tmp_Action_Walker, Offset_StartStep_ifCap_Walker+4)

		LV_GetText(tmp_Verify_Cap,WayPoint,4)	;pega o texto da linha atual, coluna 4 (Others)
		;~ BP_Imbuida := InStr(tmp_Verify_Cap, "BP Imbuida = Yes") ? "Green":"Blank"
		Verify_Cap()
		GuiControlGet, CaveBot_MaxNumeroDeVoltas
		if ( (ifCap_ActionCap > OCR_Cap or GotoProtectZone == true) or (CaveBot_NumeroDeVoltas > CaveBot_MaxNumeroDeVoltas && CaveBot_MaxNumeroDeVoltas != 0) ) {
			CaveBot_NumeroDeVoltas := 0
			GuiControl,, WayPoint, % WayPoint+1
			;~ deSelect_AllLines_ListView()	;deseleciona todas as linhas
			;~ LV_Modify(WayPoint, "+Select")	;seleciona celula step atual
		} else {
			CaveBot_NumeroDeVoltas += 1
			GuiControl,, WayPoint, %ifCap_gotoStep%
			;~ deSelect_AllLines_ListView()	;deseleciona todas as linhas
			;~ LV_Modify(WayPoint, "+Select")	;seleciona celula step atual
			;~ WayPoint := ifCap_gotoStep	;if cap > edit goto Step
		}
	} else if (InStr(LV_CaveBot_Action, "Sell All Items")) {
		Loop, {
			LV_GetText(tmp_words_to_say,WayPoint,4)	;pega o texto da linha atual, coluna 4 (Say's)
			tmp_words_to_say := StrSplit(tmp_words_to_say, " | ")

			word_say1 := SubStr(tmp_words_to_say[1], 6, StrLen(tmp_words_to_say[1])-5 )
			word_say2 := SubStr(tmp_words_to_say[2], 6, StrLen(tmp_words_to_say[2])-5 )

			;click on NPC Tab (if have)
			Xvar := 0
			Loop, 7 {
				SearchPNG(PNG.NPC.TabChat, Cords.CooldownBar.Attack.2+46+Xvar, Cords.CooldownBar.Attack.3+29, Cords.CooldownBar.Attack.2+78+Xvar, Cords.CooldownBar.Attack.3+39, Tole:=10, NPCTabChat, Mode:=1)
				;~ Crop_And_Save_Haystack(Cords.CooldownBar.Attack.2+46+Xvar,Cords.CooldownBar.Attack.3+29,32,10)
				if (NPCTabChat.1 == 1) {
					ControlClick(NPCTabChat.2+5,NPCTabChat.3+5)
					Sleep 1000
					BREAK
				} else {
					Xvar += 96
				}
			}

			if (word_say1 != "hi sir") {
				Send_Text(word_say1, 1000)
			}
			Send_Text(word_say2, 1000)
			PrintScreenData()
			SearchPNG(PNG.NPCTrade, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, NPCTradeWindow, Mode:=1)
			if (NPCTradeWindow.1 == 1) {
				;buy spear
				if (word_say1 = "hi sir") {
					SearchPNG(PNG.Ok, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Ok, Mode:=1)
					if (Ok.1 == 1) {
						ControlClick(Ok.2-116,Ok.3-56)
						Sleep 250
						ControlSend,, spear, ahk_id %active_id%
						Sleep 500
						ControlClick(NPCTradeWindow.2+62,NPCTradeWindow.3+110)	;select spear
						Sleep 250
						ControlSend,, {Tab}, ahk_id %active_id%
						Sleep 250
						ControlSend,, 9999999, ahk_id %active_id%
						Sleep 350
						ControlClick(Ok.2+5,Ok.3+5)
						Sleep 500
						;confirm purchase
						PrintScreenData()
						SearchPNG(PNG.Ok, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Ok, Mode:=1)
						if (Ok.1 == 1) {
							ControlClick(Ok.2+5,Ok.3+5)
						}
					}
				}

				;open sell window
				SearchPNG(PNG.NPC.SellButton, NPCTradeWindow.2, NPCTradeWindow.3+24, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, NPCSellButton, Mode:=1)
				if (NPCSellButton.1 == 1) {
					ControlClick(NPCSellButton.2+5,NPCSellButton.3+5)
					Sleep 1000

					Loop, {
						PrintScreenData()
						Item_Sellable := GetColorHex(NPCTradeWindow.2+43, NPCTradeWindow.3+78) = "#C0C0C0" ? true : false
						Sell_Window := GetColorHex(NPCSellButton.2, NPCSellButton.3) != "#727373" ? true : false
						if (Item_Sellable && Sell_Window) {
							ControlClick(NPCTradeWindow.2+43+5,NPCTradeWindow.3+78+5)	;first item list
							Sleep 250
							SearchPNG(PNG.Ok, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Ok, Mode:=1)
							if (Ok.1 == 1) {
								ControlClick(Ok.2+5,Ok.3+5)
								Sleep 250
							}
						} else {
							BREAK
						}
					}
				}
			}
			BREAK
		}
		GuiControl,, WayPoint, % WayPoint+1
		;~ deSelect_AllLines_ListView()	;deseleciona todas as linhas
		;~ LV_Modify(WayPoint, "+Select")	;seleciona celula step atual
	}


}
Check_Trap_Walker() {
	GLOBAL
	Gui, Gui_CaveBot:Default
	;~ ElapsedTimeCheckTrap := A_TickCount - StartTimeCheckTrap
	;~ ElapsedTimeCheckTrap := Round(ElapsedTimeCheckTrap/1000)
	GuiControlGet, Attempt_to_Check_Trap
	if (Attempt_CheckTrap > Attempt_to_Check_Trap) {

		;dead
		SearchPNG(PNG.Dead, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Dead, Mode:=1)
		if (Dead.1 = 1) {
			ControlSend,, {Enter}, ahk_id %active_id% ;ahk_group Tibia
			Sleep 500
			StartTime_Reconnect := A_TickCount
			EXIT
		}

		;click ok buton
		SearchPNG(PNG.Ok, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Ok, Mode:=1)
		if (Ok.1 == 1) {
			ControlClick(Ok.2+5,Ok.3+5)
			Sleep 150
		}

		if (Data.Conditions.ProtectionZone != 1) {
			ToolTip("`nWalker Stuck!, Check Trap...",Time:=-500,X:="",Y:="",WhichToolTip:=10)

			;~ BugMap_Action
			Gui, Looter:Submit, NoHide
			if (Start_Round_Attack != true && LooterSQM_4X != "" && LooterSQM_4X != "ERROR") {
				ControlClick(LooterSQM_4X+(LooterSQM_4X-LooterSQM_9X),LooterSQM_4Y,WhichButton:="RIGHT",fix_coordinates:=false,ghost_mouse:=true,state:="")
				ControlClick(LooterSQM_8X+(LooterSQM_8X-LooterSQM_9X),LooterSQM_8Y,WhichButton:="RIGHT",fix_coordinates:=false,ghost_mouse:=true,state:="")
				ControlClick(LooterSQM_2X,LooterSQM_2Y+(LooterSQM_2Y-LooterSQM_9Y),WhichButton:="RIGHT",fix_coordinates:=false,ghost_mouse:=true,state:="")
				ControlClick(LooterSQM_6X,LooterSQM_6Y+(LooterSQM_6Y-LooterSQM_9Y),WhichButton:="RIGHT",fix_coordinates:=false,ghost_mouse:=true,state:="")
			}


			;START COMBO
			IgnoreTargeting_Walker := false		;fix bug maracutenga
			Start_Round_Attack := true			;fix bug maracutenga
			GuiControlGet, Start_Combo_CheckBox
			if (Start_Combo_CheckBox == 1) {
				Turn_Combo("ON")
				Gui, Gui_CaveBot:Default	;maybe dont need
			}
			StartTimeCheckTrap := A_TickCount	;reseta contagem check trap


			Gui, Gui_CaveBot:Default
			RETURN, true	;retorna como se tivesse chegado
		}
	}

	RETURN, false
}

New_Targeting(){
	GLOBAL
	ElapsedTime_AutoAttack := A_TickCount - StartTime_AutoAttack
	if (ElapsedTime_AutoAttack > 500 && IgnoreTargeting_Walker < 1) {
		; [ Stop Attack AntiRed ]
		if (CheckBox_StopAttack_AntiRed && Player_On_Screen) {
			if (isAttacking) {
				ControlSend,, {Esc}, ahk_id %active_id%
			}
			if (State_Combo != "OFF") {
				Turn_Combo("OFF")
			}
			Start_Round_Attack := False, isAttacking := False, StartTime_AutoAttack := A_TickCount
			RETURN
		}

		; [ Start Combo ]
		if (Start_Round_Attack != False) {
			GuiControlGet, Start_Combo_CheckBox
			GuiControlGet, Start_Combo_Delay
			if (Start_Combo_CheckBox && State_Combo != "ON" && State_Combo != "Waiting" && WalkerEnable == 1) {
				State_Combo := "Waiting"
				;~ Type_Combo_Active := "Combo_PvE"
				SetTimer, AutoCombo, -%Start_Combo_Delay%
			}
		}

		;~ else {
			;~ GuiControlGet, Start_Combo_CheckBox
			;~ ;[Turn OFF Combo] fix bug
			;~ if (Start_Combo_CheckBox && State_Combo != "OFF") {
				;~ Turn_Combo("OFF")
			;~ }
		;~ }

		;[ Stuck Targeting ]
		ElapsedTime_Stuck_Targeting := (A_TickCount - StartTime_AutoAttack) /1000
		GuiControlGet, Total_Time_Stuck_Targeting
		if (ElapsedTime_Stuck_Targeting >= Total_Time_Stuck_Targeting && WalkerEnable == 1 && Start_Round_Attack == True) {
			ToolTip("`nStuck Targeting, Goto Next Waypoint...",Time:=-500,X:="",Y:="",WhichToolTip:=10)
			Turn_Combo("OFF")
			SetTimer, AutoCombo, OFF
			ControlSend,, {Esc}, ahk_id %active_id%
			Sleep, %Sleep_Press_ESC%
			Lootear()
			Start_Round_Attack := False, isAttacking := False, StartTime_AutoAttack := A_TickCount, AutoHunt.MonsterQuantity := 0
			CaveBot_Action()
			Delay_CaveBot := 5000
			EXIT
		}


		GuiControlGet, Priority_Monster_CheckBox
		GuiControlGet, Priority_Number_Position_DropDownList
		GuiControlGet, LureMonsterDropDownList
		GuiControlGet, StopAttackWhenHave
		GuiControlGet, Press_Esc_Cavebot_CheckBox
		GuiControlGet, Sleep_Press_ESC
		GuiControlGet, CheckBox_LootWhenChangeTargeting
		if (Start_Round_Attack == True) {
			if (Priority_Monster_CheckBox == 1 && AutoHunt.MonsterQuantity >= Priority_Number_Position_DropDownList && Data.InfoMobs[Priority_Number_Position_DropDownList]["Target"] == False) {
				if (Press_Esc_Cavebot_CheckBox) {
					ControlSend,, {Esc}, ahk_id %active_id%
					Sleep, %Sleep_Press_ESC%
				}
				if (CheckBox_LootWhenChangeTargeting) {
					Lootear()
					Sleep 100
				}
				GuiControlGet, CheckBox_Attack_With_Space
				if (CheckBox_Attack_With_Space) {
					if (Press_Esc_Cavebot_CheckBox) {
						Loop, % Priority_Number_Position_DropDownList {
							ControlSend,, {Space}, ahk_id %active_id%
						}
					} else {
						ControlSend,, {Space}, ahk_id %active_id%
					}
				} else {
					ControlClick(Data.InfoMobs[Priority_Number_Position_DropDownList]["x"], Data.InfoMobs[Priority_Number_Position_DropDownList]["y"])
					ControlClick(Cords.HP.2+1, Cords.HP.3+1)
				}
				Start_Round_Attack := True, isAttacking := True, StartTime_AutoAttack := A_TickCount
			} else if (AutoHunt.MonsterQuantity <= StopAttackWhenHave) {
					if (State_Combo != "OFF") {
						Turn_Combo("OFF")
						SetTimer, AutoCombo, OFF
					}
					Lootear()
					Start_Round_Attack := False, isAttacking := False, StartTime_AutoAttack := A_TickCount
				} else if (Priority_Monster_CheckBox == 1 && Data.InfoMobs[1]["Target"] == False && AutoHunt.MonsterQuantity < Priority_Number_Position_DropDownList) {	;force attack 1 monster on battle if not have qtd total
						if (Press_Esc_Cavebot_CheckBox) {
							ControlSend,, {Esc}, ahk_id %active_id%
							Sleep, %Sleep_Press_ESC%
						}
						if (CheckBox_LootWhenChangeTargeting) {
							Lootear()
							Sleep 100
						}
						GuiControlGet, CheckBox_Attack_With_Space
						if (CheckBox_Attack_With_Space) {
							ControlSend,, {Space}, ahk_id %active_id%
						} else {
							ControlClick(Data.InfoMobs[1]["x"], Data.InfoMobs[1]["y"])
							ControlClick(Cords.HP.2+1, Cords.HP.3+1)
						}
						Start_Round_Attack := True, isAttacking := True, StartTime_AutoAttack := A_TickCount
				}
			Refresh_CaveBot_Stats("Targeting")
		}
		if (isAttacking == False or Start_Round_Attack == False) {
			if ( (AutoHunt.MonsterQuantity >= LureMonsterDropDownList) or (Start_Round_Attack == True && AutoHunt.MonsterQuantity >= StopAttackWhenHave) ) {
				if (Press_Esc_Cavebot_CheckBox) {
					ControlSend,, {Esc}, ahk_id %active_id%
					Sleep, %Sleep_Press_ESC%
				}
				if (CheckBox_LootWhenChangeTargeting) {
					Lootear()
					Sleep 100
				}
				if (Data.InfoMobs[1]["Target"] != True) {
					GuiControlGet, CheckBox_Attack_With_Space
					if (CheckBox_Attack_With_Space) {
						ControlSend,, {Space}, ahk_id %active_id%
					} else {
						ControlClick(Data.InfoMobs[1]["x"], Data.InfoMobs[1]["y"])
						ControlClick(Cords.HP.2+1, Cords.HP.3+1)
					}
				}
				Start_Round_Attack := True, isAttacking := True, StartTime_AutoAttack := A_TickCount
				Refresh_CaveBot_Stats("Targeting")

			}

		}


	}
}

New_VerifyPlayerList(){
	GLOBAL
	GuiControlGet, CheckBox_ChangeAttackMode
	GuiControlGet, CheckBox_StopCombo_AntiRed
	GuiControlGet, CheckBox_Message_Not_PlayerOnScreen
	GuiControlGet, CheckBox_NextWayPoint_PlayerScreen
	GuiControlGet, CheckBox_StopAttack_AntiRed
	GuiControlGet, CheckBox_GotoProtectZone

	GuiControlGet, CheckBox_AlarmSound_PlayerOnScreen, Alarms:
	GuiControlGet, CheckBox_FocusTibia_PlayerOnScreen, Alarms:
	GuiControlGet, CheckBox_TelegramBot_PlayerOnScreen, Alarms:

	if (CheckBox_ChangeAttackMode or CheckBox_StopCombo_AntiRed or CheckBox_Message_Not_PlayerOnScreen or CheckBox_NextWayPoint_PlayerScreen or CheckBox_StopAttack_AntiRed or CheckBox_GotoProtectZone or CheckBox_AlarmSound_PlayerOnScreen or CheckBox_FocusTibia_PlayerOnScreen or CheckBox_TelegramBot_PlayerOnScreen) {
		if (GetColorHex(Cords.BattleList.Player.2+2, Cords.BattleList.Player.3+2) != "#919191")
			SearchPNG(PNG.BattleList.Player, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Cords.BattleList.Player:=Erro
		if (Cords.BattleList.Player.1 == 1){
			icon_color := GetColorHex(Cords.BattleList.Player.2+131, Cords.BattleList.Player.3+4)
			ICONS := (icon_color = "#2C2C2C" or icon_color = "#090808" or icon_color = "#131313") ? 48 : 0		;#131313 = RTC
			if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") {
				ICONS := (icon_color = "#131313") ? ICONS+5 : ICONS+3	;fix bug RTC
			}
			TargetY := Cords.BattleList.Player.3+28+ICONS
			TargetX := Cords.BattleList.Player.2+24
			if (TibiaClient_ProcessName = "rubinot_dx.exe" or TibiaClient_ProcessName = "rubinot_gl.exe") {
				TargetY += 3 ;fix bug rubinot RTC
				TargetX += 1 ;fix bug rubinot RTC
			}
			TargetLife := GetColorHex(TargetX, TargetY)
			if (TargetLife == "#000000"){
				; [ Change Attack Mode ]
				if (CheckBox_ChangeAttackMode) {
					SearchPNG(PNG.AttackMode.ChaseOff, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Cords.AttackMode.ChaseOff:=Erro
					if (Erro.1 == 1) {
						ControlClick(Cords.AttackMode.ChaseOff.2+5,Cords.AttackMode.ChaseOff.3+5)
					}
				}

				;[Goto ProtectZone]
				if (CheckBox_GotoProtectZone) {
					GotoProtectZone := true
				}

				Player_On_Screen := true
				StartTime_PressHotkeyifDontHavePlayer := A_TickCount	;maracutenga fix bug
				RETURN
			}
		} else {
			English     := "Please open a secondary Battle List named Player."
			Portugues  := "Por favor, abra uma Battle List secundaria com o nome Player."
			ToolTip(%GlobalLanguage%,Time:=-500,X:="",Y:="",WhichToolTip:=10)
		}
	}

	; [ Change Attack Mode ]
	if (CheckBox_ChangeAttackMode) {
		SearchPNG(PNG.AttackMode.StandOff, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1), Cords.AttackMode.StandOff:=Erro
		if (Erro.1 == 1) {
			ControlClick(Cords.AttackMode.StandOff.2+5,Cords.AttackMode.StandOff.3+5)
		}
	}

	; [PRESS HOTKEY IF DONT HAVE PLAYER ON SCREEN]
	ElapsedTime_PressHotkeyifDontHavePlayer := A_TickCount - StartTime_PressHotkeyifDontHavePlayer
	GuiControlGet, CheckBox_Message_Not_PlayerOnScreen
	GuiControlGet, Delay_Message_Not_PlayerOnScreen
	if (CheckBox_Message_Not_PlayerOnScreen && ElapsedTime_PressHotkeyifDontHavePlayer >= Delay_Message_Not_PlayerOnScreen*1000) {
		GuiControlGet, Hotkey_Message_Not_PlayerOnScreen
		Press_Key("Hotkey_Message_Not_PlayerOnScreen")
		StartTime_PressHotkeyifDontHavePlayer := A_TickCount
	}

	Player_On_Screen := FALSE
}

Refresh_CaveBot_Stats(state:="default"){
	GLOBAL
	if (state != "default") {
		state_default := state
	}
	Gui, HUD_CaveBot_Status:Default
	switch state_default {
		case "Targeting":
			GuiControl,, Action_Text_CaveBot_HUD, Targeting
			GuiControl,, Text_CaveBot_HUD, Stuck Target:
			GuiControl,, ElapsedTime_Text_CaveBot_HUD, % Round(ElapsedTime_Stuck_Targeting,2) " sec."
			GuiControl,, Attempts_Text_CaveBot_HUD, 1
			Gui, Gui_CaveBot:Default
		RETURN
		case "Walker":
			GuiControl,, Action_Text_CaveBot_HUD, Walk to Step%WayPoint%
			GuiControl,, Attempts_Text_CaveBot_HUD, % Round(ElapsedTime_Walker,2) "sec. / " Total_Time_Walker
			GuiControl,, Text_CaveBot_HUD, Check Trap:
			GuiControl,, ElapsedTime_Text_CaveBot_HUD, %Attempt_CheckTrap%x / %Attempt_to_Check_Trap%
			Gui, Gui_CaveBot:Default
		RETURN
	}

}

Create_HUD_CaveBot() {
	GLOBAL
	Gui, HUD_CaveBot_Status:New
	Gui, HUD_CaveBot_Status: +AlwaysOnTop -Caption
	;OnMessage(0x0201, "WM_LBUTTONDOWN")

	Gui, Color, 390202
	Gui, Font, cWhite
	Gui, Margin, 10, 10

	Gui, Font, Bold
	Gui, Add, Text, x0 y0 w175 h20 Center, == CaveBot Status ==

	Gui, Add, Text, x5 y20 w40 h20 Center, Action:
	Gui, Add, Text, x5 y40 w55 h20 Center, Attempts:
	Gui, Add, Text, x5 y60 w80 h20 Left vText_CaveBot_HUD,Elapsed Time:

	Gui, Font, cGreen
		Gui, Add, Text, x65 y20 w85 h20 Center vAction_Text_CaveBot_HUD, ...
		Gui, Add, Text, x65 y40 w85 h20 Center vAttempts_Text_CaveBot_HUD, ...
		Gui, Add, Text, x90 y60 w85 h20 Left vElapsedTime_Text_CaveBot_HUD, ...
	Gui, Font, cWhite


	Gui, Font, cBlack
		Gui, Add, Progress, x10 y90 w155 h10  cRed  vHealthBar_CaveBot_HUD, 0	;+BackgroundTrans
		Gui, Add, Progress, x10 y100 w155 h10  c3633A7 vManaBar_CaveBot_HUD, 0	;+BackgroundTrans
	Gui, Font, cWhite

	;~ Gui, HUD_CaveBot_Status:Show, Center AutoSize, CaveBot Status
}


; ============= [ Combo And CaveBot ] ===============
fix_Bug_CaveBot_ComboON() {
	GLOBAL
	if (State_Combo == "ON") {
		if ( (WalkerEnable == 1 && Start_Round_Attack != true) OR Data.Conditions.ProtectionZone == 1 ) {	;se o combo tiver ligado sem atacar monstros
			Turn_Combo("OFF")
			EXIT
		}
	}
}


Check_AdvConfig() {
	GLOBAL
	GuiControlGet, Total_Time_Stuck_Targeting
	if Total_Time_Stuck_Targeting is not number
		GuiControl,, Total_Time_Stuck_Targeting, 90

	GuiControlGet, Total_Attempt_Target
	if Total_Attempt_Target is not number
		GuiControl,, Total_Attempt_Target, 0

	GuiControlGet, Total_Time_Walker
	if Total_Time_Walker is not number
		GuiControl,, Total_Time_Walker, 0

	GuiControlGet, Attempt_to_Check_Trap
	if Attempt_to_Check_Trap is not number
		GuiControl,, Attempt_to_Check_Trap, 2

}
