; open Notepad
Run("notepad.exe")

; Wait for the window to open
WinWaitActive("Untitled - Notepad") 

; Send some text to the window
Send("This is some text.") 

; "press" close button
WinClose("*Untitled - Notepad") ; The name changed to "*Untitled - Notepad", due to the file now containing some text

