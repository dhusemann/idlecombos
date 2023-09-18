#NoEnv
#Persistent
#SingleInstance Force
#include %A_ScriptDir%
#include JSON.ahk
#include idledict.ahk

;Versions
global VersionNumber := "3.62"
global CurrentDictionary := "2.32"

;Local File globals
global OutputLogFile := ""
global LogFileName := "idlecombolog.txt"
global SettingsFile := "idlecombosettings.json"
global UserDetailsFile := "userdetails.json"
global ChestOpenLogFile := "chestopenlog.json"
global BlacksmithLogFile := "blacksmithlog.json"
global BountyLogFile := "bountylog.json"
global RedeemCodeLogFile := "redeemcodelog.json"
global JournalFile := "journal.json"
global CurrentSettings := []
global IconFilename := "IdleDragons.exe"
global IconFile := ""
global GameInstallDir := ""
global GamePlatform := ""
global GameClient := ""
global GameClientExe := "IdleDragons.exe"
global GameClientExeStandaloneLauncher := "IdleDragonsLauncher.exe"
global GameInstallDirSteam := "C:\Program Files (x86)\Steam\steamapps\common\IdleChampions\"
global GameInstallDirEpic := ""
global GameInstallDirStandaloneLauncher := "C:\Program Files (x86)\Idle Champions\"
global GameInstallDirStandalone := "C:\Program Files (x86)\Idle Champions\IdleChampions\"
global GameClientEpic := "C:\ProgramData\Epic\UnrealEngineLauncher\LauncherInstalled.dat"
global GameIDEpic := "40cb42e38c0b4a14a1bb133eb3291572"
global GameHashEpic := "57f205884f6c64417c7aa5e84ad9fc8d"
global GameHashSteam := "ce901520efb6bc265a549aeec201bed0"
global GameClientEpicLauncher := "com.epicgames.launcher://apps/" GameIDEpic "?action=launch&silent=true"
global WRLFile := ""
global WRLFilePath := "IdleDragons_Data\StreamingAssets\downloaded_files\webRequestLog.txt"
global DictionaryFile := "https://raw.githubusercontent.com/djravine/idlecombos/master/idledict.ahk"
global LocalDictionary := "idledict.ahk"
global ICSettingsFile := A_AppData
StringTrimRight, ICSettingsFile, ICSettingsFile, 7
ICSettingsFile := ICSettingsFile "LocalLow\Codename Entertainment\Idle Champions\localSettings.json"

;Settings globals
global ServerName := "master"
global GetDetailsonStart := 0
global LaunchGameonStart := 0
global FirstRun := 1
global AlwaysSaveChests := 0
global AlwaysSaveContracts := 0
global AlwaysSaveCodes := 0
global NoSaveSetting := 0
global LogEnabled := 0
global LoadGameClient := 0 ;0 none; 1 epic, 2 steam, 3 standalone
global TabActive := "Summary"
global TabList := "Summary|Adventures|Inventory|Patrons|Champions|Event|Settings|Log|"
global ServerDetection := 1
global ShowResultsBlacksmithContracts := 1
global DisableUserDetailsReload := 0
;global StyleSelection := "Default"
global SettingsCheckValue := 20 ;used to check for outdated settings file
global NewSettings := JSON.stringify({"alwayssavechests":1,"alwayssavecontracts":1,"alwayssavecodes":1,"firstrun":0,"getdetailsonstart":0,"hash":0,"instance_id":0,"launchgameonstart":0,"loadgameclient":0,"logenabled":0,"nosavesetting":0,"servername":"master","user_id":0,"user_id_epic":0,"user_id_steam":0,"tabactive":"Summary","serverdetection":1,"wrlpath":"","blacksmithcontractresults":1,"disableuserdetailsreload":0})

;Server globals
global DummyData := "&language_id=1&timestamp=0&request_id=0&network_id=11&mobile_client_version=999"
global CodestoEnter := ""
global ServerError := ""

;User info globals
global UserID := 0
global UserIDEpic := 0
global UserIDSteam := 0
global UserHash := 0
global InstanceID := 0
global UserDetails := []
global ActiveInstance := 0
global CurrentAdventure := ""
global CurrentArea := ""
global CurrentPatron := ""
global CurrentChampions := ""
global BackgroundAdventure := ""
global BackgroundArea := ""
global BackgroundPatron := ""
global BackgroundChampions := ""
global Background2Adventure := ""
global Background2Area := ""
global Background2Patron := ""
global Background2Champions := ""
global Background3Adventure := ""
global Background3Area := ""
global Background3Patron := ""
global Background3Champions := ""
global AchievementInfo := "Welcome to IdleCombos!`n`nPlease setup your game client`nor update your user details.`n`n`n`n`n`n`n"
global BlessingInfo := "`n`n`n`n`n`n"
global ChampDetails := ""
global TotalChamps := 0
global About := "IdleCombos v" VersionNumber "`n`nOriginal by QuickMythril`nMaintained by DJRavine`nUpdates by Eldoen, dhusemann, NeyahPeterson, deathoone, Fmagdi`n`nSpecial thanks to all the idle dragoneers who inspired and assisted me!"
global HotkeyInfo := "CONTROL + NUMPAD1 - Tiny Blacksmith Contracts`nCONTROL + NUMPAD2 - Small Blacksmith Contracts`nCONTROL + NUMPAD3 - Medium Blacksmith Contracts`nCONTROL + NUMPAD4 - Large Blacksmith Contracts`nCONTROL + NUMPAD5 - Huge Blacksmith Contracts`n"
HotkeyInfo := HotkeyInfo "CONTROL + NUMPAD/ - Buy Silver Chests`nCONTROL + NUMPAD* - Buy Gold Chests`nCONTROL + NUMPAD- - Buy Event Chests`nCONTROL + NUMPAD7 - Open Silver Chests`nCONTROL + NUMPAD8 - Open Gold Chests`nCONTROL + NUMPAD9 - Open Event Chests`n"
HotkeyInfo := HotkeyInfo "CONTROL + 7 - Tiny Bounty Contracts`nCONTROL + 8 - Small Bounty Contracts`nCONTROL + 9 - Medium Bounty Contracts`nCONTROL + 0 - Large Bounty Contracts`n"

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
global ChampionsUnlockedCount := 0
global ChampionsActiveCount := 0
global FamiliarsUnlockedCount := 0
global CostumesUnlockedCount := 0
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

;Event globals
global EventID := ""
global EventName := ""
global EventDesc := ""
global EventTokenName := ""
global EventTokens := ""
global EventHeroIDs := ""
global EventChestIDs := ""
global EventDetails := ""

;Web Tools globals
global WebToolGithub := "https://github.com/djravine/idlecombos"
global WebToolDiscord := "https://discord.gg/wFtrGqd3ZQ"
global WebToolCodes := "https://incendar.com/idlechampions_codes.php"
global WebToolCodesRecent := "#i11"
global WebToolCodesSpecial := "#i22"
global WebToolCodesPermanent := "#i33"
global WebToolGameViewer := "http://idlechampions.soulreaver.usermd.net"
global WebToolDataViewer := "https://idle.kleho.ru"
global WebToolUtilities := "https://ic.byteglow.com"
global WebToolUtilitiesModron := WebToolUtilities "/modron"
global WebToolUtilitiesFormation := WebToolUtilities "/formation"

;GUI globals
global oMyGUI := ""
global OutputText := ""
global OutputStatus := "Welcome to IdleCombos v" VersionNumber
global CurrentTime := ""
global CrashProtectStatus := "Crash Protect`nDisabled"
global CrashCount := 0
global LastUpdated := "No data loaded"
global TrayIcon := IconFile
global LastBSChamp := ""
global LastBSTnCount := ""
global LastBSSmCount := ""
global LastBSMdCount := ""
global LastBSLgCount := ""
global LastBSHgCount := ""
global LastBountyTnCount := ""
global LastBountySmCount := ""
global LastBountyMdCount := ""
global LastBountyLgCount := ""
global foundCodeString := ""
global BgColour := "FFFFFF"

;Style support
;global StyleDLLPath := A_ScriptDir "\USkin.dll" ;Location to the USkin.dll file
;global StylePath := A_ScriptDir "\styles\" ;Location where you saved the .msstyles files
;global CurrentStyle := "IdleCombos.msstyles"
;global StyleList := "Default||"
;Loop, % StylePath "*.msstyles" {
;	if (A_LoopFilename != "Default.msstyles") {
;		StyleList .= A_LoopFilename . "|"
;	}
;}
;StyleList := RegExReplace(StyleList, ".msstyles")
;RunWith(32) ;Force to start in 32 bit mode

;detect and set game installation paths
if ( setGameInstallEpic() == false ) {
	if ( setGameInstallSteam() == false ) {
		setGameInstallStandalone()
	}
}

SetIcon()

oMyGUI := new MyGui()

;OnExit("ExitFunc")

;end startup
return

;BEGIN: GUI Defs
class MyGui {
	Width := "600"
	Height := "275" ;"250"

	__New() {
		Global
		Gui, MyWindow:New
		Gui, MyWindow:+Resize -MaximizeBox +MinSize

		;Set Transparency
		;Gui, +LastFound
		;WinSet, Transparent, 180

		Menu, ICSettingsSubmenu, Add, &View Settings, ViewICSettings
		Menu, ICSettingsSubmenu, Add, &Framerate, SetFramerate
		Menu, ICSettingsSubmenu, Add, &Particles, SetParticles
		Menu, ICSettingsSubmenu, Add, &UI Scale, SetUIScale
		Menu, FileSubmenu, Add, &Idle Champions Settings, :ICSettingsSubmenu

		Menu, FileSubmenu, Add, &Launch Game Client, LaunchGame
		Menu, FileSubmenu, Add, &Update UserDetails, GetUserDetails
		Menu, FileSubmenu, Add
		Menu, FileSubmenu, Add, Detect Game - Epic Games, detectGameInstallEpic
		Menu, FileSubmenu, Add, Detect Game - Steam, detectGameInstallSteam
		Menu, FileSubmenu, Add, Detect Game - Standalone, detectGameInstallStandalone
		Menu, FileSubmenu, Add, Detect Game - Console (PS4/Xbox/Switch/iOS), detectGameInstallConsole
		Menu, FileSubmenu, Add
		Menu, FileSubmenu, Add, &Reload IdleCombos, Reload_Clicked
		Menu, FileSubmenu, Add, E&xit IdleCombos, Exit_Clicked
		Menu, IdleMenu, Add, &File, :FileSubmenu

		Menu, ChestsSubmenu, Add, Buy &Silver, Buy_Silver
		Menu, ChestsSubmenu, Add, Buy &Gold, Buy_Gold
		Menu, ChestsSubmenu, Add, Buy &Event, Buy_Event
		Menu, ChestsSubmenu, Add, Open S&ilver, Open_Silver
		Menu, ChestsSubmenu, Add, Open G&old, Open_Gold
		Menu, ChestsSubmenu, Add, Open E&vent, Open_Event
		Menu, ChestsSubmenu, Add, &Pity Timers, ShowPityTimers
		Menu, ToolsSubmenu, Add, &Chests, :ChestsSubmenu

		Menu, BlacksmithSubmenu, Add, Use &Tiny Contracts, Tiny_Blacksmith
		Menu, BlacksmithSubmenu, Add, Use &Small Contracts, Sm_Blacksmith
		Menu, BlacksmithSubmenu, Add, Use &Medium Contracts, Med_Blacksmith
		Menu, BlacksmithSubmenu, Add, Use &Large Contracts, Lg_Blacksmith
		Menu, BlacksmithSubmenu, Add, Use &Huge Contracts, Hg_Blacksmith
		Menu, BlacksmithSubmenu, Add, &Item Level Report, GearReport
		Menu, BlacksmithSubmenu, Add, &Active Patron Feats, PatronFeats
		Menu, ToolsSubmenu, Add, &Blacksmith, :BlacksmithSubmenu

		Menu, BountySubmenu, Add, Use &Tiny Contracts, Tiny_Bounty
		Menu, BountySubmenu, Add, Use &Small Contracts, Sm_Bounty
		Menu, BountySubmenu, Add, Use &Medium Contracts, Med_Bounty
		Menu, BountySubmenu, Add, Use &Large Contracts, Lg_Bounty
		Menu, ToolsSubmenu, Add, B&ounty (Alpha Feature), :BountySubmenu

		Menu, ToolsSubmenu, Add, &Redeem Codes, Open_Codes

		Menu, AdvSubmenu, Add, &Load New Adv, LoadAdventure
		Menu, AdvSubmenu, Add, &End Current Adv, EndAdventure
		;Menu, AdvSubmenu, Add, Load New BG Adv, LoadBGAdventure
		Menu, AdvSubmenu, Add, End Background Adv, EndBGAdventure
		Menu, AdvSubmenu, Add, End Background2 Adv, EndBG2Adventure
		Menu, AdvSubmenu, Add, End Background3 Adv, EndBG3Adventure
		Menu, AdvSubmenu, Add, &Kleho Image, KlehoImage
		Menu, AdvSubmenu, Add, &Incomplete Variants, IncompleteVariants
		Menu, AdvSubmenu, Add, Update Adventure List, AdventureList
		Menu, ToolsSubmenu, Add, &Adventure Manager, :AdvSubmenu

		Menu, ToolsSubmenu, Add, Briv &Stack Calculator, Briv_Calc

		Menu, WebToolsSubmenu, Add, &Data Viewer - Kleho, Open_Web_Data_Viewer
		Menu, WebToolsSubmenu, Add, &Game Viewer - SoulReaver, Open_Web_Game_Viewer
		Menu, WebToolsSubmenu, Add, Utilities - &ByteGlow, Open_Web_Utilities
		Menu, WebToolsSubmenu, Add, Utilities - &Modron Core Calc, Open_Web_Utilities_Modron
		Menu, WebToolsSubmenu, Add, Utilities - &Formation Calc, Open_Web_Utilities_Formation
		Menu, ToolsSubmenu, Add, &Web Tools, :WebToolsSubmenu

		Menu, IdleMenu, Add, &Tools, :ToolsSubmenu

		Menu, HelpSubmenu, Add, &Run Setup, FirstRun
		Menu, HelpSubmenu, Add, Clear &Log, Clear_Log
		Menu, HelpSubmenu, Add, &Update Dictionary, Update_Dictionary
		Menu, HelpSubmenu, Add, Download &Journal, Get_Journal
		Menu, HelpSubmenu, Add
		Menu, HelpSubmenu, Add, List &User Details, List_UserDetails
		Menu, HelpSubmenu, Add, List &Champ IDs, List_ChampIDs
		Menu, HelpSubmenu, Add, List C&hest IDs, List_ChestIDs
		Menu, HelpSubmenu, Add, List Hot&keys, Hotkeys_Clicked
		Menu, HelpSubmenu, Add
		Menu, HelpSubmenu, Add, &About IdleCombos, About_Clicked
		Menu, HelpSubmenu, Add, &Github Project, Github_Clicked
		Menu, HelpSubmenu, Add, &Discord Support Server, Discord_Clicked
		Menu, HelpSubmenu, Add, CNE &Support Ticket, Open_Ticket
		Menu, IdleMenu, Add, &Help, :HelpSubmenu
		Gui, Menu, IdleMenu

		col1_x := 5
		col2_x := 470
		col3_x := 530
		row_y := 5

		Gui, Add, StatusBar, , %OutputStatus%
		SB_SetParts(500, 100)
		SB_SetText("`tAHK v" A_AhkVersion, 2)

		Gui, MyWindow:Add, Button, x%col2_x% y%row_y% w60 gReload_Clicked, Reload
		Gui, MyWindow:Add, Button, x%col3_x% y%row_y% w60 gExit_Clicked, Exit

		Gui, MyWindow:Add, Tab3, vTabs x%col1_x% y%row_y% w450 h250 TabActive, % TabList
		Gui, Tab

		row_y := row_y + 25
		;Gui, MyWindow:Add, Button, x%col3_x% y%row_y% w60 gUpdate_Clicked, Update
		row_y := row_y + 25

		Gui, MyWindow:Add, Text, x460 y53 vCrashProtectStatus, % CrashProtectStatus
		Gui, MyWindow:Add, Button, x%col3_x% y%row_y% w60 gCrash_Toggle, Toggle

		Gui, MyWindow:Add, Text, x460 y100, Data Timestamp:
		Gui, MyWindow:Add, Text, x460 y120 vLastUpdated w220, % LastUpdated
		Gui, MyWindow:Add, Button, x460 y140 w60 gUpdate_Clicked, Update

		Gui, Tab, Summary
		Gui, MyWindow:Add, Text, vAchievementInfo x15 y33 w350, % AchievementInfo
		Gui, MyWindow:Add, Text, vBlessingInfo x200 y33 w350 h210, % BlessingInfo

		Gui, Tab, Adventures
		Gui, MyWindow:Add, Text, x15 y33 w130, Current Adventure:
		Gui, MyWindow:Add, Text, vCurrentAdventure x+2 w50, % CurrentAdventure
		Gui, MyWindow:Add, Text, x15 y+p w130, Current Patron:
		Gui, MyWindow:Add, Text, vCurrentPatron x+2 w50, % CurrentPatron
		Gui, MyWindow:Add, Text, x15 y+p w130, Current Champions:
		Gui, MyWindow:Add, Text, vCurrentChampions x+2 w50, % CurrentChampions
		Gui, MyWindow:Add, Text, x15 y+p w130, Current Area:
		Gui, MyWindow:Add, Text, vCurrentArea x+2 w50, % CurrentArea
		Gui, MyWindow:Add, Text, x15 y88 w130, Background1 Adventure:
		Gui, MyWindow:Add, Text, vBackgroundAdventure x+2 w50, % BackgroundAdventure
		Gui, MyWindow:Add, Text, x15 y+p w130, Background1 Patron:
		Gui, MyWindow:Add, Text, vBackgroundPatron x+2 w50, % BackgroundPatron
		Gui, MyWindow:Add, Text, x15 y+p w130, Background1 Champions:
		Gui, MyWindow:Add, Text, vBackgroundChampions x+2 w50, % BackgroundChampions
		Gui, MyWindow:Add, Text, x15 y+p w130, Background1 Area:
		Gui, MyWindow:Add, Text, vBackgroundArea x+2 w50, % BackgroundArea
		Gui, MyWindow:Add, Text, x15 y143 w130, Background2 Adventure:
		Gui, MyWindow:Add, Text, vBackground2Adventure x+2 w50, % Background2Adventure
		Gui, MyWindow:Add, Text, x15 y+p w130, Background2 Patron:
		Gui, MyWindow:Add, Text, vBackground2Patron x+2 w50, % Background2Patron
		Gui, MyWindow:Add, Text, x15 y+p w130, Background2 Champions:
		Gui, MyWindow:Add, Text, vBackground2Champions x+2 w50, % Background2Champions
		Gui, MyWindow:Add, Text, x15 y+p w130, Background2 Area:
		Gui, MyWindow:Add, Text, vBackground2Area x+2 w50, % Background2Area
		Gui, MyWindow:Add, Text, x15 y198 w130, Background3 Adventure:
		Gui, MyWindow:Add, Text, vBackground3Adventure x+2 w50, % Background3Adventure
		Gui, MyWindow:Add, Text, x15 y+p w130, Background3 Patron:
		Gui, MyWindow:Add, Text, vBackground3Patron x+2 w50, % Background3Patron
		Gui, MyWindow:Add, Text, x15 y+p w130, Background3 Champions:
		Gui, MyWindow:Add, Text, vBackground3Champions x+2 w50, % Background3Champions
		Gui, MyWindow:Add, Text, x15 y+p w130, Background3 Area:
		Gui, MyWindow:Add, Text, vBackground3Area x+2 w50, % Background3Area

		Gui, MyWindow:Add, Text, vFGCore x200 y33 w150, % FGCore
		Gui, MyWindow:Add, Text, vBGCore x200 y88 w150, % BGCore
		Gui, MyWindow:Add, Text, vBG2Core x200 y143 w150, % BG2Core
		Gui, MyWindow:Add, Text, vBG3Core x200 y198 w150, % BG3Core

		Gui, Tab, Inventory
		Gui, MyWindow:Add, Text, x15 y33 w80, Current Gems:
        Gui, MyWindow:Add, Text, vCurrentGems x+2 w80 right, % CurrentGems
        Gui, MyWindow:Add, Text, vAvailableChests x+10 w250, % AvailableChests
        Gui, MyWindow:Add, Text, x15 y+p w80, (Spent Gems):
        Gui, MyWindow:Add, Text, vSpentGems x+2 w80 right, % SpentGems

        Gui, MyWindow:Add, Text, x15 y+5+p w110, Gold Chests:
        Gui, MyWindow:Add, Text, vCurrentGolds x+2 w50 right, % CurrentGolds
        Gui, MyWindow:Add, Text, vGoldPity x+10 w190, % GoldPity
        Gui, MyWindow:Add, Text, x15 y+p w110, Silver Chests:
        Gui, MyWindow:Add, Text, vCurrentSilvers x+2 w50 right, % CurrentSilvers
        Gui, MyWindow:Add, Text, x+145 y+1 w185, Next TGP:
        Gui, MyWindow:Add, Text, x15 y+0 w110, Time Gate Pieces:
        Gui, MyWindow:Add, Text, vCurrentTGPs x+17 w35 right, % CurrentTGPs
        Gui, MyWindow:Add, Text, vAvailableTGs x+10 w85, % AvailableTGs
        Gui, MyWindow:Add, Text, vNextTGPDrop x+40 w220, % NextTGPDrop

        Gui, MyWindow:Add, Text, x15 y+5+p w110, Tiny Bounties:
        Gui, MyWindow:Add, Text, vCurrentTinyBounties x+2 w50 right, % CurrentTinyBounties
        Gui, MyWindow:Add, Text, x15 y+p w110, Small Bounties:
        Gui, MyWindow:Add, Text, vCurrentSmBounties x+2 w50 right, % CurrentSmBounties
        Gui, MyWindow:Add, Text, vAvailableTokens x+10 w220, % AvailableTokens
        Gui, MyWindow:Add, Text, x15 y+p w110, Medium Bounties:
        Gui, MyWindow:Add, Text, vCurrentMdBounties x+2 w50 right, % CurrentMdBounties
        Gui, MyWindow:Add, Text, vCurrentTokens x+10 w200, % CurrentTokens
        Gui, MyWindow:Add, Text, x15 y+p w110, Large Bounties:
        Gui, MyWindow:Add, Text, vCurrentLgBounties x+2 w50 right, % CurrentLgBounties
        Gui, MyWindow:Add, Text, vAvailableFPs x+10 w220, % AvailableFPs

        Gui, MyWindow:Add, Text, x15 y+5+p w110, Tiny Blacksmiths:
        Gui, MyWindow:Add, Text, vCurrentTinyBS x+2 w50 right, % CurrentTinyBS
        Gui, MyWindow:Add, Text, vAvailableBSLvs x+10 w175, % AvailableBSLvs
        Gui, MyWindow:Add, Text, x15 y+p w110, Small Blacksmiths:
        Gui, MyWindow:Add, Text, vCurrentSmBS x+2 w50 right, % CurrentSmBS
        Gui, MyWindow:Add, Text, x15 y+p w110, Medium Blacksmiths:
        Gui, MyWindow:Add, Text, vCurrentMdBS x+2 w50 right, % CurrentMdBS
        Gui, MyWindow:Add, Text, x15 y+p w110, Large Blacksmiths:
        Gui, MyWindow:Add, Text, vCurrentLgBS x+2 w50 right, % CurrentLgBS
        Gui, MyWindow:Add, Text, x15 y+p w110, Huge Blacksmiths:
        Gui, MyWindow:Add, Text, vCurrentHgBS x+2 w50 right, % CurrentHgBS

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
		Gui, MyWindow:Add, Text, vChampDetails x15 y33 w430 h230, % ChampDetails

		Gui, Tab, Event
		Gui, MyWindow:Add, Text, vEventDetails x15 y33 w430 h230, % EventDetails

		Gui, Tab, Settings
		Gui, MyWindow:Add, Text, x15 y+10+p w95, Server Name:
		;Gui, MyWindow:Add, Text, x170 y37 w95, Style:
		Gui, MyWindow:Add, Text, x170 y37 w95, Tab:
		Gui, MyWindow:Add, Edit, vServerName x85 y33 w50
		;Gui, MyWindow:Add, DropDownList, x200 y33 w130 h60 r10 hwndscbx vStyleChoice, % StyleList
		Gui, MyWindow:Add, DropDownList, x200 y33 w130 h60 r10 hwndscbx vTabActive, % TabList
		Gui, MyWindow:Add, Checkbox, vLogEnabled x15 y+5+p, Logging Enabled?
		Gui, MyWindow:Add, CheckBox, vServerDetection, Get Play Server Name automatically?
		Gui, MyWindow:Add, CheckBox, vGetDetailsonStart, Get User Details on start?
		Gui, MyWindow:Add, CheckBox, vLaunchGameonStart, Launch game client on start?
		Gui, MyWindow:Add, CheckBox, vAlwaysSaveChests, Always save Chest Open Results to file?
		Gui, MyWindow:Add, CheckBox, vAlwaysSaveContracts, Always save Blacksmith Results to file?
		Gui, MyWindow:Add, CheckBox, vAlwaysSaveCodes, Always save Code Redeem Results to file?
		Gui, MyWindow:Add, Checkbox, vNoSaveSetting, Never save results to file?
		Gui, MyWindow:Add, Button, gSave_Settings, Save Settings
		Gui, MyWindow:Add, Checkbox, vShowResultsBlacksmithContracts x250 y59, Show Blacksmith Contracts Results?
		Gui, MyWindow:Add, Checkbox, vDisableUserDetailsReload, Disable User Detail Reload? (Risky)
		
		Gui, Tab, Log
		Gui, MyWindow:Add, Edit, r16 vOutputText ReadOnly w425, %OutputText%

		GuiControl, Focus, SysTabControl321

		this.Load()
	}

