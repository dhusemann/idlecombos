#SingleInstance Force
#include %A_ScriptDir%
#include JSON.ahk
#include idledict.ahk
;3.10
;add working core 4 and party 4 thanks Fmagdi
;hopeful fix for opening to many chest ban thanks deathoone
;support for huge contracts thanks NeyahPeterson
;3.00
;disabled log files by default
;2.00
;2/15/22 servers settle down, reduce timer to .5 secs for Chest
;open routine 
;work to clean up chest open message box with help from community
;TODO::note community help names from discord.
;work to clean up menu so links work in progress, most of it backed Out 
;due to a wierd git conflict that would never resolve and roll back to earlier
;client. including most of the work that had been done to limit log files locally
;once steam idlecombos working merge recent changes into egs client, and maybe
;make the dhani paint work. Or focus Idlecombos.
;1.98
;update idledict content, 
;added NERDS as evergreen for equipment screen
;1.97
;include fixes for single instance from mikebaldi
;1.96
;update dict file to latest content and versioned to 1.96 
;1.95
;disabled opening chest while client is open, 
;1.94
;Updated Cleaned up UI around redeam codes with mikebaldi1980 Help
;added in party 3 and core 3 with code from HPX
;updated Eunomiac code to copy and find code from discord combination channel
;should be robust enough to find chest code in most channel but haven't verified
;1.93
;more work to clean up window for combination code.
;Added in 1.92
;added Eunomiac code to copy and find code from discord combination channel
;Added in 1.91
;Added DeathoEye Server update
;Neal's Json escape code for redeaming codes
;updated dict file to 1.91 champs, chest and feats up to UserDetailsFile

;Added in 1.9
;-Patron Zariel
;-Dictionary file updated to 1.9
;
;Added in 1.8
;-Pity Timer for Golds on Inventory Tab
;-Event Pity Timers in the Chests menu
;-More info on number of tokens/FPs available
;-Kleho image now works for Events & TGs
;-Fix for "Chests Opened: 0" in log output
;-Dictionary file updated to 1.8
;-(Also resized the window finally) :P

;Special thanks to all the idle dragons who inspired and assisted me!
global VersionNumber := "3.10"
global CurrentDictionary := "2.00"

;Local File globals
;global OutputLogFile := "idlecombolog.txt"
global OutputLogFile := ""
global SettingsFile := "idlecombosettings.json"
global UserDetailsFile := "userdetails.json"
global ChestOpenLogFile := "chestopenlog.json"
global BlacksmithLogFile := "blacksmithlog.json"
global RedeemCodeLogFile := "redeemcodelog.json"
global JournalFile := "journal.json"
global CurrentSettings := []
global GameInstallDir := "C:\Program Files (x86)\Steam\steamapps\common\IdleChampions\"
global WRLFile := GameInstallDir "IdleDragons_Data\StreamingAssets\downloaded_files\webRequestLog.txt"
global DictionaryFile := "https://raw.githubusercontent.com/dhusemann/idlecombos/master/idledict.ahk"
global LocalDictionary := "idledict.ahk"

global ICSettingsFile := A_AppData
StringTrimRight, ICSettingsFile, ICSettingsFile, 7
ICSettingsFile := ICSettingsFile "LocalLow\Codename Entertainment\Idle Champions\localSettings.json"
global GameClient := GameInstallDir "IdleDragons.exe"

;Settings globals
global ServerName := "ps7"
global GetDetailsonStart := 0
global LaunchGameonStart := 0
global FirstRun := 1
global AlwaysSaveChests := 0
global AlwaysSaveContracts := 0
global AlwaysSaveCodes := 0
global NoSaveSetting := 0
global SettingsCheckValue := 11 ;used to check for outdated settings file
global NewSettings := JSON.stringify({"servername":"ps7","firstrun":0,"user_id":0,"hash":0,"instance_id":0,"getdetailsonstart":0,"launchgameonstart":0,"alwayssavechests":1,"alwayssavecontracts":1,"alwayssavecodes":1, "NoSaveSetting":0})

;Server globals
global DummyData := "&language_id=1&timestamp=0&request_id=0&network_id=11&mobile_client_version=999"
global CodestoEnter := ""

;User info globals
global UserID := 0
global UserHash := 0
global InstanceID := 0
global UserDetails := []
global ActiveInstance := 0
global CurrentAdventure := ""
global CurrentArea := ""
global CurrentPatron := ""
global BackgroundAdventure := ""
global BackgroundArea := ""
global BackgroundPatron := ""
global Background2Adventure := ""
global Background2Area := ""
global Background2Patron := ""
global Background3Adventure := ""
global Background3Area := ""
global Background3Patron := ""
global AchievementInfo := "This page intentionally left blank.`n`n`n`n`n`n`n"
global BlessingInfo := "`n`n`n`n`n`n"
global ChampDetails := ""
global TotalChamps := 0
;Inventory globals
global CurrentGems := ""
global AvailableChests := ""
global SpentGems := ""
global CurrentGolds := ""
global GoldPity := ""
global CurrentSilvers := ""
global CurrentTGPs := ""
global AvailableTGs := ""
global NextTGPDrop := ""
global CurrentTokens := ""
global CurrentTinyBounties := ""
global CurrentSmBounties := ""
global CurrentMdBounties := ""
global CurrentLgBounties := ""
global AvailableTokens := ""
global AvailableFPs := ""
global CurrentTinyBS := ""
global CurrentSmBS := ""
global CurrentMdBS := ""
global CurrentLgBS := ""
global CurrentHgBS := ""
global AvailableBSLvs := ""
;Loot globals
global EpicGearCount := 0
global BrivSlot4 := 0
global BrivZone := 0
;Modron globals
global FGCore := "`n`n"
global BGCore := "`n`n"
global BG2Core := "`n`n"
global BG3Core := "`n`n"
;Patron globals
global MirtVariants := ""
global MirtCompleted := ""
global MirtVariantTotal := ""
global MirtFPCurrency := ""
global MirtChallenges := ""
global MirtRequires := ""
global MirtCosts := ""
global VajraVariants := ""
global VajraCompleted := ""
global VajraVariantTotal := ""
global VajraFPCurrency := ""
global VajraChallenges := ""
global VajraRequires := ""
global VajraCosts := ""
global StrahdVariants := ""
global StrahdCompleted := ""
global StrahdVariantTotal := ""
global StrahdFPCurrency := ""
global StrahdChallenges := ""
global StrahdRequires := ""
global StrahdCosts := ""
global ZarielVariants := ""
global ZarielCompleted := ""
global ZarielVariantTotal := ""
global ZarielFPCurrency := ""
global ZarielChallenges := ""
global ZarielRequires := ""
global ZarielCosts := ""
;Web Tools globals
global WebToolCodes := "https://incendar.com/idlechampions_codes.php#123"

;GUI globals
global oMyGUI := ""
global OutputText := "Test"
global OutputStatus := "Welcome to IdleCombos v" VersionNumber
global CurrentTime := ""
global CrashProtectStatus := "Crash Protect`nDisabled"
global CrashCount := 0
global LastUpdated := "No data loaded."
global TrayIcon := systemroot "\system32\imageres.dll"
global LastBSChamp := ""
global foundCodeString := ""

