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

	; Check Collectors Outside
	$ichkDBMeetCollOutside = IniRead($config, "search", "DBMeetCollOutside", "0")
	$iDBMinCollOutsidePercent = IniRead($config, "search", "DBMinCollOutsidePercent", "50")

	; Smart Upgrade
	$ichkSmartUpgrade = IniRead($config, "upgrade", "chkSmartUpgrade", "0")
	$ichkIgnoreTH = IniRead($config, "upgrade", "chkIgnoreTH", "0")
	$ichkIgnoreKing = IniRead($config, "upgrade", "chkIgnoreKing", "0")
	$ichkIgnoreQueen = IniRead($config, "upgrade", "chkIgnoreQueen", "0")
	$ichkIgnoreWarden = IniRead($config, "upgrade", "chkIgnoreWarden", "0")
	$ichkIgnoreCC = IniRead($config, "upgrade", "chkIgnoreCC", "0")
	$ichkIgnoreLab = IniRead($config, "upgrade", "chkIgnoreLab", "0")
	$ichkIgnoreBarrack = IniRead($config, "upgrade", "chkIgnoreBarrack", "0")
	$ichkIgnoreDBarrack = IniRead($config, "upgrade", "chkIgnoreDBarrack", "0")
	$ichkIgnoreFactory = IniRead($config, "upgrade", "chkIgnoreFactory", "0")
	$ichkIgnoreDFactory = IniRead($config, "upgrade", "chkIgnoreDFactory", "0")
	$ichkIgnoreGColl = IniRead($config, "upgrade", "chkIgnoreGColl", "0")
	$ichkIgnoreEColl = IniRead($config, "upgrade", "chkIgnoreEColl", "0")
	$ichkIgnoreDColl = IniRead($config, "upgrade", "chkIgnoreDColl", "0")
	$iSmartMinGold = IniRead($config, "upgrade", "SmartMinGold", "0")
	$iSmartMinElixir = IniRead($config, "upgrade", "SmartMinElixir", "0")
	$iSmartMinDark = IniRead($config, "upgrade", "SmartMinDark", "0")

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