	Load() {
		
		;First run checks and setup
		if !FileExist(SettingsFile) {
			FileAppend, %NewSettings%, %SettingsFile%
			LogFile("Settings File: '" SettingsFile "' - Created")
			this.Update()
		}
		FileRead, rawsettings, %SettingsFile%
		CurrentSettings := JSON.parse(rawsettings)
		; MsgBox, % rawsettings
		; MsgBox, % CurrentSettings.Count()
		if !(CurrentSettings.Count() == SettingsCheckValue) {
			FileDelete, %SettingsFile%
			FileAppend, %NewSettings%, %SettingsFile%
			LogFile("Settings File: '" SettingsFile "' - Created")
			FileRead, rawsettings, %SettingsFile%
			CurrentSettings := JSON.parse(rawsettings)
			this.Update()
			MsgBox, Your settings file has been deleted due to an update to IdleCombos. Please verify that your settings are set as preferred.
		}

		if !(LoadGameClient == 4) {
			if FileExist(A_ScriptDir "\webRequestLog.txt") {
				MsgBox, 4, , % "WRL File detected. Use file?"
				IfMsgBox, Yes
				{
					WRLFile := A_ScriptDir "\webRequestLog.txt"
					FirstRun()
				}
			}
		}
		if !(CurrentSettings.firstrun) {
			FirstRun()
		}
		if (CurrentSettings.user_id && CurrentSettings.hash) {
			UserID := CurrentSettings.user_id
			UserIDEpic := CurrentSettings.user_id_epic
			UserIDSteam := CurrentSettings.user_id_steam
			UserHash := CurrentSettings.hash
			InstanceID := CurrentSettings.instance_id
			SB_SetText("✅ User ID & Hash Ready")
		} else {
			SB_SetText("❌ User ID & Hash not found!")
		}

		;Load current settings
		ServerName := CurrentSettings.servername
		GetDetailsonStart := CurrentSettings.getdetailsonstart
		ServerDetection := CurrentSettings.serverdetection
		LaunchGameonStart := CurrentSettings.launchgameonstart
		AlwaysSaveChests := CurrentSettings.alwayssavechests
		AlwaysSaveContracts := CurrentSettings.alwayssavecontracts
		AlwaysSaveCodes := CurrentSettings.alwayssavecodes
		NoSaveSetting := CurrentSettings.nosavesetting
		LogEnabled := CurrentSettings.logenabled
		LoadGameClient := CurrentSettings.loadgameclient
		WRLFile := CurrentSettings.wrlpath
		ShowResultsBlacksmithContracts := CurrentSettings.blacksmithcontractresults
		DisableUserDetailsReload := CurrentSettings.disableuserdetailsreload
		;StyleSelection := CurrentSettings.style
		;SetStyle(StyleSelection)
		TabActive := CurrentSettings.tabactive

		if (TabActive) {
			GuiControl, Choose, Tabs, % TabActive
		}
		
		this.Update()
		this.Show()


		;detect and set game installation paths
		switch (LoadGameClient) {
			case 1: ;epic
				setGameInstallEpic()
			case 2: ;steam
				setGameInstallSteam()
			case 3: ;standalone
				setGameInstallStandalone()
		}

		LogFile("IdleCombos v" VersionNumber " started.")
		LogFile("Settings File: '" SettingsFile "' - Loaded")

		if !(LoadGameClient == 4) {
			GetPlayServerFromWRL()
		}
		if (GetDetailsonStart == "1") {
			GetUserDetails()
		}
		if (LaunchGameonStart == "1") {
			LaunchGame()
		}

		this.Update()

		SendMessage, 0x115, 7, 0, Edit2, A ; Scroll to the bottom of the log
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
		SendMessage, 0x115, 7, 0, Edit2 ; Scroll to the bottom of the log
		GuiControl, MyWindow:, CrashProtectStatus, % CrashProtectStatus, w250 h210
		GuiControl, MyWindow:, AchievementInfo, % AchievementInfo, w250 h210
		GuiControl, MyWindow:, BlessingInfo, % BlessingInfo, w250 h210
		GuiControl, MyWindow:, LastUpdated, % LastUpdated, w250 h210

		;Adventures
		GuiControl, MyWindow:, CurrentAdventure, % CurrentAdventure, w250 h210
		GuiControl, MyWindow:, CurrentArea, % CurrentArea, w250 h210
		GuiControl, MyWindow:, CurrentPatron, % CurrentPatron, w250 h210
		GuiControl, MyWindow:, CurrentChampions, % CurrentChampions, w250 h210
		GuiControl, MyWindow:, BackgroundAdventure, % BackgroundAdventure, w250 h210
		GuiControl, MyWindow:, BackgroundArea, % BackgroundArea, w250 h210
		GuiControl, MyWindow:, BackgroundPatron, % BackgroundPatron, w250 h210
		GuiControl, MyWindow:, BackgroundChampions, % BackgroundChampions, w250 h210
		GuiControl, MyWindow:, Background2Adventure, % Background2Adventure, w250 h210
		GuiControl, MyWindow:, Background2Area, % Background2Area, w250 h210
		GuiControl, MyWindow:, Background2Patron, % Background2Patron, w250 h210
		GuiControl, MyWindow:, Background2Champions, % Background2Champions, w250 h210
		GuiControl, MyWindow:, Background3Adventure, % Background3Adventure, w250 h210
		GuiControl, MyWindow:, Background3Area, % Background3Area, w250 h210
		GuiControl, MyWindow:, Background3Patron, % Background3Patron, w250 h210
		GuiControl, MyWindow:, Background3Champions, % Background3Champions, w250 h210
		GuiControl, MyWindow:, FGCore, % FGCore, w250 h210
		GuiControl, MyWindow:, BGCore, % BGCore, w250 h210
		GuiControl, MyWindow:, BG2Core, % BG2Core, w250 h210
		GuiControl, MyWindow:, BG3Core, % BG3Core, w250 h210

		;Inventory
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

		;Patrons
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

		;Champions
		GuiControl, MyWindow:, ChampDetails, % ChampDetails, w430 h230

		;Event
		GuiControl, MyWindow:, EventDetails, % EventDetails, w430 h230

		;Settings
		GuiControl, MyWindow:, ServerName, % ServerName, w50 h210
		if (LoadGameClient == 4) {
			ServerDetection := 0
			GuiControl, Disable, ServerDetection
		} else {
			GuiControl, Enable, ServerDetection
		}
		GuiControl, MyWindow:, ServerDetection, % ServerDetection, w250 h210
		GuiControl, MyWindow:, GetDetailsonStart, % GetDetailsonStart, w250 h210
		if (LoadGameClient == 4) {
			LaunchGameonStart := 0
			GuiControl, Disable, LaunchGameonStart
		} else {
			GuiControl, Enable, LaunchGameonStart
		}
		GuiControl, MyWindow:, LaunchGameonStart, % LaunchGameonStart, w250 h210
		GuiControl, MyWindow:, AlwaysSaveChests, % AlwaysSaveChests, w250 h210
		GuiControl, MyWindow:, AlwaysSaveContracts, % AlwaysSaveContracts, w250 h210
		GuiControl, MyWindow:, AlwaysSaveCodes, % AlwaysSaveCodes, w250 h210
		GuiControl, MyWindow:, NoSaveSetting, % NoSaveSetting, w250 h210
		GuiControl, MyWindow:, LogEnabled, % LogEnabled, w250 h210
		GuiControl, MyWindow:, ShowResultsBlacksmithContracts, % ShowResultsBlacksmithContracts, w250 h210
		GuiControl, MyWindow:, DisableUserDetailsReload, % DisableUserDetailsReload, w250 h210
		;if (StyleSelection) {
		;	GuiControl, Choose, StyleChoice, %StyleSelection%
		;}

		if (TabActive) {
			GuiControl, Choose, TabActive, % TabActive
		}

		;this.Show() - removed
	}
}

;Hotkeys
;$F9::Reload
;$F10::ExitApp
;Hotkeys - Blacksmith Contracts
Control & Numpad1::UseBlacksmith(31) ;Tiny BS
Control & Numpad2::UseBlacksmith(32) ;Small BS
Control & Numpad3::UseBlacksmith(33) ;Medium BS
Control & Numpad4::UseBlacksmith(34) ;Large BS
Control & Numpad5::UseBlacksmith(1797) ;Huge BS
;Hotkeys - Chests
Control & NumpadDiv::BuySilver() ;Buy Chest - Silver
Control & NumpadMult::BuyGold() ;Buy Chest - Gold
Control & NumpadSub::BuyEvent() ;Buy Chest - Event
Control & Numpad7::OpenSilver() ;Open Chest - Silver
Control & Numpad8::OpenGold() ;Open Chest - Gold
Control & Numpad9::OpenEvent() ;Open Chest - Event
;Hotkeys - Bounty Contracts
Control & 7::UseBounty(17) ;Tiny Bounty
Control & 8::UseBounty(18) ;Small Bounty
Control & 9::UseBounty(19) ;Medium Bounty
Control & 0::UseBounty(20) ;Large Bounty

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
		;msgbox, % CrashProtectStatus
		switch CrashProtectStatus {
			case "Crash Protect`nDisabled": {
				CrashProtectStatus := "Crash Protect`nEnabled"
				oMyGUI.Update()
				SB_SetText("✅ Crash Protect has been enabled!")
				CrashProtect()
			}
			case "Crash Protect`nEnabled": {
				CrashProtectStatus := "Crash Protect`nDisabled"
				CrashCount := 0
				oMyGUI.Update()
				SB_SetText("✅ Crash Protect has been disabled")
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
			SB_SetText("✅ Crash Protect has restarted your client")
			oMyGUI.Update()
			LogFile("Restarts since enabling Crash Protect: " CrashCount)
			Sleep 10000
		}
	}
	return
}

