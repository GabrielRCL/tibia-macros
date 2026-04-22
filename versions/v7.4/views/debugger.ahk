; ============================================== [ Debugger ] ==============================================
; ============================================== [ Debugger ] ==============================================
; ============================================== [ Debugger ] ==============================================
DrawGuiDebugger() {
    GLOBAL
	Gui, Font, Bold
	Gui, Add, Text, SECTION x5 y8 w80 h20, Name Client =
	
	Gui, Font, cRed
	Gui, Add, Edit, xs+85 ys-2 w150 h20 vNameClient, Tibia Client Name
	Gui, Font, cWhite
	
	Gui, Font, Normal
	Gui, Add, Button, x220 y483 w60 h15 gDebugger, Debugger
	Gui, Add, CheckBox, x5 y480 w130 h20 vCheckBox_HUD_ScreenBox Checked, Show HUD ScreenBox
}