; ============================== [ Settings Function ] ==============================
;CreateGUI
take_screenshot(filename, width, height) {
GLOBAL
	MouseGetPos, StartX, StartY

	img_filename := filename
	img_width := width
	img_height := height

	Gui, screen_box: New
	Gui, screen_box: +alwaysontop -Caption +Border +ToolWindow +LastFound
	Gui, screen_box: Color, Red
	WinSet, Transparent, 80
	Gui, screen_box: Show, w%width% h%height% x%StartX% y%StartY% NoActivate , ScreenBoxID



	Hotkey, LButton, take_screen_shot, On
	SetTimer, move_box, 50
	WinActivate, ahk_id %active_id%

	Hotkey, Right, increase_width_move_box, ON
	Hotkey, Up, increase_height_move_box, ON
	Hotkey, Left, decrease_width_move_box, ON
	Hotkey, Down, decrease_height_move_box, ON
}

;MoveGUI with Mouse Position
move_box:
	Gui, screen_box: Default
	MouseGetPos, move_box_pos_X, move_box_pos_Y
	move_box_pos_X := move_box_pos_X - img_width/2-10
	move_box_pos_Y := move_box_pos_Y - img_height/2-10
	Gui, screen_box: Show, w%img_width% h%img_height% x%move_box_pos_X% y%move_box_pos_Y% NoActivate , ScreenBoxID
	;WinMove, ScreenBoxID,, %move_box_pos_X%, %move_box_pos_Y%
RETURN

Refresh_Gui_Move_Box() {
GLOBAL
	MouseGetPos, move_box_pos_X, move_box_pos_Y
	move_box_pos_X := move_box_pos_X - img_width/2-10
	move_box_pos_Y := move_box_pos_Y - img_height/2-10
	Gui, screen_box: Show, w%img_width% h%img_height% x%move_box_pos_X% y%move_box_pos_Y% NoActivate , ScreenBoxID
}

increase_width_move_box:
	img_width++
RETURN
increase_height_move_box:
	img_height++
RETURN
decrease_width_move_box:
	img_width--
RETURN
decrease_height_move_box:
	img_height--
RETURN


Save_Picture_TakeSS() {
GLOBAL
	SetTimer, move_box, OFF
	Hotkey, LButton, take_screen_shot, OFF
	Gui, screen_box: Hide

	outfile := img_filename
	;Gdip_take_ss := Gdip_BitmapFromScreen(take_ss_X "|" take_ss_Y "|" img_width "|" img_height)
	Gdip_take_ss := Gdip_BitmapFromHWND( WinExist(Name_Haystack), TibiaServer )	;gera o bitmap do OBS Studio
	;Gdip_GetImageDimensions(Gdip_take_ss, Crop_Image_Width, Crop_Image_Height)
	Gdip_SaveBitmapToFile(Gdip_take_ss, A_Temp "\tmp.png", 100)
	Gdip_disposeImage(Gdip_take_ss)

	Crop_Image_X := (move_box_pos_X/(A_ScreenDPI/96)) + 7	;Margem do GDIP X = 7	;FIX GDIP
	Crop_Image_Y := (move_box_pos_Y/(A_ScreenDPI/96)) + 8	;Margem do GDIP Y = 8	;FIX GDIP
	crop(A_Temp "\tmp.png", Crop_Image_X, Crop_Image_Y, img_width, img_height)

	Gui, screen_box: Color, Green
	Gui, screen_box: Show
	Sleep 250
	Gui, screen_box:Hide



	Gui, ShowImageGUI:New
	Gui, ShowImageGUI:Color, 390202
	Gui, ShowImageGUI:Font, cWhite
	Gui ShowImageGUI:+LabelShowImageGUI_On
	Gui, ShowImageGUI:Add, Text, x45 y5 w75 h20 +Center, ! ATTENTION !
	;HBITMAP_img := Gdip_CreateHBITMAPFromBitmap(Gdip_take_ss)
	;Gui, ShowImageGUI:Add, Picture, x73 y29 w30 h30, % "HBITMAP:*" HBITMAP_img	;OLD GDIP
	Gui, ShowImageGUI:Add, Picture, x73 y29 w%img_width% h%img_height%, % A_Temp "\tmp.png"

	Gui, ShowImageGUI:Add, Text, x22 y69 w140 h30 , [BR] A Imagem Está correta? `n[EN] The Image is Correct?
	Gui, ShowImageGUI:Add, Button, x22 y109 w50 h20 gShowImageYesButton, Yes
	Gui, ShowImageGUI:Add, Button, x102 y109 w50 h20 gShowImageNoButton, No
	Gui, ShowImageGUI:Show, h144 w177 CENTER, ATTENTION!
}
;Action (Click) Script
take_screen_shot:
	Save_Picture_TakeSS()
RETURN

ShowImageNoButton:
	Gui, ShowImageGUI:Destroy
	Gui, screen_box:Color, RED
	Gui, screen_box:Show

	WinActivate, ahk_id %active_id%
	Hotkey, LButton, take_screen_shot, ON
	SetTimer, move_box, 50
RETURN
ShowImageYesButton:
	Hotkey, Right, increase_width_move_box, OFF
	Hotkey, Up, increase_height_move_box, OFF
	Hotkey, Left, decrease_width_move_box, OFF
	Hotkey, Down, decrease_height_move_box, OFF
	Gui, ShowImageGUI:Destroy
	Gui, screen_box:Destroy

	Sleep 150

	FileDelete, %outfile%
	if (ErrorLevel != 0) { ;se falhar algum delete
		MsgBox,[BR] Não foi possivel excluir a imagem atual, tente novamente. `n[EN] ERROR on Delete Image, try again.
	}

	FileMove, % A_Temp "\tmp.png", %outfile%
	Refresh_Images_GUI()