;ExitFunc() {
;	SkinForm(0)
;	return
;}

;runWith(version){	
;	if (A_PtrSize=(version=32?4:8)) ;For 32 set to 4 otherwise 8 for 64 bit
;		Return
;	SplitPath, A_AhkPath, , ahkDir ;Get directory of AutoHotkey executable
;	if (!FileExist(correct := ahkDir "\AutoHotkeyU" version ".exe")) {
;		MsgBox, 0x10, "Error", % "Couldn't find the " version " bit Unicode version of Autohotkey in:`n" correct
;		ExitApp
;	}
;	Run,"%correct%" "%A_ScriptName%", %A_ScriptDir%
;	ExitApp
;}

;SkinForm(DLLPath, Param1 = "Apply", SkinName = ""){
;	if(Param1 = Apply) {
;		DllCall("LoadLibrary", str, DLLPath)
;		DllCall(DLLPath . "\USkinInit", Int, 0, Int, 0, AStr, SkinName)
;	} else if(Param1 = Remove) {
;		DllCall(DLLPath . "\USkinRemoveSkin")
;	} else if(Param1 = Restore) {
;		DllCall(DLLPath . "\USkinRestoreSkin")
;	} else if(Param1 = 0) {
;		DllCall(DLLPath . "\USkinExit")
;	}
;}

;SetStyle(SelectedStyle) {
;	if (SelectedStyle) {
;		SkinForm(StyleDLLPath, 0)
;		if (SelectedStyle == "Default") {
;			SkinForm(StyleDLLPath, Apply, StylePath . "Concave.msstyles")
;		} else {
;			SkinForm(StyleDLLPath, Apply, StylePath . SelectedStyle . ".msstyles")
;		}
;		switch (SelectedStyle) {
;			case "Lakrits": BgColour := "222222"
;			case "Luminous": BgColour := "F4F4F3"
;			case "Mac": BgColour := "E3E3E3"
;			case "Paper": BgColour := "F6F7F9"
;			default: BgColour := "FFFFFF"
;		}
;	}
;	return
;}

SaveSettings()
{
	oMyGUI.Submit()
	CurrentSettings.alwayssavechests := AlwaysSaveChests
	CurrentSettings.alwayssavecontracts := AlwaysSaveContracts
	CurrentSettings.alwayssavecodes := AlwaysSaveCodes
	CurrentSettings.getdetailsonstart := GetDetailsonStart
	CurrentSettings.instance_id := InstanceID
	CurrentSettings.launchgameonstart := LaunchGameonStart
	CurrentSettings.serverdetection := ServerDetection
	CurrentSettings.loadgameclient := LoadGameClient
	CurrentSettings.logenabled := LogEnabled
	CurrentSettings.nosavesetting := NoSaveSetting
	CurrentSettings.servername := ServerName
	CurrentSettings.tabactive := TabActive
	CurrentSettings.wrlpath := WRLFile
	CurrentSettings.blacksmithcontractresults := ShowResultsBlacksmithContracts
	CurrentSettings.disableuserdetailsreload := DisableUserDetailsReload
	;CurrentSettings.style := StyleChoice
	;StyleSelection = StyleChoice
	newsettings := JSON.stringify(CurrentSettings)
	FileDelete, %SettingsFile%
	FileAppend, %newsettings%, %SettingsFile%
	LogFile("Settings have been saved")
	SB_SetText("✅ Settings have been saved")
	;if (StyleSelection != StyleChoice) {
	;	StyleSelection = StyleChoice
	;	SetStyle(%StyleSelection%)
	;}
	return
}

Save_Settings:
	{
		SaveSettings()
		return
	}

About_Clicked:
	{
		;MsgBox, , User Details, % About
		;CustomMsgBox("About", About, "Consolas", "s10", %BgColour%)
		ScrollBox(About, "p b1 h100 w510 f{s10, Consolas}", "About")
		return
	}

Hotkeys_Clicked:
	{
		;MsgBox, , Hotkey Details, % HotkeyInfo
		;CustomMsgBox("Hotkey Details", HotkeyInfo, "Consolas", "s10", %BgColour%)
		ScrollBox(HotkeyInfo, "p b1 h250 w400 f{s10, Consolas}", "Hotkey Details")
		return
	}

BuySilver()
	{
		Buy_Chests(1)
		return
	}

Buy_Silver:
	{
		BuySilver()
		return
	}

BuyGold()
	{
		Buy_Chests(2)
		return
	}

Buy_Gold:
	{
		BuyGold()
		return
	}

BuyEvent()
	{
		InputBox, chestid, Opening Chests, % "Enter Chest ID?`n", , 200, 150
		if ErrorLevel
			return
		if (chestid) {
			Buy_Chests(chestid)
		}
		return
	}

Buy_Event:
	{
		BuyEvent()
		return
	}

