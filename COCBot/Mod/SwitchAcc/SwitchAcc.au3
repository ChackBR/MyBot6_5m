; #FUNCTION# ====================================================================================================================
; Name ..........: Switch CoC Account
; Description ...: This file contains the Sequence that runs all MBR Bot
; Author ........: DEMEN (based on original code & idea of NDTHUAN)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global $iAttackedCountSwitch

Func InitiateSwitchAcc() ; Checking profiles setup in Mybot, First matching CoC Acc with current profile, Reset all Timers relating to Switch Acc Mode.

   $ProfileList = _GUICtrlComboBox_GetListArray($cmbProfile)
   $nTotalProfile = _GUICtrlComboBox_GetCount($cmbProfile)
   $nCurProfile = _GuiCtrlComboBox_GetCurSel($cmbProfile) + 1

   Setlog($nTotalProfile & " profiles available")

   For $i = 0 to _Min($nTotalProfile - 1,7)
	  Switch $aProfileType[$i]
	  Case 1
		 Setlog("Profile [" & $i + 1 & "]: " & $ProfileList[$i+1] & " - Active - Match with Account [" & $aMatchProfileAcc[$i] &"]")
	  Case 2
		 Setlog("Profile [" & $i + 1 & "]: " & $ProfileList[$i+1] & " - Donate - Match with Account [" & $aMatchProfileAcc[$i] &"]")
	  Case Else
		 Setlog("Profile [" & $i + 1 & "]: " & $ProfileList[$i+1] & " - Idle   - Match with Account [" & $aMatchProfileAcc[$i] &"]")
	  EndSwitch
   Next

   If $icmbTotalCoCAcc <> -1 then
	   $nTotalCoCAcc = $icmbTotalCoCAcc
	   Setlog ("Total CoC Account is declared: " & $nTotalCoCAcc)
   Else
	   $nTotalCoCAcc = 8
	   Setlog ("Total CoC Account has not declared, default: " & $nTotalCoCAcc)
   EndIf

   ; Locating CoC Accounts
   If _ArrayMax($aAccPosY) > 0 Then
	   $MaxIdx = _ArrayMaxIndex($aAccPosY)
	   For $i = 1 to $nTotalCoCAcc
		   If $aAccPosY[$i-1] <= 0 Then $aAccPosY[$i-1] = $aAccPosY[$MaxIdx] + 73*($i-1-$MaxIdx)
		   Setlog("  >>> Y-coordinate Acc No. " & $i & " is located at: " & $aAccPosY[$i-1])
	   Next
   EndIf

   $i = $nCurProfile
   While $aProfileType[$i-1] = 3 OR $aProfileType[$i-1] = 0		;	Current Profile is idle
	   If $i < $nTotalProfile Then
		   $i += 1
	   Else
		   $i = 1
	   EndIf
	   If $aProfileType[$i-1] <> 3 AND $aProfileType[$i-1] <> 0 Then
		   Setlog("Try to avoid Idle Profile. Switching to Profile [" & $i &"] - CoC Acc [" & $aMatchProfileAcc[$i-1] & "]")
		   _GUICtrlComboBox_SetCurSel($cmbProfile, $i-1)
		   cmbProfile()
		   ExitLoop
	   EndIf
   WEnd

   $nCurProfile = _GuiCtrlComboBox_GetCurSel($cmbProfile) + 1

   For $i = 0 to _Min($nTotalProfile - 1, 7)
	  $aTimerStart[$i] = 0
	  $aTimerEnd[$i] = 0
	  $aRemainTrainTime[$i] = 0
	  $aUpdateRemainTrainTime[$i] = 0
   Next
   $iAttackedCountSwitch = 0

   Setlog ("Matching CoC Account with Bot Profile. Trying to Switch Account", $COLOR_BLUE)

   SwitchCOCAcc()
   If $bReMatchAcc = False Then runBot()

EndFunc	; --> InitiateSwitchAcc()

