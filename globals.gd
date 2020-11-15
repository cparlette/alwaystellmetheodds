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

const xpLevels = {
	0: 0,
	1: 5,
	2: 10,
	3: 15,
	4: 20,
	5: 40,
	6: 100,
	7: 200,
	8: 500
}

var shipPowerMax = 10
var shipPowerCurrent = 0

var roundNumber = 1
var distanceTraveled = 0
var destinationTotalDistance = 390.4
var destinationMoon = "Ganymede"

func reinitializeGame():
	roundNumber = 1
	distanceTraveled = 0
	

var randomEvents = {
	0: {
		"text": "Sir, we are approaching an asteroid belt.  Routing power or crew to the controls should help us navigate better.  If any of those rocks hit us, we're going to take some damage",
		"helpingModule": MODULE_TYPE.CONTROLS,
		"startingOdds": 50,
		"failure": {"moduleId": MODULE_TYPE.HULL, "failText": "ALERT: Asteroids strike the hull, damage = "}
	},
	1: {
		"text": "The computer is showing inconsistencies in our life support system.  The computer can fix it, but it needs power or human help.",
		"helpingModule": MODULE_TYPE.COMPUTER,
		"startingOdds": 50,
		"failure": {"moduleId": MODULE_TYPE.LIFE_SUPPORT, "failText": "ALERT: Life Support system failure, damage = "}
	},
}
