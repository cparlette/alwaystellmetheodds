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
	3: 30,
	4: 65,
	5: 95,
	6: 130,
	7: 170,
	8: 250,
	9: 1000
}


var roundNumber = 1
var distanceTraveled = 0
var destinationTotalDistance = 390.4
var destinationMoon = "Ganymede"
var additionalOutputText = ""

var captainName = "Captain"
var crew1Name = "Ann"
var crew2Name = "Bob"
var crew3Name = "Chad"

func reinitializeGame():
	roundNumber = 1
	distanceTraveled = 0
	additionalOutputText = ""
	

var randomEvents = {
	0: {
		"text": "Sir, we are approaching an asteroid belt.  Putting a crew member on navigation should help us avoid collisions.  If any of those rocks hit us, we're going to take some damage",
		"helpingModule": MODULE_TYPE.NAVIGATION,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.HULL, "failText": "[color=red]ALERT[/color]: Asteroids strike the hull, damage = "}
	},
	1: {
		"text": "The computer is showing inconsistencies in our life support system.  The computer can fix it, but human input would help.",
		"helpingModule": MODULE_TYPE.COMPUTER,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.LIFE_SUPPORT, "failText": "[color=red]ALERT[/color]: Life Support system failure, damage = "}
	},
	2: {
		"text": "There's some debris buildup on the outside of the ship, which might affect our sensors.  One of the crew can go clean the hull to help.",
		"helpingModule": MODULE_TYPE.HULL,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.SENSORS, "failText": "[color=red]ALERT[/color]: Sensors have failed, damage = "}
	},
	3: {
		"text": "We're seeing some potential anomalies in the nav system.  More engine power can help recalibrate the bearings.",
		"helpingModule": MODULE_TYPE.ENGINE,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.NAVIGATION, "failText": "[color=red]ALERT[/color]: Damage to the navigation module, damage = "}
	},
	4: {
		"text": "The engine is overheating and leaking CO2.  Additional life support can help counteract the potential damage to the engine.",
		"helpingModule": MODULE_TYPE.LIFE_SUPPORT,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.ENGINE, "failText": "[color=red]ALERT[/color]: Engine power decreased, damage = "}
	},
	5: {
		"text": "Our computers are reporting a potential malfunction.  A crewmember can help find the root cause using the sensors.",
		"helpingModule": MODULE_TYPE.SENSORS,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.COMPUTER, "failText": "[color=red]ALERT[/color]: Computer system failure, damage = "}
	},
}
