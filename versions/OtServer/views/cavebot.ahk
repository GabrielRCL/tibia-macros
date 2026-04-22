Draw_Gui_CaveBot() {
    GLOBAL

	;[Create NEW GUI Loot Separator]
	Load_Pre_Settings("Gui_CaveBot")
	Gui, Add, Tab, x1 y1 w790 h765, Walker|Targeting|Utilities|Growth Rune|Adv. Options

	;[Walker - Geral]
	if (TibiaServer != "Global" or VipMode == "true" ) {
		; TAB WALKER
		Gui, Tab, Walker
		AdminMode := 1
		Gui, Add, Button, x600 y30 w50 h20 gSave_Conf_Walker_GUI, Save
		Gui, Add, Button, x655 y30 w50 h20 gLoad_Conf_Walker_GUI, Load
		Gui, Add, Button, x710 y30 w50 h20 gReset_Conf_Walker_GUI, Reset

		Gui, Font, Bold
			Gui, Add, Text, section x610 y120 w100 h30 +Center, Hotkey to Start CaveBot:
			Gui, Add, Hotkey, xs+15 ys+30 w70 h20 vKey_Enable_Walker, ;%Key_Enable_Walker%

			Gui, Add, Text, x22 y39 w200 h20 +Center, Configure os Passos:
		Gui, Font, Normal


		Gui, Add, Button, x280 y50 w150 h30 gAdd_Step_Walker_GUI, Add Step

		Gui, Add, Text, x22 y72 w110 h20 , Selecione uma opcao:
		Gui, Add, DropDownList, x132 y69 w120 h20 r5 vDropDownList_Action Choose1 gChange_GUI_CaveBot, Click Map|Press Hotkey|Click On Coordinate|if Cap|Sell All Items

		Gui, Add, Text, x22 y216 w200 h20 vText_Sleep_ClickMap, Quando Chegar na marca, esperar por:
		Gui, Add, DropDownList, x212 y213 w30 h20 r8 Choose1 vDropDownList_Sleep_Walker, 0|1|2|3|4|5|6|7
		Gui, Add, Text, x245 y216 w220 h20 vText_Sleep2_ClickMap, segundos antes de ir para o proximo passo.

		;[ List View - Walker ]
		Step := 0
		Gui, Font, Bold
		Gui, Add, GroupBox, x22 y279 w630 h480 , Configuracao Atual:
		Gui, Font, Normal
		Gui, Add, ListView, backgroundD4D0C8 cBlack grid hwndLV_Walker x27 y295 r20 w620 h455 +altsubmit gLV_Walker vListView_Walker, Step|Action|Delay|Others
		LV_SetSelColors(LV_Walker, 0x0096FF)
		LV_ModifyCol(1, 40)
		LV_ModifyCol(2, 220)
		LV_ModifyCol(3, 40)
		LV_ModifyCol(4, 318)

		Gui, Font, Bold
		Gui, Add, Text, x547 y268 w60 h15, Step Atual:
		Gui, Font, Normal
		Gui, Font, cRed
		Gui, Add, Edit, x611 y265 w25 h20 vWayPoint Number Limit4, 1
		Gui, Font, cWhite

		Gui, Add, Button, x655 y295 w50 h20 gUp_Step_Walker_GUI, Up
		Gui, Add, Button, x655 y317 w50 h20 gDown_Step_Walker_GUI, Down
		Gui, Add, Button, x655 y339 w50 h20 gDelete_Step_Walker_GUI, Delete
		Gui, Add, Button, x655 y361 w50 h20 gEdit_Step_Walker_GUI, Edit

		;Delay Action
		Gui, Font, Bold
		Gui, Add, Text, section x680 y700 w80 h20 Center, Delay Action:
		Gui, Font, Normal
		Gui, Font, cRed
		Gui, Add, Edit, xs+20 ys+20 w30 h20 vDelay_CaveBot Number Limit4, 250
		Gui, Font, cWhite
		Gui, Add, Text, xs+52 ys+24 w20 h20, ms.


	}

	;[Walker - ClickMap]
	if (TibiaServer != "Global" or VipMode == "true" ) {
		Gui, Add, GroupBox, x22 y99 w510 h110 vGroupBox_ClickMap, Escolha a marca do Mini Mapa que voce quer andar:
		Gui, Add, Text, x22 y242 w205 h20 vText_IgnoreMonster_ClickMap, Ignorar targeting quando chegar na marca:
		Gui, Add, DropDownList, x225 y240 w60 h20 r2 vDropDownList_IgnoreTargeting_Walker Choose2, TRUE|FALSE

		;[Mark - Picture]
		Gui, Add, Picture, x32 y119 w11 h11 +BackgroundTrans vPictureMark1, % "HBITMAP:* " Picture.Mark1
		Gui, Add, Picture, x82 y119 w11 h11 +BackgroundTrans vPictureMark2, % "HBITMAP:* " Picture.Mark2
		Gui, Add, Picture, x132 y119 w11 h11 +BackgroundTrans vPictureMark3, % "HBITMAP:* " Picture.Mark3
		Gui, Add, Picture, x182 y119 w11 h11 +BackgroundTrans vPictureMark4, % "HBITMAP:* " Picture.Mark4
		Gui, Add, Picture, x232 y119 w11 h11 +BackgroundTrans vPictureMark5, % "HBITMAP:* " Picture.Mark5
		Gui, Add, Picture, x282 y119 w11 h11 +BackgroundTrans vPictureMark6, % "HBITMAP:* " Picture.Mark6
		Gui, Add, Picture, x332 y119 w11 h11 +BackgroundTrans vPictureMark7, % "HBITMAP:* " Picture.Mark7
		Gui, Add, Picture, x382 y119 w11 h11 +BackgroundTrans vPictureMark8, % "HBITMAP:* " Picture.Mark8
		Gui, Add, Picture, x432 y119 w11 h11 +BackgroundTrans vPictureMark9, % "HBITMAP:* " Picture.Mark9
		Gui, Add, Picture, x482 y119 w11 h11 +BackgroundTrans vPictureMark10, % "HBITMAP:* " Picture.Mark10

		Gui, Add, Picture, x32 y174 w11 h11 +BackgroundTrans vPictureMark11, % "HBITMAP:* " Picture.Mark11
		Gui, Add, Picture, x82 y174 w11 h11 +BackgroundTrans vPictureMark12, % "HBITMAP:* " Picture.Mark12
		Gui, Add, Picture, x132 y174 w11 h11 +BackgroundTrans vPictureMark13, % "HBITMAP:* " Picture.Mark13
		Gui, Add, Picture, x182 y174 w11 h11 +BackgroundTrans vPictureMark14, % "HBITMAP:* " Picture.Mark14
		Gui, Add, Picture, x232 y174 w11 h11 +BackgroundTrans vPictureMark15, % "HBITMAP:* " Picture.Mark15
		Gui, Add, Picture, x282 y174 w11 h11 +BackgroundTrans vPictureMark16, % "HBITMAP:* " Picture.Mark16
		Gui, Add, Picture, x332 y174 w11 h11 +BackgroundTrans vPictureMark17, % "HBITMAP:* " Picture.Mark17
		Gui, Add, Picture, x382 y174 w11 h11 +BackgroundTrans vPictureMark18, % "HBITMAP:* " Picture.Mark18
		Gui, Add, Picture, x432 y174 w11 h11 +BackgroundTrans vPictureMark19, % "HBITMAP:* " Picture.Mark19
		Gui, Add, Picture, x482 y174 w11 h11 +BackgroundTrans vPictureMark20, % "HBITMAP:* " Picture.Mark20


		;[Mark - Radio Button]
		Gui, Add, Radio, x30 y132 w30 h12 Checked vRadio_Mark hwndRMark1, 1
		Gui, Add, Radio, x80 y132 w30 h12 hwndRMark2, 2
		Gui, Add, Radio, x130 y132 w30 h12 hwndRMark3, 3
		Gui, Add, Radio, x180 y132 w30 h12 hwndRMark4, 4
		Gui, Add, Radio, x230 y132 w30 h12 hwndRMark5, 5
		Gui, Add, Radio, x280 y132 w30 h12 hwndRMark6, 6
		Gui, Add, Radio, x330 y132 w30 h12 hwndRMark7, 7
		Gui, Add, Radio, x380 y132 w30 h12 hwndRMark8, 8
		Gui, Add, Radio, x430 y132 w30 h12 hwndRMark9, 9
		Gui, Add, Radio, x480 y132 w33 h12 hwndRMark10, 10

		Gui, Add, Radio, x30 y187 w33 h12 hwndRMark11, 11
		Gui, Add, Radio, x80 y187 w33 h12 hwndRMark12, 12
		Gui, Add, Radio, x130 y187 w33 h12 hwndRMark13, 13
		Gui, Add, Radio, x180 y187 w33 h12 hwndRMark14, 14
		Gui, Add, Radio, x230 y187 w33 h12 hwndRMark15, 15
		Gui, Add, Radio, x280 y187 w33 h12 hwndRMark16, 16
		Gui, Add, Radio, x330 y187 w33 h12 hwndRMark17, 17
		Gui, Add, Radio, x380 y187 w33 h12 hwndRMark18, 18
		Gui, Add, Radio, x430 y187 w33 h12 hwndRMark19, 19
		Gui, Add, Radio, x480 y187 w33 h12 hwndRMark20, 20
	}

	;[Walker - Press Hotkey]
	if (TibiaServer != "Global" or VipMode == "true" ) {
		Gui, Add, GroupBox, x22 y99 w510 h110 vGroupBox_PressHotkey, Escolha a Hotkey que voce quer pressionar:
		GuiControl, Hide, GroupBox_PressHotkey
		Gui, Add, Text, x32 y121 w40 h20 vText_PressHotkey, Hotkey:
		GuiControl, Hide, Text_PressHotkey
		Gui, Add, Hotkey, x72 y119 w60 h20 vHotkey_Walker_PressHotkey
		GuiControl, Hide, Hotkey_Walker_PressHotkey
	}

	;[Walker - Click On Coordinate]
	if (TibiaServer != "Global" or VipMode == "true" ) {
		Gui, Add, GroupBox, x22 y99 w510 h110 vGroupBox_ClickOnCoord, Escolha a Coordenada que voce quer clicar:
		GuiControl, Hide, GroupBox_ClickOnCoord
		Gui, Add, Text, x32 y121 w60 h20 vText_ClickOnCoord, Coordinate:
		GuiControl, Hide, Text_ClickOnCoord
		Gui, Add, Button, x92 y119 w120 h20 gButton_ClickOnCoord_GetCoord vButton_ClickOnCoord, > Get Coordinate <
		GuiControl, Hide, Button_ClickOnCoord

		Gui, Add, Text, x50 y148 w15 h20 vText_ClickOnCoord_X, X=
		GuiControl, Hide, Text_ClickOnCoord_X
		Gui, Font, cRed
			Gui, Add, Edit, x65 y145 w45 h20 vEdit_ClickOnCoord_X, 1234
			GuiControl, Hide, Edit_ClickOnCoord_X
		Gui, Font, cWhite

		Gui, Add, Text, x130 y148 w15 h20 vText_ClickOnCoord_Y, Y=
		GuiControl, Hide, Text_ClickOnCoord_Y
		Gui, Font, cRed
			Gui, Add, Edit, x145 y145 w45 h20 vEdit_ClickOnCoord_Y, 1234
			GuiControl, Hide, Edit_ClickOnCoord_Y
		Gui, Font, cWhite

		Gui, Add, Text, x32 y183 w65 h20 vText_ClickOnCoord_MouseType, Mouse Type:
		GuiControl, Hide, Text_ClickOnCoord_MouseType
		Gui, Add, DropDownList, x97 y181 w55 h20 r5 Choose1 vDropDownList_ClickOnCoord_MouseType, Left|Right
		GuiControl, Hide, DropDownList_ClickOnCoord_MouseType
	}

	;[Walker - if Cap]
	if (TibiaServer != "Global" or VipMode == "true" ) {
		Gui, Add, GroupBox, x22 y99 w510 h110 vGroupBox_ifCap, Se o Cap:
			GuiControl, Hide, GroupBox_ifCap
		Gui, Add, Text, section x32 y121 w125 h20 vText_ifCap, Se o Cap for maior que:
		Gui, Add, Text, x195 y121 w80 h20 vText2_ifCap, vᠰara o Step:
			GuiControl, Hide, Text_ifCap
			GuiControl, Hide, Text2_ifCap
		Gui, Font, cRed
		Gui, Add, Edit, x145 y119 w40 h20 vEdit_ifCap Number Limit5, 1000
		Gui, Add, Edit, x270 y119 w30 h20 vEdit2_ifCap Number Limit3, 1
			GuiControl, Hide, Edit_ifCap
			GuiControl, Hide, Edit2_ifCap
		Gui, Font, cWhite

		;~ Gui, Add, Text, section xs w155 h20 vText3_ifCap, Backpack esta com imbuiment?
		;~ Gui, Add, DropDownList, xs+160 ys-2 w45 h20 vBP_Imbuiment_ifCap r2 Choose2, Yes|No
			GuiControl, Hide, Text3_ifCap
			GuiControl, Hide, BP_Imbuiment_ifCap
	}

	;[Targeting]
	if (TibiaServer != "Global" or VipMode == "true" ) {
		;====[Targeting]====
		Gui, Tab, Targeting
		Gui, Add, GroupBox, x12 y29 w260 h180 , Targeting
		Gui, Add, CheckBox, x22 y55 w80 h20 vCheckBox_AutoAttack, Auto Attack
		Gui, Add, Text, x22 y89 w90 h20, Attack only if have
		Gui, Add, DropDownList, x112 y87 w35 h21 r8 vLureMonsterDropDownList Choose1, 1|2|3|4|5|6|7|8
		Gui, Add, Text, x150 y89 w55 h20, Monster(s)
		Gui, Add, Text, x21 y115 w150 h20, Stop attacking when have
		Gui, Add, DropDownList, x148 y112 w35 h21 r8 vStopAttackWhenHave Choose1, 0|1|2|3|4|5|6|7
		Gui, Add, Text, x185 y115 w55 h20, Monster(s)

		;Start Combo
		Gui, Add, CheckBox, x22 y145 w110 h20 vStart_Combo_CheckBox, Start Combo After:
	Gui, Font, cRed
		Gui, Add, Edit, x132 y145 w40 h20 vStart_Combo_Delay Number Limit4 Right, 2500
	Gui, Font, cWhite
		Gui, Add, Text, x173 y149 w12 h20, ms

		;Loot When Change Targeting
		Gui, Add, CheckBox, x22 y170 w170 h20 vCheckBox_LootWhenChangeTargeting, Loot When Change Targeting
	}

	;[Utilities]
	if (TibiaServer != "Global" or VipMode == "true" ) {
		; ==== [List View - Save & Load] ====
		Gui, Tab, Utilities
		Gui, Gui_CaveBot:Font, cWhite


		;[IF PLAYER NOT ON SCREEN]
		Gui, Add, GroupBox, x140 y119 w230 h75 +Center, if Player NOT on Screen ;GROUPBOX
			Gui, Add, CheckBox, x150 y139 w110 h20 vCheckBox_Message_Not_PlayerOnScreen, PRESS HOTKEY:
			Gui, Add, Hotkey, x260 y139 w70 h20 vHotkey_Message_Not_PlayerOnScreen,
			Gui, Add, Text, x155 y161 w100 h20 +Right, Delay:
		Gui,Font,cRed
			Gui, Add, Edit, x260 y159 w50 h20 +Right Number vDelay_Message_Not_PlayerOnScreen, 10
		Gui,Font,cWhite
			Gui, Add, Text, x311 y163 w25 h15, seg.

			;[Change Attack Mode]
		Gui, Add, GroupBox, x140 y29 w350 h90 +Center, if Player on Screen ;GROOUP BOX
			Gui, Add, CheckBox, x150 y50 w150 h20 vCheckBox_ChangeAttackMode, Change to Follow Attack
			Gui, Add, CheckBox, x150 y70 w185 h20 vCheckBox_StopCombo_AntiRed, Change to Combo PvP (Anti-Red)
			Gui, Add, CheckBox, x150 y90 w130 h20 vCheckBox_StopAttack_AntiRed, Stop Attack (Anti-Red)

			Gui, Add, CheckBox, x340 y50 w130 h20 vCheckBox_NextWayPoint_PlayerScreen, Goto Next WayPoint
			Gui, Add, CheckBox, x340 y70 w130 h20 vCheckBox_GotoProtectZone, Goto ProtectZone
			;~ Gui, Add, CheckBox, x340 y90 w130 h20 vCheckBox_Deslogar_PlayerScreen, Goto SafeZone

		;[Change Gold]
		Gui, Add, GroupBox, section x575 y29 w120 h170 +Center, Change Gold
		Gui, Add, CheckBox, xs+25 ys+15 w65 h20 vCheckBox_ChangeGold, ENABLE
		Gui, Add, Picture, xs+42 ys+50 w32 h32, % "HBITMAP:* " Picture.GoldConverter
		Gui, Add, Text, xs+25 ys+85 w65 h25 +Center, Hotkey Gold Converter:
		Gui, Add, Hotkey, xs+25 ys+112 w70 h20 vHotkey_GoldConverter

		Portugues := "Utilize Hotkey apenas se necessario"
		English := "Use Hotkey only if necessary"
		Gui, Add, Text, xs+5 ys+135 w110 h30 +Center, % %GlobalLanguage%

	}

	;[Growth Rune]
	if (TibiaServer != "Global" or VipMode == "true" ) {
		;[ RENOVAR MATO ]
			Gui, Tab, Growth Rune
			; Growth Rune 1
			Gui, Add, GroupBox, x10 y25 w285 h170 +Center, Renew Growth 1
			Gui, Add, CheckBox, x20 y40 w140 h20 vEnable_Renew_Growth1_CheckBox, Enable Renew Growth 1

			Gui, Add, Picture, x20 y60 w118 h113, % "HBITMAP:* " Picture.RenewGrowth
			Gui, Add, Text, x50 y111 w70 h20, Hotkey Rune:
			Gui, Add, Hotkey, x50 y131 w70 h20 vRenew_Growth1_Hotkey,
			;Gui, Add, CheckBox, x185 y150 w90 h20 vForce_Renew_Growth1_CheckBox, Force Renew


			Gui, Add, Button, x185 y45 w80 h30 gRenew_Growth1_GetArea, Get Area
			Gui, Add, Text, x153 y87 w25 h20 , X1=
			Gui, Add, Text, x225 y87 w25 h20 , Y1=
			Gui, Add, Text, x153 y117 w25 h20 , X2=
			Gui, Add, Text, x225 y117 w25 h20 , Y2=
		Gui, Font, cRed
			Gui, Add, Edit, x175 y85 w40 h20 vRenew_Growth1_X1, 0
			Gui, Add, Edit, x247 y85 w40 h20 vRenew_Growth1_Y1, 0
			Gui, Add, Edit, x175 y115 w40 h20 vRenew_Growth1_X2, 0
			Gui, Add, Edit, x247 y115 w40 h20 vRenew_Growth1_Y2, 0
		Gui, Font, cWhite

			; Growth Rune 2
			Gui, Add, GroupBox, x310 y25 w285 h170 +Center, Renew Growth 2
			Gui, Add, CheckBox, x320 y40 w140 h20 vEnable_Renew_Growth2_CheckBox, Enable Renew Growth 2

			Gui, Add, Picture, x320 y60 w118 h113,  % "HBITMAP:* " Picture.RenewGrowth
			Gui, Add, Text, x350 y111 w70 h20, Hotkey Rune:
			Gui, Add, Hotkey, x350 y131 w70 h20 vRenew_Growth2_Hotkey,
			;Gui, Add, CheckBox, x485 y150 w90 h20 vForce_Renew_Growth2_CheckBox, Force Renew


			Gui, Add, Button, x485 y45 w80 h30 gRenew_Growth2_GetArea, Get Area
			Gui, Add, Text, x453 y87 w25 h20 , X1=
			Gui, Add, Text, x525 y87 w25 h20 , Y1=
			Gui, Add, Text, x453 y117 w25 h20 , X2=
			Gui, Add, Text, x525 y117 w25 h20 , Y2=
		Gui, Font, cRed
			Gui, Add, Edit, x475 y85 w40 h20 vRenew_Growth2_X1, 0
			Gui, Add, Edit, x547 y85 w40 h20 vRenew_Growth2_Y1, 0
			Gui, Add, Edit, x475 y115 w40 h20 vRenew_Growth2_X2, 0
			Gui, Add, Edit, x547 y115 w40 h20 vRenew_Growth2_Y2, 0
		Gui, Font, cWhite

			; Growth Rune 3
			Gui, Add, GroupBox, x10 y200 w285 h170 +Center, Renew Growth 3
			Gui, Add, CheckBox, x20 y215 w140 h20 vEnable_Renew_Growth3_CheckBox, Enable Renew Growth 3

			Gui, Add, Picture, x20 y235 w118 h113, % "HBITMAP:* " Picture.RenewGrowth
			Gui, Add, Text, x50 y286 w70 h20, Hotkey Rune:
			Gui, Add, Hotkey, x50 y306 w70 h20 vRenew_Growth3_Hotkey,
			;Gui, Add, CheckBox, x185 y325 w90 h20 vForce_Renew_Growth3_CheckBox, Force Renew

			Gui, Add, Button, x185 y220 w80 h30 gRenew_Growth3_GetArea, Get Area
			Gui, Add, Text, x153 y262 w25 h20 , X1=
			Gui, Add, Text, x225 y262 w25 h20 , Y1=
			Gui, Add, Text, x153 y292 w25 h20 , X2=
			Gui, Add, Text, x225 y292 w25 h20 , Y2=
		Gui, Font, cRed
			Gui, Add, Edit, x175 y260 w40 h20 vRenew_Growth3_X1, 0
			Gui, Add, Edit, x247 y260 w40 h20 vRenew_Growth3_Y1, 0
			Gui, Add, Edit, x175 y290 w40 h20 vRenew_Growth3_X2, 0
			Gui, Add, Edit, x247 y290 w40 h20 vRenew_Growth3_Y2, 0
		Gui, Font, cWhite

			; Growth Rune 4
			Gui, Add, GroupBox, x310 y200 w285 h170 +Center, Renew Growth 4
			Gui, Add, CheckBox, x320 y215 w140 h20 vEnable_Renew_Growth4_CheckBox, Enable Renew Growth 4

			Gui, Add, Picture, x320 y235 w118 h113, % "HBITMAP:* " Picture.RenewGrowth
			Gui, Add, Text, x350 y286 w70 h20, Hotkey Rune:
			Gui, Add, Hotkey, x350 y306 w70 h20 vRenew_Growth4_Hotkey,
			;Gui, Add, CheckBox, x485 y325 w90 h20 vForce_Renew_Growth4_CheckBox, Force Renew

			Gui, Add, Button, x485 y220 w80 h30 gRenew_Growth4_GetArea, Get Area
			Gui, Add, Text, x453 y262 w25 h20 , X1=
			Gui, Add, Text, x525 y262 w25 h20 , Y1=
			Gui, Add, Text, x453 y292 w25 h20 , X2=
			Gui, Add, Text, x525 y292 w25 h20 , Y2=
		Gui, Font, cRed
			Gui, Add, Edit, x475 y260 w40 h20 vRenew_Growth4_X1, 0
			Gui, Add, Edit, x547 y260 w40 h20 vRenew_Growth4_Y1, 0
			Gui, Add, Edit, x475 y290 w40 h20 vRenew_Growth4_X2, 0
			Gui, Add, Edit, x547 y290 w40 h20 vRenew_Growth4_Y2, 0
		Gui, Font, cWhite
	}

	;[Adv. Options]
	if (TibiaServer != "Global" or VipMode == "true" ) {
		;====[Adv. Options]=====
		Gui, Tab, Adv. Options

		Gui, Add, CheckBox, x12 y30 w180 h20 vCheckBox_Show_HUD_CaveBot_Status, Show HUD CaveBot Status


		;TARGETING E WALKER CONFIGS
		Gui, Add, GroupBox, section x10 y50 w320 h170 Center, CaveBot Settings

		Gui, Add, Text, xs+5 ys+17 w135 h20 Center, Total Time Stuck Targeting:
			Gui, Add, Picture, xs+223 ys+20 Hwnd_IdStuckTargeting, % "HBITMAP:* " Picture.interrogacao

		Gui, Add, Text, xs+5 ys+42 w135 h20 Center, Total Attempt Target:
			Gui, Add, Picture, xs+217 ys+45 Hwnd_IdAttemptTarget, % "HBITMAP:* " Picture.interrogacao

		Gui, Add, Text, xs+5 ys+67 w135 h20 Center, Total Time Walker:
			Gui, Add, Picture, xs+217 ys+70 Hwnd_IdAttemptWalker, % "HBITMAP:* " Picture.interrogacao
			Gui, Add, CheckBox, xs+240 ys+72 Hwnd_IdLureMode vCheckBox_Lure_Mode, Lure Mode

		Gui, Add, Text, xs+5 ys+92 w135 h20 Center, Attempt to Check Trap:
			Gui, Add, Picture, xs+217 ys+95 Hwnd_IdAttemptCheckTrap, % "HBITMAP:* " Picture.interrogacao

		Portugues := "Maximo de Voltas:"
		English := "Maximum of Laps:"
		Gui, Add, Text, xs+5 ys+117 w135 h20 Center, % %GlobalLanguage%
			Gui, Add, Picture, xs+217 ys+120 Hwnd_IdMaximumLaps, % "HBITMAP:* " Picture.interrogacao

		Gui, Font, cRed
			Gui, Add, Edit, xs+140 ys+15 w35 h20 vTotal_Time_Stuck_Targeting Number Limit5, 90
			Gui, Add, Edit, xs+140 ys+40 w35 h20 vTotal_Attempt_Target Number Limit5, 0
			Gui, Add, Edit, xs+140 ys+65 w35 h20 vTotal_Time_Walker Number Limit2, 0
			Gui, Add, Edit, xs+140 ys+90 w35 h20 vAttempt_to_Check_Trap Number Limit5, 5
			Gui, Add, Edit, xs+140 ys+115 w35 h20 vCaveBot_MaxNumeroDeVoltas Number Limit5, 0
		Gui, Font, cWhite

			Gui, Add, Text, xs+175 ys+21 w45 h15, seconds.
			Gui, Add, Text, xs+175 ys+46 w40 h15, attempt.
			Gui, Add, Text, xs+175 ys+70 w40 h15, seconds.
			Gui, Add, Text, xs+175 ys+96 w40 h15, attempt.
			Gui, Add, Text, xs+175 ys+121 w40 h15, attempt.


		Portugues	:= "OBS: se o valor for = 0, a funcao esta desabilitada"
		English 	:= "NOTE: if the value is = 0, the function is disabled"
		Gui, Font, Bold
			Gui, Add, Text, xs+10 ys+145 w295 h20, % %GlobalLanguage%
		Gui, Font, Norm

		;ESC BUTTON
		Gui, Add, CheckBox, section x12 y240 w150 h20 vPress_Esc_Cavebot_CheckBox, Press ESC before attack
			GuiControl,, Press_Esc_Cavebot_CheckBox, 1
		Gui, Add, Text, xs+10 ys+23 w45 h20, Delay:
		Gui, Font, cRed
			Gui, Add, Edit, xs+45 ys+20 w40 h20 vSleep_Press_ESC Number, 250
		Gui, Font, cWhite
		Gui, Add, Text, xs+86 ys+24 w20 h15, ms.

		;Priority 9º Monster on Battle
		Gui, Add, CheckBox, section x12 y310 w53 h20 vPriority_Monster_CheckBox, Priority	;Priority Monster On Battle
		Gui, Add, DropDownList, xs+53 ys w30 h20 r9 vPriority_Number_Position_DropDownList Choose9, 1|2|3|4|5|6|7|8|9
		Gui, Add, Text, xs+84 ys+3 w120 h20, Monster On Battle List

		; Bypass Anti-Cheat
		Gui, Add, GroupBox, section x500 y40 w280 h100 Center, Bypass Anti-Cheat
		Gui, Add, CheckBox, xs+5 ys+20 w180 h20 Checked vCheckBox_GhostMouse_ClickOnMinimap, Ghost Mouse (Click On Minimap)
		Gui, Add, CheckBox, xs+5 ys+50 w200 h20 vCheckBox_Attack_With_Space, Attack With Space Hotkey (Chat Off)


	}

}
Draw_Gui_CaveBot:
	Gui, Gui_CaveBot:Show, % " w" 790 " h" 765, [CaveBot] %TrayName%	;NAME PROGRAMA