;BEGIN:	default run commands
if FileExist(TrayIcon) {
	if (SubStr(A_OSVersion, 1, 2) == 10) {
		Menu, Tray, Icon, %TrayIcon%, 300
	}
	else if (A_OSVersion == "WIN_8") {
		Menu, Tray, Icon, %TrayIcon%, 284
	}
	else if (A_OSVersion == "WIN_7") {
		Menu, Tray, Icon, %TrayIcon%, 78
	}
	else if (A_OSVersion == "WIN_VISTA") {
		Menu, Tray, Icon, %TrayIcon%, 77
	} ; WIN_8.1, WIN_2003, WIN_XP, WIN_2000, WIN_NT4, WIN_95, WIN_98, WIN_ME
}
UpdateLogTime()
FileAppend, (%CurrentTime%) IdleCombos v%VersionNumber% started.`n, %OutputLogFile%
FileRead, OutputText, %OutputLogFile%
if (!oMyGUI) {
	oMyGUI := new MyGui()
}
;First run checks and setup
if !FileExist(SettingsFile) {
	FileAppend, %NewSettings%, %SettingsFile%
	UpdateLogTime()
	FileAppend, (%CurrentTime%) Settings file "idlecombosettings.json" created.`n, %OutputLogFile%
	FileRead, OutputText, %OutputLogFile%
	oMyGUI.Update()
}
FileRead, rawsettings, %SettingsFile%
CurrentSettings := JSON.parse(rawsettings)
if !(CurrentSettings.Count() == SettingsCheckValue) {
	FileDelete, %SettingsFile%
	FileAppend, %NewSettings%, %SettingsFile%
	UpdateLogTime()
	FileAppend, (%CurrentTime%) Settings file "idlecombosettings.json" created.`n, %OutputLogFile%
	FileRead, OutputText, %OutputLogFile%
	FileRead, rawsettings, %SettingsFile%
	CurrentSettings := JSON.parse(rawsettings)
	oMyGUI.Update()
	MsgBox, Your settings file has been deleted due to an update to IdleCombos. Please verify that your settings are set as preferred.
}
if FileExist(A_ScriptDir "\webRequestLog.txt") {
	MsgBox, 4, , % "WRL File detected. Use file?"
	IfMsgBox, Yes
	{
		WRLFile := A_ScriptDir "\webRequestLog.txt"
		FirstRun()
	}
}
if !(CurrentSettings.firstrun) {
	FirstRun()
}
if (CurrentSettings.user_id && CurrentSettings.hash) {
	UserID := CurrentSettings.user_id
	UserHash := CurrentSettings.hash
	InstanceID := CurrentSettings.instance_id
	SB_SetText("User ID & Hash ready.")
}
else {
	SB_SetText("User ID & Hash not found!")
}
;Loading current settings
ServerName := CurrentSettings.servername
GetDetailsonStart := CurrentSettings.getdetailsonstart
LaunchGameonStart := CurrentSettings.launchgameonstart
AlwaysSaveChests := CurrentSettings.alwayssavechests
AlwaysSaveContracts := CurrentSettings.alwayssavecontracts
AlwaysSaveCodes := CurrentSettings.alwayssavecodes
NoSaveSetting := CurrentSettings.NoSaveSetting
if (GetDetailsonStart == "1") {
	GetUserDetails()
}
if (LaunchGameonStart == "1") {
	LaunchGame()
}
oMyGUI.Update()
SendMessage, 0x115, 7, 0, Edit1, A
return
;END:	default run commands

;BEGIN: GUI Defs
class MyGui {
	Width := "550"
	Height := "275" ;"250"

	__New()
	{
		Gui, MyWindow:New
		Gui, MyWindow:+Resize -MaximizeBox 

		Menu, ICSettingsSubmenu, Add, &View Settings, ViewICSettings
		Menu, ICSettingsSubmenu, Add, &Framerate, SetFramerate
		Menu, ICSettingsSubmenu, Add, &Particles, SetParticles
		Menu, ICSettingsSubmenu, Add, &UI Scale, SetUIScale
		Menu, FileSubmenu, Add, &Idle Champions Settings, :ICSettingsSubmenu

		Menu, FileSubmenu, Add, &Launch Game Client, LaunchGame
		Menu, FileSubmenu, Add, &Update UserDetails, GetUserDetails
		Menu, FileSubmenu, Add
		Menu, FileSubmenu, Add, &Reload IdleCombos, Reload_Clicked
		Menu, FileSubmenu, Add, E&xit IdleCombos, Exit_Clicked
		Menu, IdleMenu, Add, &File, :FileSubmenu

		Menu, ChestsSubmenu, Add, Buy Gold, Buy_Gold
		Menu, ChestsSubmenu, Add, Buy Silver, Buy_Silver
		Menu, ChestsSubmenu, Add, Open Gold, Open_Gold
		Menu, ChestsSubmenu, Add, Open Silver, Open_Silver
		Menu, ChestsSubmenu, Add, Pity Timers, ShowPityTimers
		Menu, ToolsSubmenu, Add, &Chests, :ChestsSubmenu

		Menu, BlacksmithSubmenu, Add, Use Tiny Contracts, Tiny_Blacksmith
		Menu, BlacksmithSubmenu, Add, Use Small Contracts, Sm_Blacksmith
		Menu, BlacksmithSubmenu, Add, Use Medium Contracts, Med_Blacksmith
		Menu, BlacksmithSubmenu, Add, Use Large Contracts, Lg_Blacksmith
		Menu, BlacksmithSubmenu, Add, Use Huge Contracts, Hg_Blacksmith
		Menu, BlacksmithSubmenu, Add, Item Level Report, GearReport
		Menu, BlacksmithSubmenu, Add, Active Patron Feats, PatronFeats
		Menu, ToolsSubmenu, Add, &Blacksmith, :BlacksmithSubmenu

		Menu, ToolsSubmenu, Add, &Redeem Codes, Open_Codes

		Menu, AdvSubmenu, Add, &Load New Adv, LoadAdventure
		Menu, AdvSubmenu, Add, &End Current Adv, EndAdventure
		;Menu, AdvSubmenu, Add, Load New BG Adv, LoadBGAdventure
		Menu, AdvSubmenu, Add, End Background Adv, EndBGAdventure
		Menu, AdvSubmenu, Add, End Background2 Adv, EndBG2Adventure
		Menu, AdvSubmenu, Add, End Background3 Adv, EndBG3Adventure
		Menu, AdvSubmenu, Add, &Kleho Image, KlehoImage
		Menu, AdvSubmenu, Add, &Incomplete Variants, IncompleteVariants
		Menu, AdvSubmenu, Add, Adventure List, AdventureList
		Menu, ToolsSubmenu, Add, &Adventure Manager, :AdvSubmenu

		Menu, ToolsSubmenu, Add, &Briv Stack Calculator, Briv_Calc
		Menu, IdleMenu, Add, &Tools, :ToolsSubmenu

		Menu, HelpSubmenu, Add, &Run Setup, FirstRun
		Menu, HelpSubmenu, Add, Clear &Log, Clear_Log
		Menu, HelpSubmenu, Add, Download &Journal, Get_Journal
		Menu, HelpSubmenu, Add, CNE &Support Ticket, Open_Ticket
		Menu, HelpSubmenu, Add
		Menu, HelpSubmenu, Add, &List Champ IDs, List_ChampIDs
		Menu, HelpSubmenu, Add, &About IdleCombos, About_Clicked
		Menu, HelpSubmenu, Add, &Update Dictionary, Update_Dictionary
		Menu, HelpSubmenu, Add, &Discord Support Server, Discord_Clicked
		Menu, IdleMenu, Add, &Help, :HelpSubmenu
		Gui, Menu, IdleMenu

		col1_x := 5
		col2_x := 420
		col3_x := 480
		row_y := 5

		Gui, Add, StatusBar,, %OutputStatus%

		Gui, MyWindow:Add, Button, x%col2_x% y%row_y% w60 gReload_Clicked, Reload
		Gui, MyWindow:Add, Button, x%col3_x% y%row_y% w60 gExit_Clicked, Exit

		Gui, MyWindow:Add, Tab3, x%col1_x% y%row_y% w400 h250, Summary|Adventures|Inventory||Patrons|Champions|Settings|Log|
		Gui, Tab

		row_y := row_y + 25
		;Gui, MyWindow:Add, Button, x%col3_x% y%row_y% w60 gUpdate_Clicked, Update
		row_y := row_y + 25

		Gui, MyWindow:Add, Text, x410 y53 vCrashProtectStatus, % CrashProtectStatus
		Gui, MyWindow:Add, Button, x%col3_x% y%row_y% w60 gCrash_Toggle, Toggle

		Gui, MyWindow:Add, Text, x410 y100, Data Timestamp:
		Gui, MyWindow:Add, Text, x410 y120 vLastUpdated w220, % LastUpdated
		Gui, MyWindow:Add, Button, x410 y140 w60 gUpdate_Clicked, Update

		Gui, Tab, Summary
		Gui, MyWindow:Add, Text, vAchievementInfo x15 y33 w300, % AchievementInfo
		Gui, MyWindow:Add, Text, vBlessingInfo x200 y33 w300, % BlessingInfo

		Gui, Tab, Adventures
		Gui, MyWindow:Add, Text, x15 y33 w130, Current Adventure:
		Gui, MyWindow:Add, Text, vCurrentAdventure x+2 w50, % CurrentAdventure
		Gui, MyWindow:Add, Text, x15 y+p w130, Current Patron:
		Gui, MyWindow:Add, Text, vCurrentPatron x+2 w50, % CurrentPatron
		Gui, MyWindow:Add, Text, x15 y+p w130, Current Area:
		Gui, MyWindow:Add, Text, vCurrentArea x+2 w50, % CurrentArea
		Gui, MyWindow:Add, Text, x15 y76 w130, Background Adventure:
		Gui, MyWindow:Add, Text, vBackgroundAdventure x+2 w50, % BackgroundAdventure
		Gui, MyWindow:Add, Text, x15 y+p w130, Background Patron:
		Gui, MyWindow:Add, Text, vBackgroundPatron x+2 w50, % BackgroundPatron
		Gui, MyWindow:Add, Text, x15 y+p w130, Background Area:
		Gui, MyWindow:Add, Text, vBackgroundArea x+2 w50, % BackgroundArea
		Gui, MyWindow:Add, Text, x15 y119 w130, Background2 Adventure:
		Gui, MyWindow:Add, Text, vBackground2Adventure x+2 w50, % Background2Adventure
		Gui, MyWindow:Add, Text, x15 y+p w130, Background2 Patron:
		Gui, MyWindow:Add, Text, vBackground2Patron x+2 w50, % Background2Patron
		Gui, MyWindow:Add, Text, x15 y+p w130, Background2 Area:
		Gui, MyWindow:Add, Text, vBackground2Area x+2 w50, % Background2Area
		Gui, MyWindow:Add, Text, x15 y162 w130, Background3 Adventure:
		Gui, MyWindow:Add, Text, vBackground3Adventure x+2 w50, % Background3Adventure
		Gui, MyWindow:Add, Text, x15 y+p w130, Background3 Patron:
		Gui, MyWindow:Add, Text, vBackground3Patron x+2 w50, % Background3Patron
		Gui, MyWindow:Add, Text, x15 y+p w130, Background3 Area:
		Gui, MyWindow:Add, Text, vBackground3Area x+2 w50, % Background3Area

		Gui, MyWindow:Add, Text, vFGCore x200 y33 w150, % FGCore
		Gui, MyWindow:Add, Text, vBGCore x200 y76 w150, % BGCore
		Gui, MyWindow:Add, Text, vBG2Core x200 y119 w150, % BG2Core
		Gui, MyWindow:Add, Text, vBG3Core x200 y162 w150, % BG3Core

		Gui, Tab, Inventory
		Gui, MyWindow:Add, Text, x15 y33 w70, Current Gems:
		Gui, MyWindow:Add, Text, vCurrentGems x+2 w75 right, % CurrentGems
		Gui, MyWindow:Add, Text, vAvailableChests x+10 w190, % AvailableChests
		Gui, MyWindow:Add, Text, x15 y+p w70, (Spent Gems):
		Gui, MyWindow:Add, Text, vSpentGems x+2 w75 right, % SpentGems

		Gui, MyWindow:Add, Text, x15 y+5+p w110, Gold Chests:
		Gui, MyWindow:Add, Text, vCurrentGolds x+2 w35 right, % CurrentGolds
		Gui, MyWindow:Add, Text, vGoldPity x+10 w190, % GoldPity
		Gui, MyWindow:Add, Text, x15 y+p w110, Silver Chests:
		Gui, MyWindow:Add, Text, vCurrentSilvers x+2 w35 right, % CurrentSilvers
		Gui, MyWindow:Add, Text, x+105 y+1 w185, Next TGP:
		Gui, MyWindow:Add, Text, x15 y+0 w110, Time Gate Pieces:
		Gui, MyWindow:Add, Text, vCurrentTGPs x+2 w35 right, % CurrentTGPs
		Gui, MyWindow:Add, Text, vAvailableTGs x+10 w85, % AvailableTGs
		Gui, MyWindow:Add, Text, vNextTGPDrop x+10 w220, % NextTGPDrop

		Gui, MyWindow:Add, Text, x15 y+5+p w110, Tiny Bounties:
		Gui, MyWindow:Add, Text, vCurrentTinyBounties x+2 w35 right, % CurrentTinyBounties
		Gui, MyWindow:Add, Text, x15 y+p w110, Small Bounties:
		Gui, MyWindow:Add, Text, vCurrentSmBounties x+2 w35 right, % CurrentSmBounties
		Gui, MyWindow:Add, Text, vAvailableTokens x+10 w220, % AvailableTokens
		Gui, MyWindow:Add, Text, x15 y+p w110, Medium Bounties:
		Gui, MyWindow:Add, Text, vCurrentMdBounties x+2 w35 right, % CurrentMdBounties
		Gui, MyWindow:Add, Text, vCurrentTokens x+10 w185, % CurrentTokens
		Gui, MyWindow:Add, Text, x15 y+p w110, Large Bounties:
		Gui, MyWindow:Add, Text, vCurrentLgBounties x+2 w35 right, % CurrentLgBounties
		Gui, MyWindow:Add, Text, vAvailableFPs x+10 w220, % AvailableFPs

		Gui, MyWindow:Add, Text, x15 y+5+p w110, Tiny Blacksmiths:
		Gui, MyWindow:Add, Text, vCurrentTinyBS x+2 w35 right, % CurrentTinyBS
		Gui, MyWindow:Add, Text, vAvailableBSLvs x+10 w175, % AvailableBSLvs
		Gui, MyWindow:Add, Text, x15 y+p w110, Small Blacksmiths:
		Gui, MyWindow:Add, Text, vCurrentSmBS x+2 w35 right, % CurrentSmBS
		Gui, MyWindow:Add, Text, x15 y+p w110, Medium Blacksmiths:
		Gui, MyWindow:Add, Text, vCurrentMdBS x+2 w35 right, % CurrentMdBS
		Gui, MyWindow:Add, Text, x15 y+p w110, Large Blacksmiths:
		Gui, MyWindow:Add, Text, vCurrentLgBS x+2 w35 right, % CurrentLgBS
		Gui, MyWindow:Add, Text, x15 y+p w110, Huge Blacksmiths:
		Gui, MyWindow:Add, Text, vCurrentHgBS x+2 w35 right, % CurrentHgBS

		Gui, Tab, Patrons
		Gui, MyWindow:Add, Text, x15 y33 w75, Mirt Variants:
		Gui, MyWindow:Add, Text, vMirtVariants x+p w75 right cRed, % MirtVariants
		Gui, MyWindow:Add, Text, x15 y+p w95, Mirt FP Currency:
		Gui, MyWindow:Add, Text, vMirtFPCurrency x+p w55 right cRed, % MirtFPCurrency
		Gui, MyWindow:Add, Text, vMirtRequires x+2 w200 right, % MirtRequires
		Gui, MyWindow:Add, Text, x15 y+p w95, Mirt Challenges:
		Gui, MyWindow:Add, Text, vMirtChallenges x+p w55 right cRed, % MirtChallenges
		Gui, MyWindow:Add, Text, vMirtCosts x+2 w200 right, % MirtCosts

		Gui, MyWindow:Add, Text, x15 y+5+p w75, Vajra Variants:
		Gui, MyWindow:Add, Text, vVajraVariants x+p w75 right cRed, % VajraVariants
		Gui, MyWindow:Add, Text, x15 y+p w95, Vajra FP Currency:
		Gui, MyWindow:Add, Text, vVajraFPCurrency x+p w55 right cRed, % VajraFPCurrency
		Gui, MyWindow:Add, Text, vVajraRequires x+2 w200 right, % VajraRequires
		Gui, MyWindow:Add, Text, x15 y+p w95, Vajra Challenges:
		Gui, MyWindow:Add, Text, vVajraChallenges x+p w55 right cRed, % VajraChallenges
		Gui, MyWindow:Add, Text, vVajraCosts x+2 w200 right, % VajraCosts

		Gui, MyWindow:Add, Text, x15 y+5+p w75, Strahd Variants:
		Gui, MyWindow:Add, Text, vStrahdVariants x+p w75 right cRed, % StrahdVariants
		Gui, MyWindow:Add, Text, x15 y+p w95, Strahd FP Currency:
		Gui, MyWindow:Add, Text, vStrahdFPCurrency x+p w55 right cRed, % StrahdFPCurrency
		Gui, MyWindow:Add, Text, vStrahdRequires x+2 w200 right, % StrahdRequires
		Gui, MyWindow:Add, Text, x15 y+p w95, Strahd Challenges:
		Gui, MyWindow:Add, Text, vStrahdChallenges x+p w55 right cRed, % StrahdChallenges
		Gui, MyWindow:Add, Text, vStrahdCosts x+2 w200 right, % StrahdCosts

		Gui, MyWindow:Add, Text, x15 y+5+p w75, Zariel Variants:
		Gui, MyWindow:Add, Text, vZarielVariants x+p w75 right cRed, % ZarielVariants
		Gui, MyWindow:Add, Text, x15 y+p w95, Zariel FP Currency:
		Gui, MyWindow:Add, Text, vZarielFPCurrency x+p w55 right cRed, % ZarielFPCurrency
		Gui, MyWindow:Add, Text, vZarielRequires x+2 w200 right, % ZarielRequires
		Gui, MyWindow:Add, Text, x15 y+p w95, Zariel Challenges:
		Gui, MyWindow:Add, Text, vZarielChallenges x+p w55 right cRed, % ZarielChallenges
		Gui, MyWindow:Add, Text, vZarielCosts x+2 w200 right, % ZarielCosts

		Gui, Tab, Champions
		Gui, MyWindow:Add, Text, vChampDetails x15 y33 w300 h180, % ChampDetails

		Gui, Tab, Settings
		Gui, MyWindow:Add, Text,, Server Name:
		Gui, MyWindow:Add, Edit, vServerName w50
		Gui, MyWindow:Add, CheckBox, vGetDetailsonStart, Get User Details on start?
		Gui, MyWindow:Add, CheckBox, vLaunchGameonStart, Launch game client on start?
		Gui, MyWindow:Add, CheckBox, vAlwaysSaveChests, Always save Chest Open Results to file?
		Gui, MyWindow:Add, CheckBox, vAlwaysSaveContracts, Always save Blacksmith Results to file?
		Gui, MyWindow:Add, CheckBox, vAlwaysSaveCodes, Always save Code Redeem Results to file?
		Gui, MyWindow:Add, Checkbox, vNoSaveSetting, Never save results to file?
		Gui, MyWindow:Add, Button, gSave_Settings, Save Settings

		Gui, Tab, Log
		Gui, MyWindow:Add, Edit, r12 vOutputText ReadOnly w360, %OutputText%
		this.Show()
	}

	Show() {
		;check if minimized if so leave it be
		WinGet, OutputVar , MinMax, IdleCombos v%VersionNumber%
		if (OutputVar = -1) {
			return
		}
		nW := this.Width
		nH := this.Height
		Gui, MyWindow:Show, w%nW% h%nH%, IdleCombos v%VersionNumber%
	}

	Hide() {
		Gui, MyWindow:Hide
	}

	Submit() {
		Gui, MyWindow:Submit, NoHide
	}

	Update() {
		GuiControl, MyWindow:, OutputText, % OutputText, w250 h210
		SendMessage, 0x115, 7, 0, Edit1
		GuiControl, MyWindow:, CrashProtectStatus, % CrashProtectStatus, w250 h210
		GuiControl, MyWindow:, AchievementInfo, % AchievementInfo, w250 h210
		GuiControl, MyWindow:, BlessingInfo, % BlessingInfo, w250 h210
		GuiControl, MyWindow:, LastUpdated, % LastUpdated, w250 h210
		;adventures
		GuiControl, MyWindow:, CurrentAdventure, % CurrentAdventure, w250 h210
		GuiControl, MyWindow:, CurrentArea, % CurrentArea, w250 h210
		GuiControl, MyWindow:, CurrentPatron, % CurrentPatron, w250 h210
		GuiControl, MyWindow:, BackgroundAdventure, % BackgroundAdventure, w250 h210
		GuiControl, MyWindow:, BackgroundArea, % BackgroundArea, w250 h210
		GuiControl, MyWindow:, BackgroundPatron, % BackgroundPatron, w250 h210
		GuiControl, MyWindow:, Background2Adventure, % Background2Adventure, w250 h210
		GuiControl, MyWindow:, Background2Area, % Background2Area, w250 h210
		GuiControl, MyWindow:, Background2Patron, % Background2Patron, w250 h210
		GuiControl, MyWindow:, Background3Adventure, % Background3Adventure, w250 h210
		GuiControl, MyWindow:, Background3Area, % Background3Area, w250 h210
		GuiControl, MyWindow:, Background3Patron, % Background3Patron, w250 h210

		GuiControl, MyWindow:, FGCore, % FGCore, w250 h210
		GuiControl, MyWindow:, BGCore, % BGCore, w250 h210
		GuiControl, MyWindow:, BG2Core, % BG2Core, w250 h210
		GuiControl, MyWindow:, BG3Core, % BG3Core, w250 h210
		;inventory
		GuiControl, MyWindow:, CurrentGems, % CurrentGems, w250 h210
		GuiControl, MyWindow:, SpentGems, % SpentGems, w250 h210
		GuiControl, MyWindow:, CurrentGolds, % CurrentGolds, w250 h210
		GuiControl, MyWindow:, GoldPity, % GoldPity, w250 h210
		GuiControl, MyWindow:, CurrentSilvers, % CurrentSilvers, w250 h210
		GuiControl, MyWindow:, CurrentTGPs, % CurrentTGPs, w250 h210
		GuiControl, MyWindow:, NextTGPDrop, % NextTGPDrop, w250 h210
		GuiControl, MyWindow:, AvailableTGs, % AvailableTGs, w250 h210
		GuiControl, MyWindow:, AvailableChests, % AvailableChests, w250 h210
		GuiControl, MyWindow:, CurrentTinyBounties, % CurrentTinyBounties, w250 h210
		GuiControl, MyWindow:, CurrentSmBounties, % CurrentSmBounties, w250 h210
		GuiControl, MyWindow:, CurrentMdBounties, % CurrentMdBounties, w250 h210
		GuiControl, MyWindow:, CurrentLgBounties, % CurrentLgBounties, w250 h210
		GuiControl, MyWindow:, AvailableTokens, % AvailableTokens, w250 h210
		GuiControl, MyWindow:, CurrentTokens, % CurrentTokens, w250 h210
		GuiControl, MyWindow:, AvailableFPs, % AvailableFPs, w250 h210
		GuiControl, MyWindow:, CurrentTinyBS, % CurrentTinyBS, w250 h210
		GuiControl, MyWindow:, CurrentSmBS, % CurrentSmBS, w250 h210
		GuiControl, MyWindow:, CurrentMdBS, % CurrentMdBS, w250 h210
		GuiControl, MyWindow:, CurrentLgBS, % CurrentLgBS, w250 h210
		GuiControl, MyWindow:, CurrentHgBS, % CurrentHgBS, w250 h210
		GuiControl, MyWindow:, AvailableBSLvs, % AvailableBSLvs, w250 h210
		;patrons
		GuiControl, MyWindow:, MirtVariants, % MirtVariants, w250 h210
		GuiControl, MyWindow:, MirtChallenges, % MirtChallenges, w250 h210
		GuiControl, MyWindow:, MirtFPCurrency, % MirtFPCurrency, w250 h210
		GuiControl, MyWindow:, MirtRequires, % MirtRequires, w250 h210
		GuiControl, MyWindow:, MirtCosts, % MirtCosts, w250 h210
		GuiControl, MyWindow:, VajraVariants, % VajraVariants, w250 h210
		GuiControl, MyWindow:, VajraChallenges, % VajraChallenges, w250 h210
		GuiControl, MyWindow:, VajraFPCurrency, % VajraFPCurrency, w250 h210
		GuiControl, MyWindow:, VajraRequires, % VajraRequires, w250 h210
		GuiControl, MyWindow:, VajraCosts, % VajraCosts, w250 h210
		GuiControl, MyWindow:, StrahdVariants, % StrahdVariants, w250 h210
		GuiControl, MyWindow:, StrahdChallenges, % StrahdChallenges, w250 h210
		GuiControl, MyWindow:, StrahdFPCurrency, % StrahdFPCurrency, w250 h210
		GuiControl, MyWindow:, StrahdRequires, % StrahdRequires, w250 h210
		GuiControl, MyWindow:, StrahdCosts, % StrahdCosts, w250 h210
		GuiControl, MyWindow:, ZarielVariants, % ZarielVariants, w250 h210
		GuiControl, MyWindow:, ZarielChallenges, % ZarielChallenges, w250 h210
		GuiControl, MyWindow:, ZarielFPCurrency, % ZarielFPCurrency, w250 h210
		GuiControl, MyWindow:, ZarielRequires, % ZarielRequires, w250 h210
		GuiControl, MyWindow:, ZarielCosts, % ZarielCosts, w250 h210		
		;champions
		GuiControl, MyWindow:, ChampDetails, % ChampDetails, w250 h210
		;settings
		GuiControl, MyWindow:, ServerName, % ServerName, w50 h210
		GuiControl, MyWindow:, GetDetailsonStart, % GetDetailsonStart, w250 h210
		GuiControl, MyWindow:, LaunchGameonStart, % LaunchGameonStart, w250 h210
		GuiControl, MyWindow:, AlwaysSaveChests, % AlwaysSaveChests, w250 h210
		GuiControl, MyWindow:, AlwaysSaveContracts, % AlwaysSaveContracts, w250 h210
		GuiControl, MyWindow:, AlwaysSaveCodes, % AlwaysSaveCodes, w250 h210
		GuiControl, MyWindow:, NoSaveSetting, % NoSaveSetting, w250 h210
		;this.Show() - removed
	}
}

;Hotkeys
;$F9::Reload
;$F10::ExitApp

Update_Clicked:
	{
		GetUserDetails()
		return
	}

Reload_Clicked:
	{
		Reload
		return
	}

Exit_Clicked:
	{
		ExitApp
		return
	}

Crash_Toggle:
	{
		switch CrashProtectStatus {
			case "Crash Protect`nDisabled": {
				CrashProtectStatus := "Crash Protect`nEnabled"
				oMyGUI.Update()
				SB_SetText("Crash Protect has been enabled!")
				CrashProtect()
			}
			case "Crash Protect`nEnabled": {
				CrashProtectStatus := "Crash Protect`nDisabled"
				CrashCount := 0
				oMyGUI.Update()
				SB_SetText("Crash Protect has been disabled.")
			}
		}
		return
	}

	CrashProtect() {
		loop {
			if (CrashProtectStatus == "Crash Protect`nDisabled") {
				return
			}
			While(Not WinExist("ahk_exe IdleDragons.exe")) {
				Sleep 2500
				Run, %GameClient%
				++CrashCount
				SB_SetText("Crash Protect has restarted your client.")
				UpdateLogTime()
				FileAppend, (%CurrentTime%) Restarts since enabling Crash Protect: %CrashCount%`n, %OutputLogFile%
				FileRead, OutputText, %OutputLogFile%
				oMyGUI.Update()
				Sleep 10000
			}
		}
		return
	}

Save_Settings:
	{
		oMyGUI.Submit()
		CurrentSettings.servername := ServerName
		CurrentSettings.getdetailsonstart := GetDetailsonStart
		CurrentSettings.launchgameonstart := LaunchGameonStart
		CurrentSettings.alwayssavechests := AlwaysSaveChests
		CurrentSettings.alwayssavecontracts := AlwaysSaveContracts
		CurrentSettings.alwayssavecodes := AlwaysSaveCodes
		CurrentSettings.nosavesetting := NoSaveSetting
		newsettings := JSON.stringify(CurrentSettings)
		FileDelete, %SettingsFile%
		FileAppend, %newsettings%, %SettingsFile%
		SB_SetText("Settings have been saved.")
		return
	}

About_Clicked:
	{
		MsgBox, , About IdleCombos v%VersionNumber%, IdleCombos v%VersionNumber% by QuickMythril Updates by Eldoen`n`nSpecial thanks to all the idle dragons who inspired and assisted me!
		return
	}

Buy_Silver:
	{
		Buy_Chests(1)
		return
	}

Buy_Gold:
	{
		Buy_Chests(2)
		return
	}

Open_Silver:
	{
		if (Not WinExist("ahk_exe IdleDragons.exe")) {
			Open_Chests(1)
			return
		}
		else {
			MsgBox, 0, , % "Note: It's recommended to close the game client before opening chests."
			return 
			;MsgBox, 4, , % "Note: It's recommended to close the game client before opening chests.`nWould you like to continue anyway?"
			;IfMsgBox, Yes
			;{
			;Open_Chests(1)
			;	return
			;}
			;else IfMsgBox, No
			;{
			;	return
			;}
		}
	}

Open_Gold:
	{
		if (Not WinExist("ahk_exe IdleDragons.exe")) {
			Open_Chests(2)
			return
		}
		else {
			MsgBox, 0, , % "Note: It's recommended to close the game client before opening chests."
			return
			;MsgBox, 4, , % "Note: It's recommended to close the game client before opening chests.`nWould you like to continue anyway?`n`n(Feats earned using this app do not count towards the related achievement.)"
			;IfMsgBox, Yes
			;{
			;	;Open_Chests(2)
			;	return
			;}
			;else IfMsgBox, No
			;{
			;	return
			;}
		}
	}

Open_Codes:
	{
		; GUI MENU
		Menu, FileMenu, Add, Auto&Load (Web)`tCtrl+L, Get_Codes_Autoload
		Menu, FileMenu, Add, AutoLoad && &Run (Web)`tCtrl+R, Get_Codes_Autoload_Run
		Menu, FileMenu, Add, &Submit`tCtrl+S, Redeem_Codes
		Menu, EditMenu, Add, Paste`tCtrl+V, Paste
		Menu, EditMenu, Add, Delete`tDel, Delete
		Menu, HelpMenu, Add, Open &Codes (Web)`tCtrl+O, Open_Web_Codes_Page
		Menu, MyMenuBar, Add, &File, :FileMenu
		Menu, MyMenuBar, Add, &Edit, :EditMenu
		Menu, MyMenuBar, Add, &Help, :HelpMenu

		; GUI
		Gui, CodeWindow:New
		Gui, Menu, MyMenuBar
		Gui, CodeWindow:-Resize -MaximizeBox
		Gui, CodeWindow:Show, w230 h240, Codes
		Gui, CodeWindow:Add, Edit, r12 vCodestoEnter w190 x20 y20, IDLE-CHAM-PION-SNOW
		Gui, CodeWindow:Add, Button, gRedeem_Codes, Submit
		Gui, CodeWindow:Add, Button, x+35 gPaste, Paste
		Gui, CodeWindow:Add, Button, x+35 gClose_Codes, Close
		Gui, CodeWindow:Add, Text, w350 x20 y+5 vCodesPending, Codes: 0/1 - Waiting... (1 code per line)
		return
	}

Paste()
	{
		getChestCodes()
		loop, parse, foundCodeString, `n, `r
		  CodeTotal := a_index
		GuiControl, , CodestoEnter, %foundCodeString%
		GuiControl, , CodesPending, Codes: 0/%CodeTotal% - Waiting... (1 code per line)
		return
	}

Delete()
	{
		GuiControl, , CodestoEnter,
		GuiControl, , CodesPending, Codes: 0/0 - Waiting... (1 code per line)
		return
	}

Open_Web_Codes_Page()
	{
		Run, %WebToolCodes%
		return
	}

Get_Codes_Autoload()
	{
		Open_Web_Codes_Page()
		winwait, ALL active IDLE Champions combination🔒 codes
		sleep, 1000
		send, ^a
		clipboard := ""
  		send, ^c
		ClipWait, 1
		if WinExist("IdleCombos")
			WinActivate
			if WinExist("Redeem Codes")
				WinActivate
		Paste()
		return
	}

Get_Codes_Autoload_Run()
	{
		Get_Codes_Autoload()
		Redeem_Codes()
		return
	}

Redeem_Codes()
	{
		Gui, CodeWindow:Submit, NoHide
		Gui, CodeWindow:Add, Text, x+45, Codes Remaining:
		CodeList := StrSplit(CodestoEnter, "`n")
		CodeCount := CodeList.Length()
		CodeNum := 1
		CodeTotal := CodeCount
		CodesPending := "Codes: " CodeNum "/" CodeTotal " - Starting..."
		GuiControl, , CodesPending, % CodesPending, w350 h210
		usedcodes := ""
		someonescodes := ""
		expiredcodes := ""
		earlycodes := ""
		invalidcodes := ""
		codegolds := 0
		codesilvers := 0
		codesupplys := 0
		otherchests := ""
		codeepics := ""
		codetgps := 0
		codepolish := 0
		tempsavesetting := 0
		for k, v in CodeList
		{
			v := StrReplace(v, "`r")
			v := StrReplace(v, "`n")
			v := Trim(v)
			CurrentCode := v
			sCode := RegExReplace(CurrentCode, "&", Replacement := "%26")
			sCode := RegExReplace(sCode, "#", Replacement := "%23")
			if !UserID {
				MsgBox % "Need User ID & Hash."
				FirstRun()
			}
			codeparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&code=" sCode
			rawresults := ServerCall("redeemcoupon", codeparams)
			coderesults := JSON.parse(rawresults)
			rawloot := JSON.stringify(coderesults.loot_details)
			codeloot := JSON.parse(rawloot)
			if (coderesults.failure_reason == "Outdated instance id") {
				MsgBox, 4, , % "Outdated instance id. Update from server?"
				IfMsgBox, Yes
				{
					GetUserDetails()
					Gui, CodeWindow:Default
					while (InstanceID == 0) {
						sleep, 2000
					}
					codeparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&code=" sCode
					rawresults := ServerCall("redeemcoupon", codeparams)
					coderesults := JSON.parse(rawresults)
					rawloot := JSON.stringify(coderesults.loot_details)
					codeloot := JSON.parse(rawloot)
				}
				else {
					return
				}
			}
			if (coderesults.failure_reason == "You have already redeemed this combination.") {
				usedcodes := usedcodes sCode "`n"
			}
			else if (coderesults.failure_reason == "Someone has already redeemed this combination.") {
				someonescodes := someonescodes sCode "`n"
			}
			else if (coderesults.failure_reason == "This offer has expired") {
				expiredcodes := expiredcodes sCode "`n"
			}
			else if (coderesults.failure_reason == "You can not yet redeem this combination.") {
				earlycodes := earlycodes sCode "`n"
			}
			else if (coderesults.failure_reason == "This is not a valid combination.") {
				invalidcodes := invalidcodes sCode "`n"
			}
			else for kk, vv in codeloot
			{
				if (vv.chest_type_id == "2") {
					codegolds += vv.count
				}
				else if (vv.chest_type_id == "37") {
					codesupplys += vv.count
				}
				else if (vv.chest_type_id == "1") {
					codesilvers += vv.count
				}
				else if (vv.chest_type_id) {
					otherchests := otherchests ChestFromID(vv.chest_type_id) "`n"
				}
				else if (vv.add_time_gate_key_piece) {
					codetgps += vv.count
				}
				else if (vv.add_inventory_buff_id) {
					switch vv.add_inventory_buff_id
					{
						case 4: codeepics := codeepics "STR (" vv.count "), "
						case 8: codeepics := codeepics "GF (" vv.count "), "
						case 16: codeepics := codeepics "HP (" vv.count "), "
						case 20: codeepics := codeepics "Bounty (" vv.count "), "
						case 34: codeepics := codeepics "BS (" vv.count "), "
						case 35: codeepics := codeepics "Spec (" vv.count "), "
						case 40: codeepics := codeepics "FB (" vv.count "), "
						case 77: codeepics := codeepics "Spd (" vv.count "), "
						case 36: codepolish += vv.count
						default: codeepics := codeepics vv.add_inventory_buff_id " (" vv.count "), "
					}
				}
			}
			CodeCount := % (CodeCount-1)
			CodeNum := % (CodeTotal-CodeCount)
			if (CurrentSettings.alwayssavecodes || tempsavesetting) {
				FileAppend, %sCode%`n, %RedeemCodeLogFile%
				FileAppend, %rawresults%`n, %RedeemCodeLogFile%
			}
			else if !(CurrentSettings.nosavesetting) {
				MsgBox, 4, , "Save to File?"
				IfMsgBox, Yes
				{
					tempsavesetting := 1
					FileAppend, %sCode%`n, %RedeemCodeLogFile%
					FileAppend, %rawresults%`n, %RedeemCodeLogFile%
				}
			}
			sleep, 1000
			CodesPending := "Codes: " CodeNum "/" CodeTotal " - Submitting..."
			GuiControl, , CodesPending, % CodesPending, w350 h210
		}
		CodesPending := "Codes: " CodeNum "/" CodeTotal " - Loading Results..."
		codemessage := ""
		if !(usedcodes == "") {
			codemessage := codemessage "You Already Used:`n" usedcodes "`n"
		}
		if !(someonescodes == "") {
			codemessage := codemessage "Someone Else Has Used:`n" someonescodes "`n"
		}
		if !(expiredcodes == "") {
			codemessage := codemessage "Expired:`n" expiredcodes "`n"
		}
		if !(invalidcodes == "") {
			codemessage := codemessage "Invalid:`n" invalidcodes "`n"
		}
		if !(earlycodes == "") {
			codemessage := codemessage "Cannot Redeem Yet:`n" earlycodes "`n"
		}
		if (codegolds > 0) {
			codemessage := codemessage "Gold Chests:`n" codegolds "`n"
		}
		if (codesilvers > 0) {
			codemessage := codemessage "Silver Chests:`n" codesilvers "`n"
		}
		if (codesupplys > 0) {
			codemessage := codemessage "Supply Chests:`n" codesupplys "`n"
		}
		if !(otherchests == "") {
			;StringTrimRight, otherchests, otherchests, 2
			codemessage := codemessage "Other Chests:`n" otherchests "`n"
		}
		if (codepolish > 0) {
			codemessage := codemessage "Potions of Polish:`n" codepolish "`n"
		}
		if (codetgps > 0) {
			codemessage := codemessage "Time Gate Pieces:`n" codetgps "`n"
		}
		if !(codeepics == "") {
			StringTrimRight, codeepics, codeepics, 2
			codemessage := codemessage "Epic Consumables:`n" codeepics "`n"
		}
		if (codemessage == "") {
			codemessage := "Unknown or No Results."
		}
		GuiControl, , CodesPending, % CodesPending, w350 h210
		GetUserDetails()
		oMyGUI.Update()
		Gui, CodeWindow: Default
		CodesPending := "Codes: " CodeTotal "/" CodeTotal " - Completed!"
		GuiControl, , CodesPending, % CodesPending, w350 h210
		; MsgBox, , Results, % codemessage
		ScrollBox(codemessage, "p b1 h200 w250", "Redeem Codes Results")
		return
	}

Briv_Calc:
	{
		InputBox, BrivSlot4, Briv Slot 4, Please enter the percentage listed`non your Briv Slot 4 item., , 250, 150, , , , , %BrivSlot4%
		if (ErrorLevel=1) {
			return
		}
		InputBox, BrivZone, Area to Reset, Please enter the area you will reset at`nafter building up Steelbones stacks., , 250, 150, , , , , %BrivZone%
		if (ErrorLevel=1) {
			return
		}
		MsgBox, 0, BrivCalc Results, % SimulateBriv(10000)
		return
	}

Close_Codes:
	{
		Gui, CodeWindow:Destroy
		return
	}

Clear_Log:
	{
		MsgBox, 4, Clear Log, Are you sure?
		IfMsgBox, Yes
		{
			FileDelete, %OutputLogFile%
			OutputText := ""
			oMyGUI.Update()
			return
		}
		return
	}

	Buy_Extra_Chests(chestid,extracount) {
		chestparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&chest_type_id=" chestid "&count="
		gemsspent := 0
		while (extracount > 0) {
			SB_SetText("Chests remaining to purchase: " extracount)
			if (extracount < 101) {
				rawresults := ServerCall("buysoftcurrencychest", chestparams extracount)
				extracount -= extracount
			}
			else {
				rawresults := ServerCall("buysoftcurrencychest", chestparams "100")
				extracount -= 100
			}
			chestresults := JSON.parse(rawresults)
			if (chestresults.success == "0") {
				MsgBox % "Error: " rawresults
				UpdateLogTime()
				FileAppend, (%CurrentTime%) Gems spent: %gemsspent%`n, %OutputLogFile%
				FileRead, OutputText, %OutputLogFile%
				oMyGUI.Update()
				GetUserDetails()
				SB_SetText("Chests remaining: " count " (Error: " chestresults.failure_reason ")")
				return
			}
			gemsspent += chestresults.currency_spent
			Sleep 1000
		}
		UpdateLogTime()
		FileAppend, (%CurrentTime%) Gems spent: %gemsspent%`n, %OutputLogFile%
		FileRead, OutputText, %OutputLogFile%
		SB_SetText("Chest purchase completed.")
		return gemsspent
	}

	Buy_Chests(chestid) {
		if !UserID {
			MsgBox % "Need User ID & Hash."
			FirstRun()
		}
		if !CurrentGems {
			MsgBox, 4, , No gems detected. Check server for user details?
				IfMsgBox, Yes
			{
				GetUserDetails()
			}
		}
		switch chestid
		{
			case 1: {
				maxbuy := Floor(CurrentGems/50)
				InputBox, count, Buying Chests, % "How many Silver Chests?`n(Max: " maxbuy ")", , 200, 180
				if ErrorLevel
					return
				if (count > maxbuy) {
					MsgBox, 4, , Insufficient gems detected for purchase.`nContinue anyway?
						IfMsgBox No
					return
				}
			}
			case 2: {
				maxbuy := Floor(CurrentGems/500)
				InputBox, count, Buying Chests, % "How many Gold Chests?`n(Max: " maxbuy ")", , 200, 180
				if ErrorLevel
					return
				if (count = "alpha5") {
					chestparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID
					rawresults := ServerCall("alphachests", chestparams)
					MsgBox % rawresults
					GetUserDetails()
					SB_SetText("Ai yi yi, Zordon!")
					return
				}
				if (count > maxbuy) {
					MsgBox, 4, , Insufficient gems detected for purchase.`nContinue anyway?
						IfMsgBox No
					return
				}
			}
			default: {
				MsgBox, Invalid chest_id value.
				return
			}
		}
		chestparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&chest_type_id=" chestid "&count="
		gemsspent := 0
		while (count > 0) {
			SB_SetText("Chests remaining to purchase: " count)
			if (count < 101) {
				rawresults := ServerCall("buysoftcurrencychest", chestparams count)
				count -= count
			}
			else {
				rawresults := ServerCall("buysoftcurrencychest", chestparams "100")
				count -= 100
			}
			chestresults := JSON.parse(rawresults)
			if (chestresults.success == "0") {
				MsgBox % "Error: " rawresults
				UpdateLogTime()
				FileAppend, (%CurrentTime%) Gems spent: %gemsspent%`n, %OutputLogFile%
				FileRead, OutputText, %OutputLogFile%
				oMyGUI.Update()
				GetUserDetails()
				SB_SetText("Chests remaining: " count " (Error: " chestresults.failure_reason ")")
				return
			}
			gemsspent += chestresults.currency_spent
			Sleep 1000
		}
		UpdateLogTime()
		FileAppend, (%CurrentTime%) Gems spent: %gemsspent%`n, %OutputLogFile%
		FileRead, OutputText, %OutputLogFile%
		oMyGUI.Update()
		GetUserDetails()
		SB_SetText("Chest purchase completed.")
		return
	}

	Open_Chests(chestid) {
		if !UserID {
			MsgBox % "Need User ID & Hash."
			FirstRun()
		}
		if (!CurrentGolds && !CurrentSilvers && !CurrentGems) {
			MsgBox, 4, , No chests or gems detected. Check server for user details?
				IfMsgBox, Yes
			{
				GetUserDetails()
			}
		}
		switch chestid
		{
			case 1: {
				InputBox, count, Opening Chests, % "How many Silver Chests?`n(Owned: " CurrentSilvers ")`n(Max: " (CurrentSilvers + Floor(CurrentGems/50)) ")", , 200, 180
				if ErrorLevel
					return
				if (count > CurrentSilvers) {
					MsgBox, 4, , % "Spend " ((count - CurrentSilvers)*50) " gems to purchase " (count - CurrentSilvers) " chests before opening?"
					extracount := (count - CurrentSilvers)
					IfMsgBox, Yes
					extraspent := Buy_Extra_Chests(1,extracount)
					else {
						return
					}
				}
			}
			case 2: {
				InputBox, count, Opening Chests, % "How many Gold Chests?`n(Owned: " CurrentGolds ")`n(Max: " (CurrentGolds + Floor(CurrentGems/500)) ")`n`n(Feats earned using this app do not`ncount towards the related achievement.)", , 360, 240
				if ErrorLevel
					return
				if (count > CurrentGolds) {
					MsgBox, 4, , % "Spend " ((count - CurrentGolds)*500) " gems to purchase " (count - CurrentGolds) " chests before opening?"
					extracount := (count - CurrentGolds)
					IfMsgBox, Yes
					extraspent := Buy_Extra_Chests(2,extracount)
					else {
						return
					}
				}
			}
			default: {
				MsgBox, Invalid chest_id value.
				return
			}
		}
		chestparams := "&gold_per_second=0&checksum=4c5f019b6fc6eefa4d47d21cfaf1bc68&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&chest_type_id=" chestid "&game_instance_id=" ActiveInstance "&count="
		tempsavesetting := 0
		lastfeat := ""
		newfeats := ""
		lastshiny := ""
		newshinies := ""
		chestresults_cumulative := {}

		while (count > 0) {
			SB_SetText("Chests remaining to open: " count)
			if (count < 100) {
				rawresults := ServerCall("opengenericchest", chestparams count)
				Sleep, 500
				count -= count
			}
			else {
				rawresults := ServerCall("opengenericchest", chestparams 99)
				Sleep, 500
				count -= 99
			}
			if (CurrentSettings.alwayssavechests || tempsavesetting) {
				FileAppend, %rawresults%`n, %ChestOpenLogFile%
			}
			else {
				if !CurrentSettings.nosavesetting {
					InputBox, dummyvar, Chest Results, Save to File?, , 250, 150, , , , , % rawresults
					dummyvar := ""
					if !ErrorLevel {
						FileAppend, %rawresults%`n, %ChestOpenLogFile%
						tempsavesetting := 1
					}
				}
			}
			chestresults := JSON.parse(rawresults)
			if ((chestresults.success == "0") || (chestresults.loot_details == "0")) {
				switch chestid
				{
					case "1": {
						chestsopened := (CurrentSilvers - chestresults.chests_remaining)
						if (extraspent) {
							chestsopened += (extraspent/50)
						}
						MsgBox % "New Shinies:`n" newshinies
					}
					case "2": {
						chestsopened := (CurrentGolds - chestresults.chests_remaining)
						if (extraspent) {
							chestsopened += (extraspent/500)
						}
						MsgBox % "New Feats:`n" newfeats "`nNew Shinies:`n" newshinies
					}
				}
				MsgBox % "Error: " rawresults
				UpdateLogTime()
				FileAppend, % "(" CurrentTime ") Chests Opened: " Floor(chestsopened) "`n", %OutputLogFile%
				FileRead, OutputText, %OutputLogFile%
				oMyGUI.Update()
				GetUserDetails()
				SB_SetText("Chests remaining: " count " (Error)")
				return
			}
			for k, v in chestresults.loot_details {
				if (v.unlock_hero_feat) {
					lastfeat := (FeatFromID(v.unlock_hero_feat) "n")
					newfeats := newfeats lastfeat
				}
				if (v.gilded) {
					if ( !IsObject( chestresults_cumulative[ v.hero_id ] ) )
					{
						chestresults_cumulative[ v.hero_id ] := {}
						chestresults_cumulative[ v.hero_id ][ v.slot_id ] := {}
						chestresults_cumulative[ v.hero_id ][ v.slot_id ][ gilded_count ] := 1
						if (v.disenchant_amount == 125)
							chestresults_cumulative[ v.hero_id ][ v.slot_id ][ disenchant_amount ] := v.disenchant_amount
					}
					else if ( !IsObject( chestresults_cumulative[ v.hero_id ][ v.slot_id ] ) )
					{
						chestresults_cumulative[ v.hero_id ][ v.slot_id ] := {}
						chestresults_cumulative[ v.hero_id ][ v.slot_id ][ gilded_count ] := 1
						if (v.disenchant_amount == 125)
							chestresults_cumulative[ v.hero_id ][ v.slot_id ][ disenchant_amount ] := v.disenchant_amount
					}
					Else
					{
						chestresults_cumulative[ v.hero_id ][ v.slot_id ][ gilded_count ] += 1
						if (v.disenchant_amount == 125)
							chestresults_cumulative[ v.hero_id ][ v.slot_id ][ disenchant_amount ] += v.disenchant_amount
					}

				}
			}
		}

		for k, v in chestresults_cumulative
		{
			for k2, v2 in v
			{
				if ( v2.gilded_count <= 1 )
					lastshiny := ( ChampFromID( k ) " (Slot " k2 ")" )
				else
					lastshiny := ( ChampFromID( k ) " (Slot " k2 " x " v2.gilded_count ")" )
				if ( v2.disenchant_amount )
					lastshiny .= " +" v2.disenchant_amount
				newshinies .= lastshiny "`n"
			}
		}
		tempsavesetting := 0
		switch chestid
		{
			case "1": {
				chestsopened := (CurrentSilvers - chestresults.chests_remaining)
				if (extraspent) {
					chestsopened += (extraspent/50)
				}
				MsgBox % "New Shinies:`n" newshinies
				UpdateLogTime()
				FileAppend, % "(" CurrentTime ") Silver Chests Opened: " Floor(chestsopened) "`n", %OutputLogFile%
			}
			case "2": {
				chestsopened := (CurrentGolds - chestresults.chests_remaining)
				if (extraspent) {
					chestsopened += (extraspent/500)
				}
				MsgBox % "New Feats:`n" newfeats "`nNew Shinies:`n" newshinies
				UpdateLogTime()
				FileAppend, % "(" CurrentTime ") Gold Chests Opened: " Floor(chestsopened) "`n", %OutputLogFile%
			}
		}
		FileRead, OutputText, %OutputLogFile%
		oMyGUI.Update()
		GetUserDetails()
		SB_SetText("Chest opening completed.")
		return
	}