Func CheckWaitHero()	; get hero regen time remaining if enabled
    Local $iActiveHero
	Local $aHeroResult[3]
	$aTimeTrain[2] = 0

	If $debugsetlogTrain = 1 Or $debugSetlog = 1 Then Setlog("CheckWaitHero", $COLOR_PURPLE)

	$aHeroResult = getArmyHeroTime("all")

	If @error Then
		Setlog("getArmyHeroTime return error, exit Check Hero's wait time!", $COLOR_RED)
		Return ; if error, then quit Check Hero's wait time
	EndIf

	If $aHeroResult = "" Then
		Setlog("You have no hero or bad TH level detection Pls manually locate TH", $COLOR_RED)
		Return
	EndIf

	Setlog("Getting Hero's recover time, King: " & $aHeroResult[0] & " m, Queen: " & $aHeroResult[1] & " m, GW: " & $aHeroResult[2] & " m.")

	If _Sleep($iDelayRespond) Then Return
	If $aHeroResult[0] > 0 Or $aHeroResult[1] > 0 Or $aHeroResult[2] > 0 Then ; check if hero is enabled to use/wait and set wait time
		For $pTroopType = $eKing To $eWarden ; check all 3 hero
			For $pMatchMode = $DB To $iModeCount - 1 ; check all attack modes
				If $debugsetlogTrain = 1 Or $debugSetlog = 1 Then
					SetLog("$pTroopType: " & NameOfTroop($pTroopType) & ", $pMatchMode: " & $sModeText[$pMatchMode], $COLOR_PURPLE)
					Setlog("TroopToBeUsed: " & IsSpecialTroopToBeUsed($pMatchMode, $pTroopType) & ", Hero Wait Status: " & (BitOr($iHeroAttack[$pMatchMode], $iHeroWait[$pMatchMode]) = $iHeroAttack[$pMatchMode]), $COLOR_PURPLE)
				EndIf
				$iActiveHero = -1
				If IsSpecialTroopToBeUsed($pMatchMode, $pTroopType) And _
					 BitOr($iHeroAttack[$pMatchMode], $iHeroWait[$pMatchMode]) = $iHeroAttack[$pMatchMode] Then ; check if Hero enabled to wait
				$iActiveHero = $pTroopType - $eKing ; compute array offset to active hero
				EndIf
				If $iActiveHero <> -1 And $aHeroResult[$iActiveHero] > 0 Then ; valid time?
					; check exact time & existing time is less than new time
					If $aTimeTrain[2] < $aHeroResult[$iActiveHero] Then
						$aTimeTrain[2] = $aHeroResult[$iActiveHero] ; use exact time
					EndIf

					If $debugsetlogTrain = 1 Or $debugSetlog = 1 Then
						SetLog("Wait enabled: " & NameOfTroop($pTroopType) & ", Attack Mode:" & $sModeText[$pMatchMode] & ", Hero Time:" & $aHeroResult[$iActiveHero] & ", Wait Time: " & StringFormat("%.2f", $aTimeTrain[2]), $COLOR_PURPLE)
					EndIf
				EndIf
			Next
			If _Sleep($iDelayRespond) Then Return
		Next
	Else
		If $debugsetlogTrain = 1 Or $debugSetlog = 1 Then Setlog("getArmyHeroTime return all zero hero wait times", $COLOR_PURPLE)
	EndIf

	Setlog("Hero recover wait time: " & $aTimeTrain[2] & " minute(s)", $COLOR_BLUE)

 EndFunc ; --> CheckWaitHero

