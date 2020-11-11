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
var shipPowerCurrent = 0

var roundNumber = 1
var distanceTraveled = 0
var destinationTotalDistance = 390.4
var destinationMoon = "Ganymede"

var randomEvents = {
	0: {
		"text": "Sir, we are approaching an asteroid belt.  Routing power or crew to the controls should help us navigate better.  If any of those rocks hit us, we're going to take some damage",
		"helpingModule": 1,
		"startingOdds": 50,
		"failure": {"moduleId": 4, "failText": "ALERT: Asteroids strike the hull, damage = "}
	},
	1: {
		"text": "The computer is showing inconsistencies in our life support system.  The computer can fix it, but it needs power or human help.",
		"helpingModule": 2,
		"startingOdds": 50,
		"failure": {"moduleId": 3, "failText": "ALERT: Life Support system failure, damage = "}
	},
}