Tiny_Blacksmith:
	{
		UseBlacksmith(31)
		return
	}

Sm_Blacksmith:
	{
		UseBlacksmith(32)
		return
	}

Med_Blacksmith:
	{
		UseBlacksmith(33)
		return
	}

Lg_Blacksmith:
	{
		UseBlacksmith(34)
		return
	}

Hg_Blacksmith:
	{
		UseBlacksmith(1797)
		return
	}

	UseBlacksmith(buffid) {
		if !UserID {
			MsgBox % "Need User ID & Hash."
			FirstRun()
		}
		switch buffid
		{
			case 31: currentcontracts := CurrentTinyBS
			case 32: currentcontracts := CurrentSmBS
			case 33: currentcontracts := CurrentMdBS
			case 34: currentcontracts := CurrentLgBS
			case 1797: currentcontracts := CurrentHgBS
		}	
		if !(currentcontracts) {
			MsgBox, 4, , No Blacksmith Contracts of that size detected. Check server for user details?
				IfMsgBox, Yes
			{
				GetUserDetails()
			}
		}
		InputBox, count, Blacksmithing, % "How many Blacksmith Contracts?`n(Max: " currentcontracts ")", , 200, 180, , , , , %currentcontracts%
		if ErrorLevel
			return
		if (count > currentcontracts) {
			MsgBox, 4, , Insufficient blacksmith contracts detected for use.`nContinue anyway?
				IfMsgBox No
			return
		}
		heroid := "error"
		InputBox, heroid, Blacksmithing, % "Use contracts on which Champ? (Enter ID)", , 200, 180, , , , , %LastBSChamp%
		if ErrorLevel
			return
		while !(heroid is number) {
			InputBox, heroid, Blacksmithing, % "Please enter a valid Champ ID number.", , 200, 180, , , , , %LastBSChamp%
			if ErrorLevel
				return
		}
		while !((heroid > 0) && (heroid < 100)) {
			InputBox, heroid, Blacksmithing, % "Please enter a valid Champ ID number.", , 200, 180, , , , , %LastBSChamp%
			if ErrorLevel
				return
		}
		MsgBox, 4, , % "Use " count " contracts on " ChampFromID(heroid) "?"
		IfMsgBox No
		return
		LastBSChamp := heroid
		bscontractparams := "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&buff_id=" buffid "&hero_id=" heroid "&num_uses="
		tempsavesetting := 0
		slot1lvs := 0
		slot2lvs := 0
		slot3lvs := 0
		slot4lvs := 0
		slot5lvs := 0
		slot6lvs := 0
		while (count > 0) {
			SB_SetText("Contracts remaining to use: " count)
			if (count < 50) {
				rawresults := ServerCall("useserverbuff", bscontractparams count)
				count -= count
			}
			else {
				rawresults := ServerCall("useserverbuff", bscontractparams "50")
				count -= 50
			}
			if (CurrentSettings.alwayssavecontracts || tempsavesetting) {
				FileAppend, %rawresults%`n, %BlacksmithLogFile%
			}
			else {
				if !CurrentSettings.nosavesetting {
					InputBox, dummyvar, Contracts Results, Save to File?, , 250, 150, , , , , % rawresults
					dummyvar := ""
					if !ErrorLevel {
						FileAppend, %rawresults%`n, %ContractLogFile%
						tempsavesetting := 1
					}
				}
			}
			blacksmithresults := JSON.parse(rawresults)
			if ((blacksmithresults.success == "0") || (blacksmithresults.okay == "0")) {
				MsgBox % ChampFromID(heroid) " levels gained:`nSlot 1: " slot1lvs "`nSlot 2: " slot2lvs "`nSlot 3: " slot3lvs "`nSlot 4: " slot4lvs "`nSlot 5: " slot5lvs "`nSlot 6: " slot6lvs
				MsgBox % "Error: " rawresults
				switch buffid
				{
					case 31: contractsused := (CurrentTinyBS - blacksmithresults.buffs_remaining)
					case 32: contractsused := (CurrentSmBS - blacksmithresults.buffs_remaining)
					case 33: contractsused := (CurrentMdBS - blacksmithresults.buffs_remaining)
					case 34: contractsused := (CurrentLgBS - blacksmithresults.buffs_remaining)
					case 1797: contractsused := (CurrentHgBS - blacksmithresults.buffs_remaining)
				}
				UpdateLogTime()
				FileAppend, % "(" CurrentTime ") Contracts Used: " Floor(contractsused) "`n", %OutputLogFile%
				FileRead, OutputText, %OutputLogFile%
				oMyGUI.Update()
				GetUserDetails()
				SB_SetText("Contracts remaining: " count " (Error)")
				return
			}
			rawactions := JSON.stringify(blacksmithresults.actions)
			blacksmithactions := JSON.parse(rawactions)
			for k, v in blacksmithactions
			{
				switch v.slot_id
				{
					case 1: slot1lvs += v.amount
					case 2: slot2lvs += v.amount
					case 3: slot3lvs += v.amount
					case 4: slot4lvs += v.amount
					case 5: slot5lvs += v.amount
					case 6: slot6lvs += v.amount
				}
			}
		}
		MsgBox % ChampFromID(heroid) " levels gained:`nSlot 1: " slot1lvs "`nSlot 2: " slot2lvs "`nSlot 3: " slot3lvs "`nSlot 4: " slot4lvs "`nSlot 5: " slot5lvs "`nSlot 6: " slot6lvs
		tempsavesetting := 0
		switch buffid {
			case 31: contractsused := (CurrentTinyBS - blacksmithresults.buffs_remaining)
			case 32: contractsused := (CurrentSmBS - blacksmithresults.buffs_remaining)
			case 33: contractsused := (CurrentMdBS - blacksmithresults.buffs_remaining)
			case 34: contractsused := (CurrentLgBS - blacksmithresults.buffs_remaining)
			case 1797: contractsused := (CurrentHgBS - blacksmithresults.buffs_remaining)
		}
		UpdateLogTime()
		FileAppend, % "(" CurrentTime ") Contracts used on " ChampFromID(heroid) ": " Floor(contractsused) "`n", %OutputLogFile%
		FileRead, OutputText, %OutputLogFile%
		oMyGUI.Update()
		GetUserDetails()
		SB_SetText("Blacksmith use completed.")
		return
	}

	global lastadv := 0			;fmagdi - to be used to save ended adventureid for use as default for next load 

	LoadAdventure() {

		GetUserDetails()
		while !(CurrentAdventure == "-1") {
			MsgBox, 5, , Please end your current adventure first.
			IfMsgBox Cancel
			return
		}
		advtoload := lastadv		;fmagdi - defaults to last ended adventure id, or to variable default in globals
		patrontoload := 0
		InputBox, advtoload, Adventure to Load, Please enter the adventure_id`nyou would like to load., , 250, 150, , , , , %advtoload%
		if (ErrorLevel=1) {
			return
		}
		if !((advtoload > 0) && (advtoload < 9999)) {
			MsgBox % "Invalid adventure_id: " advtoload
			return
		}
		InputBox, patrontoload, Patron to Load, Please enter the patron_id`nyou would like to load., , 250, 150, , , , , %patrontoload%
		if (ErrorLevel=1) {
			return
		}
		if !((patrontoload > -1) && (patrontoload < 5)) {
			MsgBox % "Invalid patron_id: " patrontoload
			return
		}
		advparams := DummyData "&patron_tier=0&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&game_instance_id=" ActiveInstance "&adventure_id=" advtoload "&patron_id=" patrontoload
		sResult := ServerCall("setcurrentobjective", advparams)
		GetUserDetails()
		SB_SetText("Selected adventure has been loaded.")
		return
	}

	EndAdventure() {
		GetUserDetails()				;fmagdi - updates info before ending an adventure to be sure you are ending the correct one

		while (CurrentAdventure == "-1") {
			MsgBox, No current adventure active.
			return
		}
		MsgBox, 4, , % "Are you sure you want to end your current adventure?`nParty: " ActiveInstance " AdvID: " CurrentAdventure " Patron: " CurrentPatron
		IfMsgBox, No
		{
			return
		}

		lastadv := CurrentAdventure	;fmagdi - saves ended adventure id for use as default when loading next adventure

		advparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&game_instance_id=" ActiveInstance
		sResult := ServerCall("softreset", advparams)
		GetUserDetails()
		SB_SetText("Current adventure has been ended.")
		return
	}

	EndBGAdventure() {
		if (ActiveInstance == "1") {
			bginstance := 2
		}
		else {
			bginstance := 1
		}
		while (BackgroundAdventure == "-1" or BackgroundAdventure == "") {
			MsgBox, No background adventure active.
			return
		}
		MsgBox, 4, , % "Are you sure you want to end your background adventure?`nParty: " bginstance " AdvID: " BackgroundAdventure " Patron: " BackgroundPatron
		IfMsgBox, No
		{
			return
		}
		advparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&game_instance_id=" bginstance
		sResult := ServerCall("softreset", advparams)
		GetUserDetails()
		SB_SetText("Background adventure has been ended.")
		return
	}

	EndBG2Adventure() {
		if (ActiveInstance == "3" or ActiveInstance == "4") {
			bginstance := 2
		}
		else {
			bginstance := 3
		}
		while (Background2Adventure == "-1" or Background2Adventure == "") {
			MsgBox, No background2 adventure active.
			return
		}
		MsgBox, 4, , % "Are you sure you want to end your background2 adventure ?`nParty: " bginstance " AdvID: " Background2Adventure " Patron: " Background2Patron
		IfMsgBox, No
		{
			return
		}
		advparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&game_instance_id=" bginstance
		sResult := ServerCall("softreset", advparams)
		GetUserDetails()
		SB_SetText("Background2 adventure has been ended.")
		return
	}

	EndBG3Adventure() {
		if (ActiveInstance == "4") {
			bginstance := 3
		}
		else {
			bginstance := 4
		}
		while (Background3Adventure == "-1" or Background3Adventure == "") {
			MsgBox, No background3 adventure active.
			return
		}
		MsgBox, 4, , % "Are you sure you want to end your background3 adventure ?`nParty: " bginstance " AdvID: " Background3Adventure " Patron: " Background3Patron
		IfMsgBox, No
		{
			return
		}
		advparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&game_instance_id=" bginstance
		sResult := ServerCall("softreset", advparams)
		GetUserDetails()
		SB_SetText("Background3 adventure has been ended.")
		return
	}
	;	fmagdi -stop

	FirstRun() {
		MsgBox, 4, , Get User ID and Hash from webrequestlog.txt?
		IfMsgBox, Yes
		{
			GetIdFromWRL()
			UpdateLogTime()
			FileAppend, (%CurrentTime%) User ID: %UserID% & Hash: %UserHash% detected in WRL.`n, %OutputLogFile%
		}
		else
		{
			MsgBox, 4, , Choose install directory manually?
			IfMsgBox Yes
			{
				FileSelectFile, WRLFile, 1, webRequestLog.txt, Select webRequestLog file, webRequestLog.txt
				if ErrorLevel
					return
				GetIdFromWRL()
				GameInstallDir := SubStr(WRLFile, 1, -67)
				GameClient := GameInstallDir "IdleDragons.exe"
			}	
			else {
				InputBox, UserID, user_id, Please enter your "user_id" value., , 250, 125
				if ErrorLevel
					return
				InputBox, UserHash, hash, Please enter your "hash" value., , 250, 125
				if ErrorLevel
					return
				UpdateLogTime()
				FileAppend, (%CurrentTime%) User ID: %UserID% & Hash: %UserHash% manually entered.`n, %OutputLogFile%
			}
		}
		FileRead, OutputText, %OutputLogFile%
		oMyGUI.Update()
		CurrentSettings.user_id := UserID
		CurrentSettings.hash := UserHash
		CurrentSettings.firstrun := 1
		newsettings := JSON.stringify(CurrentSettings)
		FileDelete, %SettingsFile%
		FileAppend, %newsettings%, %SettingsFile%
		UpdateLogTime()
		FileAppend, (%CurrentTime%) IdleCombos setup completed.`n, %OutputLogFile%
		FileRead, OutputText, %OutputLogFile%
		oMyGUI.Update()
		SB_SetText("User ID & Hash ready.")
	}

	UpdateLogTime() {
		FormatTime, CurrentTime, , yyyy-MM-dd HH:mm:ss
	}

	GetIDFromWRL() {
		FileRead, oData, %WRLFile%
		if ErrorLevel {
			MsgBox, 4, , Could not find webRequestLog.txt file.`nChoose install directory manually?
			IfMsgBox Yes
			{
				FileSelectFile, WRLFile, 1, webRequestLog.txt, Select webRequestLog file, webRequestLog.txt
				if ErrorLevel
					return
				FileRead, oData, %WRLFile%
			}
			else
				return
		}
		FoundPos := InStr(oData, "getuserdetails&language_id=1&user_id=")
		oData2 := SubStr(oData, (FoundPos + 37))
		FoundPos := InStr(oData2, "&hash=")
		StringLeft, UserID, oData2, (FoundPos - 1)
		oData := SubStr(oData2, (FoundPos + 6))
		FoundPos := InStr(oData, "&instance_key=")
		StringLeft, UserHash, oData, (FoundPos - 1)
		oData := ; Free the memory.
		oData2 := ; Free the memory.
		return
	}

	GetUserDetails() {
		Gui, MyWindow:Default
		SB_SetText("Please wait a moment...")
		getuserparams := DummyData "&include_free_play_objectives=true&instance_key=1&user_id=" UserID "&hash=" UserHash
		rawdetails := ServerCall("getuserdetails", getuserparams)
		FileDelete, %UserDetailsFile%
		FileAppend, %rawdetails%, %UserDetailsFile%
		UserDetails := JSON.parse(rawdetails)
		InstanceID := UserDetails.details.instance_id
		CurrentSettings.instance_id := InstanceID
		ActiveInstance := UserDetails.details.active_game_instance_id
		newsettings := JSON.stringify(CurrentSettings)
		FileDelete, %SettingsFile%
		FileAppend, %newsettings%, %SettingsFile%
		ParseChampData()
		ParseAdventureData()
		ParseTimestamps()
		ParseInventoryData()
		ParsePatronData()
		ParseLootData()
		CheckAchievements()
		CheckBlessings()
		oMyGUI.Update()
		SB_SetText("User details available.")
		CheckPatronProgress()
		return
	}

	ParseAdventureData() {
		bginstance := 0
		for k, v in UserDetails.details.game_instances
		if (v.game_instance_id == ActiveInstance) {
			CurrentAdventure := v.current_adventure_id
			CurrentArea := v.current_area
			CurrentPatron := PatronFromID(v.current_patron_id)
		}
		else if (bginstance == 0){
			BackgroundAdventure := v.current_adventure_id
			BackgroundArea := v.current_area
			BackgroundPatron := PatronFromID(v.current_patron_id)
			bginstance += 1
		}
		else if (bginstance == 1){
			Background2Adventure := v.current_adventure_id
			Background2Area := v.current_area
			Background2Patron := PatronFromID(v.current_patron_id)
			bginstance += 1
		}
		else if (bginstance == 2){
			Background3Adventure := v.current_adventure_id
			Background3Area := v.current_area
			Background3Patron := PatronFromID(v.current_patron_id)
		}

		FGCore := "`n"
		BGCore := "`n"
		BG2Core := "`n"
		BG3Core := "`n"
		;		If (ActiveInstance == 1) {
		;			bginstance := 2
		;		}
		;		Else {
		;			bginstance := 1
		;		}

		bginstance := 0

		for k, v in UserDetails.details.modron_saves
		if (v.instance_id == ActiveInstance) {
			if (v.core_id == 1) {
				FGCore := "Core: Modest"
			}
			else if (v.core_id == 2) {
				FGCore := "Core: Strong"
			}
			else if (v.core_id == 3) {
				FGCore := "Core: Fast"
			}
			else if (v.core_id == 4) {
				FGCore := "Core: Magic"
			}

			if (v.properties.toggle_preferences.reset == true) {
				FGCore := FGCore " (Reset at " v.area_goal ")"
			}
			xptolevel := v.exp_total
			corelevel := 1
			levelxp := 8000
			while (xptolevel > (levelxp - 1)) {
				corelevel += 1
				xptolevel -= levelxp
				levelxp += 4000
			}
			if (corelevel > 15) {
				corelevel := corelevel " - Max 15"
			}
			percenttolevel := Floor((xptolevel / levelxp) * 100)
			FGCore := FGCore "`nXP: " v.exp_total " (Lv " corelevel ")`n" xptolevel "/" levelxp " (" percenttolevel "%)"
		}
		else if (bginstance == 0 and v.instance_id != 0) {
			if (v.core_id == 1) {
				BGCore := "Core: Modest"
			}
			else if (v.core_id == 2) {
				BGCore := "Core: Strong"
			}
			else if (v.core_id == 3) {
				BGCore := "Core: Fast"
			}
			else if (v.core_id == 4) {
				BGCore := "Core: Magic"
			}
			if (v.properties.toggle_preferences.reset == true) {
				BGCore := BGCore " (Reset at " v.area_goal ")"
			}
			xptolevel := v.exp_total
			corelevel := 1
			levelxp := 8000
			while (xptolevel > (levelxp - 1)) {
				corelevel += 1
				xptolevel -= levelxp
				levelxp += 4000
			}
			if (corelevel > 15) {
				corelevel := corelevel " - Max 15"
			}
			percenttolevel := Floor((xptolevel / levelxp) * 100)
			BGCore := BGCore "`nXP: " v.exp_total " (Lv " corelevel ")`n" xptolevel "/" levelxp " (" percenttolevel "%)"
			bginstance += 1
		}
		else if (bginstance == 1 and v.instance_id != 0) {
			if (v.core_id == 1) {
				BG2Core := "Core: Modest"
			}
			else if (v.core_id == 2) {
				BG2Core := "Core: Strong"
			}
			else if (v.core_id == 3) {
				BG2Core := "Core: Fast"
			}
			else if (v.core_id == 4) {
				BG2Core := "Core: Magic"
			}
			if (v.properties.toggle_preferences.reset == true) {
				BG2Core := BG2Core " (Reset at " v.area_goal ")"
			}
			xptolevel := v.exp_total
			corelevel := 1
			levelxp := 8000
			while (xptolevel > (levelxp - 1)) {
				corelevel += 1
				xptolevel -= levelxp
				levelxp += 4000
			}
			if (corelevel > 15) {
				corelevel := corelevel " - Max 15"
			}
			percenttolevel := Floor((xptolevel / levelxp) * 100)
			BG2Core := BG2Core "`nXP: " v.exp_total " (Lv " corelevel ")`n" xptolevel "/" levelxp " (" percenttolevel "%)"
			bginstance += 1
		}
		else if(bginstance == 2 and v.instance_id != 0){
			if (v.core_id == 1) {
				BG3Core := "Core: Modest"
			}
			else if (v.core_id == 2) {
				BG3Core := "Core: Strong"
			}
			else if (v.core_id == 3) {
				BG3Core := "Core: Fast"
			}
			else if (v.core_id == 4) {
				BG3Core := "Core: Magic"
			}
			if (v.properties.toggle_preferences.reset == true) {
				BG3Core := BG3Core " (Reset at " v.area_goal ")"
			}
			xptolevel := v.exp_total
			corelevel := 1
			levelxp := 8000
			while (xptolevel > (levelxp - 1)) {
				corelevel += 1
				xptolevel -= levelxp
				levelxp += 4000
			}
			if (corelevel > 15) {
				corelevel := corelevel " - Max 15"
			}
			percenttolevel := Floor((xptolevel / levelxp) * 100)
			BG3Core := BG3Core "`nXP: " v.exp_total " (Lv " corelevel ")`n" xptolevel "/" levelxp " (" percenttolevel "%)"
		}
		;
	}

	ParseTimestamps() {
		localdiff := (A_Now - A_NowUTC)
		if (localdiff < -28000000) {
			localdiff += 70000000
		}
		if (localdiff < -250000) {
			localdiff += 760000
		}
		StringTrimRight, localdiffh, localdiff, 4
		localdiffm := SubStr(localdiff, -3)
		StringTrimRight, localdiffm, localdiffm, 2
		if (localdiffm > 59) {
			localdiffm -= 40
		}
		timestampvalue := "19700101000000"
		timestampvalue += UserDetails.current_time, s
		EnvAdd, timestampvalue, localdiffh, h
		EnvAdd, timestampvalue, localdiffm, m
		FormatTime, LastUpdated, % timestampvalue, MMM d`, h:mm tt
		tgptimevalue := "19700101000000"
		tgptimevalue += UserDetails.details.stats.time_gate_key_next_time, s
		EnvAdd, tgptimevalue, localdiffh, h
		EnvAdd, tgptimevalue, localdiffm, m
		FormatTime, NextTGPDrop, % tgptimevalue, MMM d`, h:mm tt
		if (UserDetails.details.stats.time_gate_key_next_time < UserDetails.current_time) {
			Gui, Font, cGreen
			GuiControl, Font, NextTGPDrop
		}
		else {
			Gui, Font, cBlack
			GuiControl, Font, NextTGPDrop
		}
	}

	ParseInventoryData() {
		CurrentGems := UserDetails.details.red_rubies
		SpentGems := UserDetails.details.red_rubies_spent
		CurrentGolds := UserDetails.details.chests.2
		GoldPity := "(Epic in Next " UserDetails.details.stats.forced_win_counter_2 ")"
		CurrentSilvers := UserDetails.details.chests.1
		CurrentTGPs := UserDetails.details.stats.time_gate_key_pieces
		AvailableTGs := "= " Floor(CurrentTGPs/6) " Time Gates"
		for k, v in UserDetails.details.buffs
			switch v.buff_id
		{
			case 17: CurrentTinyBounties := v.inventory_amount
			case 18: CurrentSmBounties := v.inventory_amount
			case 19: CurrentMdBounties := v.inventory_amount
			case 20: CurrentLgBounties := v.inventory_amount
			case 31: CurrentTinyBS := v.inventory_amount
			case 32: CurrentSmBS := v.inventory_amount
			case 33: CurrentMdBS := v.inventory_amount
			case 34: CurrentLgBS := v.inventory_amount
			case 1797: CurrentHgBS := v.inventory_amount
		}
		AvailableChests := "= " Floor(CurrentGems/50) " Silver Chests"
		tokencount := (CurrentTinyBounties*12)+(CurrentSmBounties*72)+(CurrentMdBounties*576)+(CurrentLgBounties*1152)
		if (UserDetails.details.event_details[1].user_data.event_tokens) {
			tokentotal := UserDetails.details.event_details[1].user_data.event_tokens
			AvailableTokens := "= " tokencount " Tokens`t(" Round(tokencount/2500, 2) " FPs)"
			CurrentTokens := "+ " tokentotal " Current`t(" Round(tokentotal/2500, 2) " FPs)"
			AvailableFPs := "(Total: " (tokentotal+tokencount) " = " Round((tokentotal + tokencount)/2500, 2) " Free Plays)"
		}
		else {
			AvailableTokens := "= " tokencount " Tokens"
			CurrentTokens := "(" Round(tokencount/2500, 2) " Free Plays)"
		}
		AvailableBSLvs := "= " CurrentTinyBS+(CurrentSmBS*2)+(CurrentMdBS*6)+(CurrentLgBS*24)+(CurrentHgBS*120) " Item Levels"
	}

	ParsePatronData() {
		for k, v in UserDetails.details.patrons
			switch v.patron_id
		{
			case 1: {
				if v.unlocked == False {
					MirtVariants := "Locked"
					MirtFPCurrency := "Requires:"
					MirtChallenges := "Costs:"
					MirtRequires := UserDetails.details.stats.total_hero_levels "/2000 Item Levels && " TotalChamps "/20 Champs"
					if ((UserDetails.details.stats.total_hero_levels > 1999) && (TotalChamps > 19)) {
						Gui, Font, cGreen
						GuiControl, Font, MirtFPCurrency
					}
					MirtCosts := CurrentTGPs "/3 TGPs && " CurrentSilvers "/10 Silver Chests"
					if ((CurrentTGPs > 2) && (CurrentSilvers > 9)) {
						Gui, Font, cGreen
						GuiControl, Font, MirtChallenges
					}
				}
				else for kk, vv in v.progress_bars
					switch vv.id
				{
				case "variants_completed":
					MirtVariantTotal := vv.goal
					MirtCompleted := vv.count
					MirtVariants := MirtCompleted " / " MirtVariantTotal
					case "free_play_limit": MirtFPCurrency := vv.count
					case "weekly_challenge_porgress": MirtChallenges := vv.count
				}
			}
			case 2: {
				if v.unlocked == False {
					VajraVariants := "Locked"
					VajraFPCurrency := "Requires:"
					VajraChallenges := "Costs:"
					VajraRequires := UserDetails.details.stats.completed_adventures_variants_and_patron_variants_c15 "/15 WD:DH Advs && " TotalChamps "/30 Champs"
					if ((UserDetails.details.stats.completed_adventures_variants_and_patron_variants_c15 > 14) && (TotalChamps > 29)) {
						Gui, Font, cGreen
						GuiControl, Font, VajraFPCurrency
					}
					VajraCosts := CurrentGems "/2500 Gems && " CurrentSilvers "/15 Silver Chests"
					if ((CurrentGems > 2499) && (CurrentSilvers > 14)) {
						Gui, Font, cGreen
						GuiControl, Font, VajraChallenges
					}
				}
				else for kk, vv in v.progress_bars
					switch vv.id
				{
				case "variants_completed":
					VajraVariantTotal := vv.goal
					VajraCompleted := vv.count
					VajraVariants := VajraCompleted " / " VajraVariantTotal
					case "free_play_limit": VajraFPCurrency := vv.count
					case "weekly_challenge_porgress": VajraChallenges := vv.count
				}
			}
			case 3: {
				if v.unlocked == False {
					StrahdVariants := "Locked"
					StrahdFPCurrency := "Requires:"
					StrahdChallenges := "Costs:"
					StrahdRequires := UserDetails.details.stats.highest_area_completed_ever_c413 "/250 in Adventure 413 && " TotalChamps "/40 Champs"
					if ((UserDetails.details.stats.highest_area_completed_ever_c413 > 249) && (TotalChamps > 39)) {
						Gui, Font, cGreen
						GuiControl, Font, StrahdFPCurrency
					}
					StrahdCosts := CurrentLgBounties "/10 Lg Bounties && " CurrentSilvers "/20 Silver Chests"
					if ((CurrentLgBounties > 9) && (CurrentSilvers > 19)) {
						Gui, Font, cGreen
						GuiControl, Font, StrahdChallenges
					}
				}
				else for kk, vv in v.progress_bars
					switch vv.id
				{
				case "variants_completed":
					StrahdVariantTotal := vv.goal
					StrahdCompleted := vv.count
					StrahdVariants := StrahdCompleted " / " StrahdVariantTotal
					case "free_play_limit": StrahdFPCurrency := vv.count
					case "weekly_challenge_porgress": StrahdChallenges := vv.count
				}
			}
			case 4: {
				if v.unlocked == False {
					ZarielVariants := "Locked"
					ZarielFPCurrency := "Requires:"
					ZarielChallenges := "Costs:"
					ZarielRequires := UserDetails.details.stats.highest_area_completed_ever_c873 "/575 in Adventure 873 && " TotalChamps "/50 Champs"
					if ((UserDetails.details.stats.highest_area_completed_ever_c873 > 574) && (TotalChamps > 49)) {
						Gui, Font, cGreen
						GuiControl, Font, ZarielFPCurrency
					}
					ZarielCosts := CurrentSilvers "/50 Silver Chests"
					if (CurrentSilvers > 49) {
						Gui, Font, cGreen
						GuiControl, Font, ZarielChallenges
					}
				}
				else for kk, vv in v.progress_bars
					switch vv.id
				{
				case "variants_completed":
					ZarielVariantTotal := vv.goal
					ZarielCompleted := vv.count
					ZarielVariants := ZarielCompleted " / " ZarielVariantTotal
					case "free_play_limit": ZarielFPCurrency := vv.count
					case "weekly_challenge_porgress": ZarielChallenges := vv.count
				}
			}
		}
	}

	ParseLootData() {
		EpicGearCount := 0
		todogear := "`nHighest Gear Level: " UserDetails.details.stats.highest_level_gear
		for k, v in UserDetails.details.loot {
			if (v.rarity == "4") {
				EpicGearCount += 1
			}
			if ((v.hero_id == "58") && (v.slot_id == "4")) {
				brivrarity := v.rarity
				brivgild := v.gild
				brivenchant := v.enchant
			}
			if ((v.enchant + 1) = UserDetails.details.stats.highest_level_gear) {
				todogear := todogear "`n(" ChampFromID(v.hero_id) " Slot " v.slot_id ")`n"
			}
		}
		AchievementInfo := "Achievement Details`n" todogear
		switch brivrarity {
			case "0": BrivSlot4 := 0
			case "1": BrivSlot4 := 10
			case "2": BrivSlot4 := 30
			case "3": BrivSlot4 := 50
			case "4": BrivSlot4 := 100
		}
		BrivSlot4 += brivenchant*0.4
		BrivSlot4 *= 1+(brivgild*0.5)
		for k, v in UserDetails.details.modron_saves
		if (v.instance_id == ActiveInstance) {
			BrivZone := v.area_goal
		}
	}

	ParseChampData() {
		TotalChamps := 0
		for k, v in UserDetails.details.heroes
		if (v.owned == 1) {
			TotalChamps += 1
		}
		;
		ChampDetails := ""
		if (UserDetails.details.stats.black_viper_total_gems) {
			ChampDetails := ChampDetails "Black Viper Red Gems: " UserDetails.details.stats.black_viper_total_gems "`n`n"
		}
		if (UserDetails.details.stats.total_paid_up_front_gold) {
			morgaengold := SubStr(UserDetails.details.stats.total_paid_up_front_gold, 1, 4)
			epos := InStr(UserDetails.details.stats.total_paid_up_front_gold, "E")
			morgaengold := morgaengold SubStr(UserDetails.details.stats.total_paid_up_front_gold, epos)
			ChampDetails := ChampDetails "M" Chr(244) "rg" Chr(230) "n Gold Collected: " morgaengold "`n`n"
		}
		if (UserDetails.details.stats.torogar_lifetime_zealot_stacks) {
			torostacks := UserDetails.details.stats.torogar_lifetime_zealot_stacks
			ChampDetails := ChampDetails "Torogar Zealot Stacks: " torostacks "`n`n"
		}

		if (UserDetails.details.stats.zorbu_lifelong_hits_beast || UserDetails.details.stats.zorbu_lifelong_hits_undead || UserDetails.details.stats.zorbu_lifelong_hits_drow) {
			ChampDetails := ChampDetails "Zorbu Kills:`n(Humanoid)`t" UserDetails.details.stats.zorbu_lifelong_hits_humanoid "`n(Beast)`t`t" UserDetails.details.stats.zorbu_lifelong_hits_beast "`n(Undead)`t" UserDetails.details.stats.zorbu_lifelong_hits_undead "`n(Drow)`t`t" UserDetails.details.stats.zorbu_lifelong_hits_drow "`n`n"
		}

		if (UserDetails.details.stats.dhani_monsters_painted) {
			dhanipaint := UserDetails.details.stats.dhani_monsters_painted
			ChampDetails := ChampDetails "D hani Paints: " dhanipaint "`n`n"
		}

	}	

	CheckPatronProgress() {
		if !(MirtVariants == "Locked") {
			if (MirtFPCurrency = "5000") {
				Gui, Font, cGreen
				GuiControl, Font, MirtFPCurrency
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, MirtFPCurrency
			}
			if (MirtChallenges = "10") {
				Gui, Font, cGreen
				GuiControl, Font, MirtChallenges
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, MirtChallenges
			}
			if (MirtCompleted = MirtVariantTotal) {
				Gui, Font, cGreen
				GuiControl, Font, MirtVariants
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, MirtVariants
			}
		}
		if !(VajraVariants == "Locked") {
			if (VajraFPCurrency = "5000") {
				Gui, Font, cGreen
				GuiControl, Font, VajraFPCurrency
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, VajraFPCurrency
			}
			if (VajraChallenges = "10") {
				Gui, Font, cGreen
				GuiControl, Font, VajraChallenges
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, VajraChallenges
			}
			if (VajraCompleted = VajraVariantTotal) {
				Gui, Font, cGreen
				GuiControl, Font, VajraVariants
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, VajraVariants
			}
		}
		if !(StrahdVariants == "Locked") {
			if (StrahdChallenges = "10") {
				Gui, Font, cGreen
				GuiControl, Font, StrahdChallenges
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, StrahdChallenges
			}
			if (StrahdFPCurrency = "5000") {
				Gui, Font, cGreen
				GuiControl, Font, StrahdFPCurrency
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, StrahdFPCurrency
			}
			if (StrahdCompleted = StrahdVariantTotal) {
				Gui, Font, cGreen
				GuiControl, Font, StrahdVariants
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, StrahdVariants
			}
		}
		if !(ZarielVariants == "Locked") {
			if (ZarielChallenges = "10") {
				Gui, Font, cGreen
				GuiControl, Font, ZarielChallenges
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, ZarielChallenges
			}
			if (ZarielFPCurrency = "5000") {
				Gui, Font, cGreen
				GuiControl, Font, ZarielFPCurrency
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, ZarielFPCurrency
			}
			if (ZarielCompleted = ZarielVariantTotal) {
				Gui, Font, cGreen
				GuiControl, Font, ZarielVariants
			}
			else {
				Gui, Font, cRed
				GuiControl, Font, ZarielVariants
			}
		}
	}

	CheckAchievements() {
		if (UserDetails.details.stats.asharra_bonds < 3) {
			if !(UserDetails.details.stats.asharra_bond_human)
				ashexotic := " human"
			if !(UserDetails.details.stats.asharra_bond_elf)
				ashelf := " elf"
			if !(UserDetails.details.stats.asharra_bond_exotic)
				ashhuman := " exotic"
			todoasharra := "`nAsharra needs:" ashhuman ashelf ashexotic
		}
		if !((UserDetails.details.stats.area_175_gromma_spec_a + UserDetails.details.stats.area_175_gromma_spec_b + UserDetails.details.stats.area_175_gromma_spec_c) == 3) {
			if !(UserDetails.details.stats.area_175_gromma_spec_a == 1)
				groma := " mountain"
			if !(UserDetails.details.stats.area_175_gromma_spec_b == 1)
				gromb := " arctic"
			if !(UserDetails.details.stats.area_175_gromma_spec_c == 1)
				gromc := " swamp"
			todogromma := "`nGromma needs:" groma gromb gromc
		}
		if !((UserDetails.details.stats.krond_cantrip_1_kills > 99) && (UserDetails.details.stats.krond_cantrip_2_kills > 99) && (UserDetails.details.stats.krond_cantrip_3_kills > 99)) {
			if !(UserDetails.details.stats.krond_cantrip_1_kills > 99)
				krond1 := " thunderclap"
			if !(UserDetails.details.stats.krond_cantrip_2_kills > 99)
				krond2 := " shockinggrasp"
			if !(UserDetails.details.stats.krond_cantrip_3_kills > 99)
				krond3 := " firebolt"
			todokrond := "`nKrond needs:" krond1 krond2 krond3
		}
		if (UserDetails.details.stats.regis_specializations < 6) {
			if !(UserDetails.details.stats.regis_back_magic == 1)
				regis1 := " <-magic"
			if !(UserDetails.details.stats.regis_back_melee == 1)
				regis2 := " <-melee"
			if !(UserDetails.details.stats.regis_back_ranged == 1)
				regis3 := " <-ranged"
			if !(UserDetails.details.stats.regis_front_magic == 1)
				regis4 := " magic->"
			if !(UserDetails.details.stats.regis_front_melee == 1)
				regis5 := " melee->"
			if !(UserDetails.details.stats.regis_front_ranged == 1)
				regis6 := " ranged->"
			todoregis := "`nRegis needs:" regis1 regis2 regis3 regis4 regis5 regis6
		}
		if (UserDetails.details.stats.krydle_return_to_baldurs_gate < 3) {
			if !(UserDetails.details.stats.krydle_return_to_baldurs_gate_delina == 1)
				krydle1 := " delina"
			if !(UserDetails.details.stats.krydle_return_to_baldurs_gate_krydle == 1)
				krydle2 := " krydle"
			if !(UserDetails.details.stats.krydle_return_to_baldurs_gate_minsc == 1)
				krydle3 := " minsc"
			todokrydle := "`nKrydle needs:" krydle1 krydle2 krydle3
		}
		AchievementInfo := AchievementInfo todoasharra todogromma todokrond todoregis todokrydle
	}

	CheckBlessings() {
		epiccount := ""
		epicvalue := Round((1.02 ** EpicGearCount), 2)
		if (UserDetails.details.reset_upgrade_levels.44) { ;Helm-Slow and Steady (X Epics)
			epiccount := "Slow and Steady:`nx" epicvalue " damage (" EpicGearCount " epics)`n`n"
		}
		veterancount := ""
		veteranvalue := Round(1 + (0.1 * UserDetails.details.stats.completed_adventures_variants_and_patron_variants_c22), 2)
		if (UserDetails.details.reset_upgrade_levels.56) { ;Tiamat-Veterans of Avernus (X Adventures)
			veterancount := "Veterans of Avernus:`nx" veteranvalue " damage (" UserDetails.details.stats.completed_adventures_variants_and_patron_variants_c22 " adventures)`n`n"
		}
		BlessingInfo := "Blessing Details`n`n" epiccount veterancount
		if (BlessingInfo == "Blessing Details`n`n") {
			BlessingInfo := "Blessing Details: N/A"
		}
	}

	ServerCall(callname, parameters) {
		;servername from settings, instead of the hard coded value
		URLtoCall := "http://" servername ".idlechampions.com/~idledragons/post.php?call=" callname parameters
		WR := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		;default values on the below in ms, 0 is INF
		;from https://docs.microsoft.com/en-us/windows/win32/winhttp/iwinhttprequest-settimeouts
		WR.SetTimeouts(0, 60000, 30000, 120000)
		Try {
			WR.Open("POST", URLtoCall, false)
			WR.SetRequestHeader("Content-Type","application/x-www-form-urlencoded")
			WR.Send()
			WR.WaitForResponse()
			data := WR.ResponseText
			WR.Close()
		}
		UpdateLogTime()
		FileAppend, (%CurrentTime%) Server request: "%callname%"`n, %OutputLogFile%
		FileRead, OutputText, %OutputLogFile%
		oMyGUI.Update()
		return data
	}

	LaunchGame() {
		if (Not WinExist("ahk_exe IdleDragons.exe")) {
			Run, %GameClient%
			SB_SetText("Game client starting...")
			WinWait, "ahk_exe IdleDragons.exe"
			SB_SetText("Game client has started!")
		}
		else {
			if !FirstRun {
				SB_SetText("Game client is already running!")
			}
		}
		return
	}

	Get_Journal:
		{
			if !UserID {
				MsgBox % "Need User ID & Hash."
				FirstRun()
			}
			if (InstanceID = 0) {
				MsgBox, 4, , No Instance ID detected. Check server for user details?
					IfMsgBox, Yes
				{
					GetUserDetails()
				}
				else
					return
			}
			journalparams := "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&page="
			InputBox, pagecount, Journal, % "How many pages of Journal to retreive?`n`n(This will overwrite any previous download.)", , 350, 180
			if ErrorLevel
				return
			pagenum := 1
			FileDelete, %JournalFile%
			while !(pagenum > pagecount) {
				SB_SetText("Journal pages remaining to download: " ((pagecount - pagenum) + 1))
				rawresults := ServerCall("getPlayHistory", journalparams pagenum)
				FileAppend, %rawresults%`n, %JournalFile%
				pagenum += 1
				sleep 1000
			}
			UpdateLogTime()
			FileAppend, % "(" CurrentTime ") Journal pages downloaded: " (pagenum - 1) "`n", %OutputLogFile%
			FileRead, OutputText, %OutputLogFile%
			oMyGUI.Update()
			SB_SetText("Journal download completed.")
			return
		}

	Open_Ticket:
		{
			Run, % "https://help.idlechampions.com/?page=help&display=open_tickets&user_id=" UserID "&hash=" UserHash
			return
		}

	Discord_Clicked:
		{
			Run, % "https://discord.com/invite/N3U8xtB"
			return
		}

		Update_Dictionary() {
			if !(DictionaryVersion == CurrentDictionary) {
				FileDelete, %LocalDictionary%
				UrlDownloadToFile, %DictionaryFile%, %LocalDictionary%
				Reload
				return
			}
			else {
				MsgBox % "Dictionary file up to date."
			}
			return
		}

	List_ChampIDs:
		{
			champnamelen := 0
			champname := ""
			id := 1
			champidlist := ""
			while (id < 121) {
				champname := ChampFromID(id)
				StringLen, champnamelen, champname
				while (champnamelen < 16)
				{
					champname := champname " "
					champnamelen += 1
				}
				if (!mod(id, 4))
					champidlist := champidlist id ": " champname "`n"
				else
					champidlist := champidlist id ": " champname "`t"
				id += 1
			}
			;MsgBox, , Champ ID List, % champidlist
			CustomMsgBox("Champion IDs and Names",champidlist,"Courier New","Blue")
			return	
		}

		CustomMsgBox(Title,Message,Font="",FontOptions="",WindowColor="")
		{
			Gui,66:Destroy
			Gui,66:Color,%WindowColor%

			Gui,66:Font,%FontOptions%,%Font%
			Gui,66:Add,Text,,%Message%
			Gui,66:Font

			GuiControlGet,Text,66:Pos,Static1

			Gui,66:Add,Button,% "Default y+10 w75 g66OK xp+" (TextW / 2) - 38 ,OK

			Gui,66:-MinimizeBox
			Gui,66:-MaximizeBox

			SoundPlay,*-1
			Gui,66:Show,,%Title%

			Gui,66:+LastFound
			WinWaitClose
			Gui,66:Destroy
			return

			66OK:
				Gui,66:Destroy
			return
		}

		ViewICSettings() {
			rawicsettings := ""
			FileRead, rawicsettings, %ICSettingsFile%
			CurrentICSettings := JSON.parse(rawicsettings)
			MsgBox, , localSettings.json file, % rawicsettings
		}

		SetUIScale() {
			FileRead, rawicsettings, %ICSettingsFile%
			CurrentICSettings := JSON.parse(rawicsettings)
			newuiscale := 1
			InputBox, newuiscale, UI Scale, Please enter the desired UI Scale.`n(0.5 - 1.25), , 250, 150, , , , , % CurrentICSettings.UIScale
			if ErrorLevel
			return
		while ((newuiscale < 0.5) || (newuiscale > 1.25)) {
			InputBox, newuiscale, UI Scale, Please enter a valid UI Scale.`n(0.5 - 1.25), , 250, 150, , , , , % CurrentICSettings.UIScale
			if ErrorLevel
			return
	}
	if (InStr(newuiscale, ".") == 1) {
		newuiscale := "0" newuiscale
	}
	newicsettings := ""
	for k, v in CurrentICSettings {
		if (k == "UIScale") {
			newicsettings := newicsettings """" k """:" newuiscale ","
		}
		else {
			newicsettings := newicsettings """" k """:" v ","
		}
	}
	StringTrimRight, newicsettings, newicsettings, 1
	newicsettings := "{" newicsettings "}"
	MsgBox % newicsettings
	FileDelete, %ICSettingsFile%
	FileAppend, %newicsettings%, %ICSettingsFile%
	UpdateLogTime()
	FileAppend, % "(" CurrentTime ") UI Scale changed to " newuiscale "`n", %OutputLogFile%
	FileRead, OutputText, %OutputLogFile%
	oMyGUI.Update()
	SB_SetText("UI Scale changed to " newuiscale)
}