Func MinRemainTrainAcc() 														; Check remain training time of all Active accounts and return the minimum remain training time

   $aRemainTrainTime[$nCurProfile-1] = _ArrayMax($aTimeTrain)				 	; remaintraintime of current account - in minutes
   $aTimerStart[$nCurProfile-1] = TimerInit() 									; start counting elapse of training time of current account

   For $i = 0 to $nTotalProfile - 1
	  If $aProfileType[$i] = 1 Then 											;	Only check Active profiles
		 If $aTimerStart[$i] <> 0 Then
			$aTimerEnd[$i] = Round(TimerDiff($aTimerStart[$i])/1000/60,2) 		; 	counting elapse of training time of an account from last army checking - in minutes
			$aUpdateRemainTrainTime[$i] = $aRemainTrainTime[$i]-$aTimerEnd[$i] 	;   updated remain train time of Active accounts
			If $aUpdateRemainTrainTime[$i] >= 0 Then
			   Setlog("Profile [" & $i+1 & "] - " & $ProfileList[$i+1] & " (Acc. " & $aMatchProfileAcc[$i] & ") will have full army in:" & $aUpdateRemainTrainTime[$i] & " minutes")
			Else
			   Setlog("Profile [" & $i+1 & "] - " & $ProfileList[$i+1] & " (Acc. " & $aMatchProfileAcc[$i] & ") was ready:" & -$aUpdateRemainTrainTime[$i] & " minutes ago")
			EndIf
		 Else ; for accounts first Run
			Setlog("Profile [" & $i+1 & "] - " & $ProfileList[$i+1] & " (Acc. " & $aMatchProfileAcc[$i] & ") has not been read its remain train time")
			$aUpdateRemainTrainTime[$i] = 0
		 EndIf
	  EndIf
   Next

   $nMinRemainTrain = _ArrayMax($aUpdateRemainTrainTime)
   For $i = 0 to $nTotalProfile - 1
	  If $aProfileType[$i] = 1 Then ;	Only check Active profiles
		 If $aUpdateRemainTrainTime[$i] <=  $nMinRemainTrain Then
			$nMinRemainTrain = $aUpdateRemainTrainTime[$i]
			$nNexProfile = $i + 1
		 EndIf
	  EndIf
   Next

EndFunc	; --> MinRemainTrainAcc()

Func SwitchProfile($SwitchCase) 										; Switch profile (1 = Active, 2 = Donate, 3 = switching continuosly) - DEMEN

   $nCurProfile = _GUICtrlComboBox_GetCurSel($cmbProfile)+1
   $aDonateProfile = _ArrayFindAll($aProfileType, 2)

   Switch $SwitchCase
   Case 1
	  Setlog("Switch to active Profile ["& $nNexProfile & "] - " & $ProfileList[$nNexProfile] & " (Acc. " & $aMatchProfileAcc[$nNexProfile-1] & ")")
	  _GUICtrlComboBox_SetCurSel($cmbProfile, $nNexProfile - 1)
	  cmbProfile()

   Case 2
	  $nNexProfile = $aDonateProfile[$DonateSwitchCounter] + 1
	  Setlog("Switch to Profile ["& $nNexProfile & "] - " & $ProfileList[$nNexProfile] & " (Acc. " & $aMatchProfileAcc[$nNexProfile - 1] & ") for donating")
	  _GUICtrlComboBox_SetCurSel($cmbProfile, $nNexProfile - 1)
	  $DonateSwitchCounter += 1
	  cmbProfile()

   Case 3
	 Setlog("Staying in this profile")

   Case 4
	 Setlog("Switching to next account")
	 $NextProfile = 1
	 If $nCurProfile < $nTotalProfile Then
		$NextProfile = $nCurProfile + 1
	 Else
		$NextProfile = 1
	 EndIf
	 While $aProfileType[$NextProfile-1] = 3 OR $aProfileType[$NextProfile-1] = 0
		If $NextProfile < $nTotalProfile Then
		   $NextProfile += 1
		Else
		   $NextProfile = 1
		EndIf
		If $aProfileType[$NextProfile-1] <> 3 AND $aProfileType[$NextProfile-1] <> 0 Then ExitLoop
	  WEnd
     _GUICtrlComboBox_SetCurSel($cmbProfile, $NextProfile-1)
	  cmbProfile()
   EndSwitch

   If _Sleep(1000) Then Return

   $nCurProfile = _GUICtrlComboBox_GetCurSel($cmbProfile)+1

EndFunc ; --> SwitchProfile()

