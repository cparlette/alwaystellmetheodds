extends Node2D

# Project window size is 1280x720
const WINDOW_X = 1280
const WINDOW_Y = 720

enum MODULE_TYPE {
	ENGINE,
	NAVIGATION,
	COMPUTER,
	LIFE_SUPPORT,
	HULL,
	SENSORS
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
		"text": "Sir, we are approaching an asteroid belt.  Putting a crew member on navigation should help us avoid collisions.  If any of those rocks hit us, we're going to take some damage",
		"helpingModule": MODULE_TYPE.NAVIGATION,
		"startingOdds": 50,
		"failure": {"moduleId": MODULE_TYPE.HULL, "failText": "ALERT: Asteroids strike the hull, damage = "}
	},
	1: {
		"text": "The computer is showing inconsistencies in our life support system.  The computer can fix it, but human input would help.",
		"helpingModule": MODULE_TYPE.COMPUTER,
		"startingOdds": 50,
		"failure": {"moduleId": MODULE_TYPE.LIFE_SUPPORT, "failText": "ALERT: Life Support system failure, damage = "}
	},
	2: {
		"text": "There's some debris buildup on the outside of the ship, which might affect our sensors.  One of the crew can go clean the hull to help.",
		"helpingModule": MODULE_TYPE.HULL,
		"startingOdds": 50,
		"failure": {"moduleId": MODULE_TYPE.SENSORS, "failText": "ALERT: Sensors have failed, damage = "}
	},
	3: {
		"text": "We're seeing some potential anomalies in the nav system.  More engine power can help recalibrate the bearings.",
		"helpingModule": MODULE_TYPE.ENGINE,
		"startingOdds": 50,
		"failure": {"moduleId": MODULE_TYPE.NAVIGATION, "failText": "ALERT: Damage to the navigation module, damage = "}
	},
	4: {
		"text": "The engine is overheating and leaking CO2.  Additional life support can help counteract the potential damage to the engine.",
		"helpingModule": MODULE_TYPE.LIFE_SUPPORT,
		"startingOdds": 50,
		"failure": {"moduleId": MODULE_TYPE.ENGINE, "failText": "ALERT: Engine power decreased, damage = "}
	},
	5: {
		"text": "Our computers are reporting a potential malfunction.  A crewmember can help find the root cause using the sensors.",
		"helpingModule": MODULE_TYPE.SENSORS,
		"startingOdds": 50,
		"failure": {"moduleId": MODULE_TYPE.COMPUTER, "failText": "ALERT: Computer system failure, damage = "}
	},
}