RETURN


LV_Walker:
	Gui, Gui_CaveBot:Default
	Gui, ListView, ListView_Walker
	Gui Submit, NoHide	;ALL GUI CONTROL GET
	if (A_GuiEvent = "Normal" or A_GuiEvent = "Rightclick")
	{
		if (LV_GetNext() > 0) {
			GuiControl,, WayPoint, % LV_GetNext() ;~ WayPoint := linha da celula em foco
		} else {
			LV_Modify(WayPoint, "+Select")
		}
	}
RETURN

Add_Step_Walker_GUI:
	Gui, Gui_CaveBot:Default
	Gui, ListView, ListView_Walker
	Gui Submit, NoHide	;ALL GUI CONTROL GET
	Step++
	switch DropDownList_Action {
		case "Click Map": 	LV_Add("", Step, DropDownList_Action " Mark(" Radio_Mark ")", DropDownList_Sleep_Walker, "Ignore Targeting = " DropDownList_IgnoreTargeting_Walker)
		case "Press Hotkey": LV_Add("", Step, DropDownList_Action " (" Hotkey_Walker_PressHotkey ")", DropDownList_Sleep_Walker, "Ignore Targeting = " DropDownList_IgnoreTargeting_Walker)
		case "Click On Coordinate": LV_Add("", Step, DropDownList_Action " (X= " Edit_ClickOnCoord_X " | Y= " Edit_ClickOnCoord_Y ")", DropDownList_Sleep_Walker, "Mouse Type = " DropDownList_ClickOnCoord_MouseType " + Ignore Targeting = " DropDownList_IgnoreTargeting_Walker)
		case "if Cap": LV_Add("", Step, DropDownList_Action " > " Edit_ifCap " goto Step" Edit2_ifCap, DropDownList_Sleep_Walker, "Ignore Targeting = " DropDownList_IgnoreTargeting_Walker)
		case "Sell All Items": LV_Add("", Step, "Sell All Items",,"Say1=hi | Say2=trade")
	}
	LV_Modify(Step, "Vis")	;Garante que a linha especificada esteja completamente visível rolando o ListView, se necessário.
	deSelect_AllLines_ListView()
	LV_Modify(WayPoint, "+Select")
	;~ LV_GetNext()	;linha da celula em foco
	;~ msgbox % LV_GetCount()	;numero de linhas
	;~ LV_GetText(outputlvgettext,1,2)	;pega o texto da linha 1, coluna 2
	;~ msgbox % outputlvgettext
	if (DropDownList_Action == "Click Map") {
		if (Radio_Mark == 20) {
			Radio_Mark := 1
		} else {
			Radio_Mark++
		}
		GuiControl, Gui_CaveBot:, % RMark%Radio_Mark%, 1
	}
