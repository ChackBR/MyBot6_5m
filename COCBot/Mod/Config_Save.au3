; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...:
; Syntax ........:
; Parameters ....:
; Return values .:
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

	; Max logout time
	If GUICtrlRead($chkTrainLogoutMaxTime) = $GUI_CHECKED Then
		IniWrite($config, "TrainLogout", "TrainLogoutMaxTime", 1)
	Else
		IniWrite($config, "TrainLogout", "TrainLogoutMaxTime", 0)
	EndIf
	IniWrite($config, "TrainLogout", "TrainLogoutMaxTimeTXT", GUICtrlRead($txtTrainLogoutMaxTime))

	; Multi Finger (LunaEclipse)
	IniWrite($config, "MultiFinger", "Select", _GUICtrlComboBox_GetCurSel($cmbDBMultiFinger))

;
; DEMEN
;

	If GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED Then
		IniWrite($profile, "Switch Account", "Enable", 1)
	Else
		IniWrite($profile, "Switch Account", "Enable", 0)
	EndIf

	IniWrite($profile, "Switch Account", "Total Coc Account", _GUICtrlCombobox_GetCurSel($cmbTotalAccount)+1)		; 1 = 1 Acc, 2 = 2 Acc, etc.

	If GUICtrlRead($radSmartSwitch) = $GUI_CHECKED Then
	   IniWrite($profile, "Switch Account", "Smart Switch", 1)
	Else
	   IniWrite($profile, "Switch Account", "Smart Switch", 0)
	EndIf

	If GUICtrlRead($chkUseTrainingClose) = $GUI_CHECKED Then
		If GUICtrlRead($radCloseCoC) = $GUI_CHECKED Then
			IniWrite($profile, "Switch Account", "Sleep Combo", 1)		; Sleep Combo = 1 => Close CoC
		Else
			IniWrite($profile, "Switch Account", "Sleep Combo", 2)		; Sleep Combo = 2 => Close Android
		EndIf
	Else
		IniWrite($profile, "Switch Account", "Sleep Combo", 0)
	EndIf

	For $i = 1 to 8
		IniWriteS($profile, "Switch Account", "MatchProfileAcc." & $i, _GUICtrlCombobox_GetCurSel($cmbAccountNo[$i-1])+1)		; 1 = Acc 1, 2 = Acc 2, etc.
	Next

	For $i = 1 to 8
		IniWriteS($profile, "Switch Account", "ProfileType." & $i, _GUICtrlCombobox_GetCurSel($cmbProfileType[$i-1])+1)			; 1 = Active, 2 = Donate, 3 = Idle
	Next

	For $i = 1 to 8
		IniWriteS($profile, "Switch Account", "AccLocation." & $i, $aLocateAccConfig[$i-1])
	Next
