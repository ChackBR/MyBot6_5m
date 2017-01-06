; #FUNCTION# ====================================================================================================================
; Name ..........: Config_Read.au3
; Description ...: Reads config file and sets variables
; Syntax ........: readConfig()
; Parameters ....: NA
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

	; Max logout time
	$TrainLogoutMaxTime = IniRead($config, "TrainLogout", "TrainLogoutMaxTime", "0")
	$TrainLogoutMaxTimeTXT = IniRead($config, "TrainLogout", "TrainLogoutMaxTimeTXT", "20")

;
; LunaEclipse
;

	; Multi Finger
	$iMultiFingerStyle = IniRead($config, "MultiFinger", "Select", "1")

	; CSV Deployment Speed Mod
	IniReadS($isldSelectedCSVSpeed[$DB], $config, "attack", "CSVSpeedDB", 4)
	IniReadS($isldSelectedCSVSpeed[$LB], $config, "attack", "CSVSpeedAB", 4)

;
; AwesomeGamer
;

	; DEB
	$iChkDontRemove = IniRead($config, "troop", "DontRemove", "0")

;
; DEMEN
;

	; Config Read for SwitchAcc Mode - DEMEN
	IniReadS($ichkSwitchAcc, $profile, "Switch Account", "Enable", "0")
	IniReadS($icmbTotalCoCAcc, $profile, "Switch Account", "Total Coc Account", "-1")
	IniReadS($ichkSmartSwitch, $profile, "Switch Account", "Smart Switch", "0")
	$ichkCloseTraining = Number(IniRead($profile, "Switch Account", "Sleep Combo", "0"))	; Sleep Combo, 1 = Close CoC, 2 = Close Android, 0 = No sleep

	For $i = 0 to 7
		IniReadS($aMatchProfileAcc[$i],$profile, "Switch Account", "MatchProfileAcc." & $i+1, "-1")
		IniReadS($aProfileType[$i], $profile, "Switch Account", "ProfileType." & $i+1, "-1")
		IniReadS($aAccPosY[$i], $profile, "Switch Account", "AccLocation." & $i+1, "-1")
	Next
