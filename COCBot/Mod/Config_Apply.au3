; #FUNCTION# ====================================================================================================================
; Name ..........: Config_Apply.au3
; Description ...: Applies all of the  variable to the GUI
; Syntax ........:
; Parameters ....:
; Return values .: NA
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

;
; MOD Config - Save Data
;

;Max logout time
If $TrainLogoutMaxTime = 1 Then
	GUICtrlSetState($chkTrainLogoutMaxTime, $GUI_CHECKED)
ElseIf $TrainLogoutMaxTime = 0 Then
	GUICtrlSetState($chkTrainLogoutMaxTime, $GUI_UNCHECKED)
EndIf
GUICtrlSetData($txtTrainLogoutMaxTime, $TrainLogoutMaxTimeTXT)

; Multi Finger (LunaEclipse)
_GUICtrlComboBox_SetCurSel($cmbDBMultiFinger,$iMultiFingerStyle)
cmbDBMultiFinger()

; CSV Deployment Speed Mod
GUICtrlSetData($sldSelectedSpeedDB, $isldSelectedCSVSpeed[$DB])
GUICtrlSetData($sldSelectedSpeedAB, $isldSelectedCSVSpeed[$LB])
sldSelectedSpeedDB()
sldSelectedSpeedAB()
;
; AwesomeGamer
;

; DEB
If $iChkDontRemove = 1 Then
	GUICtrlSetState($chkDontRemove, $GUI_CHECKED)
Else
	GUICtrlSetState($chkDontRemove, $GUI_UNCHECKED)
EndIf

;
; DEMEN
;

 	If $ichkSwitchAcc = 1 Then
 		GUICtrlSetState($chkSwitchAcc, $GUI_CHECKED)
 	Else
 		GUICtrlSetState($chkSwitchAcc, $GUI_UNCHECKED)
 	EndIf

	If $ichkSmartSwitch = 1 Then
	   GUICtrlSetState($radSmartSwitch, $GUI_CHECKED)
 	Else
	   GUICtrlSetState($radNormalSwitch, $GUI_CHECKED)
	EndIf

	radNormalSwitch()

	_GUICtrlCombobox_SetCurSel($cmbTotalAccount, $icmbTotalCoCAcc - 1)

	If $ichkCloseTraining >= 1 Then
		GUICtrlSetState($chkUseTrainingClose, $GUI_CHECKED)
		If $ichkCloseTraining = 1 Then
			GUICtrlSetState($radCloseCoC, $GUI_CHECKED)
		Else
			GUICtrlSetState($radCloseAndroid, $GUI_CHECKED)
		EndIf
	Else
		GUICtrlSetState($chkUseTrainingClose, $GUI_UNCHECKED)
	EndIf

	For $i = 0 to 7
		_GUICtrlCombobox_SetCurSel($cmbAccountNo[$i], $aMatchProfileAcc[$i]-1)
		_GUICtrlCombobox_SetCurSel($cmbProfileType[$i], $aProfileType[$i]-1)
	Next