RETURN
deSelect_AllLines_ListView() {
    GLOBAL
	Gui, Gui_CaveBot:Default
	Gui, ListView, ListView_Walker
	Gui Submit, NoHide	;ALL GUI CONTROL GET
	;~ LV_GetCount()	;numero de linhas
	i := 1
	Loop, % LV_GetCount() {
		LV_Modify(i, "-Select")
		i++
	}
}

Up_Step_Walker_GUI:
	Change_Order_Item_ListView(-1)
RETURN

Down_Step_Walker_GUI:
	Change_Order_Item_ListView(1)
RETURN

Change_Order_Item_ListView(n) {
    global
	ListView_Item := []
	ListView_ItemN := []
	Gui, Gui_CaveBot:Default
	Gui, ListView, ListView_Walker
	Gui Submit, NoHide	;ALL GUI CONTROL GET
	Line_Selected := LV_GetNext("F")
	if (Line_Selected > 0 && Line_Selected+n > 0) {
		Loop, % LV_GetCount("Col") {
			LV_GetText(tmp_output, Line_Selected, A_Index)
			ListView_Item.Push(tmp_output)
			LV_GetText(tmp_output, Line_Selected+n, A_Index)
			ListView_ItemN.Push(tmp_output)
		}
		Loop, % ListView_Item.Length() {
			;~ msgbox % ListView_Item[A_Index]
			LV_Modify(Line_Selected+n, "Col" A_Index, ListView_Item[A_Index])
			LV_Modify(Line_Selected+n, "+Select +Focus")
		}
		Loop, % ListView_ItemN.Length() {
			;~ msgbox % ListView_ItemN[A_Index]
			LV_Modify(Line_Selected, "Col" A_Index, ListView_ItemN[A_Index])
			LV_Modify(Line_Selected, "-Select -Focus")
		}
	}
	Step := 0
	Loop, % LV_GetCount() {
		Step++
		LV_Modify(Step, "Col1", Step)
	}
}

