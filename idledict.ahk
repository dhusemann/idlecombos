global DictionaryVersion := "2.22"

PatronFromID(patronid) {
	switch patronid {
		case "0": namefromid := "None"
		case "1": namefromid := "Mirt"
		case "2": namefromid := "Vajra"
		case "3": namefromid := "Strahd"
		case "4": namefromid := "Zariel"
	}
	return namefromid
}

campaignFromID(campaignid) {
	switch campaignid {
		case "1": namefromid := "Grand Tour of the Sword Coast"
		case "2": namefromid := "Tomb of Annihilation"
		case "15": namefromid := "Waterdeep: Dragon Heist"
		case "22": namefromid := "Baldur's Gate: Descent into Avernus"
		case "24": namefromid := "Icewind Dale: Rime of the Frostmaiden"
		case "23": namefromid := "Special"
		case "17": namefromid := "Time Gates"
		case "3": namefromid := "Highharvestide"
		case "4": namefromid := "Liars' Night"
		case "5": namefromid := "Feast of the Moon"
		case "6": namefromid := "Simril"
		case "7": namefromid := "Wintershield"
		case "8": namefromid := "Midwinter"
		case "9": namefromid := "Grand Revel"
		case "10": namefromid := "Fleetswake"
		case "11": namefromid := "Festival of Fools"
		case "12": namefromid := "Greengrass"
		case "13": namefromid := "The Running"
		case "14": namefromid := "The Great Modron March"
		case "16": namefromid := "Dragondown"
		case "18": namefromid := "Founders' Day"
		case "19": namefromid := "Midsummer"
		case "20": namefromid := "Ahghairon's Day"
		case "21": namefromid := "Brightswords"
		default: namefromid := "Error: " campaignid
	}
	return namefromid
}

ChampFromID(id) {
	if (id < 21) {
		switch id {
			case "1": namefromid := "Bruenor"
			case "2": namefromid := "Celeste"
			case "3": namefromid := "Nayeli"
			case "4": namefromid := "Jarlaxle"
			case "5": namefromid := "Calliope"
			case "6": namefromid := "Asharra"
			case "7": namefromid := "Minsc"
			case "8": namefromid := "Delina"
			case "9": namefromid := "Makos"
			case "10": namefromid := "Tyril"
			case "11": namefromid := "Jamilah"
			case "12": namefromid := "Arkhan"
			case "13": namefromid := "Hitch"
			case "14": namefromid := "Stoki"
			case "15": namefromid := "Krond"
			case "16": namefromid := "Gromma"
			case "17": namefromid := "Dhadius"
			case "18": namefromid := "Drizzt"
			case "19": namefromid := "Barrowin"
			case "20": namefromid := "Regis"
		}
	}
	else if (id < 41) {
		switch id {
			case "21": namefromid := "Birdsong"
			case "22": namefromid := "Zorbu"
			case "23": namefromid := "Strix"
			case "24": namefromid := "Nrakk"
			case "25": namefromid := "Catti-brie"
			case "26": namefromid := "Evelyn"
			case "27": namefromid := "Binwin"
			case "28": namefromid := "Deekin"
			case "29": namefromid := "Xander"
			case "30": namefromid := "Azaka"
			case "31": namefromid := "Ishi"
			case "32": namefromid := "Wulfgar"
			case "33": namefromid := "Farideh"
			case "34": namefromid := "Donaar"
			case "35": namefromid := "Vlahnya"
			case "36": namefromid := "Warden"
			case "37": namefromid := "Nerys"
			case "38": namefromid := "K'thriss"
			case "39": namefromid := "Paultin"
			case "40": namefromid := "Black Viper"
		}
	}
	else if (id < 61) {
		switch id {
			case "41": namefromid := "Rosie"
			case "42": namefromid := "Aila"
			case "43": namefromid := "Spurt"
			case "44": namefromid := "Qillek"
			case "45": namefromid := "Korth"
			case "46": namefromid := "Walnut"
			case "47": namefromid := "Shandie"
			case "48": namefromid := "Jim"
			case "49": namefromid := "Turiel"
			case "50": namefromid := "Pwent"
			case "51": namefromid := "Avren"
			case "52": namefromid := "Sentry"
			case "53": namefromid := "Krull"
			case "54": namefromid := "Artemis"
			case "55": namefromid := "M" Chr(244) "rg" Chr(230) "n"
			case "56": namefromid := "Havilar"
			case "57": namefromid := "Sisaspia"
			case "58": namefromid := "Briv"
			case "59": namefromid := "Melf"
			case "60": namefromid := "Krydle"
		}
	}
	else if (id < 81) {
		switch id {
			case "61": namefromid := "Jaheira"
			case "62": namefromid := "Nova"
			case "63": namefromid := "Freely"
			case "64": namefromid := "Beadle & Grimm"
			case "65": namefromid := "Omin"
			case "66": namefromid := "Lazaapz"
			case "67": namefromid := "Dragonbait"
			case "68": namefromid := "Ulkoria"
			case "69": namefromid := "Torogar"
			case "70": namefromid := "Ezmerelda"
			case "71": namefromid := "Penelope"
			case "72": namefromid := "Lucius"
			case "73": namefromid := "Baeloth"
			case "74": namefromid := "Talin"
			case "75": namefromid := "Hew Maan"
			case "76": namefromid := "Orisha"
			case "77": namefromid := "Alyndra"
			case "78": namefromid := "Orkira"
			case "79": namefromid := "Shaka"
			case "80": namefromid := "Mehen"
		}
	}
	else if (id < 101) {
		switch id {
			case "81": namefromid := "Selise"
			case "82": namefromid := "Sgt Knox"
			case "83": namefromid := "Ellywick"
			case "84": namefromid := "Prudence"
			case "85": namefromid := "Corazon"
			case "86": namefromid := "Reya"
			case "87": namefromid := "NERDS"
			case "88": namefromid := "Xerophon"
			case "89": namefromid := "D'hani"
			case "90": namefromid := "Brig"
			case "91": namefromid := "Widdle"
			case "92": namefromid := "Yorven"
			case "93": namefromid := "Viconia"
			case "94": namefromid := "Rust"
			case "95": namefromid := "Vi"
			case "96": namefromid := "Desmond"
			case "97": namefromid := "Tatyana"
			case "98": namefromid := "Gazrick"
			case "99": namefromid := "Dungeon Master"
			case "100": namefromid := "Nordom"
		}
	}
	else if (id < 111) {
		switch id {
			case "101": namefromid := "Merilwen"
			case "102": namefromid := "Nahara"
			case "103": namefromid := "Valentine"
			case "104": namefromid := "Voronika"
			case "105": namefromid := "Dob"
			case "106": namefromid := "Blooshi"
			case "107": namefromid := "UNKNOWN (" id ")"
			case "108": namefromid := "UNKNOWN (" id ")"
			case "109": namefromid := "UNKNOWN (" id ")"
			case "110": namefromid := "UNKNOWN (" id ")"
		}
	}
	else if (id < 121) {
		switch id {
			case "111": namefromid := "UNKNOWN (" id ")"
			case "112": namefromid := "UNKNOWN (" id ")"
			case "113": namefromid := "Egbert"
			case "114": namefromid := "Kent"
			case "115": namefromid := "UNKNOWN (" id ")"
			case "116": namefromid := "UNKNOWN (" id ")"
			case "117": namefromid := "UNKNOWN (" id ")"
			case "118": namefromid := "UNKNOWN (" id ")"
			case "119": namefromid := "UNKNOWN (" id ")"
			case "120": namefromid := "UNKNOWN (" id ")"
		}
	}
	else {
		namefromid := "UNKNOWN (" id ")"
	}
	return namefromid
}