Func CheckSwitchAcc(); Switch CoC Account with or without sleep combo - DEMEN

	Local $SwitchCase
	Local $aDonateProfile = _ArrayFindAll($aProfileType, 2)

	SetLog("Start SwitchAcc Mode")

	If IsMainPage() = False Then ClickP($aAway, 2, 250, "#0335")	; Sometimes the bot cannot open Army Overview Window, trying to click away first
	If IsMainPage() = False Then checkMainScreen()				; checkmainscreen (may restart CoC) if still fail to locate main page.
	getArmyTroopTime(True, False)

	If IsWaitforSpellsActive() Then
		getArmySpellTime()
	Else
		$aTimeTrain[1] = 0
	EndIf

	If IsWaitforHeroesActive() Then
		CheckWaitHero()
	Else
		$aTimeTrain[2] = 0
	EndIf

	ClickP($aAway, 1, 0, "#0000") ;Click Away

	$bReachAttackLimit = ($iAttackedCountSwitch <= $iAttackedVillageCount[0] + $iAttackedVillageCount[1] + $iAttackedVillageCount[2] +$iAttackedVillageCount[3] - 2)

	If $aProfileType[$nCurProfile-1] = 1 And _ArrayMax($aTimeTrain) <= 0 And Not($bReachAttackLimit) Then
		Setlog("Army is ready, skip switching account")
		If _Sleep(500) Then Return

	Else
		If _ArrayMax($aTimeTrain) <= 0 And $bReachAttackLimit Then Setlog("This account has attacked twice in a row, switching account")

		MinRemainTrainAcc()

		If $ichkSmartSwitch = 1 And _ArraySearch($aProfileType, 1) <> -1 Then		; Smart switch and there is at least 1 active profile
			If $nMinRemainTrain <= 0 Then
				If $nCurProfile <> $nNexProfile Then
					$SwitchCase = 1
				Else
					$SwitchCase = 3
				EndIf
			Else
				If $DonateSwitchCounter < UBound($aDonateProfile) Then
					$SwitchCase = 2
				Else
					If $nCurProfile <> $nNexProfile Then
						$SwitchCase = 1
					Else
						$SwitchCase = 3
					EndIf
					$DonateSwitchCounter = 0
				EndIf
			EndIf
		Else
			$SwitchCase = 4
		EndIf

		If $SwitchCase <> 3 Then
			If $aProfileType[$nCurProfile-1] = 1 And $iPlannedRequestCCHoursEnable = 1 And $canRequestCC = True Then
				Setlog("Try Request troops before switching account", $COLOR_BLUE)
				RequestCC(true)
			EndIf
			SwitchProfile($SwitchCase)
			checkMainScreen()
			SwitchCOCAcc()
		Else
			SwitchProfile($SwitchCase)
		EndIf

		If $ichkCloseTraining >= 1 And $nMinRemainTrain > 3 And $SwitchCase <> 2 Then
			VillageReport()
			ReArm()
			If $iPlannedRequestCCHoursEnable = 1 And $canRequestCC = True Then
				Setlog("Try Request troops before going to sleep", $COLOR_BLUE)
				RequestCC(true)
			EndIf
			PoliteCloseCoC()
			$iShouldRearm = True
			If $ichkCloseTraining = 2 Then CloseAndroid("SwitchAcc")
			EnableGuiControls() ; enable emulator menu controls
			SetLog("Enable emulator menu controls due long wait time!")
			If $ichkCloseTraining = 1 Then
				WaitnOpenCoC(($nMinRemainTrain - 1) * 60 * 1000, True)
			Else
				If _SleepStatus(($nMinRemainTrain - 1.5) * 60 * 1000) Then Return
				OpenAndroid()
				OpenCoC()
			EndIf

			SaveConfig()
			readConfig()
			applyConfig()
			DisableGuiControls()
		EndIf
		If $SwitchCase <> 3 Then runBot()
	EndIf

EndFunc; -->CheckSwitchAcc()

