; ============================================== [ Hotkeys ] ==============================================
; ============================================== [ Hotkeys ] ==============================================
; ============================================== [ Hotkeys ] ==============================================
Attack_Rune:
	if (Have_HMM == true) {
		Use_Item_On(state:="CrossHair", PosX:=HMM.2, PosY:=HMM.3)
	}
RETURN

GetPictureHMM:
	Hide_All_GUI(state:="Hide")
	MsgBox, [BR] Use as setas do teclado para aumentar e diminuir o tamanho da captura de imagem. `n`n[EN] Use the arrow keys to increase and decrease the image capture size.
	take_screenshot("HMM", 18, 18)
RETURN