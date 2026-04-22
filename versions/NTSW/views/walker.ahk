
Minimize_All_AutoHotkeyGUI() {
	Loop, 9 {
		WinMinimize, ahk_class AutoHotkeyGUI
	}
}

Get_Coordinates_Script(cordx, cordy) {
GLOBAL
WinActivate, ahk_id %active_id%
	Loop, {
		ToolTip, Click to get coordinates...
		if ( GetKeyState("LButton") ) {

			MouseGetPos, MouseX, MouseY
			GuiControl,, %cordx%, %MouseX%
			GuiControl,, %cordy%, %MouseY%

			ToolTip, Coordenada Configurada!
			SetTimer, RemoveToolTip, 1000
			Gui, Show
			BREAK
		}
	}

}

RemoveToolTip:
	ToolTip
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
		case "Training Control":  LV_Add("", Step, "Training Control", DropDownList_Sleep_Walker)
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