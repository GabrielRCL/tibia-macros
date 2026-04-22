; ============================================== [ Character Position ] ==============================================
; ============================================== [ Character Position ] ==============================================
; ============================================== [ Character Position ] ==============================================
DrawGetCharacterPosition() {
    GLOBAL
    Gui, Font, Bold
        Gui, Add, Groupbox, SECTION x175 y60 w150 h150 +Center, Character Position
    Gui, Font, Normal

    Gui, Add, Picture, xs+50 ys+20 , % "HBITMAP:* " Picture.GetCharacterPosition
    Gui, Add, Button, xs+29 ys+62 w80 h15 gGetCharacterCoord, Get Position
    Gui, Add, Text, xs+15 ys+85 w50 h20 vGetCoord_CharacterPosition_X, X = ?
    Gui, Add, Text, xs+85 ys+85 w50 h20 vGetCoord_CharacterPosition_Y, Y = ?
}