FeatFromID(id) {
	if (id < 83) {
		switch id {
			case "3": namefromid := "Bruenor (Rally +40%)"
			case "6": namefromid := "Bruenor (CHA +1)"
			case "9": namefromid := "Celeste (Global DPS +25%)"
			case "12": namefromid := "Celeste (Mass Cure Wounds +30%)"
			case "19": namefromid := "Nayeli (Overwhelm point +10)"
			case "24": namefromid := "Jarlaxle (CHA +1)"
			case "26": namefromid := "Calliope (Global DPS +25%)"
			case "34": namefromid := "Asharra (CHA +1)"
			case "36": namefromid := "Minsc (Self DPS +60%)"
			case "44": namefromid := "Delina (Surge of Power +40%)"
			case "45": namefromid := "Delina (WIS +1)"
			case "51": namefromid := "Makos (Gold +25%)"
			case "53": namefromid := "Tyril (Global DPS +25%)"
			case "59": namefromid := "Tyril (Overwhelm point +10)"
			case "61": namefromid := "Jamilah (Self DPS +60%)"
			case "63": namefromid := "Jamilah (DEX +1)"
			case "68": namefromid := "Arkhan (Self DPS +60%)"
			case "71": namefromid := "Arkhan (DEX +1)"
			case "77": namefromid := "Hitch (Global DPS +25%)"
			case "82": namefromid := "Stoki (Gold +25%)"
		}
	}
	else if (id < 171) {
		switch id {
			case "87": namefromid := "Krond (Global DPS +25%)"
			case "89": namefromid := "Krond (WIS +1)"
			case "95": namefromid := "Gromma (Health +30%)"
			case "98": namefromid := "Dhadius (Self DPS +60%)"
			case "105": namefromid := "Drizzt (Gold +25%)"
			case "106": namefromid := "Drizzt (Companions of the Hall +40%)"
			case "112": namefromid := "Barrowin (Blessed Hammer +40%)"
			case "114": namefromid := "Regis (Global DPS +25%)"
			case "119": namefromid := "Birdsong (Self DPS +60%)"
			case "128": namefromid := "Zorbu (Hunter's Pack +40%)"
			case "132": namefromid := "Strix (Global DPS +25%)"
			case "135": namefromid := "Nrakk (Self DPS +60%)"
			case "143": namefromid := "Catti-brie (Death March +40%)"
			case "144": namefromid := "Catti-brie (CHA +1)"
			case "148": namefromid := "Evelyn (Health +30%)"
			case "150": namefromid := "Evelyn (Overwhelm point +10)"
			case "154": namefromid := "Binwin (Tallest in Faerûn +40%)"
			case "158": namefromid := "Deekin (Global DPS +25%)"
			case "164": namefromid := "Xander (Streetwise +40%)"
			case "170": namefromid := "Azaka (Gold +25%)"
		}
	}
	else if (id < 255) {
		switch id {
			case "172": namefromid := "Ishi (Self DPS +60%)"
			case "181": namefromid := "Wulfgar (Health +30%)"
			case "184": namefromid := "Farideh (Self DPS +60%)"
			case "191": namefromid := "Donaar (Aura of Vitality +30%)"
			case "193": namefromid := "Zorbu (INT +1)"
			case "195": namefromid := "Vlahnya (Global DPS +25%)"
			case "198": namefromid := "Vlahnya (DEX +1)"
			case "203": namefromid := "Warden (CON +1)"
			case "207": namefromid := "Nerys (War Healing +30%)"
			case "210": namefromid := "K'thriss (Global DPS +25%)"
			case "218": namefromid := "Paultin (WIS +1)"
			case "220": namefromid := "Black Viper (Self DPS +60%)"
			case "229": namefromid := "Rosie (INT +1)"
			case "231": namefromid := "Aila (Global DPS +25%)"
			case "236": namefromid := "Aila (Overwhelm point +10)"
			case "241": namefromid := "Spurt (CON +1)"
			case "243": namefromid := "Qillek (Global DPS +25%)"
			case "248": namefromid := "Korth (Global DPS +25%)"
			case "251": namefromid := "Korth (Calculated +40%)"
			case "254": namefromid := "Walnut (Global DPS +25%)"
		}
	}
	else if (id < 340) {
		switch id {
			case "262": namefromid := "Shandie (WIS +1)"
			case "263": namefromid := "Shandie (CHA +1)"
			case "265": namefromid := "Jim (Self DPS +60%)"
			case "269": namefromid := "Spurt (Pack Tactics +40%)"
			case "284": namefromid := "Turiel (Gold +25%)"
			case "288": namefromid := "Pwent (Global DPS +25%)"
			case "295": namefromid := "Avren (Mirror Image +40%)"
			case "296": namefromid := "Avren (Seeing Double +40%)"
			case "300": namefromid := "Sentry (Global DPS +25%)"
			case "302": namefromid := "Sentry (Health +30%)"
			case "308": namefromid := "Krull (Global DPS +25%)"
			case "309": namefromid := "Krull (Gold +25%)"
			case "316": namefromid := "Krull (Virulent Strain +100%)"
			case "320": namefromid := "Artemis (Gold +25%)"
			case "322": namefromid := "Artemis (Jeweled Power +40%)"
			case "326": namefromid := "Dragonbait (Health +30%)"
			case "329": namefromid := "Dragonbait (Overwhelm point +10)"
			case "333": namefromid := "M" Chr(244) "rg" Chr(230) "n (Paid Up Front +40%)"
			case "336": namefromid := "Havilar (Global DPS +25%)"
			case "339": namefromid := "Havilar (Leadership Summit +40%)"
		}
	}
	else if (id < 406) {
		switch id {
			case "342": namefromid := "Sisaspia (Global DPS +25%)"
			case "345": namefromid := "Sisaspia (Halo of Spores +40%)"
			case "351": namefromid := "Briv (Health +30%)"
			case "354": namefromid := "Briv (Overwhelm point +10)"
			case "355": namefromid := "Deekin (Confidence in the Boss +40%)"
			case "356": namefromid := "Birdsong (Tempo of Victory +40%)"
			case "357": namefromid := "Barrowin (Base Attack Cooldown -0.5s)"
			case "358": namefromid := "Hitch (Chance of Daggers Ricocheting +40%)"
			case "366": namefromid := "Melf (Melf's Adaptive Support Spell +40%)"
			case "367": namefromid := "Melf (Melf's Speedy Supplement +40%)"
			case "374": namefromid := "Krydle (Global DPS +25%)"
			case "376": namefromid := "Krydle (Charismatic Leader +40%)"
			case "380": namefromid := "Freely (Gold +25%)"
			case "381": namefromid := "Freely (Luck of Yondalla Requisition +40%)"
			case "385": namefromid := "Jaheira (Self DPS +60%)"
			case "388": namefromid := "Jaheira (Class Warfare +40%)"
			case "392": namefromid := "Beadle & Grimm (Global DPS +25%)"
			case "395": namefromid := "Beadle & Grimm (Get Buff +40%)"
			case "397": namefromid := "Beadle & Grimm (Long Rest +40%)"
			case "405": namefromid := "Nova (Global DPS +25%)"
		}
	}
	else if (id < 483) {
		switch id {
			case "410": namefromid := "Nova (Close Encounter +40%)"
			case "412": namefromid := "Omin (Global DPS +25%)"
			case "413": namefromid := "Omin (Gold +25%)"
			case "416": namefromid := "Omin (Contractual Obligations Gold Find +40%)"
			case "418": namefromid := "Ulkoria (Global DPS +25%)"
			case "421": namefromid := "Ulkoria (Watchful Order +40%)"
			case "422": namefromid := "Ulkoria (Watchful Order +40%)"
			case "426": namefromid := "Lazaapz (Global DPS +25%)"
			case "428": namefromid := "Lazaapz (Health +30%)"
			case "446": namefromid := "Torogar (Dark Order Synergy +40%)"
			case "448": namefromid := "Ezmerelda (Global DPS +25%)"
			case "450": namefromid := "Ezmerelda (Training Montage +40%)"
			case "454": namefromid := "Penelope (Global DPS +25%)"
			case "457": namefromid := "Penelope (Chwinga Mask +40%)"
			case "465": namefromid := "Lucius (Self DPS +60%)"
			case "467": namefromid := "Lucius (Arcane Chromat - Acid +40%)"
			case "471": namefromid := "Baeloth (Global DPS +25%)"
			case "473": namefromid := "Baeloth (Gold +25%)"
			case "477": namefromid := "Baeloth (Morbid Excitement +40%)"
			case "482": namefromid := "Talin (Global DPS +25%)"
		}
	}
	else if (id < 562) {
		switch id {
			case "485": namefromid := "Talin (Quick-Release Hook)"
			case "488": namefromid := "Hew Maan (Global DPS +25%)"
			case "490": namefromid := "Hew Maan (Hello, Fellow Humans +40%)"
			case "501": namefromid := "Orisha (Flaming Wings +40%)"
			case "503": namefromid := "Orisha (Bardic Connection +40%)"
			case "505": namefromid := "Orisha (Encore Performance)"
			case "511": namefromid := "Alyndra (Portent +40%)"
			case "513": namefromid := "Alyndra (Brows of Judgement +40%)"
			case "520": namefromid := "Reya (Searing Radiance +40%)"
			case "522": namefromid := "Reya (Echoes of Zariel +40%)"
			case "532": namefromid := "Orkira (Elemental Fire +40%)"
			case "533": namefromid := "Orkira (Healing Flame +25%)"
			case "539": namefromid := "Shaka (A Celestial Puzzle +40%)"
			case "539": namefromid := "Shaka (Celestial Resistance +30%)"
			case "550": namefromid := "Mehen (Gold +25%)"
			case "551": namefromid := "Mehen (Exiled +40%)"
			case "552": namefromid := "Mehen (Brimstone Angels +40%)"
			case "557": namefromid := "Selise (Shield of Psychomancy +40%)"
			case "560": namefromid := "Selise (Relentless Avenger +50%)"
			case "561": namefromid := "Selise (Eyes of Tiwaz)"			
		}

	}
	else if (id < 668) {
		switch id {
			case "565": namefromid := "Sgt Knox (Health +30%)"
			case "567": namefromid := "Sgt Knox (Rallying Cry +40%)"
			case "574": namefromid := "Ellywick (Powerful Following +40%)"
			case "576": namefromid := "Ellywick (Fortunate Soul +40%)"
			case "588": namefromid := "Prudence (Glee +40%)"
			case "590": namefromid := "Prudence (Frustration +40%)"
			case "600": namefromid := "Corazón (Pirate's Code +40%)"
			case "601": namefromid := "Corazón (G.O.A.T. Pirate +40%)"
			case "613": namefromid := "D'hani (Paint Them Red +40%)"
			case "615": namefromid := "D'hani (Friendly Rivalry +40%)"
			case "636": namefromid := "Brig (Global DPS +25%)"
			case "638": namefromid := "Brig (Hype +40%)"
			case "642": namefromid := "Widdle (Global DPS +25%)"
			case "646": namefromid := "Widdle (Tasty Friends +40%)"
			case "652": namefromid := "Xerophon (Minion Meets Master +40%)"
			case "655": namefromid := "Xerophon (STR +1)"
			case "656": namefromid := "Xerophon (CON +1)"
			case "657": namefromid := "Xerophon (INT +1)"
			case "666": namefromid := "Yorven (Survivor's Alacrity)"
			case "667": namefromid := "Yorven (Bump in the Night)"
		}

	}
	else if (id < 746) {
		switch id {
			case "669": namefromid := "Yorven (Blood Fury Tattoo +40%)"
			case "672": namefromid := "Viconia (Global DPS +25%)"
			case "675": namefromid := "Viconia (Animate Dead +40%)"
			case "679": namefromid := "Rust (Global DPS +25%)"
			case "680": namefromid := "Rust (One Gold Piece +40%)"
			case "682": namefromid := "Rust (Rust For Hire +40%)"
			case "684": namefromid := "Rust (Close Friends +40%)"
			case "687": namefromid := "Evelyn (Divine Prayer +40%)"
			case "694": namefromid := "Walnut (Documancer +40%)"
			case "703": namefromid := "Vi (Gold +25%)"
			case "706": namefromid := "Vi (Catch and Release +40%)"
			case "707": namefromid := "Vi (I'm Too Old For This #*&! +40%)"
			case "718": namefromid := "Desmond (The Beast Within)"
			case "719": namefromid := "Desmond (What Lies in Shadow)"
			case "724": namefromid := "Desmond (Running with the Pack +40%)"
			case "725": namefromid := "Desmond (Lament the Lost +40%)"
			case "729": namefromid := "Mehen (Where my girls go, I go.)"
			case "741": namefromid := "Blooshi (Soul Gatherer +40%)"
			case "744": namefromid := "Blooshi (Hey! Skull guy! Look how good I'm doing!)"
			case "745": namefromid := "Tatyana (Health +30%)"
		}

	}
	else if (id < 726) {
		switch id {
			case "746": namefromid := "Tatyana (Faithful Friend +40%)"
			case "748": namefromid := "Tatyana (Rising Fury +40%)"
			case "754": namefromid := "Gazrick (Frosty Friendship +40%)"
			case "756": namefromid := "Gazrick (CON +1)"
			case "767": namefromid := "Tatyana (Overwhelm point +10)"
			case "769": namefromid := "Nova (Overwhelm point +10)"
			case "771": namefromid := "Blooshi (Overwhelm point +10)"
			case "775": namefromid := "Dungeon Master (Patience, Young Ones! +40%)"
			case "777": namefromid := "Dungeon Master (Words of Encouragement +40%)"
			case "784": namefromid := "Nordom (Rule of Law +40%)"
			case "706": namefromid := "Vi (Catch and Release +40%)"
			case "707": namefromid := "Vi (I'm Too Old For This #*&! +40%)"
			case "718": namefromid := "Desmond (The Beast Within)"
			case "719": namefromid := "Desmond (What Lies in Shadow)"
			case "724": namefromid := "Desmond (Running with the Pack +40%)"
			case "725": namefromid := "Desmond (Lament the Lost +40%)"
			;case "638": namefromid := "Brig (Harmonies Hype +40%)"
			;case "638": namefromid := "Brig (Harmonies Hype +40%)"
			;case "638": namefromid := "Brig (Harmonies Hype +40%)"
			;case "638": namefromid := "Brig (Harmonies Hype +40%)"
		}

	}

	else {
		namefromid := "UNKNOWN (" id ")"
	}
	return namefromid
}

