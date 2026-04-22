; ============================================== [ Remove ToolTip ] ==============================================
; ============================================== [ Remove ToolTip ] ==============================================
; ============================================== [ Remove ToolTip ] ==============================================
RemoveToolTip01:
RemoveToolTip02:
RemoveToolTip03:
RemoveToolTip04:
RemoveToolTip05:
RemoveToolTip06:
RemoveToolTip07:
RemoveToolTip08:
RemoveToolTip09:
RemoveToolTip10:
RemoveToolTip11:
RemoveToolTip12:
RemoveToolTip13:
RemoveToolTip18:
RemoveToolTip19:
RemoveToolTip20:
	ToolTip,,,, % SubStr(A_ThisLabel, -1)
	SetTimer, % "RemoveToolTip" SubStr(A_ThisLabel, -1), Off
	List_State_ToolTip[SubStr(A_ThisLabel, -1)] := 0	;RESETA O STATE TOOLTIP DELAY
return