Delete_Step_Walker_GUI:
	Gui, Gui_CaveBot:Default
	Gui, ListView, ListView_Walker
	Gui Submit, NoHide	;ALL GUI CONTROL GET
	LV_Delete(LV_GetNext())	;deleta a linha da celula em foco
	Step := 0
	Loop, % LV_GetCount() {
		Step++
		LV_Modify(Step, "Col1", Step)
	}
RETURN

Edit_Step_Walker_GUI:
	Gui, Gui_CaveBot:Default
	Gui, Gui_CaveBot:-AlwaysOnTop
	Gui, ListView, ListView_Walker
	Gui Submit, NoHide	;ALL GUI CONTROL GET
	Line_Selected := LV_GetNext("F")
	if (Line_Selected > 0) {
		LV_GetText(Edit_Action,Line_Selected,2)	;pega o texto da linha selecionada, coluna 2
		LV_GetText(Edit_Delay,Line_Selected,3)	;pega o texto da linha selecionada, coluna 3
		LV_GetText(Edit_Others,Line_Selected,4)	;pega o texto da linha selecionada, coluna 4
		Create_GUI_Edit_ListView()
	} else {
		MsgBox, Selecione um step para edita-lo.
		Gui, Gui_CaveBot:+AlwaysOnTop
	}
