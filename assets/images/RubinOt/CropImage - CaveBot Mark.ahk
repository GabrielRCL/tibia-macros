#SingleInstance, Ignore ; Allow only one running instance of script
;~ #Warn
; [ LIBRARY ]
#Include <GDIP64>

k:=100
Image_File := "All_Mark.png"
Gdip_Token := Gdip_Startup()
Gdip_Haystack := Gdip_createBitmapFromFile(Image_File)
Gdip_GetImageDimensions(Gdip_Haystack, Haystack_Width, Haystack_Height)


; CROP IMAGE EIXO X
i:=0
Loop, 10 {
	Gdip_Haystack_Cropped := Gdip_CloneBitmapArea(Gdip_Haystack, 4+(21*i),4,7,7)
	Gdip_SaveBitmapToFile(Gdip_Haystack_Cropped, "RubinOT-Mark" i+1 ".png")
	i++
}

; CROP IMAGE EIXO Y
i:=0
Loop, 10 {
	Gdip_Haystack_Cropped := Gdip_CloneBitmapArea(Gdip_Haystack, 4+(21*i),25,7,7)
	Gdip_SaveBitmapToFile(Gdip_Haystack_Cropped, "RubinOT-Mark" i+11 ".png")
	i++
}




Gdip_DisposeImage(Gdip_Haystack)
Gdip_DisposeImage(Gdip_Haystack_Cropped)
Gdip_Shutdown(Gdip_Token)
MSGBOX, Done!

