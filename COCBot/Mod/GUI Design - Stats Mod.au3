; #FUNCTION# ====================================================================================================================
; Name ..........: GUI Design - Stats Mod
; Description ...: Extension of GUI Design Child Bot - Stats
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

;TAB Profile Stats - SwitchAcc Mode - DEMEN
$hGUI_STATS_TAB_ITEM4 = GUICtrlCreateTabItem("Profile Stats")


Local $x = 25, $y = 30

; total gain
Global $aGoldTotalAcc[8], $aElixirTotalAcc[8], $aDarkTotalAcc[8], $aTrophyLootAcc[8], $aAttackedCountAcc[8], $aSkippedVillageCountAcc[8]

; village report
Global $aGoldCurrentAcc[8], $aElixirCurrentAcc[8], $aDarkCurrentAcc[8], $aTrophyCurrentAcc[8], $aGemAmountAcc[8], $aFreeBuilderCountAcc[8], $aTotalBuilderCountAcc[8]


Global $grpVillageAcc[8], $lblResultGoldNowAcc[8], $lblResultElixirNowAcc[8], $lblResultDENowAcc[8], $lblResultTrophyNowAcc[8], $lblResultBuilderNowAcc[8], $lblResultGemNowAcc[8]
Global $lblGoldLootAcc[8], $lblElixirLootAcc[8], $lblDarkLootAcc[8], $lblTrophyLootAcc[8]
Global $lblHourlyStatsGoldAcc[8], $lblHourlyStatsElixirAcc[8], $lblHourlyStatsDarkAcc[8], $lblHourlyStatsTrophyAcc[8]
Global $aStartHide[8], $aSecondHide[8],$aEndHide[8]

	$lblStatsRev = GUICtrlCreateLabel("Stats", $x - 10, $y, 87, 17, $SS_CENTER)
	GUICtrlSetBkColor(-1, 0xA8A8A8)
	GUICtrlSetFont(-1, 9, $FW_BOLD, Default, "Arial", $CLEARTYPE_QUALITY)
	GUICtrlSetColor(-1, $COLOR_BLACK)
	$lblGoldRev = GUICtrlCreateLabel("Gold", $x + 77, $y, 95, 17, $SS_CENTER)
	GUICtrlSetBkColor(-1, 0xA8A8A8)
	GUICtrlSetFont(-1, 9, $FW_BOLD, Default, "Arial", $CLEARTYPE_QUALITY)
	GUICtrlSetColor(-1, $COLOR_BLACK)
	$lblElixirRev = GUICtrlCreateLabel("Elixir", $x + 172, $y, 75, 17, $SS_CENTER)
	GUICtrlSetBkColor(-1, 0xA8A8A8)
	GUICtrlSetFont(-1, 9, $FW_BOLD, Default, "Arial", $CLEARTYPE_QUALITY)
	GUICtrlSetColor(-1, $COLOR_BLACK)
	$lblDarkRev = GUICtrlCreateLabel("DarkE", $x + 247, $y, 90, 17, $SS_CENTER)
	GUICtrlSetBkColor(-1, 0xA8A8A8)
	GUICtrlSetFont(-1, 9, $FW_BOLD, Default, "Arial", $CLEARTYPE_QUALITY)
	GUICtrlSetColor(-1, $COLOR_BLACK)
	$lblTrophyRev = GUICtrlCreateLabel("Trophy", $x + 327, $y, 75, 17, $SS_CENTER)
	GUICtrlSetBkColor(-1, 0xA8A8A8)
	GUICtrlSetFont(-1, 9, $FW_BOLD, Default, "Arial", $CLEARTYPE_QUALITY)
	GUICtrlSetColor(-1, $COLOR_BLACK)


   For $i = 0 To 3
	   $x = 15
	   $y = 50

	   $delY = 78
	   $delX = 85

	   $aStartHide[$i] = GUICtrlCreateDummy()

	   $grpVillageAcc[$i] = GUICtrlCreateGroup("Village: ", $x-10, $y + $i * $delY, 425, 75)
		If $i <= $nTotalProfile - 1 Then GUICtrlSetData(-1, "Village: " & $ProfileList[$i+1])

		 GUICtrlCreateGraphic($x + 295, $y + $i * $delY, 115, 17, $SS_WHITERECT)
		 $lblResultBuilderNowAcc[$i] = GUICtrlCreateLabel("", $x + 285, $y + $i * $delY, 30, 17, $SS_RIGHT)