RETURN
Create_GUI_Edit_ListView() {
GLOBAL
	Gui, Edit_ListView:New
	Gui, Edit_ListView:+AlwaysOnTop
	Gui, Edit_ListView:+LabelEdit_ListView_On
	Gui, Add, Text, section xm h20, Step: %Line_Selected%
	Gui, Add, Text, section xs h20, Action:
	Gui, Add, Text, xs h20, Delay:
	Gui, Add, Text, xs h20, Others:
	Gui, Add, Edit, section ys w280 h18 vEdit_Action, %Edit_Action%
	Gui, Add, Edit, section xs w280 h18 vEdit_Delay, %Edit_Delay%
	Gui, Add, Edit, section xs w280 h18 vEdit_Others, %Edit_Others%
	Gui, Add, Button, section xs gEdit_ListView_Ok_Button, OK
	Gui, Add, Button, ys gEdit_ListView_Cancel_Button, Cancel
	Gui, Show

}
Edit_ListView_Ok_Button:
	Gui, Edit_ListView:Submit, NoHide	;ALL GUI CONTROL GET
	Gui, Edit_ListView:Destroy
	Gui, Gui_CaveBot:Default
	Gui, Gui_CaveBot:+AlwaysOnTop
	Gui, ListView, ListView_Walker
	LV_Modify(Line_Selected, "Col2", Edit_Action)
	LV_Modify(Line_Selected, "Col3", Edit_Delay)
	LV_Modify(Line_Selected, "Col4", Edit_Others)
