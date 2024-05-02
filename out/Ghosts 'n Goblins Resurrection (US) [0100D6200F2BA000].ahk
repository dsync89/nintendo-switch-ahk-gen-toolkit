; Get the full path of the script
scriptFullPath := A_ScriptFullPath
scriptDirectory := StrReplace(scriptFullPath, A_ScriptName, "")
scriptFileName := SubStr(A_ScriptName, 1, StrLen(A_ScriptName) - 4) ; Remove ".ahk" extension

; Read the config.txt file
configFile := A_ScriptDir . "\" . ".config.ini"

; Read values from the config.txt file
emuPath := IniRead(configFile, "Settings", "EmuPath")
gameDbPath := IniRead(configFile, "Settings", "GameDbPath")
romDir := IniRead(configFile, "RomPath", "RomDir")
startFullScreen := IniRead(configFile, "Settings", "StartFullScreen")
debug := IniRead(configFile, "Settings", "Debug")

root := romDir

FD := ""

FileEncoding "UTF-8" ; set to UTF-8 encoding so that special character like é is read correctly

Loop Read gameDbPath `n ; Loop through each line in the filepath (assuming newline as delimiter)
{
	Loop parse, A_LoopReadLine, A_Tab
	{
		LineText := A_LoopField
		if LineText = ""
			break

		; Split the line into parts using |
		GameInfo := StrSplit(LineText, "|")

		; Get the number of elements after splitting
		elementCount := GameInfo.Length

		gameTitle := Trim(GameInfo[1])

		; MsgBox Format("Game Title: {1} == {2}", gameTitle, scriptFileName)
		; Check if the AHK script's filename matches the GameTitle
		if (gameTitle = scriptFileName)
		{
			; MsgBox Format("Game Title: {1} == {2}", gameTitle, scriptFileName)
			fdArr := Array()
		
			Loop(GameInfo.Length) {
				if (A_Index > 1)
				{
					_bootSource := Trim(GameInfo[A_Index])					

					if InStr(_bootSource, ".xci") || InStr(_bootSource, ".nsp") {
						FD := Chr(34) . root . "\" . gameTitle . "\" . _bootSource . Chr(34)
						fdArr.Push FD
					}   					
				}
			}    

			bootArgs := ""
			If fdArr.Length > 0 {
				Loop fdArr.Length {
					bootArgs .= fdArr[A_Index] . " " ; Concatenate
				}
			}
			
			Command := emuPath " " bootArgs
			If debug
				MsgBox Format("Command: {1}", Command)
			Run(Command)
			
		}    
	}
}

; ============================================================
; Key Bindings
; ============================================================

Esc::
{
	If (A_PriorHotkey = "Esc" and A_TimeSincePriorHotkey < 500) {
		ProcessClose "ryujinx.exe"
		Run "taskkill /im ryujinx.exe /F",, "Hide"
		ExitApp
	}
}