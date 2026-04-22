
Draw_Gui_HealFriend() {
    GLOBAL

	Load_Pre_Settings("HealFriend")
	Gui, Add, Tab, section x1 y1 w581 h421 , Heal Friend|Adv. Options

	Gui, Tab, Heal Friend
	; === VERIFY PLAYER ON SCREEN BUTTON ===
		Gui, Add, CheckBox, x15 y397 w180 h20 vAutoFollowFriend, AutoFollow Friend

	; [Heal Friend] Tab ====================================================================
	; [Heal Friend] Tab ====================================================================
	; [Heal Friend] Tab ====================================================================
	if (Vocation == "Druid") {
		; ===== [First Player] Exura Sio =====

		Gui, Add, GroupBox, x5 y29 w520 h140 , FIRST Player On Party List	;[EK] Heal Friend

	Gui, Add, Text, x267 y44 w155 h20 +Center vEKOldSioTextCoordinates, Coordinates ;OLD SIO Text
		GuiControl, Hide, EKOldSioTextCoordinates ;Hide Old Sio text "Coordinates"
	Gui, Add, Text, x266 y67 w20 h15 +Center vEKOldSioTextCoordinatesX, X =			;OLD SIO Text
		GuiControl, Hide, EKOldSioTextCoordinatesX ;Hide Old Sio text "X"
	Gui, Add, Text, x343 y67 w20 h15 +Center vEKOldSioTextCoordinatesY, Y =			;OLD SIO Text
		GuiControl, Hide, EKOldSioTextCoordinatesY ;Hide Old Sio text "X"

		Gui, Add, Text, x140 y44 w70 h20 +Center, Hotkey
		Gui, Add, Text, x262 y39 w155 h20 +Center vDefaultSioTextFriendHealth, Friend Health `%	;Default Sio Text
			Gui, Add, Picture, x12 y49 w32 h32 ,  % "HBITMAP:* " Picture.SioFriend
			Gui, Add, CheckBox, x47 y49 w65 h32 vEK_ExuraSio, Exura Sio
		Gui, Font, cBlack
			Gui, Add, Hotkey, x140 y65 w70 h20 vHotkey_EK_ExuraSio, ;%Hotkey_EK_ExuraSio%

			Gui, Add, Slider, x262 y60 w155 h30 vPercent_EK_ExuraSio gPercent_EK_ExuraSio +Range0-20 +TickInterval2 AltSubmit, ;%Percent_EK_ExuraSio%

	Gui, Font, cRed
	Gui, Add, Edit, x287 y65 w50 h20 r1 vEK_ExuraSioX, ;%EK_ExuraSioX%	;Old Sio Edit Coordinate X
		GuiControl, Hide, EK_ExuraSioX ;Hide Old Sio Edit Coordinate X
	Gui, Add, Edit, x364 y65 w50 h20 r1 vEK_ExuraSioY, ;%EK_ExuraSioY%	;Old Sio Edit Coordinate Y
		GuiControl, Hide, EK_ExuraSioY ;Hide Old Sio Edit Coordinate X
	Gui, Font, cWhite

	Gui, Add, Button, x427 y52 w75 h30 vSelectCoordinatesEK_ExuraSio gSelectCoordinatesEK_ExuraSio +Center, Select Coordinates	;Old Sio Button Select Coordinates
		GuiControl, Hide, SelectCoordinatesEK_ExuraSio ;Hide Old Sio Button Select Coordinates

		; ===== [First Player] Exura Gran Sio =====

		Gui, Add, Text, x140 y104 w70 h20 +Center, Hotkey
		Gui, Add, Text, x262 y99 w155 h20 +Center, Friend Health `%

	Gui, Add, Text, x267 y101 w155 h20 +Center vEKOldGranSioTextCoordinates, Coordinates
		GuiControl, Hide, EKOldGranSioTextCoordinates ;Hide Old Gran Sio text "Coordinates"
	Gui, Add, Text, x267 y127 w20 h15 +Center vEKOldGranSioTextCoordinatesX, X =
		GuiControl, Hide, EKOldGranSioTextCoordinatesX ;Hide Old Gran Sio text "X"
	Gui, Add, Text, x351 y127 w20 h15 +Center vEKOldGranSioTextCoordinatesY, Y =
		GuiControl, Hide, EKOldGranSioTextCoordinatesY ;Hide Old Gran Sio text "Y"

			Gui, Add, Picture, x12 y109 w32 h32 , % "HBITMAP:* " Picture.Nature_Embrace
			Gui, Add, CheckBox, x47 y109 w65 h32 vEK_ExuraGranSio, Exura Gran Sio
		Gui, Font, cBlack
			Gui, Add, Hotkey, x140 y125 w70 h20 vHotkey_EK_ExuraGranSio, ;%Hotkey_EK_ExuraGranSio%

			Gui, Add, Slider, x262 y120 w155 h30 vPercent_EK_ExuraGranSio gPercent_EK_ExuraGranSio +Range0-20 +TickInterval2 AltSubmit, ;%Percent_EK_ExuraGranSio%

		Gui, Font, cRed
	Gui, Add, Edit, x288 y125 w50 h20 vEK_ExuraGranSioX, ;%EK_ExuraGranSioX%
		GuiControl, Hide, EK_ExuraGranSioX ;Hide Old Sio Edit Coordinate X
	Gui, Add, Edit, x372 y125 w50 h20 vEK_ExuraGranSioY, ;%EK_ExuraGranSioY%
		GuiControl, Hide, EK_ExuraGranSioY ;Hide Old Sio Edit Coordinate X
		Gui, Font, cWhite
	Gui, Add, Button, x427 y109 w75 h30 vSelectCoordinatesEK_ExuraGranSio gSelectCoordinatesEK_ExuraGranSio +Center, Select Coordinates
		GuiControl, Hide, SelectCoordinatesEK_ExuraGranSio ;Hide Old Sio Edit Coordinate X

		; ===== [Second Player] Exura Sio =====

		Gui, Add, GroupBox, x5 y179 w520 h140 , SECOND Player On Party List ;[RP] Heal Friend
		Gui, Add, Text, x140 y194 w70 h20 +Center, Hotkey
		Gui, Add, Text, x262 y189 w155 h20 +Center vEK_FriendHealthPercent, Friend Health `%

	Gui, Add, Text, x262 y189 w155 h20 +Center vRPOldSioTextCoordinates, Coordinates	;RP OLD SIO TEXT
		GuiControl, Hide, RPOldSioTextCoordinates ;Hide Old Sio text "Coordinates"
	Gui, Add, Text, x267 y212 w20 h15 +Center vRPOldSioTextCoordinatesX, X =			;RP OLD SIO TEXT
		GuiControl, Hide, RPOldSioTextCoordinatesX ;Hide Old Sio text "Coordinates"
	Gui, Add, Text, x346 y212 w20 h15 +Center vRPOldSioTextCoordinatesY, Y =			;RP OLD SIO TEXT
		GuiControl, Hide, RPOldSioTextCoordinatesY ;Hide Old Sio text "Coordinates"

			Gui, Add, Picture, x12 y199 w32 h32 , % "HBITMAP:* " Picture.SioFriend
			Gui, Add, CheckBox, x47 y199 w65 h32 vRP_ExuraSio, Exura Sio
		Gui, Font, cBlack
			Gui, Add, Hotkey, x140 y215 w70 h20 vHotkey_RP_ExuraSio, ;%Hotkey_RP_ExuraSio%

			Gui, Add, Slider, x262 y210 w155 h30 vPercent_RP_ExuraSio gPercent_RP_ExuraSio +Range0-20 +TickInterval2 AltSubmit, ;%Percent_RP_ExuraSio%

		Gui, Font, cRed
	Gui, Add, Edit, x288 y210 w50 h20 r1 vRP_ExuraSioX, ;%RP_ExuraSioX%	;OLD EXURA SIO RP
		GuiControl, Hide, RP_ExuraSioX ;Hide Old Sio Edit Coordinate X
	Gui, Add, Edit, x367 y210 w50 h20 r1 vRP_ExuraSioY, ;%RP_ExuraSioY%	;OLD EXURA SIO RP
		GuiControl, Hide, RP_ExuraSioY ;Hide Old Sio Edit Coordinate X
		Gui, Font, cWhite
	Gui, Add, Button, x422 y196 w75 h30 vSelectCoordinatesRP_ExuraSio gSelectCoordinatesRP_ExuraSio +Center, Select Coordinates	;OLD EXURA SIO RP
		GuiControl, Hide, SelectCoordinatesRP_ExuraSio ;Hide Old Sio Edit Coordinate X

		; ===== [Second Player] Exura Gran Sio =====

		Gui, Add, Text, x140 y254 w70 h20 +Center, Hotkey
		Gui, Add, Text, x262 y249 w155 h20 +Center, Friend Health `%

	Gui, Add, Text, x262 y249 w155 h20 +Center vRPOldGranSioTextCoordinates, Coordinates
		GuiControl, Hide, RPOldGranSioTextCoordinates ;Hide Old Sio text "Coordinates"
	Gui, Add, Text, x267 y273 w20 h15 +Center vRPOldGranSioTextCoordinatesX , X =
		GuiControl, Hide, RPOldGranSioTextCoordinatesX ;Hide Old Sio text "Coordinates"
	Gui, Add, Text, x346 y273 w20 h15 +Center vRPOldGranSioTextCoordinatesY , Y =
		GuiControl, Hide, RPOldGranSioTextCoordinatesY ;Hide Old Sio text "Coordinates"


			Gui, Add, Picture, x12 y259 w32 h32 , % "HBITMAP:* " Picture.Nature_Embrace
			Gui, Add, CheckBox, x47 y259 w65 h32 vRP_ExuraGranSio, Exura Gran Sio
		Gui, Font, cBlack
			Gui, Add, Hotkey, x140 y275 w70 h20 vHotkey_RP_ExuraGranSio, ;%Hotkey_RP_ExuraGranSio%

			Gui, Add, Slider, x262 y270 w155 h30 vPercent_RP_ExuraGranSio gPercent_RP_ExuraGranSio +Range0-20 +TickInterval2 AltSubmit, ;%Percent_RP_ExuraGranSio%

		Gui, Font, cRed
	Gui, Add, Edit, x288 y270 w50 h20 vRP_ExuraGranSioX, ;%RP_ExuraGranSioX%
			GuiControl, Hide, RP_ExuraGranSioX ;Hide Old Sio text "Coordinates"
	Gui, Add, Edit, x367 y270 w50 h20 vRP_ExuraGranSioY, ;%RP_ExuraGranSioY%
			GuiControl, Hide, RP_ExuraGranSioY ;Hide Old Sio text "Coordinates"
		Gui, Font, cWhite
	Gui, Add, Button, x422 y256 w75 h30 vSelectCoordinatesRP_ExuraGranSio gSelectCoordinatesRP_ExuraGranSio +Center, Select Coordinates
			GuiControl, Hide, SelectCoordinatesRP_ExuraGranSio ;Hide Old Sio text "Coordinates"


		; ===== [MAS HEALING] EXURA GRAN MAS RES =====

		Gui, Add, GroupBox, x5 y324 w520 h70 , Mass Healing
		Gui, Add, Text, x140 y339 w70 h20 +Center, Hotkey
		Gui, Add, Text, x262 y336 w155 h20 +Center, Your Health `% to Healing
			Gui, Add, Picture, x12 y344 w32 h32 , % "HBITMAP:* " Picture.Mass_Healing
			Gui, Add, CheckBox, x47 y344 w65 h32 vMasRes, Mas Res
		Gui, Font, cBlack
			Gui, Add, Hotkey, x140 y360 w70 h20 vHotkey_MasRes, ;%Hotkey_MasRes%
			Gui, Add, Slider, x262 y355 w155 h30 vPercent_MasRes_Stage1 gPercent_MasRes_Stage1 +Range0-20 +TickInterval2 AltSubmit, ;%Percent_MasRes_Stage1%
		Gui, Font, cWhite

		; ===== [CHANGE SIO] Default And Old =====
	;~ Gui, Add, Button, x215 y397 w70 h20 vActiveDefaultSio gActiveOldSio, Default Sio
	;~ GuiControl, Hide, ActiveDefaultSio
		;~ Gui, Add, Button, x215 y397 w70 h20 vActiveOldSio gActiveOldSio, Old Sio
	}

	if (Vocation != "Druid") {
		; ===== [EK] Exura Sio =====

		Gui, Add, GroupBox, x5 y29 w520 h140 , FIRST Player On Party List ;[EK] UH Friend

	Gui, Add, Text, x267 y44 w155 h20 +Center vEKOldSioTextCoordinates, Coordinates ;OLD SIO Text
		GuiControl, Hide, EKOldSioTextCoordinates ;Hide Old Sio text "Coordinates"
	Gui, Add, Text, x266 y67 w20 h15 +Center vEKOldSioTextCoordinatesX, X =			;OLD SIO Text
		GuiControl, Hide, EKOldSioTextCoordinatesX ;Hide Old Sio text "X"
	Gui, Add, Text, x343 y67 w20 h15 +Center vEKOldSioTextCoordinatesY, Y =			;OLD SIO Text
		GuiControl, Hide, EKOldSioTextCoordinatesY ;Hide Old Sio text "X"

		Gui, Add, Text, x140 y44 w70 h20 +Center, Hotkey
		Gui, Add, Text, x262 y39 w155 h20 +Center vDefaultSioTextFriendHealth, Friend Health `%
			Gui, Add, Picture, x12 y49 w32 h32 , % "HBITMAP:* " Picture.Ultimate_Healing_Rune
			Gui, Add, CheckBox, x47 y49 w65 h32 vEK_ExuraSio, UH Rune
		Gui, Font, cBlack
			Gui, Add, Hotkey, x140 y65 w70 h20 vHotkey_EK_ExuraSio, ;%Hotkey_EK_ExuraSio%
		;Gui, Font, cRed
			Gui, Add, Slider, x262 y60 w155 h30 vPercent_EK_ExuraSio gPercent_EK_ExuraSio +Range0-20 +TickInterval2 AltSubmit, ;%Percent_EK_ExuraSio%

	Gui, Font, cRed
	Gui, Add, Edit, x287 y65 w50 h20 r1 vEK_ExuraSioX, ;%EK_ExuraSioX%	;Old Sio Edit Coordinate X
		GuiControl, Hide, EK_ExuraSioX ;Hide Old Sio Edit Coordinate X
	Gui, Add, Edit, x364 y65 w50 h20 r1 vEK_ExuraSioY, ;%EK_ExuraSioY%	;Old Sio Edit Coordinate Y
		GuiControl, Hide, EK_ExuraSioY ;Hide Old Sio Edit Coordinate X
	Gui, Font, cWhite

	Gui, Add, Button, x427 y52 w75 h30 vSelectCoordinatesEK_ExuraSio gSelectCoordinatesEK_ExuraSio +Center, Select Coordinates	;Old Sio Button Select Coordinates
		GuiControl, Hide, SelectCoordinatesEK_ExuraSio ;Hide Old Sio Button Select Coordinates


		; ===== [RP] Exura Sio =====

		Gui, Add, GroupBox, x5 y179 w520 h140 , SECOND Player On Party List ;[RP] Sio Friend
		Gui, Add, Text, x140 y194 w70 h20 +Center, Hotkey
		Gui, Add, Text, x262 y189 w155 h20 +Center vEK_FriendHealthPercent, Friend Health `%

	Gui, Add, Text, x262 y189 w155 h20 +Center vRPOldSioTextCoordinates, Coordinates	;RP OLD SIO TEXT
		GuiControl, Hide, RPOldSioTextCoordinates ;Hide Old Sio text "Coordinates"
	Gui, Add, Text, x267 y212 w20 h15 +Center vRPOldSioTextCoordinatesX, X =			;RP OLD SIO TEXT
		GuiControl, Hide, RPOldSioTextCoordinatesX ;Hide Old Sio text "Coordinates"
	Gui, Add, Text, x346 y212 w20 h15 +Center vRPOldSioTextCoordinatesY, Y =			;RP OLD SIO TEXT
		GuiControl, Hide, RPOldSioTextCoordinatesY ;Hide Old Sio text "Coordinates"

			Gui, Add, Picture, x12 y199 w32 h32 , % "HBITMAP:* " Picture.Ultimate_Healing_Rune
			Gui, Add, CheckBox, x47 y199 w65 h32 vRP_ExuraSio, UH Rune
		Gui, Font, cBlack
			Gui, Add, Hotkey, x140 y215 w70 h20 vHotkey_RP_ExuraSio, ;%Hotkey_RP_ExuraSio%

			Gui, Add, Slider, x262 y210 w155 h30 vPercent_RP_ExuraSio gPercent_RP_ExuraSio +Range0-20 +TickInterval2 AltSubmit, ;%Percent_RP_ExuraSio%

		Gui, Font, cRed
	Gui, Add, Edit, x288 y210 w50 h20 r1 vRP_ExuraSioX, ;%RP_ExuraSioX%	;OLD EXURA SIO RP
		GuiControl, Hide, RP_ExuraSioX ;Hide Old Sio Edit Coordinate X
	Gui, Add, Edit, x367 y210 w50 h20 r1 vRP_ExuraSioY, ;%RP_ExuraSioY%	;OLD EXURA SIO RP
		GuiControl, Hide, RP_ExuraSioY ;Hide Old Sio Edit Coordinate X
		Gui, Font, cWhite
	Gui, Add, Button, x422 y196 w75 h30 vSelectCoordinatesRP_ExuraSio gSelectCoordinatesRP_ExuraSio +Center, Select Coordinates	;OLD EXURA SIO RP
		GuiControl, Hide, SelectCoordinatesRP_ExuraSio ;Hide Old Sio Edit Coordinate X


		; ===== [CHANGE SIO] Default And Old =====
	;~ Gui, Add, Button, x215 y397 w70 h20 vActiveDefaultSio gActiveOldSio, Default Sio
	;~ GuiControl, Hide, ActiveDefaultSio
		;~ Gui, Add, Button, x215 y397 w70 h20 vActiveOldSio gActiveOldSio, Old Sio

	}


	Gui, Tab, Adv. Options
	Portugues := "Inverter Prioridade (Second Player > First Player)"
	English := "Invert Priority (Second Player > First Player)"
	Gui, Add, CheckBox, x10 y27 w250 h20 vcheckBox_Inverter_Prioridade_HealFriend, % %GlobalLanguage%
}


Draw_Gui_HealFriend:
	Gui, HealFriend:Show, % " w" 581 " h" 421, [Heal Friend] %TrayName%	;NAME PROGRAMA
RETURN




Percent_EK_ExuraSio:
	Gui, HealFriend:Default
	GuiControlGet, Percent_EK_ExuraSio
	intPercent_EK_ExuraSio := Percent_EK_ExuraSio*5
	Slider_ToolTip_HealFriend(intPercent_EK_ExuraSio, Percent_EK_ExuraSio)
return
Percent_EK_ExuraGranSio:
	Gui, HealFriend:Default
	GuiControlGet, Percent_EK_ExuraGranSio
	intPercent_EK_ExuraGranSio := Percent_EK_ExuraGranSio*5
	Slider_ToolTip_HealFriend(intPercent_EK_ExuraGranSio, Percent_EK_ExuraGranSio)
return

Percent_RP_ExuraSio:
	Gui, HealFriend:Default
	GuiControlGet, Percent_RP_ExuraSio
	intPercent_RP_ExuraSio := Percent_RP_ExuraSio*5
	Slider_ToolTip_HealFriend(intPercent_RP_ExuraSio, Percent_RP_ExuraSio)
return
Percent_RP_ExuraGranSio:
	Gui, HealFriend:Default
	GuiControlGet, Percent_RP_ExuraGranSio
	intPercent_RP_ExuraGranSio := Percent_RP_ExuraGranSio*5
	Slider_ToolTip_HealFriend(intPercent_RP_ExuraGranSio, Percent_RP_ExuraGranSio)
return

Percent_MasRes_Stage1:
	Gui, HealFriend:Default
	GuiControlGet, Percent_MasRes_Stage1
	intPercent_MasRes_Stage1 := Percent_MasRes_Stage1*5
    Slider_ToolTip_Percent_Stage(intPercent_MasRes_Stage1, Percent_MasRes_Stage1)	;not heal friend
return



SelectCoordinatesEK_ExuraSio:
	Minimize_All_AutoHotkeyGUI()
	MsgBox, 64, Select Coordinates, OBS: PARA CONFIGURAR O EK PRECISA ESTAR COM A VIDA FULL `n`nClique com o botao ESQUERDO do mouse em cima da `% de HP do EK que voce deseja healar.
	Create_GUI_Show_Color()
	Gui, HealFriend:Default
	;~ Get_Coordinates_Heal_Friend_Script("EK_ExuraSioX", "EK_ExuraSioY")
return
SelectCoordinatesEK_ExuraGranSio:
	Minimize_All_AutoHotkeyGUI()
	MsgBox, 64, Select Coordinates, OBS: PARA CONFIGURAR O EK PRECISA ESTAR COM A VIDA FULL `n`nClique com o botao ESQUERDO do mouse em cima da `% de HP do EK que voce deseja healar.
	Create_GUI_Show_Color()
	Gui, HealFriend:Default
	;~ Get_Coordinates_Heal_Friend_Script("EK_ExuraGranSioX", "EK_ExuraGranSioY")
return

SelectCoordinatesRP_ExuraSio:
	Minimize_All_AutoHotkeyGUI()
	MsgBox, 64, Select Coordinates, OBS: PARA CONFIGURAR O RP PRECISA ESTAR COM A VIDA FULL `n`nClique com o botao ESQUERDO do mouse em cima da `% de HP do RP que voce deseja healar.
	Create_GUI_Show_Color()
	Gui, HealFriend:Default
	;~ Get_Coordinates_Heal_Friend_Script("RP_ExuraSioX", "RP_ExuraSioY")
return
SelectCoordinatesRP_ExuraGranSio:
	Minimize_All_AutoHotkeyGUI()
	MsgBox, 64, Select Coordinates, OBS: PARA CONFIGURAR O EK PRECISA ESTAR COM A VIDA FULL `n`nClique com o botao ESQUERDO do mouse em cima da `% de HP do RP que voce deseja healar.
	Create_GUI_Show_Color()
	Gui, HealFriend:Default
	;~ Get_Coordinates_Heal_Friend_Script("RP_ExuraGranSioX", "RP_ExuraGranSioY")
return


Create_GUI_Show_Color() {
GLOBAL
	Gui, Show_Color:New
	Gui, Show_Color:+AlwaysOnTop
	Gui, Show_Color:Show, % " w" 270 " h" 270, VERIFIQUE A COR
	WinActivate, ahk_id %active_id%	;fix bug on win7
}


; [ToolTip's]==============================================================================
Slider_ToolTip_Percent_Stage(intPercent_Stage, Percent_Stage) {
    Global
	Gui,Submit,NoHide
    intPercent_Stage := Percent_Stage*5
    tooltip % intPercent_Stage "%"
    SetTimer, RemoveToolTip, -500

}

;[Sio Friend]
Slider_ToolTip_HealFriend(intPercent_Stage, Percent_Stage) {
    Global

	Gui,Submit,NoHide
	intPercent_Stage := Round(Percent_Stage*6.45) + 0 ;number of pixel 5% life change in party list
	ToolTipPercent := Percent_Stage * 5 ;only show % in GUI
    tooltip % ToolTipPercent "%"
    ;SetTimer, RemoveToolTip, 500
	Sleep 500
	ToolTip
}

RemoveToolTip:
	ToolTip
	ToolTip,,,, 2
	SetTimer, RemoveToolTip, OFF
RETURN