RETURN
Edit_ListView_Cancel_Button:
Edit_ListView_OnClose:
	Gui, Gui_CaveBot:+AlwaysOnTop
	Gui, Edit_ListView:Destroy
RETURN

ALL_LIST_GUI_Walker:
	Gui, Gui_CaveBot:Default
	pontovirgula := ";"
	ControlGet, Listx, List, , SysListView321, %TrayName%
	StringReplace,listx,listx,`t,%pontovirgula%,all
	ClipBoard := Listx
	msgbox % Listx
RETURN

Save_Conf_Walker_GUI:
	Gui, Gui_CaveBot:Default
	Gui, ListView, ListView_Walker
	Minimize_All_AutoHotkeyGUI()
	FileCreateDir, %A_WorkingDir%\Configs\CaveBot
	FileSelectFile, OutputVar, S8, %A_WorkingDir%\Configs\CaveBot, Save Configs CaveBot
	if (OutputVar != "") {
		NameExtension := SubStr(OutputVar, -3 , 4)
		if (NameExtension != ".ini"){
			FileName_CaveBot_Conf := OutputVar ".ini"
		} Else {
			FileName_CaveBot_Conf := OutputVar
		}
		if(FileExist(FileName_CaveBot_Conf)){
			FileDelete, % FileName_CaveBot_Conf
		}
		i := 0
		Loop, % LV_GetCount() {
			i++
			;Save Step
			LV_GetText(Save_Step,i,1)	;pega o texto da linha 1, coluna 1 (Step)
			IniWrite, %Save_Step%, %FileName_CaveBot_Conf%, Step, Step%i%

			;Save Action
			LV_GetText(Save_Action,i,2)	;pega o texto da linha 1, coluna 2 (Action)
			IniWrite, %Save_Action%, %FileName_CaveBot_Conf%, Action, Action%i%

			;Save Delay
			LV_GetText(Save_Delay,i,3)	;pega o texto da linha 1, coluna 3 (Delay)
			IniWrite, %Save_Delay%, %FileName_CaveBot_Conf%, Delay, Delay%i%

			;Save IgnoreMonster
			LV_GetText(Save_IgnoreMonster,i,4)	;pega o texto da linha 1, coluna 4 (IgnoreMonster)
			IniWrite, %Save_IgnoreMonster%, %FileName_CaveBot_Conf%, IgnoreMonster, IgnoreMonster%i%
		}
		;~ MsgBox, 4160, CaveBot, % "Configs Saved."
	}
	Gui, Show
RETURN

Load_Conf_Walker_GUI:
	Gui, Gui_CaveBot:Default
	Gui, ListView, ListView_Walker
	Minimize_All_AutoHotkeyGUI()
	FileCreateDir, %A_WorkingDir%\Configs\CaveBot
	FileSelectFile, OutputVar, S8, %A_WorkingDir%\Configs\CaveBot, Load Configs CaveBot
	if (OutputVar != "") {
		i:=0
		Loop, {
			i++
			IniRead, Step%i%, %OutputVar%, Step, Step%i%
			IniRead, Action%i%, %OutputVar%, Action, Action%i%
			IniRead, Delay%i%, %OutputVar%, Delay, Delay%i%
			IniRead, IgnoreMonster%i%, %OutputVar%, IgnoreMonster, IgnoreMonster%i%
			if Step%i% is not number
				BREAK
			LV_Add("", Step%i%, Action%i%, Delay%i%, IgnoreMonster%i%)
		}
		Step := i - 1
		;~ MsgBox, 4160, CaveBot, % "Load Sucess."
	}
	Gui, Show
RETURN

Reset_Conf_Walker_GUI:
	Gui, Gui_CaveBot:Default
	Gui, ListView, ListView_Walker
	LV_Delete()	;delete all row on list
	Step := 0
RETURN

Change_GUI_CaveBot:
	Change_GUI_CaveBot()
RETURN

Change_GUI_CaveBot() {
GLOBAL
	Gui, Gui_CaveBot:Default
	Gui Submit, NoHide	;ALL GUI CONTROL GET
	if (true) {	;HIDE ALL GUI
		;ClickMAP
		GuiControl, Hide, GroupBox_ClickMap
		;~ GuiControl, Hide, Text_IgnoreMonster_ClickMap
		;~ GuiControl, Hide, DropDownList_IgnoreTargeting_Walker
		i := 0
		Loop, 20 {
			i++
			GuiControl, Hide, % RMark%i%
			GuiControl, Hide, PictureMark%i%
		}

		;PRESS HOTKEY
		GuiControl, Hide, GroupBox_PressHotkey
		GuiControl, Hide, Text_PressHotkey
		GuiControl, Hide, Hotkey_Walker_PressHotkey

		;Click On Coordinate
		GuiControl, Hide, GroupBox_ClickOnCoord
		GuiControl, Hide, Text_ClickOnCoord
		GuiControl, Hide, Button_ClickOnCoord
		GuiControl, Hide, Edit_ClickOnCoord_X
		GuiControl, Hide, Text_ClickOnCoord_X
		GuiControl, Hide, Edit_ClickOnCoord_Y
		GuiControl, Hide, Text_ClickOnCoord_Y
		GuiControl, Hide, Text_ClickOnCoord_MouseType
		GuiControl, Hide, DropDownList_ClickOnCoord_MouseType

		;if Cap
		GuiControl, Hide, GroupBox_ifCap
		GuiControl, Hide, Text_ifCap
		GuiControl, Hide, Text2_ifCap
		GuiControl, Hide, Edit_ifCap
		GuiControl, Hide, Edit2_ifCap
		GuiControl, Hide, Text3_ifCap
		GuiControl, Hide, BP_Imbuiment_ifCap
	}
	if (DropDownList_Action == "Click Map") {
		GuiControl, Show, GroupBox_ClickMap
		;~ GuiControl, Show, Text_IgnoreMonster_ClickMap
		;~ GuiControl, Show, DropDownList_IgnoreTargeting_Walker
		i := 0
		Loop, 20 {
			i++
			GuiControl, Show, % RMark%i%
			GuiControl, Show, PictureMark%i%
		}
	}
	if (DropDownList_Action == "Press Hotkey") {
		GuiControl, Show, GroupBox_PressHotkey
		GuiControl, Show, Text_PressHotkey
		GuiControl, Show, Hotkey_Walker_PressHotkey
	}
	if (DropDownList_Action == "Click On Coordinate") {
		GuiControl, Show, GroupBox_ClickOnCoord
		GuiControl, Show, Text_ClickOnCoord
		GuiControl, Show, Button_ClickOnCoord

		GuiControl, Show, Edit_ClickOnCoord_X
		GuiControl, Show, Text_ClickOnCoord_X
		GuiControl, Show, Edit_ClickOnCoord_Y
		GuiControl, Show, Text_ClickOnCoord_Y

		GuiControl, Show, Text_ClickOnCoord_MouseType
		GuiControl, Show, DropDownList_ClickOnCoord_MouseType
	}
	if (DropDownList_Action == "if Cap") {
		GuiControl, Show, GroupBox_ifCap
		GuiControl, Show, Text_ifCap
		GuiControl, Show, Text2_ifCap
		GuiControl, Show, Edit_ifCap
		GuiControl, Show, Edit2_ifCap
		GuiControl, Show, Text3_ifCap
		GuiControl, Show, BP_Imbuiment_ifCap
	}

}

Button_ClickOnCoord_GetCoord:
	Minimize_All_AutoHotkeyGUI()
	Gui, Gui_CaveBot:Default
	MsgBox, 64, Select Coordinates, [PT-BR] Clique com o botao ESQUERDO do mouse para capturar a coordenada. `n`n[EN] LEFT-click to get coordinate.
	Get_Coordinates_Script("Edit_ClickOnCoord_X","Edit_ClickOnCoord_Y")
	Gui Submit, NoHide	;ALL GUI CONTROL GET
RETURN

; ===============================================================================================================================
; ==================================================================================================================================
; Sets the colors for selected rows in a ListView.
; Parameters:
;     HLV      -  handle (HWND) of the ListView control.
;     BkgClr   -  background color as RGB integer value (0xRRGGBB).
;                 If omitted or empty the ListViews's background color will be used.
;     TxtClr   -  text color as RGB integer value (0xRRGGBB).
;                 If omitted or empty the ListView's text color will be used.
;                 If both BkgColor and TxtColor are omitted or empty the control will be reset to use the default colors.
;     Dummy    -  must be omitted or empty!!!
; Return value:
;     No return value.
; Remarks:
;     The function adds a handler for WM_NOTIFY messages to the chain of existing handlers.
; ==================================================================================================================================
LV_SetSelColors(HLV, BkgClr := "", TxtClr := "", Dummy := "") {
   Static OffCode := A_PtrSize * 2              ; offset of code        (NMHDR)
        , OffStage := A_PtrSize * 3             ; offset of dwDrawStage (NMCUSTOMDRAW)
        , OffItem := (A_PtrSize * 5) + 16       ; offset of dwItemSpec  (NMCUSTOMDRAW)
        , OffItemState := OffItem + A_PtrSize   ; offset of uItemState  (NMCUSTOMDRAW)
        , OffClrText := (A_PtrSize * 8) + 16    ; offset of clrText     (NMLVCUSTOMDRAW)
        , OffClrTextBk := OffClrText + 4        ; offset of clrTextBk   (NMLVCUSTOMDRAW)
        , Controls := {}
        , MsgFunc := Func("LV_SetSelColors")
        , IsActive := False
   Local Item, H, LV, Stage
   If (Dummy = "") { ; user call ------------------------------------------------------------------------------------------------------
      If (BkgClr = "") && (TxtClr = "")
         Controls.Delete(HLV)
      Else {
         If (BkgClr <> "")
            Controls[HLV, "B"] := ((BkgClr & 0xFF0000) >> 16) | (BkgClr & 0x00FF00) | ((BkgClr & 0x0000FF) << 16) ; RGB -> BGR
         If (TxtClr <> "")
            Controls[HLV, "T"] := ((TxtClr & 0xFF0000) >> 16) | (TxtClr & 0x00FF00) | ((TxtClr & 0x0000FF) << 16) ; RGB -> BGR
      }
      If (Controls.MaxIndex() = "") {
         If (IsActive) {
            OnMessage(0x004E, MsgFunc, 0)
            IsActive := False
      }  }
      Else If !(IsActive) {
         OnMessage(0x004E, MsgFunc)
         IsActive := True
   }  }
   Else { ; system call ------------------------------------------------------------------------------------------------------------
      ; HLV : wParam, BkgClr : lParam, TxtClr : uMsg, Dummy : hWnd
      H := NumGet(BkgClr + 0, "UPtr")
      If (LV := Controls[H]) && (NumGet(BkgClr + OffCode, "Int") = -12) { ; NM_CUSTOMDRAW
         Stage := NumGet(BkgClr + OffStage, "UInt")
         If (Stage = 0x00010001) { ; CDDS_ITEMPREPAINT
            Item := NumGet(BkgClr + OffItem, "UPtr")
            If DllCall("SendMessage", "Ptr", H, "UInt", 0x102C, "Ptr", Item, "Ptr", 0x0002, "UInt") { ; LVM_GETITEMSTATE, LVIS_SELECTED
               ; The trick: remove the CDIS_SELECTED (0x0001) and CDIS_FOCUS (0x0010) states from uItemState and set the colors.
               NumPut(NumGet(BkgClr + OffItemState, "UInt") & ~0x0011, BkgClr + OffItemState, "UInt")
               If (LV.B <> "")
                  NumPut(LV.B, BkgClr + OffClrTextBk, "UInt")
               If (LV.T <> "")
                  NumPut(LV.T, BkgClr + OffClrText, "UInt")
               Return 0x02 ; CDRF_NEWFONT
         }  }
         Else If (Stage = 0x00000001) ; CDDS_PREPAINT
            Return 0x20 ; CDRF_NOTIFYITEMDRAW
         Return 0x00 ; CDRF_DODEFAULT
}  }  }