SetFramerate() {
	FileRead, rawicsettings, %ICSettingsFile%
	CurrentICSettings := JSON.parse(rawicsettings)
	newframerate := 60
	InputBox, newframerate, Framerate, Please enter the desired Framerate.`n(1 - 240), , 250, 150, , , , , % CurrentICSettings.TargetFramerate
	if ErrorLevel
		return
	while ((newframerate < 1) || (newframerate > 240)) {
		InputBox, newframerate, Framerate, Please enter a valid Framerate.`n(1 - 240), , 250, 150, , , , , % CurrentICSettings.TargetFramerate
		if ErrorLevel
			return
	}
	newicsettings := ""
	for k, v in CurrentICSettings {
		if (k == "TargetFramerate") {
			newicsettings := newicsettings """" k """:" newframerate ","
		}
		else {
			newicsettings := newicsettings """" k """:" v ","
		}
	}
	StringTrimRight, newicsettings, newicsettings, 1
	newicsettings := "{" newicsettings "}"
	MsgBox % newicsettings
	FileDelete, %ICSettingsFile%
	FileAppend, %newicsettings%, %ICSettingsFile%
	UpdateLogTime()
	FileAppend, % "(" CurrentTime ") Framerate changed to " newframerate "`n", %OutputLogFile%
	FileRead, OutputText, %OutputLogFile%
	oMyGUI.Update()
	SB_SetText("Framerate changed to " newframerate)
}

