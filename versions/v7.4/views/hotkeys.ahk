DrawGuiHotkeys() {
    GLOBAL
    Gui, Font, Bold
        Gui, Add, GroupBox, SECTION x5 y247 w490 h100 +Center, Hotkeys ( Use With Crosshair )
    Gui, Font, Normal

        Gui, Add, Picture, xs+10 ys+15 w18 h18 vPicture_HMM,  % "HBITMAP:* " Picture.HMM
        Gui, Add, Text, xs+30 ys+17 w40 h20, Hotkey:
        Gui, Add, Hotkey, xs+68 ys+15 w60 h20 vHotkey_HMM, 
        Gui, Add, Button, xs+25 ys+38 w80 h15 gGetPictureHMM, Get Picture
}