OpenSilver()
	{
		if (Not WinExist("ahk_exe IdleDragons.exe")) {
			Open_Chests(1)
			return
		} else {
			MsgBox, 0, , % "NOTE: It's recommended to close the game client before opening chests"
			return 
			;MsgBox, 4, , % "NOTE: It's recommended to close the game client before opening chests.`nWould you like to continue anyway?"
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

Open_Silver:
	{
		OpenSilver()
		return
	}

OpenGold()
	{
		if (Not WinExist("ahk_exe IdleDragons.exe")) {
			Open_Chests(2)
			return
		} else {
			MsgBox, 0, , % "NOTE: It's recommended to close the game client before opening chests"
			return
			;MsgBox, 4, , % "NOTE: It's recommended to close the game client before opening chests.`nWould you like to continue anyway?`n`n(Feats earned using this app do not count towards the related achievement.)"
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

Open_Gold:
	{
		OpenGold()
		return
	}

OpenEvent()
	{
		if (Not WinExist("ahk_exe IdleDragons.exe")) {
			InputBox, chestid, Opening Chests, % "Enter Chest ID?`n", , 200, 150
			if ErrorLevel
				return
			if (chestid) {
				Open_Chests(chestid)
			}
			return
		} else {
			MsgBox, 0, , % "NOTE: It's recommended to close the game client before opening chests"
			return
			;MsgBox, 4, , % "NOTE: It's recommended to close the game client before opening chests.`nWould you like to continue anyway?`n`n(Feats earned using this app do not count towards the related achievement.)"
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

Open_Event:
	{
		OpenEvent()
		return
	}

Open_Codes:
	{
		; GUI MENU
		Menu, FileMenu, Add, Auto Load Recent (Web)`tCtrl+L, Get_Codes_Autoload_Recent
		Menu, FileMenu, Add, Auto Load Special (Web)`tCtrl+M, Get_Codes_Autoload_Special
		Menu, FileMenu, Add, Auto Load Permanent (Web)`tCtrl+N, Get_Codes_Autoload_Permanent
		Menu, FileMenu, Add, Auto Load &Recent && Run (Web)`tCtrl+R, Get_Codes_Autoload_Run_Recent
		Menu, FileMenu, Add, Auto Load &Special && Run (Web)`tCtrl+E, Get_Codes_Autoload_Run_Special
		Menu, FileMenu, Add, Auto Load &Permanent && Run (Web)`tCtrl+P, Get_Codes_Autoload_Run_Permanent
		Menu, FileMenu, Add, &Submit`tCtrl+S, Redeem_Codes
		Menu, EditMenu, Add, Paste`tCtrl+V, Paste
		Menu, EditMenu, Add, Clear`tDel, Delete
		Menu, HelpMenu, Add, Open &Codes (Web)`tCtrl+O, Open_Web_Codes_Page
		Menu, MyMenuBar, Add, &File, :FileMenu
		Menu, MyMenuBar, Add, &Edit, :EditMenu
		Menu, MyMenuBar, Add, &Help, :HelpMenu

		; GUI
		Gui, CodeWindow:New
		Gui, Menu, MyMenuBar
		Gui, CodeWindow: -Resize -MaximizeBox +MinSize
		Gui, CodeWindow:Show, w230 h270, 📜 Codes
		Gui, CodeWindow:Add, Edit, r12 vCodestoEnter w190 x20 y20, IDLE-CHAM-PION-SNOW
		Gui, CodeWindow:Add, Button, vButton_Recent gGet_Codes_Autoload_Run_Recent, Recent
		Gui, CodeWindow:Add, Button, x+15 vButton_Special gGet_Codes_Autoload_Run_Special, Special
		Gui, CodeWindow:Add, Button, x+15 vButton_Permanent gGet_Codes_Autoload_Run_Permanent, Permanent
		Gui, CodeWindow:Add, Button, x20 vButton_Submit gRedeem_Codes, Submit
		Gui, CodeWindow:Add, Button, x+10 vButton_Paste gPaste, Paste
		Gui, CodeWindow:Add, Button, x+10 vButton_Delete gDelete, Clear
		Gui, CodeWindow:Add, Button, x+10 gClose_Codes, Close

		; STATUS BAR
		Gui, Add, StatusBar, vCodesOutputStatus, ❗ Codes: 0/1 - Waiting... (1 code per line)
		return
	}

	Paste() {
		getChestCodes()
		loop, parse, foundCodeString, `n, `r
			CodeTotal := a_index
		GuiControl, , CodestoEnter, %foundCodeString%
		if ( CodeTotal == "") {
			CodeTotal := "0"
		}
		GuiControl, , CodesOutputStatus, ❗ Codes: 0/%CodeTotal% - Waiting... (1 code per line)
		return
	}

	Delete() {
		GuiControl, , CodestoEnter,
		GuiControl, , CodesOutputStatus, ❗ Codes: 0/0 - Waiting... (1 code per line)
		return
	}

	Open_Web_Codes_Page() {
		Run, WebToolCodes
		return
	}

	Open_Web_Codes_Page_Element(TextboxID) {
		Run, %WebToolCodes%%TextboxID%
		return
	}

	Wait_For_Load(wb)
	{
		while wb.busy or wb.ReadyState != 4
			Sleep, 1
	}

	Get_Codes_Autoload_Recent() {
		Get_Codes_Autoload(WebToolCodesRecent)
		return
	}

	Get_Codes_Autoload_Special() {
		Get_Codes_Autoload(WebToolCodesSpecial)
		return
	}

	Get_Codes_Autoload_Permanent() {
		Get_Codes_Autoload(WebToolCodesPermanent)
		return
	}

	Get_Codes_Autoload(TextboxID) {
		; MsgBox, % TextboxID

		;Old method
		; Open_Web_Codes_Page_Element(TextboxID)
		; winwait, ALL active Idle Champions of the Forgotten Realms chest combination🔒 codes
		; sleep, 1500
		; send, ^a
		; clipboard := ""
		; send, ^c
		; ClipWait, 1

		;Use new COM Object to hide browser
		try {
			wb := ComObjCreate("InternetExplorer.Application")
			wb.Visible := False
			wb.Navigate(WebToolCodes)
			Wait_For_Load(wb)
			if(SubStr(TextboxID, 1, 1) == "#") {
				TextboxIDTrim := SubStr(TextboxID, 2, 10)
			} else {
				TextboxIDTrim := TextboxID
			}
			; MsgBox, % TextboxIDTrim
			Codes := wb.document.getElementByID(TextboxIDTrim).innerText
			clipboard := Codes
			wb.quit()
		} catch e {
			MsgBox, An exception was thrown!`n%e%
			return
		}

		if WinExist("📜 Codes") {
			WinActivate
			Delete()
			Paste()
		}
		return
	}

	Get_Codes_Autoload_Run_Recent() {
		Get_Codes_Autoload_Run(WebToolCodesRecent)
		return
	}

	Get_Codes_Autoload_Run_Special() {
		Get_Codes_Autoload_Run(WebToolCodesSpecial)
		return
	}

	Get_Codes_Autoload_Run_Permanent() {
		Get_Codes_Autoload_Run(WebToolCodesPermanent)
		return
	}

	Get_Codes_Autoload_Run(TextboxID) {
		Get_Codes_Autoload(TextboxID)
		Redeem_Codes()
		return
	}

	Redeem_Codes() {
		LogFile("Redeem Code Started")
		Gui, CodeWindow:Submit, NoHide
		Gui, CodeWindow:Add, Text, x+45, Codes Remaining:
		CodeList := StrSplit(CodestoEnter, "`n")
		CodeCount := CodeList.Length()
		if (CodeCount == 0) {
			CodesPending := "🚫 Codes: 0/0 - No Codes Found..."
			GuiControl, , CodesOutputStatus, % CodesPending
		} else {
			; Disable Buttons
			GuiControl, Disable, Button_Recent
			GuiControl, Disable, Button_Special
			GuiControl, Disable, Button_Permanent
			GuiControl, Disable, Button_Submit
			GuiControl, Disable, Button_Paste
			GuiControl, Disable, Button_Delete
			CodeNum := 1
			CodeTotal := CodeCount
			usedcodescount := 0
			usedcodes := ""
			someonescodescount := 0
			someonescodes := ""
			expiredcodescount := 0
			expiredcodes := ""
			earlycodescount := 0
			earlycodes := ""
			invalidcodescount := 0
			invalidcodes := ""
			codegolds := 0
			codesilvers := 0
			codesupplys := 0
			otherchestscount := 0
			otherchestsarray := []
			;otherchests := ""
			codeepicscount := 0
			codeepics := ""
			codetgps := 0
			codepolish := 0
			tempsavesetting := 0
			if (ServerDetection == 1) {
				CodesPending := "⌛ Codes: " CodeNum "/" CodeTotal " - Getting User Details..."
				GuiControl, , CodesOutputStatus, % CodesPending
				GetUserDetails()
				sleep, 2000
			}
			Gui, CodeWindow: Default
			CodesPending := "⌛ Codes: " CodeNum "/" CodeTotal " - Starting..."
			GuiControl, , CodesOutputStatus, % CodesPending
			for k, v in CodeList {
				v := StrReplace(v, "`r")
				v := StrReplace(v, "`n")
				v := Trim(v)
				CurrentCode := v
				sCode := RegExReplace(CurrentCode, "&", Replacement := "%26")
				sCode := RegExReplace(sCode, "#", Replacement := "%23")
				if !UserID {
					MsgBox % "Need User ID & Hash"
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
					} else {
						return
					}
				}
				if (coderesults.failure_reason == "You have already redeemed this combination.") {
					usedcodescount += 1
					usedcodes := usedcodes sCode "`n"
				} else if (coderesults.failure_reason == "Someone has already redeemed this combination.") {
					someonescodescount += 1
					someonescodes := someonescodes sCode "`n"
				} else if (coderesults.failure_reason == "This offer has expired") {
					expiredcodescount += 1
					expiredcodes := expiredcodes sCode "`n"
				} else if (coderesults.failure_reason == "You can not yet redeem this combination.") {
					earlycodescount += 1
					earlycodes := earlycodes sCode "`n"
				} else if (coderesults.failure_reason == "This is not a valid combination.") {
					invalidcodescount += 1
					invalidcodes := invalidcodes sCode "`n"
				} else {
					for kk, vv in codeloot {
						if (vv.chest_type_id == "2") {
							codegolds += vv.count
						} else if (vv.chest_type_id == "37") {
							codesupplys += vv.count
						} else if (vv.chest_type_id == "1") {
							codesilvers += vv.count
						} else if (vv.chest_type_id) {
							;otherchests := otherchests ChestFromID(vv.chest_type_id) "`n"
							otherchestscount += vv.count
							othercheststype:= ChestFromID(vv.chest_type_id)
							if ( otherchestsarray.HasKey(othercheststype) ) {
								otherchestsarray[othercheststype] += vv.count
							} else {
								otherchestsarray[othercheststype] := 1
							}
						} else if (vv.add_time_gate_key_piece) {
							codetgps += vv.count
						} else if (vv.add_inventory_buff_id) {
							codeepicscount += vv.count
							switch vv.add_inventory_buff_id {
								case 4: codeepics := codeepics "STR (" vv.count "), "
								case 8: codeepics := codeepics "GF (" vv.count "), "
								case 16: codeepics := codeepics "HP (" vv.count "), "
								case 20: codeepics := codeepics "Bounty (" vv.count "), "
								case 34: codeepics := codeepics "BS (" vv.count "), "
								case 35: codeepics := codeepics "Spec (" vv.count "), "
								case 40: codeepics := codeepics "FB (" vv.count "), "
								case 77: codeepics := codeepics "Spd (" vv.count "), "
								case 36: codepolish += vv.count
										 codeepicscount -= vv.count
								default: codeepics := codeepics vv.add_inventory_buff_id " (" vv.count "), "
							}
						}
					}
				} 
				CodeCount := % (CodeCount-1)
				CodeNum := % (CodeTotal-CodeCount)
				if (CurrentSettings.alwayssavecodes || tempsavesetting) {
					FileAppend, "{""submit_code"":""" %sCode% """}"`n, %RedeemCodeLogFile%
					FileAppend, %rawresults%`n, %RedeemCodeLogFile%
				} else if !(CurrentSettings.nosavesetting) {
					MsgBox, 4, , "Save to File?"
					IfMsgBox, Yes
					{
						tempsavesetting := 1
						FileAppend, %sCode%`n, %RedeemCodeLogFile%
						FileAppend, %rawresults%`n, %RedeemCodeLogFile%
					}
				}
				sleep, 500
				Gui, CodeWindow: Default
				CodesPending := "⌛ Codes: " CodeNum "/" CodeTotal " - Submitting..."
				GuiControl, , CodesOutputStatus, % CodesPending
			}
			CodesPending := "⌛ Codes: " CodeNum "/" CodeTotal " - Loading Results..."
			codemessage := ""
			if (codegolds > 0) {
				codemessage := codemessage "Gold Chests:`n" codegolds "`n"
			}
			if (codesilvers > 0) {
				codemessage := codemessage "Silver Chests:`n" codesilvers "`n"
			}
			if (codesupplys > 0) {
				codemessage := codemessage "Supply Chests:`n" codesupplys "`n"
			}
			; if !(otherchests == "") {
			; 	;StringTrimRight, otherchests, otherchests, 2
			; 	codemessage := codemessage "Other Chests (" otherchestscount "):`n" otherchests "`n"
			; }
			if (otherchestscount > 0) {
				codemessage := codemessage "Other Chests (" otherchestscount "):`n"
				for otherchestsindex, otherchestselement in otherchestsarray {
					codemessage := codemessage otherchestsindex " (" otherchestselement ")`n"
				}
				codemessage := codemessage "`n"
			}
			if (codepolish > 0) {
				codemessage := codemessage "Potions of Polish:`n" codepolish "`n"
			}
			if (codetgps > 0) {
				codemessage := codemessage "Time Gate Pieces:`n" codetgps "`n"
			}
			if !(codeepics == "") {
				StringTrimRight, codeepics, codeepics, 2
				codemessage := codemessage "Epic Consumables (" codeepicscount "):`n" codeepics "`n`n"
			}
			if !(earlycodes == "") {
				codemessage := codemessage "Cannot Redeem Yet (" earlycodescount "):`n" earlycodes "`n"
			}
			if !(someonescodes == "") {
				codemessage := codemessage "Someone Else Has Used (" someonescodescount "):`n" someonescodes "`n"
			}
			if !(expiredcodes == "") {
				codemessage := codemessage "Expired (" expiredcodescount "):`n" expiredcodes "`n"
			}
			if !(invalidcodes == "") {
				codemessage := codemessage "Invalid (" invalidcodescount "):`n" invalidcodes "`n"
			}
			if !(usedcodes == "") {
				codemessage := codemessage "You Already Used (" usedcodescount "):`n" usedcodes "`n"
			}
			if (codemessage == "") {
				codemessage := "Unknown or No Results"
			}
			GuiControl, , CodesOutputStatus, % CodesPending, w350 h210
			if( DisableUserDetailsReload == 0) {
				GetUserDetails()
			}
			oMyGUI.Update()
			Gui, CodeWindow: Default
			CodesPending := "✅ Codes: " CodeTotal "/" CodeTotal " - Completed! 😎"
			GuiControl, , CodesOutputStatus, % CodesPending
			; Enable Buttons
			GuiControl, Enable, Button_Recent
			GuiControl, Enable, Button_Special
			GuiControl, Enable, Button_Permanent
			GuiControl, Enable, Button_Submit
			GuiControl, Enable, Button_Paste
			GuiControl, Enable, Button_Delete
			;MsgBox, , Results, % codemessage
			ScrollBox(codemessage, "p b1 h200 w250", "Redeem Codes Results")
			;ScrollBox(codemessage, "p b1 h200 w250 f{s10, Consolas}", "Redeem Codes Results")
			;CustomMsgBox("Redeem Codes Results", codemessage, "Consolas", "s14", %BgColour%)
			LogFile("Redeem Code Finished")
		}
		return
	}

Close_Codes:
	{
		Gui, CodeWindow:Destroy
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

Open_Web_Game_Viewer() {
		Run, %WebToolGameViewer%
		return
	}

Open_Web_Data_Viewer() {
		Run, %WebToolDataViewer%
		return
	}

Open_Web_Utilities() {
		Run, %WebToolUtilities%
		return
	}

Open_Web_Utilities_Formation() {
		Run, %WebToolUtilitiesFormation%
		return
	}

Open_Web_Utilities_Modron() {
		Run, %WebToolUtilitiesModron%
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
		}
		return
	}

Buy_Extra_Chests(chestid,extracount) {
	chestparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&chest_type_id=" chestid "&count="
	gemsspent := 0
	while (extracount > 0) {
		SB_SetText("⌛ " ChestFromID(chestid) " remaining to purchase: " extracount)
		if (extracount < 101) {
			rawresults := ServerCall("buysoftcurrencychest", chestparams extracount)
			extracount -= extracount
		} else {
			rawresults := ServerCall("buysoftcurrencychest", chestparams "100")
			extracount -= 100
		}
		chestresults := JSON.parse(rawresults)
		if (chestresults.success == "0") {
			MsgBox % "Error: " rawresults
			LogFile("Gems Spent: " gemsspent)
			GetUserDetails()
			SB_SetText("⌛ " ChestFromID(chestid) " remaining: " count " (Error: " chestresults.failure_reason ")")
			return
		}
		gemsspent += chestresults.currency_spent
		Sleep 1000
	}
	LogFile("Gems Spent: " gemsspent)
	SB_SetText("✅ " ChestFromID(chestid) " purchase completed")
	return gemsspent
}

Buy_Chests(chestid) {
	if !UserID {
		MsgBox % "Need User ID & Hash"
		FirstRun()
	}
	if !CurrentGems && (chestid = 1 OR chestid = 2) {
		MsgBox, 4, , No gems detected. Check server for user details?
		IfMsgBox, Yes
		{
			GetUserDetails()
		}
	}
	switch true {
		case (chestid = 1): {
			maxbuy := Floor(CurrentGems/50)
			InputBox, count, Buying Chests, % "How many Silver Chests?`n(Max: " maxbuy ")", , 250, 180, , , , , %maxbuy%
			if ErrorLevel
				return
			if (count > maxbuy) {
				MsgBox, 4, , Insufficient gems detected for purchase.`nContinue anyway?
				IfMsgBox, No
				{
					return
				}
			}
		}
		case (chestid = 2): {
			maxbuy := Floor(CurrentGems/500)
			InputBox, count, Buying Chests, % "How many Gold Chests?`n(Max: " maxbuy ")", , 250, 180, , , , , %maxbuy%
			if ErrorLevel
				return
			if (count = "alpha5") {
				chestparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID
				rawresults := ServerCall("alphachests", chestparams)
				MsgBox % rawresults
				GetUserDetails()
				SB_SetText("✨ Ai yi yi, Zordon!")
				return
			}
			if (count > maxbuy) {
				MsgBox, 4, , Insufficient gems detected for purchase.`nContinue anyway?
				IfMsgBox, No
				{
					return
				}
			}
		}
		case (chestid > 3 and chestid < 510): {
			maxbuy := Floor(EventTokens/10000)
			InputBox, count, Buying Chests, % "How many " ChestFromID(chestid) "?`n(" EventTokenName ": " EventTokens ")`n(Max: " maxbuy ")", , 250, 180, , , , , %maxbuy%
			if ErrorLevel
				return
			if (count = "alpha5") {
				chestparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID
				rawresults := ServerCall("alphachests", chestparams)
				MsgBox % rawresults
				GetUserDetails()
				SB_SetText("✨ Ai yi yi, Zordon!")
				return
			}
			if (count > maxbuy) {
				MsgBox, 4, , Insufficient %EventTokenName% detected for purchase.`nContinue anyway?
				IfMsgBox, No
				{
					return
				}
			}
		}
		default: {
			MsgBox, Invalid chest_id value.
			return
		}
	}
	if (ServerDetection == 1) {
		GetUserDetails()
		sleep, 2000
	}
	chestparams := DummyData "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&chest_type_id=" chestid "&count="
	gemsspent := 0
	tokenspent := 0
	chestsbought := 0
	while (count > 0) {
		SB_SetText("⌛ " ChestFromID(chestid) " remaining to purchase: " count)
		if (count < 101) {
			rawresults := ServerCall("buysoftcurrencychest", chestparams count)
			chestsbought += count
			count -= count
		} else {
			rawresults := ServerCall("buysoftcurrencychest", chestparams "100")
			chestsbought += 100
			count -= 100
		}
		chestresults := JSON.parse(rawresults)
		if (chestresults.success == "0") {
			MsgBox % "Error: " rawresults
			if(gemsspent > 0){
				LogFile("Gems spent: " gemsspent)
			}
			if(tokenspent > 0){
				LogFile(EventTokenName " spent: " tokenspent)
			}
			GetUserDetails()
			SB_SetText("⌛ " ChestFromID(chestid) " remaining: " count " (Error: " chestresults.failure_reason ")")
			return
		}
		if(chestid = 1 OR chestid = 2) {
			gemsspent += chestresults.currency_spent
		} else {
			tokenspent += chestresults.currency_spent
		}
		Sleep 500
	}
	if(gemsspent > 0){
		LogFile("Gems spent: " gemsspent)
	}
	if(tokenspent > 0){
		LogFile(EventTokenName " spent: " tokenspent)
	}
	if( DisableUserDetailsReload == 0) {
		GetUserDetails()
	}
	SB_SetText("✅ " chestsbought " " ChestFromID(chestid) " purchase completed.")
	return
}

Open_Chests(chestid) {
	if !UserID {
		MsgBox % "Need User ID & Hash"
		FirstRun()
	}
	if (!CurrentGolds && !CurrentSilvers && !CurrentGems && (chestid = 1 OR chestid = 2) ) {
		MsgBox, 4, , No chests or gems detected. Check server for user details?
		IfMsgBox, Yes
		{
			GetUserDetails()
		}
	}
	switch true {
		case (chestid = 1): {
			InputBox, count, Opening Chests, % "How many Silver Chests?`n(Owned: " CurrentSilvers ")`n(Max: " (CurrentSilvers + Floor(CurrentGems/50)) ")", , 200, 180, , , , , %CurrentSilvers%
			if ErrorLevel
				return
			if (count > CurrentSilvers) {
				MsgBox, 4, , % "Spend " ((count - CurrentSilvers)*50) " gems to purchase " (count - CurrentSilvers) " chests before opening?"
				extracount := (count - CurrentSilvers)
				IfMsgBox, Yes
				{
					extraspent := Buy_Extra_Chests(1,extracount)
				} else {
					return
				}
			}
		}
		case (chestid = 2): {
			InputBox, count, Opening Chests, % "How many Gold Chests?`n(Owned: " CurrentGolds ")`n(Max: " (CurrentGolds + Floor(CurrentGems/500)) ")`n`n(Feats earned using this app do not`ncount towards the related achievement.)", , 360, 240, , , , , %CurrentGolds%
			if ErrorLevel
				return
			if (count > CurrentGolds) {
				MsgBox, 4, , % "Spend " ((count - CurrentGolds)*500) " gems to purchase " (count - CurrentGolds) " chests before opening?"
				extracount := (count - CurrentGolds)
				IfMsgBox, Yes
				{
					extraspent := Buy_Extra_Chests(2,extracount)
				} else {
					return
				}
			}
		}
		case (chestid > 3 and chestid < 510): {
			CurrentChests := 0
			CurrentChestsLookup := ""
			for k, v in UserDetails.details.chests {
				if (k == chestid) {
					CurrentChestsLookup := v
				}
			}
			if(CurrentChestsLookup) {
				CurrentChests := CurrentChestsLookup
			}
			InputBox, count, Opening Chests, % "How many '" ChestFromID(chestid) "' Chests?`n(" EventTokenName ": " EventTokens ")`n(Owned: " CurrentChests ")`n(Max: " (CurrentChests + Floor(EventTokens/10000)) ")`n`n(Feats earned using this app do not`ncount towards the related achievement.)", , 360, 240, , , , , %CurrentChests%
			if ErrorLevel
				return
			if (count > CurrentChests) {
				MsgBox, 4, , % "Spend " ((count - CurrentChests)*10000) " " EventTokenName " to purchase " (count - CurrentChests) " chests before opening?"
				extracount := (count - CurrentChests)
				IfMsgBox, Yes
				{
					extraspent := Buy_Extra_Chests(chestid,extracount)
				} else {
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
		SB_SetText("⌛ Chests remaining to open: " count)
		if (count < 1000) {
			rawresults := ServerCall("opengenericchest", chestparams count)
			Sleep, 500
			count -= count
		} else {
			rawresults := ServerCall("opengenericchest", chestparams 1000)
			Sleep, 500
			count -= 1000
		}
		if (CurrentSettings.alwayssavechests || tempsavesetting) {
			FileAppend, %rawresults%`n, %ChestOpenLogFile%
		} else {
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
			switch chestid {
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
			LogFile("Chests Opened: " Floor(chestsopened))
			if( DisableUserDetailsReload == 0) {
				GetUserDetails()
			}
			SB_SetText("⌛ Chests remaining: " count " (Error)")
			return
		}
		for k, v in chestresults.loot_details {
			if (v.unlock_hero_feat) {
				lastfeat := (FeatFromID(v.unlock_hero_feat) "n")
				newfeats := newfeats lastfeat
			}
			if (v.gilded) {
				if ( !IsObject( chestresults_cumulative[ v.hero_id ] ) ) {
					chestresults_cumulative[ v.hero_id ] := {}
					chestresults_cumulative[ v.hero_id ][ v.slot_id ] := {}
					chestresults_cumulative[ v.hero_id ][ v.slot_id ][ gilded_count ] := 1
					if (v.disenchant_amount == 125)
						chestresults_cumulative[ v.hero_id ][ v.slot_id ][ disenchant_amount ] := v.disenchant_amount
				} else if ( !IsObject( chestresults_cumulative[ v.hero_id ][ v.slot_id ] ) ) {
					chestresults_cumulative[ v.hero_id ][ v.slot_id ] := {}
					chestresults_cumulative[ v.hero_id ][ v.slot_id ][ gilded_count ] := 1
					if (v.disenchant_amount == 125)
						chestresults_cumulative[ v.hero_id ][ v.slot_id ][ disenchant_amount ] := v.disenchant_amount
				} else {
					chestresults_cumulative[ v.hero_id ][ v.slot_id ][ gilded_count ] += 1
					if (v.disenchant_amount == 125)
						chestresults_cumulative[ v.hero_id ][ v.slot_id ][ disenchant_amount ] += v.disenchant_amount
				}
			}
		}
	}

	for k, v in chestresults_cumulative {
		for k2, v2 in v {
			if ( v2.gilded_count <= 1 ) {
				lastshiny := ( ChampFromID( k ) " (Slot " k2 ")" )
			} else {
				lastshiny := ( ChampFromID( k ) " (Slot " k2 " x " v2.gilded_count ")" )
			}
			if ( v2.disenchant_amount ) {
				lastshiny .= " +" v2.disenchant_amount
			}
			newshinies .= lastshiny "`n"
		}
	}
	tempsavesetting := 0
	switch chestid {
		case "1": {
			chestsopened := (CurrentSilvers - chestresults.chests_remaining)
			if (extraspent) {
				chestsopened += (extraspent/50)
			}
			MsgBox % "New Shinies:`n" newshinies
			LogFile("Silver Chests Opened: " Floor(chestsopened))
		}
		case "2": {
			chestsopened := (CurrentGolds - chestresults.chests_remaining)
			if (extraspent) {
				chestsopened += (extraspent/500)
			}
			MsgBox % "New Feats:`n" newfeats "`nNew Shinies:`n" newshinies
			LogFile("Gold Chests Opened: " Floor(chestsopened))
		}
	}
	if( DisableUserDetailsReload == 0) {
		GetUserDetails()
	}
	SB_SetText("✅ Chest opening completed")
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
		MsgBox % "Need User ID & Hash"
		FirstRun()
	}
	switch buffid {
		case 31:
			currentcontracts := CurrentTinyBS
			lastcontracts := LastBSTnCount
			contractname := "Tiny"
		case 32:
			currentcontracts := CurrentSmBS
			lastcontracts := LastBSSmCount
			contractname := "Small"
		case 33:
			currentcontracts := CurrentMdBS
			lastcontracts := LastBSMdCount
			contractname := "Medium"
		case 34:
			currentcontracts := CurrentLgBS
			lastcontracts := LastBSLgCount
			contractname := "Large"
		case 1797:
			currentcontracts := CurrentHgBS
			lastcontracts := LastBSHgCount
			contractname := "Huge"
	}
	if !(lastcontracts) {
		lastcontracts := currentcontracts
	}
	if (lastcontracts > currentcontracts) {
		lastcontracts := currentcontracts
	}
	if !(currentcontracts) {
		MsgBox, 4, , No %contractname% Blacksmith Contracts detected. Check server for user details?
			IfMsgBox, Yes
			{
				GetUserDetails()
			}
	}
	InputBox, count, Blacksmithing, % "How many " contractname " Blacksmith Contracts?`n(Max: " currentcontracts ")", , 200, 180, , , , , %lastcontracts%
	if ErrorLevel
		return
	if (count > currentcontracts) {
		MsgBox, 4, , Insufficient %contractname% Blacksmith Contracts detected for use.`nContinue anyway?
		IfMsgBox, No
		{
			return
		}
	}
	heroid := "error"
	InputBox, heroid, Blacksmithing, % "Use " contractname " Blacksmith Contracts on which Champ? (Enter ID)", , 200, 180, , , , , %LastBSChamp%
	if ErrorLevel
		return
	while !((heroid is number) OR ((heroid > 0) && (heroid < 107)) OR ((heroid > 112) && (heroid < 130))) {
		InputBox, heroid, Blacksmithing, % "Please enter a valid Champ ID number", , 200, 180, , , , , %LastBSChamp%
		if ErrorLevel
			return
	}
	MsgBox, 4, , % "Use " count " " contractname " Blacksmith Contracts on " ChampFromID(heroid) "?"
	IfMsgBox, No
	{
		return
	}
	LastBSChamp := heroid
	switch buffid {
		case 31: LastBSTnCount := count
		case 32: LastBSSmCount := count
		case 33: LastBSMdCount := count
		case 34: LastBSLgCount := count
		case 1797: LastBSHgCount := count
	}	
	bscontractparams := "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&buff_id=" buffid "&hero_id=" heroid "&num_uses="
	tempsavesetting := 0
	slot1lvs := 0
	slot2lvs := 0
	slot3lvs := 0
	slot4lvs := 0
	slot5lvs := 0
	slot6lvs := 0
	while (count > 0) {
		SB_SetText("⌛ " contractname " Blacksmith Contracts remaining to use: " count)
		if (count < 50) {
			rawresults := ServerCall("useserverbuff", bscontractparams count)
			count -= count
		} else {
			rawresults := ServerCall("useserverbuff", bscontractparams "50")
			count -= 50
		}
		if (CurrentSettings.alwayssavecontracts || tempsavesetting) {
			FileAppend, %rawresults%`n, %BlacksmithLogFile%
		} else {
			if !CurrentSettings.nosavesetting {
				InputBox, dummyvar, Blacksmith Contracts Results, Save to File?, , 250, 150, , , , , % rawresults
				dummyvar := ""
				if !ErrorLevel {
					FileAppend, %rawresults%`n, %BlacksmithLogFile%
					tempsavesetting := 1
				}
			}
		}
		blacksmithresults := JSON.parse(rawresults)
		if ((blacksmithresults.success == "0") || (blacksmithresults.okay == "0")) {
			if(ShowResultsBlacksmithContracts == 1) {
				MsgBox % ChampFromID(heroid) " levels gained:`nSlot 1: " slot1lvs "`nSlot 2: " slot2lvs "`nSlot 3: " slot3lvs "`nSlot 4: " slot4lvs "`nSlot 5: " slot5lvs "`nSlot 6: " slot6lvs
			}
			MsgBox % "Error: " rawresults
			switch buffid {
				case 31: contractsused := (CurrentTinyBS - blacksmithresults.buffs_remaining)
				case 32: contractsused := (CurrentSmBS - blacksmithresults.buffs_remaining)
				case 33: contractsused := (CurrentMdBS - blacksmithresults.buffs_remaining)
				case 34: contractsused := (CurrentLgBS - blacksmithresults.buffs_remaining)
				case 1797: contractsused := (CurrentHgBS - blacksmithresults.buffs_remaining)
			}
			LogFile(contractname "Blacksmith Contracts Used: " Floor(contractsused))
			if( DisableUserDetailsReload == 0) {
				GetUserDetails()
			}
			SB_SetText("⌛ " contractname " Blacksmith Contracts remaining: " count " (Error)")
			return
		}
		rawactions := JSON.stringify(blacksmithresults.actions)
		blacksmithactions := JSON.parse(rawactions)
		for k, v in blacksmithactions {
			switch v.slot_id {
				case 1: slot1lvs += v.amount
				case 2: slot2lvs += v.amount
				case 3: slot3lvs += v.amount
				case 4: slot4lvs += v.amount
				case 5: slot5lvs += v.amount
				case 6: slot6lvs += v.amount
			}
		}
	}
	if(ShowResultsBlacksmithContracts == 1) {
		MsgBox % ChampFromID(heroid) " levels gained:`nSlot 1: " slot1lvs "`nSlot 2: " slot2lvs "`nSlot 3: " slot3lvs "`nSlot 4: " slot4lvs "`nSlot 5: " slot5lvs "`nSlot 6: " slot6lvs
	}
	tempsavesetting := 0
	switch buffid {
		case 31: contractsused := (CurrentTinyBS - blacksmithresults.buffs_remaining)
		case 32: contractsused := (CurrentSmBS - blacksmithresults.buffs_remaining)
		case 33: contractsused := (CurrentMdBS - blacksmithresults.buffs_remaining)
		case 34: contractsused := (CurrentLgBS - blacksmithresults.buffs_remaining)
		case 1797: contractsused := (CurrentHgBS - blacksmithresults.buffs_remaining)
	}
	LogFile(contractname " Blacksmith Contracts used on " ChampFromID(heroid) ": " Floor(contractsused))
	if( DisableUserDetailsReload == 0) {
		GetUserDetails()
	}
	SB_SetText("✅ " contractname " Blacksmith Contracts use completed")
	return
}

Tiny_Bounty:
	{
		UseBounty(17)
		return
	}

Sm_Bounty:
	{
		UseBounty(18)
		return
	}

Med_Bounty:
	{
		UseBounty(19)
		return
	}

Lg_Bounty:
	{
		UseBounty(20)
		return
	}

UseBountyClick(name, imagename, offset_x, offset_y, delay) {
	FileAppend, %name%`n, %BountyLogFile%
	WinGet, PID, PID, Idle Champions
	WinActivate, ahk_pid %PID%
	ImageSearch, ix, iy, 0, 0, a_screenHeight, a_screenWidth, %A_ScriptDir%/images/%imagename%.png
	FileAppend, %name% - Errorlevel: %errorlevel% ix: %ix% iy: %iy%`n, %BountyLogFile%
	if (errorlevel == 0) {
		MouseClick, left, ix+offset_x, iy+offset_y
		sleep %delay%
		return 1
	}
	return 0
}

UseBounty(buffid) {
	if !UserID {
		MsgBox % "Need User ID & Hash"
		FirstRun()
	}
	switch buffid {
		case 17:
			currentcontracts := CurrentTinyBounties
			lastcontracts := LastBountyTnCount
			contractname := "Tiny"
		case 18:
			currentcontracts := CurrentSmBounties
			lastcontracts := LastBountySmCount
			contractname := "Small"
		case 19:
			currentcontracts := CurrentMdBounties
			lastcontracts := LastBountyMdCount
			contractname := "Medium"
		case 20:
			currentcontracts := CurrentLgBounties
			lastcontracts := LastBountyLgCount
			contractname := "Large"
	}
	if !(lastcontracts) {
		lastcontracts := currentcontracts
	}
	if (lastcontracts > currentcontracts) {
		lastcontracts := currentcontracts
	}
	if !(currentcontracts) {
		MsgBox, 4, , No %contractname% Bounty Contracts detected. Check server for user details?
			IfMsgBox, Yes
			{
				GetUserDetails()
			}
	}
	InputBox, count, Bounties, % "How many " contractname " Bounty Contracts?`n(Max: " currentcontracts ")", , 200, 180, , , , , %lastcontracts%
	if ErrorLevel
		return
	if (count > currentcontracts) {
		MsgBox, 4, , Insufficient %contractname% Bounty Contracts detected for use.`nContinue anyway?
		IfMsgBox, No
		{
			return
		}
	}
	MsgBox, 4, , % "Use " count " " contractname " Bounty Contracts?`n`nWARNING: This is an alpha feature and is prone to bugs (or just not work at all) and must be run at resolution 1280x720 and not in fullscreen`n`nNOTE: Do not touch the mouse or keyboard until process completed`n`nAUTO PROGRESS will be temporarily turned off for this process"
	IfMsgBox, No
	{
		return
	}
	FileAppend, [PROCESS START] %contractname% Bounty Contracts to use: %count%`n, %BountyLogFile%
	;bounty cancel
	UseBountyClick("BOUNTY CANCEL", "bounty_cancel", 5, 5, 500)
	;inventory close
	UseBountyClick("INVENTORY CLOSE", "inventory_close", 5, 5, 500)
	;turn auto progress off
	autoprogress := 0
	if (UseBountyClick("AUTO PROGRESS OFF", "auto_progress_on", 5, 5, 50) == 1) {
		autoprogress := 1
	}
	;inventory open
	if (UseBountyClick("INVENTORY OPEN", "inventory", 15, 15, 500) == 1) {
		contractsused := 0
		page := 1
		while (count > 0) {
			found := 0
			while (found == 0) { ;search pages for bounties
				if (page == 5) {
					FileAppend, [PROCESS COMPLETED] No %contractname% Bounty Contracts found`n, %BountyLogFile%
					msgbox % "[PROCESS COMPLETED]`n`nNo "contractname " Bounty Contracts found"
					return
				}
				;search inventory page
				FileAppend, FIND BOUNTY CONTRACT`n, %BountyLogFile%
				WinGet, PID, PID, Idle Champions
				WinActivate, ahk_pid %PID%
				;bounty icon
				switch buffid {
					case 17:
						ImageSearch, ix, iy, 0, 0, a_screenHeight, a_screenWidth, %A_ScriptDir%/images/bounty_tn.png
					case 18:
						ImageSearch, ix, iy, 0, 0, a_screenHeight, a_screenWidth, %A_ScriptDir%/images/bounty_sm.png
					case 19:
						ImageSearch, ix, iy, 0, 0, a_screenHeight, a_screenWidth, %A_ScriptDir%/images/bounty_md.png
					case 20:
						ImageSearch, ix, iy, 0, 0, a_screenHeight, a_screenWidth, %A_ScriptDir%/images/bounty_lg.png
				}
				FileAppend, FIND BOUNTY CONTRACT - PAGE %page% - Errorlevel: %errorlevel% ix: %ix% iy: %iy%`n, %BountyLogFile%
				if (errorlevel == 0) {
					WinGet, PID, PID, Idle Champions
					WinActivate, ahk_pid %PID%
					MouseClick, left, ix+15, iy+15
					sleep 500
					found := 1
				} else if (errorlevel == 1) {
					page += 1
					FileAppend, INVENTORY NEXT PAGE`n, %BountyLogFile%
					WinGet, PID, PID, Idle Champions
					WinActivate, ahk_pid %PID%
					;inventory next page
					ImageSearch, ix, iy, 0, 0, a_screenHeight, a_screenWidth, %A_ScriptDir%/images/inventory_next.png
					FileAppend, INVENTORY NEXT PAGE - Errorlevel: %errorlevel% ix: %ix% iy: %iy%`n, %BountyLogFile%
					if (errorlevel == 0) {
						WinGet, PID, PID, Idle Champions
						WinActivate, ahk_pid %PID%
						MouseClick, left, ix+5, iy+5
						MouseMove, ix+50, iy+5
						sleep 500
					}
				}
			}
			if (found == 1) {
				SB_SetText("⌛ " contractname " Bounty Contracts remaining to use: " count)
				repeatcount := 0
				if (count < 50) {
					contractsused += count
					repeatcount := count
					count -= count
				} else {
					contractsused += 50
					repeatcount := 50
					count -= 50
				}
				repeatcount -= 1
				;bounty next/increase count
				FileAppend, INVENTORY COUNT INCREASE`n, %BountyLogFile%
				WinGet, PID, PID, Idle Champions
				WinActivate, ahk_pid %PID%
				ImageSearch, ix, iy, 0, 0, a_screenHeight, a_screenWidth, %A_ScriptDir%/images/bounty_next.png
				FileAppend, INVENTORY COUNT INCREASE - Errorlevel: %errorlevel% ix: %ix% iy: %iy%`n, %BountyLogFile%
				if (errorlevel == 0) {
					loop %repeatcount% {
						WinGet, PID, PID, Idle Champions
						WinActivate, ahk_pid %PID%
						MouseClick, left, ix+10, iy+10
						sleep 20
					}
				}
				;bounty go
				UseBountyClick("CLICK GO", "bounty_go", 15, 15, 750)
				if (repeatcount = 49) {
					;additional cancel
					UseBountyClick("ADDITIONAL CANCEL", "additional_cancel", 5, 5, 500)
				}
			}
		}
		;inventory close
		UseBountyClick("INVENTORY CLOSE", "inventory_close", 5, 5, 500)
		if (autoprogress == 1) {
			;turn auto progress on
			UseBountyClick("AUTO PROGRESS ON", "auto_progress_off", 5, 5, 1)
		}
		FileAppend, [PROCESS COMPLETED] %contractname% Bounty Contracts used: %contractsused%`n, %BountyLogFile%
		msgbox % "[PROCESS COMPLETED]`n`n"contractname " Bounty Contracts used: " Floor(contractsused)
		LogFile(contractname " Bounty Contracts used: " Floor(contractsused))
		GetUserDetails()
		SB_SetText("✅ " contractname " Bounty Contracts use completed")
	}
}

UseBounty2(buffid) {
	if !UserID {
		MsgBox % "Need User ID & Hash"
		FirstRun()
	}
	switch buffid {
		case 17:
			currentcontracts := CurrentTinyBounties
			lastcontracts := LastBountyTnCount
			contractname := "Tiny"
		case 18:
			currentcontracts := CurrentSmBounties
			lastcontracts := LastBountySmCount
			contractname := "Small"
		case 19:
			currentcontracts := CurrentMdBounties
			lastcontracts := LastBountyMdCount
			contractname := "Medium"
		case 20:
			currentcontracts := CurrentLgBounties
			lastcontracts := LastBountyLgCount
			contractname := "Large"
	}
	if !(lastcontracts) {
		lastcontracts := currentcontracts
	}
	if (lastcontracts > currentcontracts) {
		lastcontracts := currentcontracts
	}
	if !(currentcontracts) {
		MsgBox, 4, , No %contractname% Bounty Contracts detected. Check server for user details?
			IfMsgBox, Yes
			{
				GetUserDetails()
			}
	}
	InputBox, count, Bounties, % "How many " contractname " Bounty Contracts?`n(Max: " currentcontracts ")", , 200, 180, , , , , %lastcontracts%
	if ErrorLevel
		return
	if (count > currentcontracts) {
		MsgBox, 4, , Insufficient %contractname% Bounty Contracts detected for use.`nContinue anyway?
		IfMsgBox, No
		{
			return
		}
	}
	MsgBox, 4, , % "Use " count " " contractname " Bounty Contracts?"
	IfMsgBox, No
	{
		return
	}
	switch buffid {
		case 17: LastBountyTnCount := count
		case 18: LastBountySmCount := count
		case 19: LastBountyMdCount := count
		case 20: LastBountyLgCount := count
	}	
	bountycontractparams := "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&buff_id=" buffid "&num_uses="
	tempsavesetting := 0
	slot1lvs := 0
	slot2lvs := 0
	slot3lvs := 0
	slot4lvs := 0
	slot5lvs := 0
	slot6lvs := 0
	while (count > 0) {
		SB_SetText("⌛ " contractname " Bounty Contracts remaining to use: " count)
		if (count < 50) {
			rawresults := ServerCall("useserverbuff", bountycontractparams count)
			count -= count
		} else {
			rawresults := ServerCall("useserverbuff", bountycontractparams "50")
			count -= 50
		}
		if (CurrentSettings.alwayssavecontracts || tempsavesetting) {
			FileAppend, %rawresults%`n, %BountyLogFile%
		} else {
			if !CurrentSettings.nosavesetting {
				InputBox, dummyvar, Bounty Contracts Results, Save to File?, , 250, 150, , , , , % rawresults
				dummyvar := ""
				if !ErrorLevel {
					FileAppend, %rawresults%`n, %BountyLogFile%
					tempsavesetting := 1
				}
			}
		}
		bountyresults := JSON.parse(rawresults)
		if ((bountyresults.success == "0") || (bountyresults.okay == "0")) {
			MsgBox % "Items gained:`nSlot 1: " slot1lvs "`nSlot 2: " slot2lvs "`nSlot 3: " slot3lvs "`nSlot 4: " slot4lvs "`nSlot 5: " slot5lvs "`nSlot 6: " slot6lvs
			MsgBox % "Error: " rawresults
			switch buffid {
				case 17: contractsused := (CurrentTinyBounties - bountyresults.buffs_remaining)
				case 18: contractsused := (CurrentSmBounties - bountyresults.buffs_remaining)
				case 19: contractsused := (CurrentMdBounties - bountyresults.buffs_remaining)
				case 20: contractsused := (CurrentLgBounties - bountyresults.buffs_remaining)
			}
			LogFile(contractname "Bounty Contracts Used: " Floor(contractsused))
			if( DisableUserDetailsReload == 0) {
				GetUserDetails()
			}
			SB_SetText("⌛ " contractname " Bounty Contracts remaining: " count " (Error)")
			return
		}
		rawactions := JSON.stringify(bountyresults.actions)
		bountyactions := JSON.parse(rawactions)
		for k, v in bountyactions {
			switch v.slot_id {
				case 1: slot1lvs += v.amount
				case 2: slot2lvs += v.amount
				case 3: slot3lvs += v.amount
				case 4: slot4lvs += v.amount
				case 5: slot5lvs += v.amount
				case 6: slot6lvs += v.amount
			}
		}
	}
	MsgBox % "Items gained:`nSlot 1: " slot1lvs "`nSlot 2: " slot2lvs "`nSlot 3: " slot3lvs "`nSlot 4: " slot4lvs "`nSlot 5: " slot5lvs "`nSlot 6: " slot6lvs
	tempsavesetting := 0
	switch buffid {
		case 17: contractsused := (CurrentTinyBounties - bountyresults.buffs_remaining)
		case 18: contractsused := (CurrentSmBounties - bountyresults.buffs_remaining)
		case 19: contractsused := (CurrentMdBounties - bountyresults.buffs_remaining)
		case 20: contractsused := (CurrentLgBounties - bountyresults.buffs_remaining)
	}
	LogFile(contractname " Bounty Contracts used: " Floor(contractsused))
	if( DisableUserDetailsReload == 0) {
		GetUserDetails()
	}
	SB_SetText("✅ " contractname " Bounty Contracts use completed")
	return
}

global lastadv := 0			;fmagdi - to be used to save ended adventureid for use as default for next load 

LoadAdventure() {
	GetUserDetails()
	while !(CurrentAdventure == "-1") {
		MsgBox, 5, , Please end your current adventure first.
		IfMsgBox, Cancel
		{
			return
		}
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
	SB_SetText("✅ Selected adventure has been loaded")
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
	SB_SetText("✅ Current adventure has been ended")
	return
}

EndBGAdventure() {
	if (ActiveInstance == "1") {
		bginstance := 2
	} else {
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
	SB_SetText("✅ Background adventure has been ended")
	return
}

EndBG2Adventure() {
	if (ActiveInstance == "3" or ActiveInstance == "4") {
		bginstance := 2
	} else {
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
	SB_SetText("✅ Background2 adventure has been ended")
	return
}

EndBG3Adventure() {
	if (ActiveInstance == "4") {
		bginstance := 3
	} else {
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
	SB_SetText("✅ Background3 adventure has been ended")
	return
}
;	fmagdi -stop

SetIcon() {
	;IdleChampions Icon
	if FileExist(IconFile) {
		Menu, Tray, Icon, %IconFile%
	}
}

detectGameInstallEpic() {
	setGameInstallEpic(true)
}

setGameInstallEpic( manual = false) {
	; Detect Epic Games install
	if FileExist(GameClientEpic) {
		FileRead, EpicJSONString, %GameClientEpic%
		EpicJSONobj := JSON.parse(EpicJSONString)
		for each, item in EpicJSONobj.InstallationList {
			if item.AppName = GameIDEpic {
				GameInstallDirEpic := item.InstallLocation "\"
				GameInstallDir := GameInstallDirEpic
				GameClient := GameClientEpicLauncher
				WRLFile := GameInstallDir WRLFilePath
				IconFile := GameInstallDir IconFilename
				GamePlatform := "Epic Game Store"
				LoadGameClient := 1
				SetIcon()
				if manual {
					msgbox Epic Games install found
					FirstRun()
					GetUserDetails()
				}
				return true
			}
		}
	}
	if manual
		msgbox Epic Games install NOT found
	return false
}

detectGameInstallSteam() {
	setGameInstallSteam(true)
}

setGameInstallSteam( manual = false) {
	; Detect Steam install
	if FileExist(GameInstallDirSteam) {
		GameInstallDir := GameInstallDirSteam
		GameClient := GameInstallDir GameClientExe
		WRLFile := GameInstallDir WRLFilePath
		IconFile := GameInstallDir IconFilename
		GamePlatform := "Steam"
		LoadGameClient := 2
		SetIcon()
		if manual {
			msgbox Steam install found
			FirstRun()
			GetUserDetails()
		}
		return true
	}
	if manual
		msgbox Steam install NOT found
	return false
}

detectGameInstallStandalone() {
	setGameInstallStandalone(true)
}

setGameInstallStandalone( manual = false) {
	; Detect Standalone install
	if FileExist(GameInstallDirStandalone) {
		GameInstallDir := GameInstallDirStandaloneLauncher
		GameClient := GameInstallDirStandaloneLauncher GameClientExeStandaloneLauncher
		WRLFile := GameInstallDirStandalone WRLFilePath
		IconFilename := GameClientExeStandaloneLauncher
		IconFile := GameInstallDir IconFilename
		GamePlatform := "Standalone"
		LoadGameClient := 3
		SetIcon()
		if manual {
			msgbox Standalone install found
			FirstRun()
			GetUserDetails()
		}
		return true
	}
	if manual
		msgbox Standalone install NOT found
	return setGameInstallStandaloneLauncher(manual)
}

detectGameInstallStandaloneLauncher() {
	setGameInstallStandaloneLauncher(true)
}

setGameInstallStandaloneLauncher( manual = false) {
	; Detect Standalone Launcher install
	if FileExist(GameInstallDirStandaloneLauncher) {
		GameInstallDir := GameInstallDirStandaloneLauncher
		GameClient := GameInstallDirStandaloneLauncher GameClientExeStandaloneLauncher
		WRLFile := ""
		IconFilename := GameClientExeStandaloneLauncher
		IconFile := GameInstallDir IconFilename
		LoadGameClient := 3
		SetIcon()
		GamePlatform := "Standalone Launcher"
		if manual {
			msgbox Standalone Launcher install found`nYou must login to the launcher and install the game first`nAfter the game is installed, launch the game`nThen rerun game detection to grab the User ID and Hash
		}
		return true
	}
	if manual
		msgbox Standalone Launcher install NOT found
	return false
}

detectGameInstallConsole() {
	setGameInstallConsole(true)
}

setGameInstallConsole( manual = false) {
	; Detect Console install
	if FileExist(GameInstallDirStandalone) {
		; GameInstallDir := GameInstallDirStandaloneLauncher
		; GameClient := GameInstallDirStandaloneLauncher GameClientExeStandaloneLauncher
		; WRLFile := GameInstallDirStandalone WRLFilePath
		; IconFilename := GameClientExeStandaloneLauncher
		; IconFile := GameInstallDir IconFilename
		GamePlatform := "Console"
		LoadGameClient := 4
		ServerDetection := 0
		SetIcon()
		if manual {
			; msgbox Console install found
			FirstRun()
			GetUserDetails()
		}
		return true
	}
	if manual
		msgbox Console install NOT found
	return false
}

FirstRun() {
	if(LoadGameClient == 4) {
		InputBox, UserID, user_id, Please enter your "user_id" value., , 250, 125
		if ErrorLevel
			return
		InputBox, UserHash, hash, Please enter your "hash" value., , 250, 125
		if ErrorLevel
			return
		LogFile("User ID: " UserID " & Hash: " UserHash " manually entered")
	} else {
		MsgBox, 4, , Get User ID and Hash from webrequestlog.txt?
		IfMsgBox, Yes
		{
			GetIdFromWRL()
			LogFile("Platform: " GamePlatform)
			LogFile("User ID: " UserID " & Hash: " UserHash " detected in WRL")
			GetPlayServerFromWRL()
		} else {
			MsgBox, 4, , Choose install directory manually?
			IfMsgBox, Yes
			{
				FileSelectFile, WRLFile, 1, webRequestLog.txt, Select webRequestLog file, webRequestLog.txt
				if ErrorLevel
					return
				GetIdFromWRL()
				GameInstallDir := SubStr(WRLFile, 1, -67)
				GameClient := GameInstallDir "IdleDragons.exe"
			} else {
				InputBox, UserID, user_id, Please enter your "user_id" value., , 250, 125
				if ErrorLevel
					return
				InputBox, UserHash, hash, Please enter your "hash" value., , 250, 125
				if ErrorLevel
					return
				LogFile("User ID: " UserID " & Hash: " UserHash " manually entered")
			}
		}
	}
	CurrentSettings.user_id := UserID
	CurrentSettings.user_id_epic := UserIDEpic
	CurrentSettings.user_id_steam := UserIDSteam
	CurrentSettings.hash := UserHash
	CurrentSettings.firstrun := 1
	CurrentSettings.wrlpath := WRLFile
	newsettings := JSON.stringify(CurrentSettings)
	FileDelete, %SettingsFile%
	FileAppend, %newsettings%, %SettingsFile%
	LogFile("IdleCombos Setup Completed")
	SB_SetText("✅ User ID & Hash Ready")
}

UpdateLogTime() {
	FormatTime, CurrentTime, , yyyy-MM-dd HH:mm:ss
}

LogFile(LogMessage) {
	if (LogEnabled) {
		OutputLogFile := LogFileName
		if (LogMessage) {
			UpdateLogTime()
			FileAppend, [%CurrentTime%] %LogMessage% `n, %OutputLogFile%
			FileRead, OutputText, %OutputLogFile%
			oMyGUI.Update()
		}
	} else {
		OutputLogFile := ""
	}
}

GetIDFromWRL() {
	FileRead, oData, %WRLFile%
	if ErrorLevel {
		MsgBox, 4, , Could not find webRequestLog.txt file.`nChoose install directory manually?
		IfMsgBox, Yes
		{
			FileSelectFile, WRLFile, 1, webRequestLog.txt, Select webRequestLog file, webRequestLog.txt
			if ErrorLevel
				return
			FileRead, oData, %WRLFile%
		} else {
			return
		}
	}
	FoundPos := InStr(oData, "getuserdetails&language_id=1&user_id=")
	oData2 := SubStr(oData, (FoundPos + 37))
	FoundPos := InStr(oData2, "&hash=")
	StringLeft, UserID, oData2, (FoundPos - 1)
	oData3 := SubStr(oData2, (FoundPos + 6))
	FoundPos := InStr(oData3, "&instance_key=")
	StringLeft, UserHash, oData3, (FoundPos - 1)
	FoundPos := InStr(oData, "&account_id=")
	oData4 := SubStr(oData, (FoundPos + 12))
	if oData4 {
		FoundPos := InStr(oData4, "&access_token=")
		StringLeft, UserIDEpic, oData4, (FoundPos - 1)
	}
	FoundPos := InStr(oData, "&steam_user_id=")
	oData5 := SubStr(oData, (FoundPos + 15))
	if oData5 {
		FoundPos := InStr(oData5, "&steam_name=")
		StringLeft, UserIDSteam, oData5, (FoundPos - 1)
	}
	oData := ; Free the memory.
	oData2 := ; Free the memory.
	oData3 := ; Free the memory.
	oData4 := ; Free the memory.
	oData5 := ; Free the memory.
	return
}

StrReverse(String) {
	String .= "", DllCall("msvcrt.dll\_wcsrev", "Ptr", &String, "CDecl")
    return String
}

GetPlayServerFromWRL() {
	FileRead, oData, %WRLFile%
	if ErrorLevel {
		MsgBox, 4, , Could not find webRequestLog.txt file.`nChoose install directory manually?
		IfMsgBox, Yes
		{
			FileSelectFile, WRLFile, 1, webRequestLog.txt, Select webRequestLog file, webRequestLog.txt
			if ErrorLevel
				return
			FileRead, oData, %WRLFile%
		} else {
			return
		}
	}
	FoundPos1 := InStr(oData, "Error connecting:", 0, -1, 1)
	if(FoundPos1 != 0){
		oData1 := SubStr(oData, (FoundPos1 + 17))
		FoundPos1 := InStr(oData1, "<br/>")
		sServerError := ""
		StringLeft, sServerError, oData1, (FoundPos1 - 1)
		; MsgBox, % "Server Error: " sServerError
		ServerError := sServerError
		oData := ; Free the memory.
		oData1 := ; Free the memory.
		return
	}
	if (ServerDetection == 1) {
		GetPlayServer(oData)
	}
	return
}

GetPlayServer(oData) {
	LogFile("Detecting play server")

	searchString = "play_server"
	; ScrollBox(oData, "p b1 h700 w1000 f{s10, Consolas}", "oData")

	; reversedData := StrReverse(oData)
	; ScrollBox(reversedData, "p b1 h700 w1000 f{s10, Consolas}", "reversedData")
	; MsgBox, % "searchString - " StrReverse(searchString)
	; position := InStr(reversedData, StrReverse(searchString))
	; FoundPos2 := StrLen(oData) - (FoundPos2 + StrLen(searchString)) + 1
	
	FoundPos2 := InStr(oData, searchString)
	; MsgBox, % "FoundPos2 - " FoundPos2
	oData2 := SubStr(oData, (FoundPos2 + 14))
	
	; MsgBox, % "oData2 - " oData2
	FoundPos2 := InStr(oData2, ":\/\/")
	oData3 := SubStr(oData2, (FoundPos2 + 5))
	; MsgBox, % "oData3 - " oData3
	FoundPos2 := InStr(oData3, ".idlechampions.com\/~idledragons\/")
	NewServerName := ""
	StringLeft, NewServerName, oData3, (FoundPos2 - 1)
	playservername := ServerName
	if (NewServerName != ServerName){
		ServerName := NewServerName
		playservername := NewServerName
		SaveSettings()
		Sleep, 250
		LogFile("Play Server Detected - " NewServerName)
	}
	oData := ; Free the memory.
	oData2 := ; Free the memory.
	return playservername
}

GetUserDetails(newservername = "") {
	If (newservername = "") {
		playservername := ServerName
	} else {
		playservername := newservername
	}
	Gui, MyWindow:Default
	SB_SetText("⌛ Loading Data... Please wait...")
	; LogFile("Server Name: " playservername)
	getuserparams := DummyData "&include_free_play_objectives=true&instance_key=1&user_id=" UserID "&hash=" UserHash
	rawdetails := ServerCall("getuserdetails", getuserparams, playservername)
	; ScrollBox(rawdetails, "p b1 h700 w1000 f{s10, Consolas}", "rawdetails")
	if ( ServerError != "") {
		SB_SetText("❌ API Error: " ServerError " - Try to close and reopen Idle Champions - Server might be in Maintenance? 😟")
		ServerError := ""
	} else {
		swtichPlayServer := InStr(rawdetails, "switch_play_server")
		; MsgBox, % "swtichPlayServer - " swtichPlayServer
		if (swtichPlayServer > 0) {
			playservername := GetPlayServer(rawdetails)
			GetUserDetails(playservername)
		} else {
			FileDelete, %UserDetailsFile%
			FileAppend, %rawdetails%, %UserDetailsFile%
			Try {
				UserDetails := JSON.parse(rawdetails)
			} catch e {
				SB_SetText("❌ API Error: Try to close and reopen Idle Champions - Server might be in Maintenance? 😟")
				msgbox, % "API ERROR: " e.message
				return
			}
			InstanceID := UserDetails.details.instance_id
			CurrentSettings.instance_id := InstanceID
			CurrentSettings.loadgameclient := LoadGameClient
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
			CheckPatronProgress()
			CheckEvents()
			SB_SetText("✅ Loaded and Ready 😎")
			LogFile("User Details - Loaded")
			oMyGUI.Update()
		}
	}
	return
}

ParseAdventureData() {
	SB_SetText("⌛ Parsing Data - Adventures... Please wait...")
	InstanceList := [{},{},{},{}]
	CoreList := ["Modest","Strong","Fast","Magic"]
	MagList := ["K","M","B","t"]
	
	for k, v in UserDetails.details.game_instances {
		InstanceList[v.game_instance_id].current_adventure_id := v.current_adventure_id
		InstanceList[v.game_instance_id].current_area := v.current_area
		InstanceList[v.game_instance_id].Patron := PatronFromID(v.current_patron_id)
		InstanceList[v.game_instance_id].ChampionsCount := 0
		for l, w in v.formation {
			if (w > 0) {
				InstanceList[v.game_instance_id].ChampionsCount += 1
			}
		}
	}
	for k, v in UserDetails.details.modron_saves {
		InstanceList[v.instance_id].core := "Core: " Corelist[v.core_id]
		if (v.properties.toggle_preferences.reset == true)
			InstanceList[v.instance_id].core := InstanceList[v.instance_id].core " (Reset at " v.area_goal ")"
		core_level := ceil((sqrt(36000000+8000*v.exp_total)-6000)/4000)
		core_tolevel := v.exp_total-(2000*(core_level-1)**2+6000*(core_level-1))
		core_levelxp := 4000*(core_level+1)
		core_pcttolevel := Floor((core_tolevel / core_levelxp) * 100)
		core_humxp := Format("{:.2f}",v.exp_total / (1000 ** Floor(log(v.exp_total)/3))) MagList[Floor(log(v.exp_total)/3)]
		if (core_level > 15) 
			core_level := core_level " - Max 15"
		InstanceList[v.instance_id].core := InstanceList[v.instance_id].core "`nXP: " core_humxp " (Lvl " core_level ")`n" core_tolevel "/" core_levelxp " (" core_pcttolevel "%)"
	}
	
	ChampionsActiveCount := 0
	bginstance := 0
	FGCore := "`n"
	BGCore := "`n"
	BG2Core := "`n"
	BG3Core := "`n"

	for k, v in InstanceList {
		if (k == ActiveInstance) {
			CurrentAdventure := v.current_adventure_id
			CurrentArea := v.current_area
			CurrentPatron := v.Patron
			FGCore := v.core
			CurrentChampions := v.ChampionsCount
			ChampionsActiveCount += v.ChampionsCount
		} else if (bginstance == 0){
			BackgroundAdventure := v.current_adventure_id
			BackgroundArea := v.current_area
			BackgroundPatron := v.Patron
			BGCore := v.core
			BackgroundChampions := v.ChampionsCount
			ChampionsActiveCount += v.ChampionsCount
			bginstance += 1
		} else if (bginstance == 1){
			Background2Adventure := v.current_adventure_id
			Background2Area := v.current_area
			Background2Patron := v.Patron
			BG2Core := v.core
			Background2Champions := v.ChampionsCount
			ChampionsActiveCount += v.ChampionsCount
			bginstance += 1
		} else if (bginstance == 2){
			Background3Adventure := v.current_adventure_id
			Background3Area := v.current_area
			Background3Patron := v.Patron
			Background3Champions := v.ChampionsCount
			ChampionsActiveCount += v.ChampionsCount
			BG3Core := v.core
		}
	}
}

ParseTimestamps() {
	SB_SetText("⌛ Parsing Data - Timestamps... Please wait...")
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
	} else {
		Gui, Font, cBlack
		GuiControl, Font, NextTGPDrop
	}
}

ParseInventoryData() {
	SB_SetText("⌛ Parsing Data - Inventory... Please wait...")
	CurrentGems := UserDetails.details.red_rubies
	SpentGems := UserDetails.details.red_rubies_spent
	CurrentGolds := UserDetails.details.chests.2
	GoldPity := "(Epic in Next " UserDetails.details.stats.forced_win_counter_2 ")"
	CurrentSilvers := UserDetails.details.chests.1
	CurrentTGPs := UserDetails.details.stats.time_gate_key_pieces
	AvailableTGs := "= " Floor(CurrentTGPs/6) " Time Gates"
	for k, v in UserDetails.details.buffs {
		switch v.buff_id {
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
	}
	if (CurrentTinyBounties = "") {
		CurrentTinyBounties := 0
	}
	if (CurrentSmBounties = "") {
		CurrentSmBounties := 0
	}
	if (CurrentMdBounties = "") {
		CurrentMdBounties := 0
	}
	if (CurrentLgBounties = "") {
		CurrentLgBounties := 0
	}
	if (CurrentTinyBS = "") {
		CurrentTinyBS := 0
	}
	if (CurrentSmBS = "") {
		CurrentSmBS := 0
	}
	if (CurrentMdBS = "") {
		CurrentMdBS := 0
	}
	if (CurrentLgBS = "") {
		CurrentLgBS := 0
	}
	if (CurrentHgBS = "") {
		CurrentHgBS := 0
	}
	AvailableChests := "= " Floor(CurrentGems/50) " Silver Chests = " Floor(CurrentGems/500) " Gold Chests"
	tokencount := (CurrentTinyBounties*12)+(CurrentSmBounties*72)+(CurrentMdBounties*576)+(CurrentLgBounties*1152)
	if (UserDetails.details.event_details[1].user_data.event_tokens) {
		tokentotal := UserDetails.details.event_details[1].user_data.event_tokens
		AvailableTokens := "= " tokencount " Tokens   (" Round(tokencount/2500, 2) " Free Plays)"
		CurrentTokens := "+ " tokentotal " Current      (" Round(tokentotal/2500, 2) " Free Plays)"
		AvailableFPs := "(Total: " (tokentotal+tokencount) " = " Round((tokentotal + tokencount)/2500, 2) " Free Plays)"
	} else {
		AvailableTokens := "= " tokencount " Tokens"
		CurrentTokens := "(" Round(tokencount/2500, 2) " Free Plays)"
	}
	AvailableBSLvs := "= " CurrentTinyBS+(CurrentSmBS*2)+(CurrentMdBS*6)+(CurrentLgBS*24)+(CurrentHgBS*120) " Item Levels"
}

ParsePatronData() {
	SB_SetText("⌛ Parsing Data - Patrons... Please wait...")
	MagList := ["K","M","B","t"]
	for k, v in UserDetails.details.patrons {
		switch v.patron_id {
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
					if (CurrentTGPs == "") {
						CurrentTGPs := 0
					}
					if (CurrentSilvers == "") {
						CurrentSilvers := 0
					}
					MirtCosts := CurrentTGPs "/3 TGPs && " CurrentSilvers "/10 Silver Chests"
					if ((CurrentTGPs > 2) && (CurrentSilvers > 9)) {
						Gui, Font, cGreen
						GuiControl, Font, MirtChallenges
					}
				} else {
					for kk, vv in v.progress_bars {
						switch vv.id {
							case "variants_completed":
								MirtVariantTotal := vv.goal
								MirtCompleted := vv.count
								MirtVariants := MirtCompleted " / " MirtVariantTotal
							case "free_play_limit": MirtFPCurrency := vv.count
							case "weekly_challenge_porgress": MirtChallenges := vv.count
						}
					}
					MirtRequires := "Mirt Influence: " SubStr( "          " Format("{:.2f}",v.influence_current_amount / (1000 ** Floor(log(v.influence_current_amount)/3))) MagList[Floor(log(v.influence_current_amount)/3)], -9)
					MirtCosts := "Mirt Coins: " SubStr( "          " Format("{:.2f}",v.currency_current_amount / (1000 ** Floor(log(v.currency_current_amount)/3))) MagList[Floor(log(v.currency_current_amount)/3)], -9)
				}
			}
			case 2: {
				if v.unlocked == False {
					VajraVariants := "Locked"
					VajraFPCurrency := "Requires:"
					VajraChallenges := "Costs:"
					VajraRequiresAdventure := UserDetails.details.stats.completed_adventures_variants_and_patron_variants_c15
					if (VajraRequiresAdventure = "") {
						VajraRequiresAdventure := "0"
					}
					VajraRequires := VajraRequiresAdventure "/15 WD:DH Advs && " TotalChamps "/30 Champs"
					if ((VajraRequiresAdventure > 14) && (TotalChamps > 29)) {
						Gui, Font, cGreen
						GuiControl, Font, VajraFPCurrency
					}
					VajraCosts := CurrentGems "/2500 Gems && " CurrentSilvers "/15 Silver Chests"
					if ((CurrentGems > 2499) && (CurrentSilvers > 14)) {
						Gui, Font, cGreen
						GuiControl, Font, VajraChallenges
					}
				} else {
					for kk, vv in v.progress_bars {
						switch vv.id {
							case "variants_completed":
								VajraVariantTotal := vv.goal
								VajraCompleted := vv.count
								VajraVariants := VajraCompleted " / " VajraVariantTotal
							case "free_play_limit": VajraFPCurrency := vv.count
							case "weekly_challenge_porgress": VajraChallenges := vv.count
						}
					}
					VajraRequires := "Vajra Influence: " SubStr( "          " Format("{:.2f}",v.influence_current_amount / (1000 ** Floor(log(v.influence_current_amount)/3))) MagList[Floor(log(v.influence_current_amount)/3)], -9)
					VajraCosts := "Vajra Coins: " SubStr( "          " Format("{:.2f}",v.currency_current_amount / (1000 ** Floor(log(v.currency_current_amount)/3))) MagList[Floor(log(v.currency_current_amount)/3)], -9)
				}
			}
			case 3: {
				if v.unlocked == False {
					StrahdVariants := "Locked"
					StrahdFPCurrency := "Requires:"
					StrahdChallenges := "Costs:"
					StrahdRequiresAdventure := UserDetails.details.stats.highest_area_completed_ever_c413
					if (StrahdRequiresAdventure = "") {
						StrahdRequiresAdventure := "0"
					}
					StrahdRequires := StrahdRequiresAdventure "/250 in Adv 413 && " TotalChamps "/40 Champs"
					if ((StrahdRequiresAdventure > 249) && (TotalChamps > 39)) {
						Gui, Font, cGreen
						GuiControl, Font, StrahdFPCurrency
					}
					if (CurrentSilvers = "") {
						CurrentSilvers := "0"
					}
					if (CurrentLgBounties = "") {
						CurrentLgBounties := "0"
					}
					StrahdCosts := CurrentLgBounties "/10 Lg Bounties && " CurrentSilvers "/20 Silver Chests"
					if ((CurrentLgBounties > 9) && (CurrentSilvers > 19)) {
						Gui, Font, cGreen
						GuiControl, Font, StrahdChallenges
					}
				} else {
					for kk, vv in v.progress_bars {
						switch vv.id {
							case "variants_completed":
								StrahdVariantTotal := vv.goal
								StrahdCompleted := vv.count
								StrahdVariants := StrahdCompleted " / " StrahdVariantTotal
							case "free_play_limit": StrahdFPCurrency := vv.count
							case "weekly_challenge_porgress": StrahdChallenges := vv.count
						}
					}
					StrahdRequires := "Strahd Influence: " SubStr( "          " Format("{:.2f}",v.influence_current_amount / (1000 ** Floor(log(v.influence_current_amount)/3))) MagList[Floor(log(v.influence_current_amount)/3)], -9)
					StrahdCosts := "Strahd Coins: " SubStr( "          " Format("{:.2f}",v.currency_current_amount / (1000 ** Floor(log(v.currency_current_amount)/3))) MagList[Floor(log(v.currency_current_amount)/3)], -9)
				}
			}
			case 4: {
				if v.unlocked == False {
					ZarielVariants := "Locked"
					ZarielFPCurrency := "Requires:"
					ZarielChallenges := "Costs:"
					ZarielRequiresAdventure := UserDetails.details.stats.highest_area_completed_ever_c873
					if (ZarielRequiresAdventure = "") {
						ZarielRequiresAdventure := "0"
					}
					ZarielRequires := ZarielRequiresAdventure "/575 in Adv 873 && " TotalChamps "/50 Champs"
					if ((ZarielRequiresAdventure > 574) && (TotalChamps > 49)) {
						Gui, Font, cGreen
						GuiControl, Font, ZarielFPCurrency
					}
					ZarielCosts := CurrentSilvers "/50 Silver Chests"
					if (CurrentSilvers > 49) {
						Gui, Font, cGreen
						GuiControl, Font, ZarielChallenges
					}
				} else {
					for kk, vv in v.progress_bars {
						switch vv.id {
							case "variants_completed":
								ZarielVariantTotal := vv.goal
								ZarielCompleted := vv.count
								ZarielVariants := ZarielCompleted " / " ZarielVariantTotal
							case "free_play_limit": ZarielFPCurrency := vv.count
							case "weekly_challenge_porgress": ZarielChallenges := vv.count
						}
					}
					ZarielRequires := "Zariel Influence: " SubStr( "          " Format("{:.2f}",v.influence_current_amount / (1000 ** Floor(log(v.influence_current_amount)/3))) MagList[Floor(log(v.influence_current_amount)/3)], -9)
					ZarielCosts := "Zariel Coins: " SubStr( "          " Format("{:.2f}",v.currency_current_amount / (1000 ** Floor(log(v.currency_current_amount)/3))) MagList[Floor(log(v.currency_current_amount)/3)], -9)
				}
			}
		}
	}
}

ParseLootData() {
	SB_SetText("⌛ Parsing Data - Loot... Please wait...")
	ChampionsUnlockedCount := 0
	FamiliarsUnlockedCount := 0
	CostumesUnlockedCount := 0
	EpicGearCount := 0
	todogear := "`nHighest Gear Level: " UserDetails.details.stats.highest_level_gear
	for k, v in UserDetails.details.heroes {
		if (v.owned == "1") {
			ChampionsUnlockedCount += 1
		}
	}
	for k, v in UserDetails.details.familiars {
		FamiliarsUnlockedCount += 1
	}
	for k, v in UserDetails.details.unlocked_hero_skins {
		CostumesUnlockedCount += 1
	}
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
	for k, v in UserDetails.details.modron_saves {
		if (v.instance_id == ActiveInstance) {
			BrivZone := v.area_goal
		}
	}
}

ParseChampData() {
	SB_SetText("⌛ Parsing Data - Champions... Please wait...")
	TotalChamps := 0
	MagList := ["K","M","B","t"]
	for k, v in UserDetails.details.heroes {
		if (v.owned == 1) {
			TotalChamps += 1
		}
	}
	ChampDetails := ""
	if (UserDetails.details.stats.black_viper_total_gems) {
		ViperGemsValue := UserDetails.details.stats.black_viper_total_gems
		ViperGems := SubStr( "          " Format("{:.2f}",ViperGemsValue / (1000 ** Floor(log(ViperGemsValue)/3))) MagList[Floor(log(ViperGemsValue)/3)], -9)
		ChampDetails := ChampDetails "Black Viper Red Gems: " ViperGems "`n`n"
	}
	if (UserDetails.details.stats.total_paid_up_front_gold) {
		MorgaenGold := SubStr(UserDetails.details.stats.total_paid_up_front_gold, 1, 4)
		ePos := InStr(UserDetails.details.stats.total_paid_up_front_gold, "E")
		MorgaenGold := morgaengold SubStr(UserDetails.details.stats.total_paid_up_front_gold, epos)
		ChampDetails := ChampDetails "M" Chr(244) "rg" Chr(230) "n Gold Collected:   " MorgaenGold "`n`n"
	}
	if (UserDetails.details.stats.torogar_lifetime_zealot_stacks) {
		TorogarStacksValue := UserDetails.details.stats.torogar_lifetime_zealot_stacks
		TorogarStacks := SubStr( "          " Format("{:.2f}",TorogarStacksValue / (1000 ** Floor(log(TorogarStacksValue)/3))) MagList[Floor(log(TorogarStacksValue)/3)], -9)
		ChampDetails := ChampDetails "Torogar Zealot Stacks: " TorogarStacks "`n`n"
	}
	if (UserDetails.details.stats.zorbu_lifelong_hits_humanoid || UserDetails.details.stats.zorbu_lifelong_hits_beast || UserDetails.details.stats.zorbu_lifelong_hits_undead || UserDetails.details.stats.zorbu_lifelong_hits_drow) {
		ZorbuHitsHumanoidValue := UserDetails.details.stats.zorbu_lifelong_hits_humanoid
		ZorbuHitsHumanoid := SubStr( "          " Format("{:.2f}",ZorbuHitsHumanoidValue / (1000 ** Floor(log(ZorbuHitsHumanoidValue)/3))) MagList[Floor(log(ZorbuHitsHumanoidValue)/3)], -9)
		ZorbuHitsBeastValue := UserDetails.details.stats.zorbu_lifelong_hits_beast
		ZorbuHitsBeast := SubStr( "          " Format("{:.2f}",ZorbuHitsBeastValue / (1000 ** Floor(log(ZorbuHitsBeastValue)/3))) MagList[Floor(log(ZorbuHitsBeastValue)/3)], -9)
		ZorbuHitsUndeadValue := UserDetails.details.stats.zorbu_lifelong_hits_undead
		ZorbuHitsUndead := SubStr( "          " Format("{:.2f}",ZorbuHitsUndeadValue / (1000 ** Floor(log(ZorbuHitsUndeadValue)/3))) MagList[Floor(log(ZorbuHitsUndeadValue)/3)], -9)
		ZorbuHitsDrowValue := UserDetails.details.stats.zorbu_lifelong_hits_drow
		ZorbuHitsDrow := SubStr( "          " Format("{:.2f}",ZorbuHitsDrowValue / (1000 ** Floor(log(ZorbuHitsDrowValue)/3))) MagList[Floor(log(ZorbuHitsDrowValue)/3)], -9)
		ChampDetails := ChampDetails "Zorbu Kills:`n - Humanoid: " ZorbuHitsHumanoid "`n - Beast:       " ZorbuHitsBeast "`n - Undead:    " ZorbuHitsUndead "`n - Drow:         " ZorbuHitsDrow "`n`n"
	}
	if (UserDetails.details.stats.dhani_monsters_painted) {
		DhaniPaintValue := UserDetails.details.stats.dhani_monsters_painted
		DhaniPaint := SubStr( "          " Format("{:.2f}",DhaniPaintValue / (1000 ** Floor(log(DhaniPaintValue)/3))) MagList[Floor(log(DhaniPaintValue)/3)], -9)
		ChampDetails := ChampDetails "D'hani Paints: " DhaniPaint "`n`n"
	}

}	

CheckPatronProgress() {
	SB_SetText("⌛ Parsing Data - Patrons... Please wait...")
	if !(MirtVariants == "Locked") {
		if (MirtFPCurrency = "5000") {
			Gui, Font, cGreen
			GuiControl, Font, MirtFPCurrency
		} else {
			Gui, Font, cRed
			GuiControl, Font, MirtFPCurrency
		}
		if (MirtChallenges = "10") {
			Gui, Font, cGreen
			GuiControl, Font, MirtChallenges
		} else {
			Gui, Font, cRed
			GuiControl, Font, MirtChallenges
		}
		if (MirtCompleted = MirtVariantTotal) {
			Gui, Font, cGreen
			GuiControl, Font, MirtVariants
		} else {
			Gui, Font, cRed
			GuiControl, Font, MirtVariants
		}
	}
	if !(VajraVariants == "Locked") {
		if (VajraFPCurrency = "5000") {
			Gui, Font, cGreen
			GuiControl, Font, VajraFPCurrency
		} else {
			Gui, Font, cRed
			GuiControl, Font, VajraFPCurrency
		}
		if (VajraChallenges = "10") {
			Gui, Font, cGreen
			GuiControl, Font, VajraChallenges
		} else {
			Gui, Font, cRed
			GuiControl, Font, VajraChallenges
		}
		if (VajraCompleted = VajraVariantTotal) {
			Gui, Font, cGreen
			GuiControl, Font, VajraVariants
		} else {
			Gui, Font, cRed
			GuiControl, Font, VajraVariants
		}
	}
	if !(StrahdVariants == "Locked") {
		if (StrahdChallenges = "10") {
			Gui, Font, cGreen
			GuiControl, Font, StrahdChallenges
		} else {
			Gui, Font, cRed
			GuiControl, Font, StrahdChallenges
		}
		if (StrahdFPCurrency = "5000") {
			Gui, Font, cGreen
			GuiControl, Font, StrahdFPCurrency
		} else {
			Gui, Font, cRed
			GuiControl, Font, StrahdFPCurrency
		}
		if (StrahdCompleted = StrahdVariantTotal) {
			Gui, Font, cGreen
			GuiControl, Font, StrahdVariants
		} else {
			Gui, Font, cRed
			GuiControl, Font, StrahdVariants
		}
	}
	if !(ZarielVariants == "Locked") {
		if (ZarielChallenges = "10") {
			Gui, Font, cGreen
			GuiControl, Font, ZarielChallenges
		} else {
			Gui, Font, cRed
			GuiControl, Font, ZarielChallenges
		}
		if (ZarielFPCurrency = "5000") {
			Gui, Font, cGreen
			GuiControl, Font, ZarielFPCurrency
		} else {
			Gui, Font, cRed
			GuiControl, Font, ZarielFPCurrency
		}
		if (ZarielCompleted = ZarielVariantTotal) {
			Gui, Font, cGreen
			GuiControl, Font, ZarielVariants
		} else {
			Gui, Font, cRed
			GuiControl, Font, ZarielVariants
		}
	}
}

CheckAchievements() {
	SB_SetText("⌛ Parsing Data - Achievements... Please wait...")
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
	SB_SetText("⌛ Parsing Data - Blessings... Please wait...")

	epiccount := ""
	epicvalue := Round((1.02 ** EpicGearCount), 2)
	if (UserDetails.details.reset_upgrade_levels.44) { ;Helm-Slow and Steady (X Epics)
		epiccount := "Slow and Steady:`n x" epicvalue " damage (" EpicGearCount " epics)`n"
	}

	championcount := ""
	championvalue := Round((1.02 ** ChampionsUnlockedCount), 2)
	if (UserDetails.details.reset_upgrade_levels.72) { ;Helm-Familiar Faces (X Champions)
		championcount := "Familiar Faces:`n x" championvalue " damage (" ChampionsUnlockedCount " champions)`n"
	}

	championactivecount := ""
	championactivevalue := Round((1.02 ** ChampionsActiveCount), 2)
	if (UserDetails.details.reset_upgrade_levels.76) { ;Helm-Splitting the Party (X Champions)
		championactivecount := "Splitting the Party:`n x" championactivevalue " damage (" ChampionsActiveCount " active champions)`n"
	}

	veterancount := ""
	veteranvalue := Round(1 + (0.1 * UserDetails.details.stats.completed_adventures_variants_and_patron_variants_c22), 2)
	if (UserDetails.details.reset_upgrade_levels.56) { ;Tiamat-Veterans of Avernus (X Adventures)
		veterancount := "Veterans of Avernus:`n x" veteranvalue " damage (" UserDetails.details.stats.completed_adventures_variants_and_patron_variants_c22 " adventures)`n"
	}

	costumecount := ""
	costumevalue := Round((1.20 ** CostumesUnlockedCount), 2)
	if (UserDetails.details.reset_upgrade_levels.88) { ;Auril-Costume Party (X Skins)
		costumecount := "Costume Party:`n x" costumevalue " damage (" CostumesUnlockedCount " skins)`n"
	}

	familiarcount := ""
	familiarvalue := Round((1.20 ** FamiliarsUnlockedCount), 2)
	if (UserDetails.details.reset_upgrade_levels.108) { ;Corellon-Familiar Stakes (X Familiars)
		familiarcount := "Familiar Stakes:`n x" familiarvalue " damage (" FamiliarsUnlockedCount " familiars)`n"
	}

	BlessingInfo := "Blessing Details`n`n" epiccount championcount championactivecount veterancount costumecount familiarcount
	if (BlessingInfo == "Blessing Details`n`n") {
		BlessingInfo := "Blessing Details: N/A"
	}
}

CheckEvents() {
	SB_SetText("⌛ Parsing Data - Events... Please wait...")
	EventNextID := UserDetails.details.next_event
	EventID := 0
	EventName := "N/A"
	EventDesc := "No Event currently in Progress"
	EventTokenName := "Tokens"
	EventTokens := 0
	EventHeroIDs := ""
	EventHeros := "N/A"
	EventChestIDs := ""
	EventChests := "N/A"
	for k, v in UserDetails.details.event_details {
		if (v.event_id == EventNextID && v.active = "1") {
			EventID := EventNextID
			EventName := v.name
			EventDesc := v.description
			EventTokenName := v.details.event_token.name_plural
			EventTokens := v.user_data.event_tokens
			EventHeroCount := 0
			EventHeroIDs := ""
			EventHeroes := ""
			EventChestCount := 0
			EventChestIDs := ""
			EventChests := ""
			for l, w in v.details.years {
				for m, x in w.hero_ids {
					if (EventHeroCount > 0) {
						EventHeroIDs .= ","
						EventHeroes .= ", "
					}
					EventHeroIDs .= x
					EventHeroes .= ChampFromID(x) " (" x ")"
					EventHeroCount += 1
				}
				for m, x in w.chest_ids {
					if (EventChestCount > 0) {
						EventChestIDs .= ","
						EventChests .= ", "
					}
					EventChestIDs .= x
					EventChests .= ChestFromID(x) " (" x ")"
					EventChestCount += 1
				}
			}
		}
	}
	if (EventID != 0) {
		InfoEventName := EventName " (ID:" EventID ")`n" EventDesc "`n`n"
	} else {
		InfoEventName := EventDesc "`n`n"
	}
	InfoEventTokens := EventTokenName ": " EventTokens "`n`n"
	InfoEventHeroes := "Heroes: " EventHeroes "`n`n"
	InfoEventChests := "Chests: " EventChests "`n`n"
	EventDetails := InfoEventName InfoEventTokens InfoEventHeroes InfoEventChests
}

CheckServerCallError(data) {
	FoundPos1 := InStr(data, "Error connecting:", 0, -1, 1)
	if(FoundPos1 != 0){
		data1 := SubStr(data, (FoundPos1 + 17))
		FoundPos1 := InStr(data1, "<br/>")
		sServerError := ""
		StringLeft, sServerError, data1, (FoundPos1 - 1)
		; MsgBox, % "Server Error: " sServerError
		ServerError := sServerError
		return false
	}
	return true
}

ServerCall(callname, parameters, newservername = "") {
	If (newservername = "") {
		playservername := ServerName
	} else {
		playservername := newservername
	}
	; SB_SetText("⌛ Contacting API Server (" playservername ")... '" callname "'... Please wait...")
	URLtoCall := "http://" playservername ".idlechampions.com/~idledragons/post.php?call=" callname parameters
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
	LogFile("API Call (" playservername "): " callname)
	if( !CheckServerCallError(data) ) {
		return
	}
	return data
}

ServerCallNew(callname, parameters, newservername = "") {
	If (newservername = "") {
		playservername := ServerName
	} else {
		playservername := newservername
	}
	; SB_SetText("⌛ Contacting API Server (" ServerName ")... '" callname "'... Please wait...")
	URLtoCall := "http://" ServerName ".idlechampions.com/~idledragons/post.php?call=" callname parameters
	WR := ComObjCreate("Msxml2.XMLHTTP.6.0")
	Try {
		WR.Open("GET", URLtoCall, false)
		WR.Send()
		data := WR.ResponseText
		WR.Close()
	}
	LogFile("API Call (" ServerName "): " callname)
	if( !CheckServerCallError(data) ) {
		return
	}
	return data
}

ServerCallAlt(callname, parameters, newservername = "") {
	If (newservername = "") {
		playservername := ServerName
	} else {
		playservername := newservername
	}
	; SB_SetText("⌛ Contacting API Server (" ServerName ")... '" callname "'... Please wait...")
	URLtoCall := "http://" ServerName ".idlechampions.com/~idledragons/post.php?call=" callname parameters
	URLDownloadToFile, %URLtoCall%, %UserDetailsFile%
	FileRead, data, %UserDetailsFile%
	LogFile("API Call (" ServerName "): " callname)
	if( !CheckServerCallError(data) ) {
		return
	}
	return data
}

LaunchGame() {
	if( GamePlatform == "Standalone Launcher") {
		if (Not WinExist("ahk_exe IdleDragonsLauncher.exe")) {
			Run, %GameClient%, %GameInstallDir%
			SB_SetText("⌛ Game Launcher starting...")
			WinWait, Idle Champions
			LogFile("Game Launcher Launched")
			SB_SetText("✅ Game Launcher has started!")
		} else {
			SB_SetText("✅ Game Launcher is already running!")
		}
		return
	}
	if (Not WinExist("ahk_exe IdleDragons.exe")) {
		Run, %GameClient%, %GameInstallDir%
		SB_SetText("⌛ Game Client starting...")
		WinWait, Idle Champions
		LogFile("Game Client Launched")
		SB_SetText("✅ Game Client has started!")
	} else {
		SB_SetText("✅ Game Client is already running!")
	}
	return
}

Get_Journal:
	{
		if !UserID {
			MsgBox % "Need User ID & Hash"
			FirstRun()
		}
		if (InstanceID = 0) {
			MsgBox, 4, , No Instance ID detected. Check server for user details?
				IfMsgBox, Yes
				{
					GetUserDetails()
				} else {
					return
				}
		}
		journalparams := "&user_id=" UserID "&hash=" UserHash "&instance_id=" InstanceID "&page="
		InputBox, pagecount, Journal, % "How many pages of Journal to retreive?`n`n(This will overwrite any previous download.)", , 350, 180
		if ErrorLevel
			return
		pagenum := 1
		FileDelete, %JournalFile%
		while !(pagenum > pagecount) {
			SB_SetText("⌛ Journal pages remaining to download: " ((pagecount - pagenum) + 1))
			rawresults := ServerCall("getPlayHistory", journalparams pagenum)
			FileAppend, %rawresults%`n, %JournalFile%
			pagenum += 1
			sleep 1000
		}
		LogFile("Journal pages downloaded: " (pagenum - 1))
		SB_SetText("✅ Journal download completed")
		return
	}

Open_Ticket:
	{
		if (GamePlatform = "Steam"){
			Run, % "https://help.idlechampions.com/?page=help&steam_user_id=" UserIDSteam "&steam_hash=" GameHashSteam "&user_id=" UserID
		} else if (GamePlatform = "Epic Game Store") {
			Run, % "https://help.idlechampions.com/?page=help&network=epicgames&epic_games_user_id=" UserIDEpic "&epic_games_hash=" GameHashEpic "&language_id=1&user_id=" UserIDEpic
		}
		return
	}

Discord_Clicked:
	{
		Run, % WebToolDiscord
		return
	}

Github_Clicked:
	{
		Run, % WebToolGithub
		return
	}

Update_Dictionary() {
	if !(DictionaryVersion == CurrentDictionary) {
		FileDelete, %LocalDictionary%
		UrlDownloadToFile, %DictionaryFile%, %LocalDictionary%
		Reload
		return
	} else {
		MsgBox % "Dictionary file up to date"
	}
	return
}

List_UserDetails:
	{
		userdetailslist := "Game Platform: " GamePlatform "`n"
		userdetailslist := userdetailslist "User ID: " UserID "`n"
		userdetailslist := userdetailslist "User Hash: " UserHash "`n"
		if UserIDEpic {
			userdetailslist := userdetailslist "Epic Games User ID: " UserIDEpic "`n"
		}
		if UserIDSteam {
			userdetailslist := userdetailslist "Steam User ID: " UserIDSteam "`n"
		}
		;MsgBox, , User Details, % userdetailslist
		;CustomMsgBox("User Details", userdetailslist, "Consolas", "s14", %BgColour%)
		ScrollBox(userdetailslist, "p b1 h100 w700 f{s14, Consolas}", "User Details")
		return	
	}

List_ChampIDs:
	{
		champnamelen := 0
		champname := ""
		id := 1
		champidlist := ""
		while (id < 155) {
			champname := ChampFromID(id)
			StringLen, champnamelen, champname
			while (champnamelen < 25) {
				champname := champname " "
				champnamelen += 1
			}
			if (!mod(id, 3)) {
				champidlist := champidlist id ": " champname "`n"
			} else {
				champidlist := champidlist id ": " champname "`t"
			}
			id += 1
		}
		;MsgBox, , Champ ID List, % champidlist
		;CustomMsgBox("Champion IDs and Names", champidlist, "Consolas", "s14", %BgColour%)
		ScrollBox(champidlist, "p b1 h700 w1000 f{s14, Consolas}", "Champion IDs and Names")
		return	
	}


List_ChestIDs:
	{
		chestnamelen := 0
		chestname := ""
		id := 1
		chestidlist := ""
		while (id < 586) {
			chestname := ChestFromID(id)
			StringLen, chestnamelen, chestname
			while (chestnamelen < 40) {
				chestname := chestname " "
				chestnamelen += 1
			}
			if (!mod(id, 2)) {
				chestidlist := chestidlist id ": " chestname "`n"
			} else {
				chestidlist := chestidlist id ": " chestname "`t"
			}
			id += 1
		}
		;MsgBox, , Chest ID List, % chestidlist
		;CustomMsgBox("Chest IDs and Names", chestidlist, "Consolas", "s14", %BgColour%)
		ScrollBox(chestidlist, "p b1 h700 w1000 f{s14, Consolas}", "Chest IDs and Names")
		return	
	}

CustomMsgBox(Title, Message, Font="", FontOptions="", WindowColor="")
{
	Gui,66:Destroy
	Gui,66:Color,%WindowColor%

	Gui,66:Font,%FontOptions%,%Font%
	Gui,66:Add,Edit,ReadOnly,%Message%
	Gui,66:Font

	GuiControlGet,Edit,66:Pos,Static1

	Gui,66:Add,Button,% "Default y+10 w75 g66OK xp+" (TextW / 2) - 38,OK

	;Gui,66:+ToolWindow
	Gui,66:-MinimizeBox
	Gui,66:-MaximizeBox

	SoundPlay,*-1
	Gui,66:Show,,%Title%
	ControlFocus,OK,%Title%

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
		} else {
			newicsettings := newicsettings """" k """:" v ","
		}
	}
	StringTrimRight, newicsettings, newicsettings, 1
	newicsettings := "{" newicsettings "}"
	MsgBox % newicsettings
	FileDelete, %ICSettingsFile%
	FileAppend, %newicsettings%, %ICSettingsFile%
	LogFile("UI Scale changed to " newuiscale)
	SB_SetText("✅ UI Scale changed to " newuiscale)
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
		} else {
			newicsettings := newicsettings """" k """:" v ","
		}
	}
	StringTrimRight, newicsettings, newicsettings, 1
	newicsettings := "{" newicsettings "}"
	MsgBox % newicsettings
	FileDelete, %ICSettingsFile%
	FileAppend, %newicsettings%, %ICSettingsFile%
	LogFile("Framerate changed to " newframerate)
	SB_SetText("✅ Framerate changed to " newframerate)
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
		} else {
			newicsettings := newicsettings """" k """:" v ","
		}
	}
	StringTrimRight, newicsettings, newicsettings, 1
	newicsettings := "{" newicsettings "}"
	MsgBox % newicsettings
	FileDelete, %ICSettingsFile%
	FileAppend, %newicsettings%, %ICSettingsFile%
	LogFile("Paticles changed to " newparticles)
	SB_SetText("✅ Particles changed to " newparticles)
}

SimulateBriv(i) {
	SB_SetText("⌛ Calculating...")
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
	if (skipLevels < 3) {
		trueChance := Round(trueChance * 100, 2)
	} else {
		trueChance := Round(chance * 100, 2)
	}
	avgSkips := Round(totalSkips / i, 2)
	avgSkipped := Round(avgSkips * skipLevels, 2)
	avgZones := Round(totalLevels / i, 2)
	avgSkipRate := Round((avgSkipped / avgZones) * 100, 2)
	avgStacks := Round((1.032**avgSkips) * 48, 2)
	multiplier := 0.1346894362, additve := 41.86396406
	roughTime := Round(((multiplier * avgStacks) + additve), 2)
	message = With Briv skip %skipLevels% until zone %BrivZone%`n(%trueChance%`% chance to skip %skipLevels% zones)`n`n%i% simulations produced an average:`n%avgSkips% skips (%avgSkipped% zones skipped)`n%avgZones% end zone`n%avgSkipRate%`% true skip rate`n%avgStacks% required stacks with`n%roughTime% time in secs to build said stacks very rough guess
	SB_SetText("✅ Calculation has completed")
	Return message
}

KlehoImage() {
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
	} else if !((campaignid < 3) or (campaignid == 15) or (campaignid > 21)) {
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
				} else {
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

IncompleteVariants() {
	if !FileExist("advdefs.json") {
		MsgBox % "Downloading adventure defines"
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
	} else {
		IncompletePatron(idtocheck)
	}
	return
}

IncompleteBase() {
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

IncompletePatron(patronid) {
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
	MsgBox % "advdefs.json saved to file"
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
			} else {
				currentchamplevel += (v.enchant + 1)
				currentcount += 1
			}
		} else if ((lastchamp = 13) or (lastchamp = 18) or (lastchamp = 30) or (lastchamp = 67) or (lastchamp = 68) or (lastchamp = 86) or (lastchamp = 87) or (lastchamp = 88) or (lastchamp = 106)){
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
			} else {
				currentchamplevel += (v.enchant + 1)
				currentcount += 1
			}
		} else {
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
			} else {
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
	pityjsonoutput := "{"
	jsoncount := 0
	for k, v in (UserDetails.details.stats) {
		if (InStr(k,"forced_win_counter_")) {
			if (jsoncount > 0) {
				pityjsonoutput := pityjsonoutput ","
			}
			jsoncount += 1
			pityjsonoutput := pityjsonoutput """" k """:""" v """"
		}
	}
	pityjsonoutput := pityjsonoutput "}"
	pityjson := JSON.parse( pityjsonoutput )
	pityjsonoutput := "" ; Free Memory
	newestchamp := JSON.stringify(UserDetails.details.heroes[UserDetails.details.heroes.MaxIndex()].hero_id)
	newestchamp := StrReplace(newestchamp, """")
	chestsforepic := 1
	while (chestsforepic < 11) {
		if (chestsforepic == 1) {
			pitylist := pitylist "Epic in Next Chest for:`n"
		} else {
			pitylist := pitylist "`nEpic in next " chestsforepic " Chests for:`n"
		}
		currentchamp := 14
		currentcount := 0
		currentchest := 0
		currentpity := ""
		while (currentchamp < newestchamp) {
			currentchest := "forced_win_counter_" ChestIDFromChampID(currentchamp)
			for k, v in (pityjson) {
				if (k = currentchest) {
					currentpity := v
				}
			}
			if (currentpity = chestsforepic) {
				tempchamp := ChampFromID(currentchamp)
				if not InStr(tempchamp, "UNKNOWN") {
					pitylist := pitylist tempchamp ", "
				}
				tempchamp := ""
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
		} else {
			StringTrimRight, pitylist, pitylist, 2
			pitylist := pitylist "`n"
		}
		chestsforepic += 1
	}
	ScrollBox(pitylist, "p b1 h450 w700 f{s10, Consolas}", "Pity Timers")
	; MsgBox % pitylist
	return
}

getChestCodes() {
	clipContents := clipboard
	;regexpPattern := "P)\b(?<![A-Za-z0-9-/@#$`%^&!*])([A-Za-z0-9-@#$`%^&!*]{12,20})(?![A-Za-z0-9-/@#$`%^&!*])" ;Original
	regexpPattern := "P)(?<![A-Za-z0-9-\/@#$`%^&!*_=+\(\)\{\}\[\]])([A-Za-z0-9-@#$%^&!*]{12,20})(?![A-Za-z0-9-\/@#$`%^&!*_=+\(\)\{\}\[\]])"
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
		;Gui, +ToolWindow +MinSize200x200 +Resize
		Gui, +MinSize200x200 +Resize
		;Gui, Color, FFFFFF
		Gui, Color, %BgColour%
		Opt := "hwndGui_Hwnd ReadOnly -E0x200 "
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
				ButtonX := EditWidth / 2 - Adjust1
				ButtonY := EditHeight + 20 + (Adjust1/6) 
				GuiControl, Move, %Resize_Gui_Hwnd%, W%EditWidth% H%EditHeight%
				GuiControl, Move, %ScrollBox_Button1_Hwnd%, X%ButtonX% Y%ButtonY%
			}
			else
			{
				EditWidth := A_GuiWidth - 20
				EditHeight := A_GuiHeight - 20 - (Adjust1 * 3)
				Button1X := EditWidth / 4 - (Adjust1 * 2)
				Button2X := 3 * EditWidth / 4 - (Adjust1 * 1.5)
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