Func SwitchCOCAcc()

	Local $NextAccount, $YCoord
	$NextAccount = $aMatchProfileAcc[$nCurProfile-1]

	If $aAccPosY[$NextAccount-1] > 0 Then
		$YCoord = $aAccPosY[$NextAccount-1]
	Else
		$YCoord = 373.5 - ($nTotalCoCAcc - 1)*36.5 + 73*($NextAccount - 1)
	EndIf

	Setlog ("Switching to Account [" & $NextAccount & "]")

	PureClick(820, 585, 1, 0, "Click Setting")      ;Click setting
	If _Sleep(500) Then Return

	$idx=0
	While $idx <=15								; Checking Green Connect Button continuously in 15sec
		If _ColorCheck(_GetPixelColor(408, 408, True), "D0E878", 20) Then		;	Green
			PureClick(440, 420, 2, 1000)			;	Click Connect & Disconnect
			If _Sleep(500) Then Return
			Setlog("   1. Click connect & disconnect")
			ExitLoop
		ElseIf _ColorCheck(_GetPixelColor(408, 408, True), "F07077", 20) Then	; 	Red
			PureClick(440, 420)						;	Click Disconnect
			If _Sleep(500) Then Return
			Setlog("   1. Click disconnect")
			ExitLoop
		Else
			If _Sleep(900) Then Return
			$idx += 1
			If $idx = 15 Then SwitchFail_runBot()
		EndIf
	WEnd

	$idx=0
	While $idx <=15								; Checking Account List continuously in 15sec
		If _ColorCheck(_GetPixelColor(600, 310, True), "FFFFFF", 20) Then		;	Grey
			PureClick(383, $YCoord)					;	Click Account
			Setlog("   2. Click account [" & $NextAccount & "]")
			If _Sleep(1000) Then Return
			ExitLoop
		ElseIf _ColorCheck(_GetPixelColor(408, 408, True), "F07077", 20) And $idx = 6 Then	; 	Red, double click did not work, try click Disconnect 1 more time
			PureClick(440, 420)						;	Click Disconnect
			Setlog("   1.5. Click disconnect again")
			If _Sleep(500) Then Return
		Else
			If _Sleep(900) Then Return
			$idx += 1
			If $idx = 15 Then SwitchFail_runBot()
		EndIf
	WEnd

	$idx=0
	While $idx <=15								; Checking Load Button continuously in 15sec
		If _ColorCheck(_GetPixelColor(408, 408, True), "D0E878", 20) Then 	; Already in current account
			Setlog("Already in current account")
			PureClickP($aAway, 2, 0, "#0167") ;Click Away
			If _Sleep(1000) Then Return
			$bReMatchAcc = False
			ExitLoop

		ElseIf _ColorCheck(_GetPixelColor(480, 441, True), "60B010", 20) Then 	; Load Button
			PureClick(443, 430, 1, 0, "Click Load")      ;Click Load
			Setlog("   3. Click load button")

			$idx2 = 0
			While $idx2 <= 15					; Checking Text Box continuously in 15sec
				If _ColorCheck(_GetPixelColor(585, 16, True), "F88088", 20) Then	; Pink (close icon)
					PureClick(360, 195, 1, 0, "Click Text box")
					Setlog("   4. Click text box")
					If _Sleep(500) Then Return
					AndroidSendText("CONFIRM")
					ExitLoop
				Else
					If _Sleep(900) Then Return
					$idx2 = $idx2 + 1
					If $idx2 = 15 Then SwitchFail_runBot()
				EndIf
			WEnd

			$idx3 = 0
			While $idx3 <= 10					; Checking OKAY Button continuously in 10sec
				If _ColorCheck(_GetPixelColor(480, 200, True), "71BB1E", 20) Then
					PureClick(480, 200, 1, 0, "Click OKAY")      ;Click OKAY
					Setlog("   5. Click OKAY")
					ExitLoop
				Else
					If _Sleepstatus(900) Then Return
					$idx3 = $idx3 + 1
					If $idx2 = 10 Then SwitchFail_runBot()
				EndIf
			WEnd

			Setlog("please wait for loading CoC")
			checkMainScreen()
			$bReMatchAcc = False
			$iShouldRearm = True
			$iAttackedCountSwitch = $iAttackedVillageCount[0] + $iAttackedVillageCount[1] + $iAttackedVillageCount[2] +$iAttackedVillageCount[3]
			ExitLoop

		Else
			If _Sleepstatus(900) Then Return
			$idx += 1
			If $idx = 15 Then SwitchFail_runBot()

		EndIf
	WEnd

EndFunc     ;==> SwitchCOCAcc

Func SwitchFail_runBot()
	Setlog("Switching account failed!", $COLOR_RED)
	$bReMatchAcc = True
	PureClickP($aAway, 3, 500)
	checkMainScreen()
	runBot()
EndFunc

