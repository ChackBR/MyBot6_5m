; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global $lblProfileNo[8], $lblProfileName[8], $cmbAccountNo[8], $cmbProfileType[8]

$ProfileList = _GUICtrlComboBox_GetListArray($cmbProfile)
$nTotalProfile = _GUICtrlComboBox_GetCount($cmbProfile)

Local $x = 25, $y = 45	;	Keep upchanged as original GUI of Profile Tab

	$x = 22
	$y = 100

$grpSwitchAcc = GUICtrlCreateGroup("Switch Account Mode", $x - 12, $y - 20, 200, 300)
		$chkSwitchAcc = GUICtrlCreateCheckbox("Enable Switch Account", $x , $y, -1, -1)
			$txtTip = "Switch to another account & profile when troop training time is >= 3 minutes" & @CRLF & "This function supports maximum 6 CoC accounts & 6 Bot profiles" & @CRLF & "Make sure to create sufficient Profiles equal to number of CoC Accounts, and align the index of accounts order with profiles order"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkSwitchAcc")

		$lblTotalAccount = GUICtrlCreateLabel("Total CoC Acc:", $x + 15, $y + 29, -1, -1)
			$txtTip = "Choose number of CoC Accounts pre-logged"

		$cmbTotalAccount= GUICtrlCreateCombo("", $x + 100, $y + 25, 60, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "1 Acc." & "|" & "2 Acc." & "|" & "3 Acc." & "|" & "4 Acc." & "|" & "5 Acc." & "|" & "6 Acc." & "|" & "7 Acc." & "|" & "8 Acc.")
			GUICtrlSetTip(-1, $txtTip)

		$radNormalSwitch = GUICtrlCreateRadio("Normal switch", $x + 15, $y + 55, -1, 16)
			GUICtrlSetTip(-1, "Switching accounts continously")
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "radNormalSwitch")

		$radSmartSwitch= GUICtrlCreateRadio("Smart switch", $x + 100 , $y + 55, -1, 16)
			GUICtrlSetTip(-1, "Switch to account with the shortest remain training time")
			GUICtrlSetOnEvent(-1, "radNormalSwitch")

		$y += 80

		$chkUseTrainingClose = GUICtrlCreateCheckbox("Combo Sleep after Switch Acc.", $x, $y, -1, -1)
			$txtTip = "Close CoC combo with Switch Account when there is more than 3 mins remaining on training time of all accounts."
			GUICtrlSetTip(-1, $txtTip)

		GUIStartGroup()
		$radCloseCoC= GUICtrlCreateRadio("Close CoC", $x + 15 , $y + 30, -1, 16)
			GUICtrlSetState(-1, $GUI_CHECKED)

		$radCloseAndroid = GUICtrlCreateRadio("Close Android", $x + 100, $y + 30, -1, 16)

		$y += 60

		$lblLocateAcc = GUICtrlCreateLabel("Manually locate account coordinates", $x, $y, -1, -1)

		$cmbLocateAcc = GUICtrlCreateCombo("", $x + 15, $y + 25, 60, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Select CoC Account to manually locate its y-coordinate"
			GUICtrlSetData(-1, "Acc. 1" & "|" & "Acc. 2" & "|" & "Acc. 3" & "|" & "Acc. 4" & "|" & "Acc. 5" & "|" & "Acc. 6" & "|" & "Acc. 7" & "|" & "Acc. 8", "Acc. 1")
			GUICtrlSetTip(-1, $txtTip)

		GUICtrlCreateButton("Locate", $x + 80, $y + 24 , 50, 23)
			GUICtrlSetTip(-1, "Starting locate your CoC Account")
			GUICtrlSetOnEvent(-1, "btnLocateAcc")

		GUICtrlCreateButton("Clear All", $x + 135, $y + 24 , 50, 23, $BS_MULTILINE)
			GUICtrlSetTip(-1, "clear location data of all accounts")
			GUICtrlSetOnEvent(-1, "btnClearAccLocation")

	GUICtrlCreateGroup("", -99, -99, 1, 1)

; Profiles & Account matching

	Local $x = 235, $y = 100
	$grpSwitchAccMapping = GUICtrlCreateGroup("Profiles", $x - 20, $y - 20, 225, 300)
		$btnUpdateProfiles = GUICtrlCreateButton("Update Profiles", $x + 40, $y - 5 , -1, 25)
			GUICtrlSetOnEvent(-1, "btnUpdateProfile")
		$btnClearAllProfiles = GUICtrlCreateButton("Clear Profiles", $x + 130, $y - 5 , -1, 25)
			GUICtrlSetOnEvent(-1, "btnClearProfile")

	$y += 35
		GUICtrlCreateLabel("No.", $x-10, $y, 15,-1,$SS_CENTER)
		GUICtrlCreateLabel("Profile Name", $x+10, $y, 90,-1,$SS_CENTER)
		GUICtrlCreateLabel("Acc.", $x+105, $y, 30,-1,$SS_CENTER)
		GUICtrlCreateLabel("Bot Type", $x+140, $y, 60,-1,$SS_CENTER)

	$y += 20
		GUICtrlCreateGraphic($x - 10, $y, 205, 1, $SS_GRAYRECT)
		GUICtrlCreateGraphic($x + 10, $y - 25, 1, 40, $SS_GRAYRECT)

	$y += 10
		 For $i = 0 To 7
			$lblProfileNo[$i] = GUICtrlCreateLabel($i + 1 & ".", $x -10, $y + 4 + ($i) * 25, 15, 18, $SS_CENTER)
			GUICtrlCreateGraphic($x + 10, $y + ($i) * 25, 1, 25, $SS_GRAYRECT)

			$lblProfileName[$i] = GUICtrlCreateLabel("Village Name", $x +10, $y + 4 + ($i) * 25, 90, 18, $SS_CENTER)
				If $i <= $nTotalProfile - 1 Then GUICtrlSetData(-1, $ProfileList[$i+1])
			$cmbAccountNo[$i] = GUICtrlCreateCombo("", $x + 105, $y + ($i) * 25, 30, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				$txtTip = "Select the index of CoC Account to match with this Profile"
				GUICtrlSetData(-1, "1" & "|" & "2" & "|" & "3" & "|" & "4" & "|" & "5" & "|" & "6" & "|" & "7" & "|" & "8")
				GUICtrlSetTip(-1, $txtTip)
				GUICtrlSetOnEvent(-1, "cmbMatchProfileAcc"&$i+1)
			$cmbProfileType[$i] = GUICtrlCreateCombo("", $x + 140, $y + ($i) * 25, 60, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				$txtTip = "Define the botting type of this profile"
				GUICtrlSetData(-1, "Active" & "|" & "Donate" & "|" & "Idle")
				GUICtrlSetTip(-1, $txtTip)
			If $i > $nTotalProfile - 1 Then
				For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
					GUICtrlSetState($j, $GUI_HIDE)
				Next
			EndIf

		 Next
		 GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateGroup("", -99, -99, 1, 1)