SetParticles() {
	FileRead, rawicsettings, %ICSettingsFile%
	CurrentICSettings := JSON.parse(rawicsettings)
	newparticles := 100
	InputBox, newparticles, Particles, Please enter the desired Percentage.`n(0 - 100), , 250, 150, , , , , % CurrentICSettings.PercentOfParticlesSpawned
	if ErrorLevel
		return
	while ((newparticles < 0) || (newparticles > 100)) {
		InputBox, newparticles, Particles, Please enter a valid Percentage.`n(0 - 100), , 250, 150, , , , , % CurrentICSettings.PercentOfParticlesSpawned
		if ErrorLevel
			return
	}
	newicsettings := ""
	for k, v in CurrentICSettings {
		if (k == "PercentOfParticlesSpawned") {
			newicsettings := newicsettings """" k """:" newparticles ","
		}
		else {
			newicsettings := newicsettings """" k """:" v ","
		}
	}
	StringTrimRight, newicsettings, newicsettings, 1
	newicsettings := "{" newicsettings "}"
	MsgBox % newicsettings
	FileDelete, %ICSettingsFile%
	FileAppend, %newicsettings%, %ICSettingsFile%
	UpdateLogTime()
	FileAppend, % "(" CurrentTime ") Paticles changed to " newparticles "`n", %OutputLogFile%
	FileRead, OutputText, %OutputLogFile%
	oMyGUI.Update()
	SB_SetText("Particles changed to " newparticles)
}

