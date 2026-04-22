DrawGuiHealing() {
    GLOBAL
    Gui, Font, Bold
        Gui, Add, GroupBox, SECTION x5 y35 w490 h200 +Center, Auto Healing
    Gui, Font, Normal

    ; LIFE
    Gui, Font, Bold
        Gui, Add, GroupBox, SECTION xs+15 ys+25 w150 h150 +Center, LIFE
        Gui, Add, CheckBox, xs+10 ys+15 w100 h20 vCheckBox_Enable_Healing_Life, Spell Healing
    Gui, Font, Normal
        Gui, Add, Picture, xs+10 ys+40 w20 h22 vPicture_GetPixel_HP_Percent
        ;~ Draw_Rectangle_OnPicture(color:="0xFFF16161", PosX:=0,PosY:=0, widthh:=20,heightt:=20, GuiTab:="Main",PictureVar:="MyPicLife")
        Gui, Add, Button, xs+35 ys+43 w80 h15 gGetPixelHP`%, GetPixel HP`%

        Gui, Add, Text, xs+10 ys+67 w40 h20 vText_Healing_Life, Hotkey:
        Gui, Add, Hotkey, xs+50 ys+65 w60 h20 vHotkey_Healing_Life, 
        Gui, Add, CheckBox, xs+10 ys+105 w125 h20 vCheckBox_Healing_Life_UseUH, Rune ( Yourself )
        Gui, Add, Picture, xs+25 ys+125 w18 h18 vPicture_UH, % "HBITMAP:* " Picture.UH
        Gui, Add, Button, xs+45 ys+127 w80 h15 gGetPictureUH, Get Picture

    ; MANA
    Gui, Font, Bold
        Gui, Add, GroupBox, SECTION xs+310 ys w150 h150 +Center, MANA
        Gui, Add, CheckBox, xs+10 ys+15 w80 h20 gEnable_Healing vCheckBox_Enable_Healing_Mana, ENABLE
    Gui, Font, Normal
        Gui, Add, Picture, xs+10 ys+40 w20 h22 vPicture_GetPixel_MP_Percent
        ;~ Draw_Rectangle_OnPicture(color:="0xFF4340C0", PosX:=0,PosY:=0, widthh:=20,heightt:=20, GuiTab:="Main",PictureVar:="MyPicMana")
        Gui, Add, Button, xs+35 ys+43 w80 h15 gGetPixelMP`%, GetPixel MP`%
        Gui, Add, Picture, xs+10 ys+65 w18 h18 vPicture_ManaFluid, % "HBITMAP:* " Picture.ManaFluid
        Gui, Add, Button, xs+35 ys+67 w80 h15 gGetPicture_ManaFluid, Get Picture
}