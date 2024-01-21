#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

GUICreate("Calculator", 260, 230)

; Digit's buttons
Local $idbtn0 = GUICtrlCreateButton("0", 54, 171, 36, 29)
Local $idbtn1 = GUICtrlCreateButton("1", 54, 138, 36, 29)
Local $idbtn2 = GUICtrlCreateButton("2", 93, 138, 36, 29)
Local $idbtn3 = GUICtrlCreateButton("3", 132, 138, 36, 29)
Local $idbtn4 = GUICtrlCreateButton("4", 54, 106, 36, 29)
Local $idbtn5 = GUICtrlCreateButton("5", 93, 106, 36, 29)
Local $idbtn6 = GUICtrlCreateButton("6", 132, 106, 36, 29)
Local $idbtn7 = GUICtrlCreateButton("7", 54, 73, 36, 29)
Local $idbtn8 = GUICtrlCreateButton("8", 93, 73, 36, 29)
Local $idbtn9 = GUICtrlCreateButton("9", 132, 73, 36, 29)
Local $idbtnPeriod = GUICtrlCreateButton(".", 132, 171, 36, 29)

; Memory's buttons
Local $idbtnMClear = GUICtrlCreateButton("MC", 8, 73, 36, 29)
Local $idbtnMRestore = GUICtrlCreateButton("MR", 8, 106, 36, 29)
Local $idbtnMStore = GUICtrlCreateButton("MS", 8, 138, 36, 29)
Local $idbtnMAdd = GUICtrlCreateButton("M+", 8, 171, 36, 29)

; Operators
Local $idbtnChangeSign = GUICtrlCreateButton("+/-", 93, 171, 36, 29)
Local $idbtnDivision = GUICtrlCreateButton("/", 171, 73, 36, 29)
Local $idbtnMultiplication = GUICtrlCreateButton("*", 171, 106, 36, 29)
Local $idbtnSubtract = GUICtrlCreateButton("-", 171, 138, 36, 29)
Local $idbtnAdd = GUICtrlCreateButton("+", 171, 171, 36, 29)
Local $idbtnAnswer = GUICtrlCreateButton("=", 210, 171, 36, 29)
Local $idbtnInverse = GUICtrlCreateButton("1/x", 210, 138, 36, 29)
Local $idbtnSqrt = GUICtrlCreateButton("Sqrt", 210, 73, 36, 29)
Local $idbtnPercentage = GUICtrlCreateButton("%", 210, 106, 36, 29)
Local $idbtnBackspace = GUICtrlCreateButton("Backspace", 54, 37, 63, 29)
Local $idbtnClearE = GUICtrlCreateButton("CE", 120, 37, 62, 29)
Local $idbtnClear = GUICtrlCreateButton("C", 185, 37, 62, 29)

; Local $idEdtScreen = GUICtrlCreateEdit("0.", 8, 2, 239, 23)
Local $idEdtScreen = GUICtrlCreateEdit(" 0.", 8, 2, 239, 23, BitOR($ES_READONLY, $ES_RIGHT), $WS_EX_STATICEDGE)

; Local $idLblMemory = GUICtrlCreateLabel("", 12, 39, 27, 26)
Local $idLblMemory = GUICtrlCreateLabel("", 12, 39, 27, 26, $SS_SUNKEN)

GUISetState()

Local $iMsg
Do
	$iMsg = GUIGetMsg()

Until $iMsg = $GUI_EVENT_CLOSE