;~ 		 GUICtrlSetBkColor(-1, $COLOR_WHITE)

		 GUICtrlCreateIcon ($pIconLib, $eIcnBuilder, $x + 320, $y + $i * $delY, 16, 14)

		 $lblResultGemNowAcc[$i] = GUICtrlCreateLabel("", $x + 345, $y + $i * $delY, 40, 17, $SS_RIGHT)
;~  		 GUICtrlSetBkColor(-1, $COLOR_WHITE)

		 $picResultGemNowAcc = GUICtrlCreateIcon ($pIconLib, $eIcnGem, $x + 390, $y + $i * $delY, 16, 14)

		 $y +=17
	     GUICtrlCreateLabel("Village report:", $x + 10, $y + 1 + $i * $delY, - 1, - 1)

			 $lblResultGoldNowAcc[$i] = GUICtrlCreateLabel("0", $x + $delX, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 65 + $delX, $y + $i * $delY, 16, 16)
			 $lblResultElixirNowAcc[$i] = GUICtrlCreateLabel("0", $x + $delX*2, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 65 + $delX*2, $y + $i * $delY, 16, 16)
			 $lblResultDENowAcc[$i] = GUICtrlCreateLabel("0", $x + $delX*3, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 65 + $delX*3, $y + $i * $delY, 16, 16)
			 $lblResultTrophyNowAcc[$i] = GUICtrlCreateLabel("0", $x - 15 + $delX*4, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 50 + $delX*4, $y + $i * $delY, 16, 16)

		 $aSecondHide[$i] = GUICtrlCreateDummy()
		 $y +=17
	     GUICtrlCreateLabel("Gain per Hour:", $x + 10, $y + 1 + $i * $delY, - 1, - 1)

			 $lblHourlyStatsGoldAcc[$i] = GUICtrlCreateLabel("0/h", $x + $delX, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 65 + $delX, $y + $i * $delY, 16, 16)
			 $lblHourlyStatsElixirAcc[$i] = GUICtrlCreateLabel("0/h", $x + $delX*2, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 65 + $delX*2, $y + $i * $delY, 16, 16)
			 $lblHourlyStatsDarkAcc[$i] = GUICtrlCreateLabel("0/h", $x + $delX*3, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 65 + $delX*3, $y + $i * $delY, 16, 16)
			 $lblHourlyStatsTrophyAcc[$i] = GUICtrlCreateLabel("0/h", $x - 15 + $delX*4, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 50 + $delX*4, $y + $i * $delY, 16, 16)

		 $y +=17
	     GUICtrlCreateLabel("Total Gain:", $x + 10, $y + 1 + $i * $delY, - 1, - 1)

			 $lblGoldLootAcc[$i] = GUICtrlCreateLabel("0", $x + $delX, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 65 + $delX, $y + $i * $delY, 16, 16)
			 $lblElixirLootAcc[$i] = GUICtrlCreateLabel("0", $x + $delX*2, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 65 + $delX*2, $y + $i * $delY, 16, 16)
			 $lblDarkLootAcc[$i] = GUICtrlCreateLabel("0", $x + $delX*3, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 65 + $delX*3, $y + $i * $delY, 16, 16)
			 $lblTrophyLootAcc[$i] = GUICtrlCreateLabel("0", $x - 15 + $delX*4, $y + 1 + $i * $delY, 60, 17, $SS_RIGHT)
				GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 50 + $delX*4, $y + $i * $delY, 16, 16)

		 $aEndHide[$i] = GUICtrlCreateDummy()

		GUICtrlCreateGroup("", -99, -99, 1, 1)

		If $i > $nTotalProfile - 1 Then
			For $j = $aStartHide[$i] To $aEndHide[$i]
				GUICtrlSetState($j, $GUI_HIDE)
			Next
		EndIf

   Next

;-->TAB Gain Separate - Stats Per Profile - SwitchAcc Mode - DEMEN