; DEBUGGER.AHK ================================================================================
Debugger:
	TibiaDeBug()
RETURN

TibiaDeBug(){
    GLOBAL
    PrintScreenData()
    DllCall(ProcCreateBitmap, "Ptr", WindowInfo.HBITMAP, "Ptr", 0, "Ptr*", NewBitmap)
    Gdip_SaveBitmapToFile(NewBitmap, "DeBug.png")
    Debugger_hBitmap := Gdip_CreateHBITMAPFromBitmap(NewBitmap)
    DllCall(ProcDisposeImage, "Ptr", NewBitmap)

    MsgBox, 4096, DeBug, % "`VersionType:`t " VersionType "`nTitle:`t " WindowInfo.Title "`nExe:`t " WindowInfo.Exe "`nClass:`t " WindowInfo.Class "`nIDClassNN: " WindowInfo.IDClassNN "`nID:`t " WindowInfo.ID "`npID:`t " WindowInfo.pID "`nWindow:`t x" WindowInfo.Window.x "`t y" WindowInfo.Window.y "`tw" WindowInfo.Window.w "`th" WindowInfo.Window.h "`nClassNN:`t x" WindowInfo.ClassNN.x "`t y" WindowInfo.ClassNN.y "`tw" WindowInfo.ClassNN.w "`th" WindowInfo.ClassNN.h "`nClient:`t w" WindowInfo.Client.w "`t h" WindowInfo.Client.h "`nLoot:`t x:" SQTLoot.1.x " y" SQTLoot.1.y " SQM: " SQTLoot.SQT

    Gui, Debugger:New
    Gui, Debugger:+AlwaysOnTop
    Gui, Debugger:Add, Picture, x5 y5, % "HBITMAP:* " Debugger_hBitmap
    Gui, Debugger:Show, AutoSize

    Gui, Main:Default
}