RETURN
ShowImageGUI_OnClose:
	Gui, ShowImageGUI:Destroy
	Gui, screen_box:Destroy
RETURN

crop(FilePath, x, y, w, h) {
	static IP:=""
	img := ComObjCreate("WIA.ImageFile")
	img.LoadFile(FilePath)
	if (!IP) {
		IP:=ComObjCreate("WIA.ImageProcess")
		ip.Filters.Add(IP.FilterInfos("Crop").FilterID)
	}

	; x,y,r,b are the number of pixels to crop from each edge. They cannot be negative numbers.
	ip.filters[1].properties("Left") := x
	ip.filters[1].properties("Top") := y
	if ((r := img.width - w - x) < 1)
		r := 0
	if ((b := img.height - h - y) < 1)
		b := 0
	ip.filters[1].properties("Right") := r
	ip.filters[1].properties("Bottom") := b
	img := IP.Apply(img)
	FileDelete, %FilePath%
	while FileExist(FilePath)
		Sleep, 10
	img.SaveFile(FilePath)
	return
}

Refresh_Images_GUI() {
	GLOBAL
	Gui, Support:Default
	i := -1	;começa no -1 por que o começa no Hotkey0
	PNG.Hotkey74 := []
	Loop, 10 {
		i++
		GuiControl,, Hotkeys74_Picture_Hotkey%i%, Imagens\Hotkeys74\Hotkey%i%.png
		bitmap_Hotkey74 := Gdip_CreateBitmapFromFile(A_WorkingDir "\Imagens\Hotkeys74\Hotkey" i ".png")
		base64_Hotkey74 := EncodeBitmapTo64string(bitmap_Hotkey74,"PNG")
		Gdip_disposeImage(bitmap_Hotkey74)
		PNG.Hotkey74[i] := BitmapFromBase64(1,0,base64_Hotkey74)
	}
}

GetCoord:
	Gui, GetCoord:New
    Gui, GetCoord:-Caption +Border +AlwaysOnTop +LastFound
    Gui, GetCoord:Color, RED
    WinSet, Transparent, 80

	SetTimer, area, Off

    MouseGetPos, x1, y1
	x1-=10
    y1-=10
	x2:=""
	y2:=""
    while GetKeyState("LButton", "P") {
        ToolTip, %x1%`, %y1%`, %x2%`, %y2%
        MouseGetPos, x2, y2
        x3 := x2 - x1
        y3 := y2 - y1
        Gui, GetCoord:Show, x%x1% y%y1% w%x3% h%y3% NoActivate
    }
    Gui, GetCoord:Cancel
    Clipboard = %x1%, %y1%, %x2%, %y2%
    ToolTip, ÁREA COPIADA!
    Sleep, 1000
    ToolTip

	Hotkey, LButton, take_screen_shot, OFF
	WinActivate, ahk_class AutoHotkeyGUI
return

area:
    ToolTip, Selecione uma área
return