ChestFromID(id) {
	if (id < 21) {
		switch id {
			case "1": namefromid := "Silver Chest"
			case "2": namefromid := "Gold Chest"
			case "3": namefromid := "Silver Stoki Chest"
			case "4": namefromid := "Gold Stoki Chest"
			case "5": namefromid := "Silver Krond Chest"
			case "6": namefromid := "Gold Krond Chest"
			case "7": namefromid := "Silver Gromma Chest"
			case "8": namefromid := "Gold Gromma Chest"
			case "9": namefromid := "Silver Dhadius Chest"
			case "10": namefromid := "Gold Dhadius Chest"
			case "11": namefromid := "Silver Barrowin Chest"
			case "12": namefromid := "Gold Barrowin Chest"
			case "13": namefromid := "Gold Snowy Chest"
			case "14": namefromid := "Gold Chultan Chest"
			case "15": namefromid := "Gold Wayside Chest"
			case "16": namefromid := "Silver Regis Chest"
			case "17": namefromid := "Gold Regis Chest"
			case "18": namefromid := "Silver Birdsong Chest"
			case "19": namefromid := "Gold Birdsong Chest"
			case "20": namefromid := "Gold Neutral Chest"
		}
	}
	else if (id < 41) {
		switch id {
			case "21": namefromid := "Silver Zorbu Chest"
			case "22": namefromid := "Gold Zorbu Chest"
			case "23": namefromid := "Gold Evil Chest"
			case "24": namefromid := "Gold Chaos Chest"
			case "25": namefromid := "Gold Good Chest"
			case "26": namefromid := "Silver Strix Chest"
			case "27": namefromid := "Gold Strix Chest"
			case "28": namefromid := "Gold Spring Chest"
			case "29": namefromid := "Silver Nrakk Chest"
			case "30": namefromid := "Gold Nrakk Chest"
			case "31": namefromid := "Gold Lawful Chest"
			case "32": namefromid := "Gold Companions' Chest"
			case "33": namefromid := "Gold Force Grey Chest"
			case "34": namefromid := "Gold Bird-Loving Chest"
			case "35": namefromid := "Silver Catti-brie Chest"
			case "36": namefromid := "Gold Catti-brie Chest"
			case "37": namefromid := "Gold Supply Chest"
			case "38": namefromid := "Gold Tough Chest"
			case "39": namefromid := "Gold Magic Chest"
			case "40": namefromid := "Silver Evelyn Chest"
		}
	}
	else if (id < 61) {
		switch id {
			case "41": namefromid := "Gold Evelyn Chest"
			case "42": namefromid := "Gold Warrior Chest"
			case "43": namefromid := "Gold Stuffed Chest"
			case "44": namefromid := "Gold Googly-Eyed Chest"
			case "45": namefromid := "Silver Binwin Chest"
			case "46": namefromid := "Gold Binwin Chest"
			case "47": namefromid := "Gold Gentlemen Chest"
			case "48": namefromid := "Gold Adventurers' Chest"
			case "49": namefromid := "Gold Minion Chest"
			case "50": namefromid := "Gold Scroll-Filled Chest"
			case "51": namefromid := "Gold Chaotic Chest"
			case "52": namefromid := "Gold Gate Chest"
			case "53": namefromid := "Silver Deekin Chest"
			case "54": namefromid := "Gold Deekin Chest"
			case "55": namefromid := "Silver Xander Chest"
			case "56": namefromid := "Gold Xander Chest"
			case "57": namefromid := "Silver Ishi Chest"
			case "58": namefromid := "Gold Ishi Chest"
			case "59": namefromid := "Gold Storyteller Chest"
			case "60": namefromid := "Gold Many-Horned Chest"
		}
	}
	else if (id < 81) {
		switch id {
			case "61": namefromid := "Gold Pummeled Chest"
			case "62": namefromid := "Gold Puzzle Cube Chest"
			case "63": namefromid := "Gold Friend Chest"
			case "64": namefromid := "Gold Warband Chest"
			case "65": namefromid := "Gold Weave-Bound Chest"
			case "66": namefromid := "Gold Band Chest"
			case "67": namefromid := "Silver Wulfgar Chest"
			case "68": namefromid := "Gold Wulfgar Chest"
			case "69": namefromid := "Gold Mithral Hall Chest"
			case "70": namefromid := "Gold Heist Chest"
			case "71": namefromid := "Silver Farideh Chest"
			case "72": namefromid := "Gold Farideh Chest"
			case "73": namefromid := "Silver Donaar Chest"
			case "74": namefromid := "Gold Donaar Chest"
			case "75": namefromid := "Silver Vlahnya Chest"
			case "76": namefromid := "Gold Vlahnya Chest"
			case "77": namefromid := "Gold Dice Chest"
			case "78": namefromid := "Gold Sheaf Chest"
			case "79": namefromid := "Gold Brimstone Chest"
			case "80": namefromid := "Gold Rampage Chest"
		}
	}
	else if (id < 101) {
		switch id {
			case "81": namefromid := "Silver Warden Chest"
			case "82": namefromid := "Gold Warden Chest"
			case "83": namefromid := "Silver Nerys Chest"
			case "84": namefromid := "Gold Nerys Chest"
			case "85": namefromid := "Silver K'thriss Chest"
			case "86": namefromid := "Gold K'thriss Chest"
			case "87": namefromid := "Silver Paultin Chest"
			case "88": namefromid := "Gold Paultin Chest"
			case "89": namefromid := "Silver Black Viper Chest"
			case "90": namefromid := "Gold Black Viper Chest"
			case "91": namefromid := "Silver Rosie Chest"
			case "92": namefromid := "Gold Rosie Chest"
			case "93": namefromid := "Silver Aila Chest"
			case "94": namefromid := "Gold Aila Chest"
			case "95": namefromid := "Silver Spurt Chest"
			case "96": namefromid := "Gold Spurt Chest"
			case "97": namefromid := "Silver Qillek Chest"
			case "98": namefromid := "Gold Qillek Chest"
			case "99": namefromid := "Silver Korth Chest"
			case "100": namefromid := "Gold Korth Chest"
		}
	}
	else if (id < 121) {
		switch id {
			case "101": namefromid := "Silver Walnut Chest"
			case "102": namefromid := "Gold Walnut Chest"
			case "103": namefromid := "Silver Shandie Chest"
			case "104": namefromid := "Gold Shandie Chest"
			case "105": namefromid := "Silver Jim Chest"
			case "106": namefromid := "Gold Jim Chest"
			case "107": namefromid := "Silver Turiel Chest"
			case "108": namefromid := "Gold Turiel Chest"
			case "109": namefromid := "Gold Story Chest"
			case "110": namefromid := "Gold Crew Chest"
			case "111": namefromid := "Gold Runic Chest"
			case "112": namefromid := "Gold Friend Chest"
			case "113": namefromid := "Gold Battlegroup Chest"
			case "114": namefromid := "Gold Returning Hero Chest"
			case "115": namefromid := "Gold Jungle Chest"
			case "116": namefromid := "Gold Welcome Chest"
			case "117": namefromid := "Gold Braggy Chest"
			case "118": namefromid := "Gold Protected Chest"
			case "119": namefromid := "Gold Wild Chest"
			case "120": namefromid := "Gold Watchful Chest"
		}
	}
	else if (id < 141) {
		switch id {
			case "121": namefromid := "Gold Exotic Chest"
			case "122": namefromid := "Gold Inventive Chest"
			case "123": namefromid := "Gold Cruel Chest"
			case "124": namefromid := "Gold Owlbear Chest"
			case "125": namefromid := "Gold Siren Chest"
			case "126": namefromid := "Gold Distressed Chest"
			case "127": namefromid := "Gold Trapped Chest"
			case "128": namefromid := "Gold Murderbot Chest"
			case "129": namefromid := "Gold Fit Chest"
			case "130": namefromid := "Gold Honeycomb Chest"
			case "131": namefromid := "Gold Spiritual Chest"
			case "132": namefromid := "Gold Non-Mimic Chest"
			case "133": namefromid := "Gold Misfit Chest"
			case "134": namefromid := "Gold Gust Chest"
			case "135": namefromid := "Gold Spider Climb Chest"
			case "136": namefromid := "Gold Feywild Chest"
			case "137": namefromid := "Gold Kobold Chest"
			case "138": namefromid := "Gold Descent Chest"
			case "139": namefromid := "Gold Scourge Chest"
			case "140": namefromid := "Gold Rage-Filled Chest"
		}
	}
	else if (id < 161) {
		switch id {
			case "141": namefromid := "Gold Well-Aligned Chest"
			case "142": namefromid := "Gold OK Chest"
			case "143": namefromid := "Gold Petrified Chest"
			case "144": namefromid := "Gold Feathered Chest"
			case "145": namefromid := "Gold Stock-Up Chest"
			case "146": namefromid := "Gold Zombiefied Chest"
			case "147": namefromid := "Gold Rebalanced Chest"
			case "148": namefromid := "Gold Ranged Chest"
			case "149": namefromid := "Gold Measured Chest"
			case "150": namefromid := "Gold Together Chest"
			case "151": namefromid := "Gold Documented Chest"
			case "152": namefromid := "Gold Mirt Patron Chest"
			case "153": namefromid := "Gold Vajra Patron Chest"
			case "154": namefromid := "Gold Allied Chest"
			case "155": namefromid := "Gold Welcoming Chest"
			case "156": namefromid := "Gold Skulking Chest"
			case "157": namefromid := "Gold Dashing Chest"
			case "158": namefromid := "Silver Pwent Chest"
			case "159": namefromid := "Gold Pwent Chest"
			case "160": namefromid := "Silver Avren Chest"
		}
	}
	else if (id < 181) {
		switch id {
			case "161": namefromid := "Gold Avren Chest"
			case "162": namefromid := "Silver Sentry Chest"
			case "163": namefromid := "Gold Sentry Chest"
			case "164": namefromid := "Silver Krull Chest"
			case "165": namefromid := "Gold Krull Chest"
			case "166": namefromid := "Silver Artemis Chest"
			case "167": namefromid := "Gold Artemis Chest"
			case "168": namefromid := "Silver M" Chr(244) "rg" Chr(230) "n Chest"
			case "169": namefromid := "Gold M" Chr(244) "rg" Chr(230) "n Chest"
			case "170": namefromid := "Silver Havilar Chest"
			case "171": namefromid := "Gold Havilar Chest"
			case "172": namefromid := "Silver Sisaspia Chest"
			case "173": namefromid := "Gold Sisaspia Chest"
			case "174": namefromid := "Silver Briv Chest"
			case "175": namefromid := "Gold Briv Chest"
			case "176": namefromid := "Silver Melf Chest"
			case "177": namefromid := "Gold Melf Chest"
			case "178": namefromid := "Silver Krydle Chest"
			case "179": namefromid := "Gold Krydle Chest"
			case "180": namefromid := "Silver Jaheira Chest"
		}
	}
	else if (id < 201) {
		switch id {
			case "181": namefromid := "Gold Jaheira Chest"
			case "182": namefromid := "Silver Nova Chest"
			case "183": namefromid := "Gold Nova Chest"
			case "184": namefromid := "Silver Freely Chest"
			case "185": namefromid := "Gold Freely Chest"
			case "186": namefromid := "Silver Beadle & Grimm Chest"
			case "187": namefromid := "Gold Beadle & Grimm Chest"
			case "188": namefromid := "Silver Omin Chest"
			case "189": namefromid := "Gold Omin Chest"
			case "190": namefromid := "Silver Lazaapz Chest"
			case "191": namefromid := "Gold Lazaapz Chest"
			case "192": namefromid := "Gold Lucky Chest"
			case "193": namefromid := "Gold Courageous Chest"
			case "194": namefromid := "Gold Heroic Chest"
			case "195": namefromid := "Gold Splattered Chest"
			case "196": namefromid := "Gold Magical Chest"
			case "197": namefromid := "Gold Versatile Chest"
			case "198": namefromid := "Gold Quest-Filled Chest"
			case "199": namefromid := "Gold Lowlands Chest"
			case "200": namefromid := "Gold Cloned Chest"
		}
	}
	else if (id < 221) {
		switch id {
			case "201": namefromid := "Gold Pristine Chest"
			case "202": namefromid := "Gold Dark Days Chest"
			case "203": namefromid := "Gold Dusty Chest"
			case "204": namefromid := "Gold Screened Chest"
			case "205": namefromid := "Gold Mithral Hall Chest (NOT USED)"
			case "206": namefromid := "Gold Hexed Chest"
			case "207": namefromid := "Gold Arkhan's Army Chest"
			case "208": namefromid := "Gold Stained Chest"
			case "209": namefromid := "Gold Broken Chest"
			case "210": namefromid := "Gold Arrow-Filled Chest"
			case "211": namefromid := "Gold Grubby Chest"
			case "212": namefromid := "Gold Ruby Chest"
			case "213": namefromid := "Gold Secret Chest"
			case "214": namefromid := "Gold Twothbrush Chest"
			case "215": namefromid := "Gold Packaged Chest"
			case "216": namefromid := "Gold Sprung Chest"
			case "217": namefromid := "Gold Shadow Chest"
			case "218": namefromid := "Gold Hooked Chest"
			case "219": namefromid := "Gold Strahd Patron Chest"
			case "220": namefromid := "Gold Extra-Golden Chest"
		}
	}
	else if (id < 241) {
		switch id {
			case "221": namefromid := "Gold Shelled Chest"
			case "222": namefromid := "Gold Hugged Chest"
			case "223": namefromid := "Gold Footprint Chest"
			case "224": namefromid := "Gold Armored Chest"
			case "225": namefromid := "Gold May Day Chest"
			case "226": namefromid := "Gold Solwynn Chest"
			case "227": namefromid := "Gold Hunted Chest"
			case "228": namefromid := "Gold Shielded Chest"
			case "229": namefromid := "Gold Pebbled Chest"
			case "230": namefromid := "Modron Component Chest"
			case "231": namefromid := "Gold Shifted Chest"
			case "232": namefromid := "Gold Kissed Chest"
			case "233": namefromid := "Gold Tartan Chest"
			case "234": namefromid := "Gold Legends Chest"
			case "235": namefromid := "Gold Wittled Chest"
			case "236": namefromid := "Gold Snakeskin Chest"
			case "237": namefromid := "Gold Book-End Chest"
			case "238": namefromid := "Gold Striking Chest"
			case "239": namefromid := "Gold Rainbowed Chest"
			case "240": namefromid := "Gold Whisker Chest"
		}
	}
	else if (id < 261) {
		switch id {
			case "241": namefromid := "Gold Egg Chest"
			case "242": namefromid := "Gold Undermountain Chest"
			case "243": namefromid := "Gold Historical Chest"
			case "244": namefromid := "Silver Torogar Chest"
			case "245": namefromid := "Gold Torogar Chest"
			case "246": namefromid := "Silver Ezmerelda Chest"
			case "247": namefromid := "Gold Ezmerelda Chest"
			case "248": namefromid := "Silver Penelope Chest"
			case "249": namefromid := "Gold Penelope Chest"
			case "250": namefromid := "Silver Lucius Chest"
			case "251": namefromid := "Gold Lucius Chest"
			case "252": namefromid := "Silver Baeloth Chest"
			case "253": namefromid := "Gold Baeloth Chest"
			case "254": namefromid := "Silver Talin Chest"
			case "255": namefromid := "Gold Talin Chest"
			case "256": namefromid := "Silver Hew Mann Chest"
			case "257": namefromid := "Gold Hew Mann Chest"
			case "258": namefromid := "Silver Orisha Chest"
			case "259": namefromid := "Gold Orisha Chest"
			case "260": namefromid := "Silver Alyndra Chest"
		}
	}
	else if (id < 281) {
		switch id {
			case "261": namefromid := "Gold Alyndra Chest"
			case "262": namefromid := "Silver Orkira Chest"
			case "263": namefromid := "Gold Orkira Chest"
			case "264": namefromid := "Silver Shaka Chest"
			case "265": namefromid := "Gold Shaka Chest"
			case "266": namefromid := "Silver Mehan Chest"
			case "267": namefromid := "Gold Mehan Chest"
			case "268": namefromid := "Silver Selise Chest"
			case "269": namefromid := "Gold Selise Chest"
			case "270": namefromid := "Silver Sgt Knox Chest"
			case "271": namefromid := "Gold Sgt Knox Chest"
			case "272": namefromid := "Silver Ellywick Chest"
			case "273": namefromid := "Gold Ellywick Chest"
			case "274": namefromid := "Silver Prudence Chest"
			case "275": namefromid := "Gold Prudence Chest"
			case "276": namefromid := "Silver Corazon Chest"
			case "277": namefromid := "Gold Corazon Chest"
			case "278": namefromid := "Gold Bold Chest"
			case "279": namefromid := "Gold Rime Chest"
			case "280": namefromid := "Gold Feathered Hat Chest"
		}
	}
	else if (id < 301) {
		switch id {
			case "281": namefromid := "Gold Experimental Chest"
			case "282": namefromid := "Electrum Chest"
			case "284": namefromid := "Gold Ichor Covered Chest"
			case "285": namefromid := "Gold Scrappy Chest"
			case "286": namefromid := "Gold Giant's Bane Chest"
			case "287": namefromid := "Gold Dragonscale Chest"
			case "288": namefromid := "Gold Maze Chest"
			case "289": namefromid := "Gold Freezing Chest"
			case "290": namefromid := "Gold Coin-Filled Chest"
			case "291": namefromid := "Gold Agile Chest"
			case "292": namefromid := "Gold Tactical Chest"
			case "293": namefromid := "Gold Starburst Chest"
			case "294": namefromid := "Gold Radiant Chest"
			case "295": namefromid := "Gold Heroes of Aerois Chest"
			case "296": namefromid := "Gold Holiday Chest"
			case "297": namefromid := "Gold Hunter Chest"
			case "298": namefromid := "Gold Cold Chest"
			case "299": namefromid := "Gold Grambars Blades Chest"
			case "300": namefromid := "Gold Bovine Chest"			
		}
	}
	else if (id < 321) {
		switch id {
			case "301": namefromid := "Gold Dungeon Director Chest"
			case "302": namefromid := "Gold Add Venture Chest"
			case "303": namefromid := "Gold Glowing Chest"
			case "304": namefromid := "Gold Frilly Chest"
			case "305": namefromid := "Gold Sunken Chest"
			case "306": namefromid := "Gold Ancient Chest"
			case "307": namefromid := "Gold Speedy Chest"
			case "308": namefromid := "Gold Commentator Chest"
			case "309": namefromid := "Gold Orator Chest"
			case "310": namefromid := "Gold One-HewMaan-Band Chest"
			case "311": namefromid := "Gold Zariel Patron Chest"
			case "312": namefromid := "Gold Flaming Chest"
			case "313": namefromid := "Gold Tidal Chest"
			case "314": namefromid := "Gold Netherese Chest"
			case "315": namefromid := "Gold Smores Chest"
			;case "316": namefromid := "UNKNOWN (" id ")"
			;case "317": namefromid := "UNKNOWN (" id ")"
			;case "318": namefromid := "UNKNOWN (" id ")"
			case "319": namefromid := "Gold Illusion Chest"
			case "320": namefromid := "Gold Coast Chest"
		}
	}
	else if (id < 341) {
		switch id {
			case "321": namefromid := "Gold Rock Star Chest"
			case "322": namefromid := "Gold Twin Chest"
			case "323": namefromid := "Glory of Bahamut Chest"
			case "324": namefromid := "Gold Winged Chest"
			case "325": namefromid := "Gold A-maze-ing Chest"
			case "326": namefromid := "Gold Spiky Chest"
			case "327": namefromid := "Gold Silvershield Chest"
			case "328": namefromid := "Gold Sun Chest"
			case "329": namefromid := "Gold Moon Chest"
			case "330": namefromid := "Gold Shard Chest"
			case "331": namefromid := "Gold Painted Chest"
			case "332": namefromid := "Gold Performance Chest"
			case "333": namefromid := "Gold Cloudy Chest"
			case "334": namefromid := "Silver D'hani Chest"
			case "335": namefromid := "Gold D'hani Chest"
			case "336": namefromid := "Silver Briv Chest"
			case "337": namefromid := "Gold Briv Chest"
			case "338": namefromid := "Silver Widdle Chest"
			case "339": namefromid := "Gold Widdle Chest"
			case "340": namefromid := "Silver Yorven Chest"
		}
	}
	else if (id < 361) {
		switch id {
			case "341": namefromid := "Gold Yorven Chest"
			case "342": namefromid := "Silver Viconia Chest"
			case "343": namefromid := "Gold Viconia Chest"
			case "344": namefromid := "Silver Rust Chest"
			case "345": namefromid := "Gold Rust Chest"
			case "346": namefromid := "Silver Vi Chest"
			case "347": namefromid := "Gold Vi Chest"
			case "348": namefromid := "Silver Desmond Chest"
			case "349": namefromid := "Gold Desmond Chest"
			case "350": namefromid := "Silver Tatyana Chest"
			case "351": namefromid := "Gold Tatyana Chest"
			case "352": namefromid := "Silver Gazrick Chest"
			case "353": namefromid := "Gold Gazrick Chest"
			case "354": namefromid := "Silver Dungeon Master Chest"
			case "355": namefromid := "Gold Dungeon Master Chest"
			case "356": namefromid := "Silver Nordom Chest"
			case "357": namefromid := "Gold Nordom Chest"
			case "358": namefromid := "Silver Merilwen Chest"
			case "359": namefromid := "Gold Merilwen Chest"
			case "360": namefromid := "Silver Nahara Chest"
		}
	}
	else if (id < 381) {
		switch id {
			case "361": namefromid := "Gold Nahara Chest"
			case "362": namefromid := "Silver Y5E15 Chest"
			case "363": namefromid := "Gold Y5E15 Chest"
			case "364": namefromid := "Silver Y5E16 Chest"
			case "365": namefromid := "Gold Y5E16 Chest"
			case "366": namefromid := "Silver Y5E17 Chest"
			case "367": namefromid := "Gold Y5E17 Chest"
			case "368": namefromid := "Gold Barred Chest"
			case "369": namefromid := "Gold Charred Chest"
			case "370": namefromid := "Gold Weighted Chest"
			case "371": namefromid := "Gold Fey Chest"
			case "372": namefromid := "Gold Contract Chest"
			case "373": namefromid := "Gold Blasted Chest"
			case "374": namefromid := "Gold Big Top Chest"
			case "375": namefromid := "Gold Spinnaker Chest"
			case "376": namefromid := "Gold Weapons Chest"
			case "377": namefromid := "Gold Powered Chest"
			case "378": namefromid := "Gold Pumpkin Chest"
			case "379": namefromid := "Gold Polymorphed Chest"
			case "380": namefromid := "Gold Captain Boo Chest"
		}
	}
	else if (id < 401) {
		switch id {
			case "381": namefromid := "Gold Freshly Painted Chest"
			case "382": namefromid := "Gold Branched Chest"
			case "383": namefromid := "Gold Blazed Chest"
			case "384": namefromid := "Gold Spotlight Chest"
			case "385": namefromid := "Gold Pirate Chest"
			case "386": namefromid := "Gold Gingerbread Chest"
			case "387": namefromid := "Gold Candy Cane Chest"
			case "388": namefromid := "Gold Carrot Chest"
			case "389": namefromid := "Gold Overstuffed Chest"
			case "390": namefromid := "Gold Ice Dagger Chest"
			case "391": namefromid := "Gold Spell-Covered Chest"
			case "392": namefromid := "Gold Elven Chest"
			case "393": namefromid := "Gold Gold Piece Chest"
			case "394": namefromid := "Gold Pouch Chest"
			case "395": namefromid := "Gold Tarrasque Chest"
			case "396": namefromid := "Gold Wheeled Chest"
			case "397": namefromid := "Gold Shadow Chest"
			case "398": namefromid := "Gold Shenanigan Chest"
			case "399": namefromid := "Gold Raven Queens Chest"
			case "400": namefromid := "Gold Shadow-Eberron Chest"
		}
	}
	else if (id < 412) {
		switch id {
			case "401": namefromid := "Gold Rescue Chest"
			case "402": namefromid := "Gold New Moon Chest"
			case "403": namefromid := "Gold Vampiric Chest"
			case "404": namefromid := "Gold Snack Chest"
			case "405": namefromid := "Gold Skewered Chest"
			case "406": namefromid := "Gold Swag Chest"
			case "407": namefromid := "Gold Savage Chest"
			case "408": namefromid := "Gold Dice Chest"
			case "409": namefromid := "Gold Clockwork Chest"
			case "410": namefromid := "Gold Marching Chest"
			case "411": namefromid := "Gold Toolbox Chest"
			;case "412": namefromid := "Gold Elven Chest"
			;case "413": namefromid := "Gold Gold Piece Chest"
			;case "414": namefromid := "Gold Pouch Chest"
			;case "415": namefromid := "Gold Tarrasque Chest"
			;case "416": namefromid := "UNKNOWN (" id ")"
			;case "417": namefromid := "UNKNOWN (" id ")"
			;case "418": namefromid := "UNKNOWN (" id ")"
			;case "419": namefromid := "UNKNOWN (" id ")"
			;case "420": namefromid := "UNKNOWN (" id ")"
		}
	}
	else {
		namefromid := "UNKNOWN (" id ")"
	}
	return namefromid
}