SimulateBriv(i) {
	SB_SetText("Calculating...")
	;Original version by Gladio Stricto - pastebin.com/Rd8wWSVC
	;Copied from updated version - github.com/Deatho0ne
	chance := ((BrivSlot4 / 100) + 1) * 0.25
	trueChance := chance
	skipLevels := 1
	if (chance > 2) {
		while chance >= 1 {
			skipLevels++
			chance /= 2
		}
		;trueChance := ((chance - Floor(chance)) / 2)
	} else {
		skipLevels := Floor(chance + 1)
		If (skipLevels > 1) {
			trueChance := 0.5 + ((chance - Floor(chance)) / 2)
		}
	}
	totalLevels := 0
	totalSkips := 0
	Loop % i {
		level := 0.0
		skips := 0.0
		Loop {
			Random, x, 0.0, 1.0
			If (x < trueChance) {
				level += skipLevels
				skips++
			}
			level++
		}
		Until level > BrivZone
		totalLevels += level
		totalSkips += skips
	}
	;chance := Round(chance, 2)
	if skipLevels < 3
		trueChance := Round(trueChance * 100, 2)
	else
		trueChance := Round(chance * 100, 2)
	avgSkips := Round(totalSkips / i, 2)
	avgSkipped := Round(avgSkips * skipLevels, 2)
	avgZones := Round(totalLevels / i, 2)
	avgSkipRate := Round((avgSkipped / avgZones) * 100, 2)
	avgStacks := Round((1.032**avgSkips) * 48, 2)
	multiplier := 0.1346894362, additve := 41.86396406
	roughTime := Round(((multiplier * avgStacks) + additve), 2)
	message = With Briv skip %skipLevels% until zone %BrivZone%`n(%trueChance%`% chance to skip %skipLevels% zones)`n`n%i% simulations produced an average:`n%avgSkips% skips (%avgSkipped% zones skipped)`n%avgZones% end zone`n%avgSkipRate%`% true skip rate`n%avgStacks% required stacks with`n%roughTime% time in secs to build said stacks very rough guess
	SB_SetText("Calculation has completed.")
	Return message
}

