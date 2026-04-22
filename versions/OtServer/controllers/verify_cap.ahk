Verify_Cap(){
    GLOBAL
	;~ SearchPNG(PNG.CapText, WindowInfo.ClassNN.w/2, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, CapText, Mode:=1)
	;~ msgbox % "IMAGE SEARCH: " CapText.2 " , " CapText.3

	;verify imbuiment backpack
	if ( PixelSearch(Cords.Con.2+80,Cords.Con.3-12,20,7, colorRGB:="44AD25",variation:=0, outputvarX:="outputvarX", outputvarY:="outputvarY") == 0 ) {	;found
		Color := "Green"
	} else {
		Color := "Blank"
	}

	CapText := []
	CapText.2 := Cords.Con.2+83
	CapText.3 := Cords.Con.3-21
	OCR_Cap := ""
	j := 0
	Loop, 5 {
		Loop, 10 {
				Index := 10-A_Index
				SearchPNG(PNG.CapOCR[Color][Index], CapText.2+17-2, CapText.3+9, CapText.2+17+7+j, CapText.3+9+8, Tole:=75, FoundOCR, Mode:=1)
				if (Index == 9) {
					;~ bitmap_test := Gdip_BitmapFromHWND( WinExist(Name_Haystack), TibiaServer )
					;~ Gdip_SaveBitmapToFile(bitmap_test, A_WorkingDir "\tmp.png", 100)
					;~ crop(A_WorkingDir "\tmp.png", CapText.2+17+WindowInfo.ClassNN.x, CapText.3+9+WindowInfo.ClassNN.y, 7+j, 8)
					;~ Gdip_disposeImage(bitmap_test)
					;~ msgbox, foi
				}
				if (FoundOCR.1 == 1){
					OCR_Cap := Index OCR_Cap
					Break 1
				} else if (A_Index == 10 && j == 0) {
					CapText.2 += 3	;fix bug with hav 3 digits
					j := -1
				}
		}
		CapText.2 -= 7
		if (j < 2) {	;fix bug tamanho weight
			j++
		}
	}
	;~ TOOLTIP(OCR_Cap ".")

	;~ SearchPNG(PNG.ThereIsNoWay, 0, 0, WindowInfo.ClassNN.w, WindowInfo.ClassNN.h, Tole:=20, Erro, Mode:=1)
	;~ if (Erro.1 == 1) {
		;~ TOOLTIP("ECONTROU")
	;~ } else {
		;~ TOOLTIP("NOT FOUND")
	;~ }
}
