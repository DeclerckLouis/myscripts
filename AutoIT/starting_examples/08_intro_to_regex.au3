#include <MsgBoxConstants.au3>
; setup of a string to search
;StringRegExp( "test" , "pattern" [, flag ] )

;~ "test" = The string to search through for matches.
;~ "pattern" = A string consisting of certain key characters that let the function know PRECISELY what you want to match. No ifs, ands, or buts.. it's a match or it isn't.
;~ flag [optional] = Tells the function if you just want to know if the "pattern" is found, or if you want it to return the first match, or if you want it to return all the matches in the "test" string.

; Examples
MsgBox($MB_OK, "SRE Example 1 Result", StringRegExp("text", 'test')) 
; returns 0 because the pattern is not found in the string

MsgBox($MB_OK, "SRE Example 2 Result", StringRegExp("text", 'te[sx]t'))
MsgBox($MB_OK, "SRE Example 2 Result", StringRegExp("test", 'te[sx]t')) 
; returns 1 because the pattern is found in the string (the letter can be either s or x)

; This example is redundant but shows you can check per letter how many times it occurs
MsgBox($MB_OK, "SRE Example 3 Result", StringRegExp("text", 't{1}e{1}[sx]{1}t{1}'))

MsgBox($MB_OK, "SRE Example 3 Result", StringRegExp("aaaabbbbcccc", 'b{4}')) 
