; open Notepad
Run("cmd")

; Wait for the window to open
WinWaitActive("Untitled - Notepad") 

; Send some text to the window
Send("This is some text.") 

; "press" close button
WinClose("*Untitled - Notepad") ; The name changed to "*Untitled - Notepad", due to the file now containing some text

; wait for the "Notepad, Do you want to save" box
WinWaitActive("Notepad", "Save") 

; Next we want to automatically press Alt-N to select the No/Don't save button 
; (Underlined letters in windows usually indicate that you can use the ALT key and that letter as a keyboard shortcut). 
; In the Send function to send an ALT key we use ! .
;~ Send("!n") 

; We can also send arrows and enters
Send("{RIGHT}")
Send("{ENTER}")