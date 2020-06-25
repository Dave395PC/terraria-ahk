;; Directives & Gobal Variables

#SingleInstance force
SetMouseDelay, 50
CoordMode, Mouse, Client

TerrariaDirectory := "C:\Program Files (x86)\Steam\steamapps\common\Terraria"
;                      ↑↑ Folder of your Terraria install ↑↑



;;--------------------------------------------------------------

;; YOU WILL ALSO NEED TO CHANGE COORDS
;; My display is 3440x1440, and chances are yours isn't
;; Use Alt+Ctrl+Shift+C (short for cursor) to append
;;  the current coordinates of your cursor
;;  to Cursor-Coords.txt
;;  That file has documentation
;; Every number, number are X, Y coordinates for the cursor
;; They are all documented

;;--------------------------------------------------------------



;; Commands


; Dupe from inv open w/ item in inv
!^+z:: ; closest to modifier keys used
	if TerrariaExist() {
		
		InputBox, dupeAmnt, "Auto-Duplicator", "How many times would you like to duplicate?"
		
		if ErrorLevel
			dupeAmnt := 1
		
		Loop, %dupeAmnt% {
			Dupe()
		}
	}
return


; Join the server
!^+j:: ; j for Join
	if !TerrariaExist()
		StartTerraria()
	
	if WinExist("ahk_exe" . TerrariaDirectory . "\Terraria.exe") {
		WinActivate
		JoinServer()
	}
return


; Capture curr pos of cur & append to Desktop\Stuff.txt
!^+c:: ; c for Copy or Capture
	global StuffDirectory
	MouseGetPos, xpos, ypos
	FormatTime, clickTime,, yyyy/MM/dd HH:mm:ss
	FileAppend, `n%clickTime% X`,Y %xpos%`, %ypos%, Cursor-Coords.txt
return


;; Functions


;Join server from Main Menu
JoinServer() {
	Click, 1718, 543 ; Multiplayer
	
	Sleep, 150
	
	Click, 1732, 444 ; Join via IP
	
	Sleep, 150
	
	Click, 1250, 495 ; Player at top of list
	
	Sleep, 150
	
	Click, 1723, 471 ; Most recent server
	
	Sleep, 2500
}


; Save and Exit from ESC
SaveExit() {
	Click, 3292, 1405 ; Settings
	
	Sleep, 200
	
	Click, 1497, 958 ; Save and Exit
	
	Sleep, 1000
}


; If Terraria is currently running
TerrariaExist() {
	global TerrariaDirectory
	if WinExist("ahk_exe" . TerrariaDirectory . "\Terraria.exe") {
		return 1
	}
	if !WinExist("ahk_exe" . TerrariaDirectory . "\Terraria.exe") {
		return 0
	}
	else {
		MsgBox wtf
	}
}


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


; Start Terraria
StartTerraria() {
	Run, steam://rungameid/105600 ; Start Terraria thru Steam
	WinWait, ahk_exe %TerrariaDirectory%\Terraria.exe,, 10
	if ErrorLevel {
		MsgBox, "Tf happened to Terraria?"
		Exit
	} else {
		Sleep, 30000 ; I timed how long Terraria takes to start but I still have no clue
					 ; bc it's different EVERY SINGLE FUCKING TIME
	}
}


; Force-Restart Terraria
ForceRestartTerraria() {
	Run, %comspec% /c TASKKILL /IM Terraria.exe /F ; Kill Terraria
	Sleep, 750 ; Why not
	StartTerraria()
}


; Clik da chest
Chest() {
	Click, right, 1647, 738 ; Dupe chest
}


; Move item from inv dupe slot to chest 1st slot
toChest() {
	Click, 551, 178 ; Slot in your inventory for the item being duplicated
	Click, 119, 359 ; Slot in chest for the item being duplicated
}


; Move item from chest 1st slot to inv dupe slot
fromChest() {
	Click, 119, 359 ; Slot in chest for the item being duplicated
	Click, 551, 178 ; Slot in your inventory for the item being duplicated
}

Dupe() {
	SaveExit()
	
	JoinServer()
	
	Chest()
	
	Sleep, 250
	
	toChest()
	
	Sleep, 250
	
	ForceRestartTerraria()
	
	JoinServer()
	
	Chest()
	
	Sleep, 250
	
	fromChest()
	
	Sleep, 250
}