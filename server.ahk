; Set server time to Dawn
!^+d::	ServSend("dawn") ; d for Dawn/Day

; Set server time to Noon
!^+s::	ServSend("noon") ; s for Sun

; Set server time to Dusk
!^+n::	ServSend("dusk") ; n for Night

; Set server time to Midnight
!^+m::	ServSend("midnight") ; m for Midnight


; Send the server a command
ServSend(cmdtxt) {
	WinGet, beforeid, ID, A
	SetTitleMatchMode, 1
	if WinExist("Terraria Server: ") {
		WinActivate
		Send, %cmdtxt%{Enter}
		
		WinActivate, ahk_id %beforeid%
	}
}