KlehoFromID(id) {
	if (id < 21) {
		switch id {
			case "14": namefromid := "3a23"
			case "15": namefromid := "4a44"
			case "16": namefromid := "5a49"
			case "17": namefromid := "6a64"
			case "19": namefromid := "7a84"
			case "20": namefromid := "8a89"
		}
	}
	else if (id < 41) {
		switch id {
			case "21": namefromid := "9a104"
			case "22": namefromid := "10a119"
			case "23": namefromid := "11a134"
			case "24": namefromid := "12a139"
			case "25": namefromid := "13a144"
			case "26": namefromid := "14a159"
			case "27": namefromid := "16a174"
			case "28": namefromid := "18a202"
			case "29": namefromid := "19a218"
			case "31": namefromid := "20a224"
			case "32": namefromid := "21a240"
			case "33": namefromid := "3a256"
			case "34": namefromid := "4a272"
			case "35": namefromid := "5a288"
			case "36": namefromid := "6a293"
			case "37": namefromid := "7a298"
			case "38": namefromid := "8a303"
			case "39": namefromid := "9a308"
			case "40": namefromid := "10a313"
		}
	}
	else if (id < 61) {
		switch id {
			case "41": namefromid := "11a318"
			case "42": namefromid := "12a323"
			case "43": namefromid := "13a328"
			case "44": namefromid := "14a333"
			case "45": namefromid := "16a338"
			case "46": namefromid := "18a343"
			case "47": namefromid := "19a348"
			case "48": namefromid := "20a353"
			case "49": namefromid := "21a358"
			case "50": namefromid := "3a438"
			case "51": namefromid := "4a443"
			case "52": namefromid := "5a448"
			case "53": namefromid := "6a453"
			case "54": namefromid := "7a458"
			case "55": namefromid := "8a463"
			case "56": namefromid := "9a468"
			case "57": namefromid := "10a473"
			case "58": namefromid := "11a478"
			case "59": namefromid := "12a483"
			case "60": namefromid := "13a488"
		}
	}
	else if (id < 81) {
		switch id {
			case "61": namefromid := "14a493"
			case "62": namefromid := "16a498"
			case "63": namefromid := "18a503"
			case "64": namefromid := "19a508"
			case "65": namefromid := "20a513"
			case "66": namefromid := "21a518"
			case "69": namefromid := "3a700"
			case "70": namefromid := "4a705"
			case "71": namefromid := "5a710"
			case "72": namefromid := "6a715"
			case "73": namefromid := "7a720"
			case "74": namefromid := "8a725"
			case "75": namefromid := "9a730"
			case "76": namefromid := "10a735"
			case "77": namefromid := "11a740"
			case "78": namefromid := "12a745"
			case "79": namefromid := "13a750"
			case "80": namefromid := "14a755"
		}
	}
	else if (id < 86) {
		switch id {
			case "81": namefromid := "16a760"
			case "82": namefromid := "18a765"
			case "83": namefromid := "19a770"
			case "84": namefromid := "20a775"
			case "85": namefromid := "21a780"
		}
	}
	else {
		namefromid := "UNKNOWN (" id ")"
	}
	return namefromid
}

