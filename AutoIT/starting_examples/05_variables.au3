#include <MsgBoxConstants.au3>

For $i = 1 To 2
    Global $sHello = "Goodbye"
    If $i = 2 Then MsgBox($MB_OK, "OK", $sHello)

Next 