KlehoImage()
{
	campaignid := 0
	currenttimegate := ""
	kleholink := "https://idle.kleho.ru/assets/fb/"
	for k, v in UserDetails.defines.campaign_defines {
		campaignid := v.id
	}
	if (campaignid == 17) {
		for k, v in UserDetails.details.game_instances {
			if (v.game_instance_id == ActiveInstance) {
				currenttimegate := JSON.stringify(v.defines.adventure_defines[1].requirements[1].champion_id)
			}
		}
		campaignid := KlehoFromID(currenttimegate)
	}
	else if !((campaignid < 3) or (campaignid == 15) or (campaignid > 21)) {
		for k, v in UserDetails.details.game_instances {
			if (v.game_instance_id == ActiveInstance) {
				campaignid := campaignid "a" JSON.stringify(v.defines.adventure_defines[1].requirements[1].adventure_id)
			}
		}
	}
	kleholink := kleholink campaignid "/"
	for k, v in UserDetails.details.game_instances {
		if (v.game_instance_id == ActiveInstance) {
			for kk, vv in v.formation {
				if (vv > 0) {
					kleholink := kleholink vv "_"
				}
				else {
					kleholink := kleholink "_"
				}
			}
		}
	}
	StringTrimRight, kleholink, kleholink, 1
	kleholink := kleholink ".png"
	InputBox, dummyvar, Kleho Image, % "Copy link for formation sharing.`n`nSave image to the following file?`nformationimages\Patron-" CurrentPatron "\AdvID-" CurrentAdventure "\Area-" CurrentArea ".png", , , , , , , , % kleholink
	if ErrorLevel {
		dummyvar := ""
		return
	}
	if !(FileExist("\formationimages\")) {
		FileCreateDir, formationimages
	}
	if !(FileExist("\formationimages\Patron-" CurrentPatron)) {
		FileCreateDir, % "formationimages\Patron-" CurrentPatron
	}
	if !(FileExist("\formationimages\Patron-" CurrentPatron "\AdvID-" CurrentAdventure)) {
		FileCreateDir, % "formationimages\Patron-" CurrentPatron "\AdvID-" CurrentAdventure
	}
	UrlDownloadToFile, %kleholink%, % "formationimages\Patron-" CurrentPatron "\AdvID-" CurrentAdventure "\Area-" CurrentArea ".png"
	dummyvar := ""
	return
}

IncompleteVariants()
{
	if !FileExist("advdefs.json") {
		MsgBox % "Downloading adventure defines."
		AdventureList()
	}
	idtocheck := 0
	InputBox, idtocheck, Incomplete Adventures, Please enter the Patron to check.`nNone (0)`tMirt (1)`nVajra (2)`tStrahd (3)`nZariel (4), , 250, 200, , , , , % idtocheck
	if ErrorLevel
		return
	while ((idtocheck < 0) or (idtocheck > 4)) {
		InputBox, idtocheck, Incomplete Adventures, Please enter a valid Patron ID.`nMirt (1)`tVajra (2)`tStrahd (3)`nZariel (4), , 250, 200, , , , , % idtocheck
		if ErrorLevel
			return
	}
	if (idtocheck == 0) {
		IncompleteBase()
	}
	else {
		IncompletePatron(idtocheck)
	}
	return
}

IncompleteBase()
{
	FileRead, AdventureFile, advdefs.json
	AdventureNames := JSON.parse(AdventureFile)

	missingvariants := "No Patron:"
	campaignvariants := ""
	availablelist := {}
	completelist := {}
	freeplaylist := {}
	getparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID
	sResult := ServerCall("getcampaigndetails", getparams)
	FileDelete, campaign.json
	FileAppend, %sResult%, campaign.json
	campaignresults := JSON.parse(sResult)
	for k, v in campaignresults.defines.adventure_defines {
		if (v.repeatable) {
			freeplaylist.push(v.id)
		}
	}
	for k, v in campaignresults.campaigns {
		for k2, v2 in v.available_adventure_ids {
			availablelist.push(v2)
		}
		for k2, v2 in v.completed_adventure_ids {
			completelist.push(v2)
		}
		if (availablelist[1]) {
			campaignvariants := campaignvariants "`n" CampaignFromID(v.campaign_id) "- "
		}
		for k2, v2 in availablelist {
			campaignvariants := campaignvariants v2 ", "
		}
		for k2, v2 in completelist {
			campaignvariants := StrReplace(campaignvariants, " " v2 ", ", " ")
		}
		for k2, v2 in freeplaylist {
			campaignvariants := StrReplace(campaignvariants, " " v2 ", ", " ")
		}
		if (availablelist[1]) {
			StringTrimRight, campaignvariants, campaignvariants, 2
		}
		availablelist := {}
		completelist := {}
		if !(campaignvariants == ("`n" CampaignFromID(v.campaign_id))) {
			missingvariants := missingvariants campaignvariants
		}
		campaignvariants := ""
	}
	missingvariants := StrReplace(missingvariants, "-", ":`n")
	MsgBox % missingvariants
	return
}

IncompletePatron(patronid)
{
	FileRead, AdventureFile, advdefs.json
	AdventureNames := JSON.parse(AdventureFile)

	missingvariants := PatronFromID(patronid) ":"
	campaignvariants := ""
	availablelist := {}
	completelist := {}
	freeplaylist := {}
	getparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID
	sResult := ServerCall("getcampaigndetails", getparams)
	FileDelete, campaign.json
	FileAppend, %sResult%, campaign.json
	campaignresults := JSON.parse(sResult)
	for k, v in campaignresults.defines.adventure_defines {
		if (v.repeatable) {
			freeplaylist.push(v.id)
		}
	}
	for k, v in campaignresults.campaigns {
		for k2, v2 in v.available_patron_adventure_ids {
			for k3, v3 in v2 {
				if ((k3 == patronid) && (v3[1] == 1))
					availablelist.push(k2)
			}
		}
		for k2, v2 in v.completed_patron_adventure_ids {
			for k3, v3 in v2 {
				if ((k3 == patronid) && (v3[1] == 1))
					completelist.push(k2)
			}
		}
		if (availablelist[1]) {
			campaignvariants := campaignvariants "`n" CampaignFromID(v.campaign_id) "- "
		}
		for k2, v2 in availablelist {
			campaignvariants := campaignvariants v2 ", "
		}
		for k2, v2 in completelist {
			campaignvariants := StrReplace(campaignvariants, " " v2 ", ", " ")
		}
		for k2, v2 in freeplaylist {
			campaignvariants := StrReplace(campaignvariants, " " v2 ", ", " ")
		}
		if (availablelist[1]) {
			StringTrimRight, campaignvariants, campaignvariants, 2
		}
		availablelist := {}
		completelist := {}
		if !(campaignvariants == ("`n" CampaignFromID(v.campaign_id))) {
			missingvariants := missingvariants campaignvariants
		}
		campaignvariants := ""
	}
	missingvariants := StrReplace(missingvariants, "-", ":`n")
	MsgBox % missingvariants
	return
}

AdventureList() {
	getparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID
	sResult := ServerCall("getcampaigndetails", getparams)
	campaignresults := JSON.parse(sResult)
	freeplayids := {}
	freeplaynames := {}
	for k, v in campaignresults.defines.adventure_defines {
		freeplayids.push(v.id)
		freeplaynames.push(v.name)
	}
	count := 1
	testvar := "{"
	while (count < freeplayids.Count()) {
		testvar := testvar """" JSON.stringify(freeplayids[count]) """:"
		tempname := JSON.stringify(freeplaynames[count])
		testvar := testvar tempname ","
		count += 1
	}
	StringTrimRight, testvar, testvar, 1
	testvar := testvar "}"
	FileDelete, advdefs.json
	FileAppend, %testvar%, advdefs.json
	MsgBox % "advdefs.json saved to file."
	return
}