ChestIDFromChampID(id) {
	if (id < 21) {
		switch id {
			case "14": chestfromchamp := "4"
			case "15": chestfromchamp := "6"
			case "16": chestfromchamp := "8"
			case "17": chestfromchamp := "10"
			case "19": chestfromchamp := "12"
			case "20": chestfromchamp := "17"
		}
	}
	else if (id < 41) {
		switch id {
			case "21": chestfromchamp := "19"
			case "22": chestfromchamp := "22"
			case "23": chestfromchamp := "27"
			case "24": chestfromchamp := "30"
			case "25": chestfromchamp := "36"
			case "26": chestfromchamp := "41"
			case "27": chestfromchamp := "46"
			case "28": chestfromchamp := "54"
			case "29": chestfromchamp := "56"
			case "31": chestfromchamp := "58"
			case "32": chestfromchamp := "68"
			case "33": chestfromchamp := "72"
			case "34": chestfromchamp := "74"
			case "35": chestfromchamp := "76"
			case "36": chestfromchamp := "82"
			case "37": chestfromchamp := "84"
			case "38": chestfromchamp := "86"
			case "39": chestfromchamp := "88"
			case "40": chestfromchamp := "90"
		}
	}
	else if (id < 61) {
		switch id {
			case "41": chestfromchamp := "92"
			case "42": chestfromchamp := "94"
			case "43": chestfromchamp := "96"
			case "44": chestfromchamp := "98"
			case "45": chestfromchamp := "100"
			case "46": chestfromchamp := "102"
			case "47": chestfromchamp := "104"
			case "48": chestfromchamp := "106"
			case "49": chestfromchamp := "108"
			case "50": chestfromchamp := "159"
			case "51": chestfromchamp := "161"
			case "52": chestfromchamp := "163"
			case "53": chestfromchamp := "165"
			case "54": chestfromchamp := "167"
			case "55": chestfromchamp := "169"
			case "56": chestfromchamp := "171"
			case "57": chestfromchamp := "173"
			case "58": chestfromchamp := "175"
			case "59": chestfromchamp := "177"
			case "60": chestfromchamp := "179"
		}
	}
	else if (id < 81) {
		switch id {
			case "61": chestfromchamp := "181"
			case "62": chestfromchamp := "183"
			case "63": chestfromchamp := "185"
			case "64": chestfromchamp := "187"
			case "65": chestfromchamp := "189"
			case "66": chestfromchamp := "191"
			case "69": chestfromchamp := "245"
			case "70": chestfromchamp := "247"
			case "71": chestfromchamp := "249"
			case "72": chestfromchamp := "251"
			case "73": chestfromchamp := "253"
			case "74": chestfromchamp := "255"
			case "75": chestfromchamp := "257"
			case "76": chestfromchamp := "259"
			case "77": chestfromchamp := "261"
			case "78": chestfromchamp := "263"
			case "79": chestfromchamp := "265"
			case "80": chestfromchamp := "267"
		}
	}
	else if (id < 86) {
		switch id {
			case "81": chestfromchamp := "269"
			case "82": chestfromchamp := "271"
			case "93": chestfromchamp := "273"
			case "84": chestfromchamp := "275"
			case "85": chestfromchamp := "277"
		}
	}
	else {
		chestfromchamp := "UNKNOWN (" id ")"
	}
	return chestfromchamp
}