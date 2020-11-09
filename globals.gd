extends Node2D

# Project window size is 1280x720
const WINDOW_X = 1280
const WINDOW_Y = 720

enum MODULE_TYPE {
	ENGINE,
	CONTROLS,
	COMPUTER,
	LIFE_SUPPORT,
	HULL,
	COMMUNICATIONS
}

enum CREW_NAMES {
	Ann,
	Bob,
	Chad,
	Deb
}

var shipPowerMax = 10
var shipPowerCurrent = 5

var roundNumber = 1

var randomEvents = {
	0: {
		"text": "This is event 0.  Do you want Option A or Option B?",
		"optionA": {
			"text": "Fix engine, break controls",
			"good": {"moduleId": 0, "effect": 5},
			"bad": {"moduleId": 1, "effect": -5}
		},
		"optionB": {
			"text": "Fix computer, break life support",
			"good": {"moduleId": 2, "effect": 5},
			"bad": {"moduleId": 3, "effect": -5}
		}
	},
	1: {
		"text": "This is event 1.  Do you want Option A or Option B?",
		"optionA": {
			"text": "Fix computer, break controls",
			"good": {"moduleId": 2, "effect": 5},
			"bad": {"moduleId": 1, "effect": -5}
		},
		"optionB": {
			"text": "Fix hull, break life support",
			"good": {"moduleId": 4, "effect": 5},
			"bad": {"moduleId": 3, "effect": -5}
		}
	},
	2: {
		"text": "This is event 2.  Do you want Option A or Option B?",
		"optionA": {
			"text": "Fix engine, break controls",
			"good": {"moduleId": 0, "effect": 5},
			"bad": {"moduleId": 1, "effect": -5}
		},
		"optionB": {
			"text": "Fix communications, break hull",
			"good": {"moduleId": 5, "effect": 5},
			"bad": {"moduleId": 4, "effect": -5}
		}
	},
}