GearReport() {
	totalgearlevels := -1
	totalgearitems := -1
	totalcorelevels := -1
	totalcoreitems := -1
	totaleventlevels := 0
	totaleventitems := 0
	totalshinycore := 0
	totalshinyevent := 0
	highestcorelevel := 0
	highesteventlevel := 0
	highestcoreid := 0
	highesteventid := 0
	lowestcorelevel := 10000000000
	lowesteventlevel := 10000000000
	lowestcoreid := 0
	lowesteventid := 0
	currentchamplevel := 0
	currentcount := 0
	lastchamp := 0
	lastshiny := 0
	currentloot := UserDetails.details.loot
	dummyitem := {}
	currentloot.push(dummyitem)

	for k, v in currentloot {
		totalgearlevels += (v.enchant + 1)
		totalgearitems += 1

		if (lastchamp < 13) {
			totalcorelevels += (v.enchant + 1)
			totalcoreitems += 1
			if (lastshiny) {
				totalshinycore += 1
			}
			if ((v.hero_id != lastchamp) and (lastchamp != 0)) {
				if (currentchamplevel > highestcorelevel) {
					highestcorelevel := currentchamplevel
					highestcoreid := lastchamp
				}
				if (currentchamplevel < lowestcorelevel) {
					lowestcorelevel := currentchamplevel
					lowestcoreid := lastchamp
				}
				currentchamplevel := 0
				currentcount := 0
				currentchamplevel := (v.enchant + 1)
				currentcount += 1
			}
			else {
				currentchamplevel += (v.enchant + 1)
				currentcount += 1
			}
		}
		else if ((lastchamp = 13) or (lastchamp = 18) or (lastchamp = 30) or (lastchamp = 67) or (lastchamp = 68) or (lastchamp = 86) or (lastchamp = 87) or (lastchamp = 88) or (lastchamp = 106)){
			totalcorelevels += (v.enchant + 1)
			totalcoreitems += 1
			if (lastshiny) {
				totalshinycore += 1
			}
			if (v.hero_id != lastchamp) {
				if (currentchamplevel > highestcorelevel) {
					highestcorelevel := currentchamplevel
					highestcoreid := lastchamp
				}
				if (currentchamplevel < lowestcorelevel) {
					lowestcorelevel := currentchamplevel
					lowestcoreid := lastchamp
				}
				currentchamplevel := 0
				currentcount := 0
				currentchamplevel := (v.enchant + 1)
				currentcount += 1
			}
			else {
				currentchamplevel += (v.enchant + 1)
				currentcount += 1
			}
		}
		else {
			totaleventlevels += (v.enchant + 1)
			totaleventitems += 1
			if (lastshiny) {
				totalshinyevent += 1
			}
			if (v.hero_id != lastchamp) {
				if (currentchamplevel > highesteventlevel) {
					highesteventlevel := currentchamplevel
					highesteventid := lastchamp
				}
				if (currentchamplevel < lowesteventlevel) {
					lowesteventlevel := currentchamplevel
					lowesteventid := lastchamp
				}
				currentchamplevel := 0
				currentcount := 0
				currentchamplevel := (v.enchant + 1)
				currentcount += 1
			}
			else {
				currentchamplevel += (v.enchant + 1)
				currentcount += 1
			}
		}

		lastchamp := v.hero_id
		lastshiny := v.gild
	}
	dummyitem := currentloot.pop()
	shortreport := ""

	shortreport := shortreport "Avg item level:`t" Round(totalgearlevels/totalgearitems)

	shortreport := shortreport "`n`nAvg core level:`t" Round(totalcorelevels/totalcoreitems)
	shortreport := shortreport "`nHighest avg core:`t" Round(highestcorelevel/6) " (" ChampFromID(highestcoreid) ")"
	shortreport := shortreport "`nLowest avg core:`t" Round(lowestcorelevel/6) " (" ChampFromID(lowestcoreid) ")"
	shortreport := shortreport "`nCore Shinies:`t" totalshinycore "/" totalcoreitems

	shortreport := shortreport "`n`nAvg event level:`t" Round(totaleventlevels/totaleventitems)
	shortreport := shortreport "`nHighest avg event:`t" Round(highesteventlevel/6) " (" ChampFromID(highesteventid) ")"
	shortreport := shortreport "`nLowest avg event:`t" Round(lowesteventlevel/6) " (" ChampFromID(lowesteventid) ")"
	shortreport := shortreport "`nEvent Shinies:`t" totalshinyevent "/" totaleventitems

	MsgBox % shortreport
	return
}

PatronFeats() {
	assignedfeats := ""
	for k, v in UserDetails.details.heroes {
		for k2, v2 in v.active_feats {
			switch JSON.stringify(v2) {
				case "272": assignedfeats := assignedfeats "Celeste CON+1`n"
				case "13": assignedfeats := assignedfeats "Celeste INT+1`n"
				case "107": assignedfeats := assignedfeats "Drizzt INT+1`n"
				case "138": assignedfeats := assignedfeats "Nrakk INT+1`n"
				case "193": assignedfeats := assignedfeats "Zorbu INT+1`n"
				case "208": assignedfeats := assignedfeats "Nerys INT+1`n"
				case "229": assignedfeats := assignedfeats "Rosie INT+1`n"
				case "361": assignedfeats := assignedfeats "Gromma INT+1`n"
				default: assignedfeats := assignedfeats
			}
		}
	}
	if (assignedfeats = "") {
		assignedfeats := "None"
	}
	MsgBox % assignedfeats
	return
}

ShowPityTimers() {
	pitylist := ""
	pityjson := JSON.stringify(UserDetails.details.stats)
	pityjson := StrReplace(pityjson, """forced_tutorial_done"":""0"",""", """forced_win"":{""")
	pityjson := StrReplace(pityjson, "forced_win_counter_", "")
	pityjson := StrReplace(pityjson, ",""free_plays_completed""", "},""free_plays_completed""")
	pityjson := JSON.parse(pityjson)
	newestchamp := JSON.stringify(UserDetails.details.heroes[UserDetails.details.heroes.MaxIndex()].hero_id)
	newestchamp := StrReplace(newestchamp, """")
	chestsforepic := 1
	while (chestsforepic < 11) {
		if (chestsforepic == 1) {
			pitylist := pitylist "Epic in Next Chest for:`n "
		}
		else {
			pitylist := pitylist "Epic in next " chestsforepic " Chests for:`n "
		}
		currentchamp := 14
		currentcount := 0
		currentchest := 0
		currentpity := ""
		while (currentchamp < newestchamp) {
			currentchest := ChestIDFromChampID(currentchamp)
			for k, v in (pityjson.forced_win) {
				if (k = currentchest) {
					currentpity := v
				}
			}
			if (currentpity = chestsforepic) {
				pitylist := pitylist ChampFromID(currentchamp) ", "
				currentcount += 1
			}
			switch currentchamp {
				case "17": currentchamp += 2
				case "29": currentchamp += 2
				case "66": currentchamp += 3
				default: currentchamp += 1
			}
		}
		if !(currentcount) {
			pitylist := pitylist "(None)`n"
		}
		else {
			StringTrimRight, pitylist, pitylist, 2
			pitylist := pitylist "`n"
		}
		chestsforepic += 1
	}
	MsgBox % pitylist
	return
}

getChestCodes() {
	clipContents := clipboard
regexpPattern = P)\b(?<![A-Za-z0-9-/@#$`%^&!*])([A-Za-z0-9-@#$`%^&!*]{12,20})(?![A-Za-z0-9-/@#$`%^&!*])
foundCodeString := ""
while (clipContents ~= regexpPattern) {
	foundPos := RegExMatch(clipContents, regexpPattern, foundLength)
	foundCode := RegExReplace(SubStr(clipContents, foundPos, foundLength), "-")
	clipContents := SubStr(clipContents, foundPos + foundLength)
	if (InStr(foundCodeString, foundCode) = 0 && (StrLen(foundCode) = 12 || StrLen(foundCode) == 16)) {
		foundCodeString .= foundCode . "`r`n"
	}
}
foundCodeString := RegExReplace(foundCodeString, "`r`n$")
return foundCodeString
}

;{ ScrollBox
; SOURCE: https://www.autohotkey.com/boards/viewtopic.php?f=6&t=4837
; AUTHOR: Fanatic Guru
; CHANGELOG:
; 2016 11 18		Version 1.2
; 2018 06 09		Version 1.21
;	Fixed issue with creating autosize control containing more than 32k characters
;
; FUNCTION to Create Gui Scroll Box 
;
;------------------------------------------------
;
; Method:
;   ScrollBox(String, Options, Label)
;
;   Parameters:
;   1) {String} String to be displayed in scroll box
;
;   2) {Options}
;		d		destroy Gui if exist and recreate new
;		w		word wrap
;		p		pause until Gui closed
;		h		hide Gui if exist
;		s		show Gui if exist
;		l		left justified
;		r		right justified
;		c		center justified
;		p%%		p followed by a number for ms to pause
;		f%%		f followed by a number for font size
;		f{%%}	f followed by font options in format of Gui font command
;		x%%		x followed by a number for x box location
;		y%% 	y followed by a number for y box location
;		h%%		h followed by a number for height of box
;		w%%		w followed by a number for width of box
;		t%%		t followed by a number for tab stop (can be multiple)
;		b1		OK button, pauses for response
;		b2		YES / NO buttons, pauses for response
;					Options of existing Gui can not be changed except for position and size
;
;	3)  {Label}	Identifier for dealing with multiply Gui, also the Label at the top of Gui
;				Used to create the Gui name, all non-valid characters are striped
;				If Label exist and String is null and Options is null then Gui is destroyed
;					Otherwise Gui will be updated with new string
;					And Options x, y, h, w can be used to reposition and resize Gui Window
;
;				If String and Label are null then all Gui are destroyed
;
; Returns: 
;		1		OK or YES button pushed
;		0		NO button pushed
;		-1		Gui closed or escaped without pushing button
;		-2		Gui either had no pause or pause finished causing Gui to close
;
; Global:
;   Creates a series of global gui labels prefixed with ScrollBox_Gui_Label_
;
; Note:
;	When scroll box attempts to auto adjust control to fit text it will fail on very large strings.
; 	If scroll box is given a height and width then larger strings can be displayed.
;	Closing the box or hitting escape will destroy the gui.
;
; Example:
;	ScrollBox(Text, "w b2 p5000 f{s16 cRed bold, Arial} x50 y50 h400 w400")
;
ScrollBox(String := "", Options := "", Label := "")
{
	Static Gui_List, Gui_Index
	DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
	SetWinDelay, % (Setting_A_WinDelay := A_WinDelay) ? 0 : 0
	if !Gui_List
		Gui_List := {}
	if Label
	{
		Gui_Label := "ScrollBox_Gui_Label_" RegExReplace(Label, "i)[^0-9a-z#_@\$]", "")
		Gui_Hwnd := Gui_List[Gui_Label]
		Win_Hwnd := DllCall("GetParent", UInt, Gui_Hwnd)
		if RegExMatch(RegExReplace(Options, "\{.*}"), "i)d")
			Gui, %Gui_Label%:Destroy
		else if WinExist("ahk_id " Win_Hwnd)
		{
			if String
				GuiControl,,%Gui_Hwnd%, %String%
			WinGetPos, WinX, WinY, WinW, WinH
			if RegExMatch(Options, "i)x(\d+)", Match)
				WinX := Match1
			if RegExMatch(Options, "i)y(\d+)", Match)
				WinY := Match1
			if RegExMatch(Options, "i)w(\d+)", Match)
				WinW := Match1
			if RegExMatch(Options, "i)h(\d+)", Match)
				WinH := Match1
			Winmove, ahk_id %Win_Hwnd%,, WinX, WinY, WinW, WinH
			if RegExMatch(Options, "i)h(?!\d)", Match)
				Gui, %Gui_Label%:Hide
			if RegExMatch(Options, "i)s", Match)
				Gui, %Gui_Label%:Show
			DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
			SetWinDelay, %Setting_A_WinDelay%
			return
		}
	}
	else
	{
		Gui_Index ++
		Gui_Label := "ScrollBox_Gui_Label_" Gui_Index
	}
	if (!String and !Options)
	{
		if Label
		{
			Gui_List.Delete(Gui_Label)
			Gui, %Gui_Label%:Destroy
		}
		else
		{
			for key, element in Gui_List
				Gui, %key%:Destroy
			Gui_List := {}
		}
		DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
		SetWinDelay, %Setting_A_WinDelay%
		return
	}
	Gui %Gui_Label%:Default
	Gui +LabelAllGui
	Adjust1 := 10
	ButtonPushed := -2
	if RegExMatch(Options, "i)f(\d+)", Match)
	{
		Gui, Font, s%Match1%
		Adjust1 := Match1
	}
	else if RegExMatch(Options, "i)f\{(.*)}", Match)
	{
		Options := RegExReplace(Options, "i)f\{.*}")
		StringSplit, Match, Match1, `,
		Gui, Font, %Match1%, % Trim(Match2)
		RegExMatch(Match1, "i)s(\d+)", Adjust)
	}
	else
		Gui, Font
	Gui, Margin, 20, 20
	Gui, +MinSize200x200 +Resize
	Gui, Color, FFFFFF
	Opt := "hwndGui_Hwnd ReadOnly -E0x200  "
	if !(Options ~= "i)w(?!\d)")
		Opt .= "+0x300000 -wrap "
	if RegExMatch(Options, "i)h(\d+)", Match)
		Opt .= "h" Match1 " ", Control := true 
	if RegExMatch(Options, "i)w(\d+)", Match)
		Opt .= "w" Match1 " ", Control := true
	if (Options ~= "i)c")
		Opt .= "center "
	if (Options ~= "i)l")
		Opt .= "left "
	if (Options ~= "i)r")
		Opt .= "right "
	Loop
	{
		Pos ++
		if (Pos := RegExMatch(Options, "i)t(\d+)", Match, Pos))
			Opt .= "t" Match1 " "
	} until !Pos
	Opt_Show := "AutoSize "
	if RegExMatch(Options, "i)x(\d+)", Match)
		Opt_Show .= "x" Match1 " "
	if RegExMatch(Options, "i)y(\d+)", Match)
		Opt_Show .= "y" Match1 " "
	if Control
	{
		Gui, Add, Edit, % Opt
		GuiControl, , %Gui_Hwnd%, %String%
	}
	else
	{
		if (StrLen(String) < 32000)	; Gui control cannot be created with more than 32k of text directly
			Gui, Add, Edit, % Opt, %String%
		else
		{
			Gui, Add, Edit, % Opt, % SubStr(String, 1, 32000)
			GuiControl, , %Gui_Hwnd%, %String%
		}
	}
	if RegExMatch(Options, "i)b(1|2)", Match)
	{
		Button := Match1
		if (Button = 1)
			Gui, Add, Button, gAllGuiButtonOK hwndScrollBox_Button1_Hwnd Default, OK
		else
		{
			Gui, Add, Button, gAllGuiButtonYES hwndScrollBox_Button1_Hwnd Default, YES
			Gui, Add, Button, gAllGuiButtonNO hwndScrollBox_Button2_Hwnd, % " NO "
		}
	}
	Gui, Show, % Opt_Show, % Label ? Label : "ScrollBox"
	Gui_List[Gui_Label] := Gui_Hwnd
	Win_Hwnd := DllCall("GetParent", UInt, Gui_Hwnd)
	WinGetPos,X,Y,W,H, ahk_id %Win_Hwnd%
	WinMove, ahk_id %Win_Hwnd%,,X,Y,W-1,H-1 ; Move
	WinMove, ahk_id %Win_Hwnd%,,X,Y,W,H ; And Move Back to Force Recalculation of Margins
	if Button
		ControlSend,,{Tab}{Tab}+{Tab}, ahk_id %Gui_Hwnd% ; Move to Button
	else
		ControlSend,,^{Home}, ahk_id %Gui_Hwnd% ; Unselect Text and Move to Top of Control
	DllCall("HideCaret", "Int", Gui_Hwnd)
	if ((Options ~= "i)p(?!\d)") or (!(Options ~= "i)p") and Button))
		while (ButtonPushed = -2)
			Sleep 50
	else if RegExMatch(Options, "i)p(\d+)", Match)
	{
		TimeEnd := A_TickCount + Match1
		while (A_TickCount < TimeEnd and ButtonPushed = -2)
			Sleep 50
		Gui_List.Delete(Gui_Label)
		Gui, Destroy
	}
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	SetWinDelay, %Setting_A_WinDelay%
	Gui, 1:Default
	return ButtonPushed

	AllGuiSize:
		Resize_Gui_Hwnd := Gui_List[A_Gui]
		if Button
		{
			if (Button = 1)
			{
				EditWidth := A_GuiWidth - 20
				EditHeight := A_GuiHeight - 20 - (Adjust1 * 3)
				ButtonX := EditWidth / 2  - Adjust1
				ButtonY := EditHeight + 20 + (Adjust1/6)   
				GuiControl, Move, %Resize_Gui_Hwnd%, W%EditWidth% H%EditHeight%
				GuiControl, Move, %ScrollBox_Button1_Hwnd%, X%ButtonX% Y%ButtonY%
			}
			else
			{
				EditWidth := A_GuiWidth - 20
				EditHeight := A_GuiHeight - 20 - (Adjust1 * 3)
				Button1X := EditWidth / 4 - (Adjust1 * 2)
				Button2X := 3 * EditWidth / 4  - (Adjust1 * 1.5)
				ButtonY := EditHeight + 20 + (Adjust1/6) 
				GuiControl, Move, %Resize_Gui_Hwnd%, W%EditWidth% H%EditHeight%
				GuiControl, Move, %ScrollBox_Button1_Hwnd%, X%Button1X% Y%ButtonY%
				GuiControl, Move, %ScrollBox_Button2_Hwnd%, X%Button2X% Y%ButtonY%
			}
		}
		else
		{
			EditWidth := A_GuiWidth - 20
			EditHeight := A_GuiHeight - 20
			GuiControl, Move, %Resize_Gui_Hwnd%, W%EditWidth% H%EditHeight%
		}
	return

	AllGuiButtonOK:
		ButtonPushed := 1
		Gui, %A_Gui%:Destroy
		Gui_List.Delete(A_Gui)
	return

	AllGuiButtonYES:
		ButtonPushed := 1
		Gui, %A_Gui%:Destroy
		Gui_List.Delete(A_Gui)
	return

	AllGuiButtonNO:
		ButtonPushed := 0
		Gui, %A_Gui%:Destroy
		Gui_List.Delete(A_Gui)
	return

	AllGuiEscape:
	AllGuiClose:
		ButtonPushed := -1
		Gui, %A_Gui%:Destroy
		Gui_List.Delete(A_Gui)
	return
}