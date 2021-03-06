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
	3: 20,
	4: 35,
	5: 55,
	6: 80,
	7: 110,
	8: 150,
	9: 200,
	10: 250,
	11: 300,
	12: 350,
	13: 400,
	14: 450,
	15: 500,
	16: 600,
	17: 700,
	18: 800,
	19: 900,
	20: 2000
}

const possibleMoons = {
	0: {"name": "Phobos", "distance": 48.3, "difficulty":"Easy", "moonID":0, "music":"Holst-Mars.ogg"},
	1: {"name": "Ganymede", "distance": 390.4, "difficulty":"Medium", "moonID":1, "music":"Holst-Jupiter.ogg"},
	2: {"name": "Titan", "distance": 890.7, "difficulty":"Hard", "moonID":2, "music":"Holst-Saturn.ogg"},
	3: {"name": "Oberon", "distance": 1692.0, "difficulty":"Expert", "moonID":3, "music":"Holst-Uranus.ogg"}
}

var roundNumber = 1
var distanceTraveled = 0
var score = 0
var destinationMoon = {"name": "Ganymede", "distance": 390.4, "difficulty":"Medium", "moonID":1}
var additionalOutputText = ""
var reasonForLoss = ""

var captainName = "Captain"
var crew1Name = "Ann"
var crew2Name = "Bob"
var crew3Name = "Chad"

func reinitializeGame():
	roundNumber = 1
	distanceTraveled = 0
	additionalOutputText = ""
	score = 0
	reasonForLoss = ""
	

var randomEvents = {
	0: {
		"text": "Captain, we are approaching an asteroid belt.  Boosting [color=aqua]navigation[/color] should help us avoid collisions.  If any of those rocks hit us, our [color=#FFC000]hull[/color] is going to take some damage",
		"helpingModule": MODULE_TYPE.NAVIGATION,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.HULL, "failText": "[color=red]ALERT[/color]: Asteroids strike the hull, damage = "}
	},
	1: {
		"text": "The computer is showing inconsistencies in our life support system.  Boosting the [color=aqua]computer[/color] can fix it, or else we risk damage to the [color=#FFC000]life support[/color] system.",
		"helpingModule": MODULE_TYPE.COMPUTER,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.LIFE_SUPPORT, "failText": "[color=red]ALERT[/color]: Life Support system failure, damage = "}
	},
	2: {
		"text": "There's some debris buildup on the outside of the ship, which might affect our sensors.  One of the crew can go boost the [color=aqua]hull[/color] to help, or else the [color=#FFC000]sensors[/color] might take damage.",
		"helpingModule": MODULE_TYPE.HULL,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.SENSORS, "failText": "[color=red]ALERT[/color]: Sensors have failed, damage = "}
	},
	3: {
		"text": "We're seeing some potential anomalies in the nav system.  More [color=aqua]engine[/color] boost can recalibrate the bearings and prevent [color=#FFC000]navigation[/color] problems.",
		"helpingModule": MODULE_TYPE.ENGINE,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.NAVIGATION, "failText": "[color=red]ALERT[/color]: Damage to the navigation module, damage = "}
	},
	4: {
		"text": "The engine is overheating and leaking CO2.  Boosting [color=aqua]life support[/color] can help counteract the potential damage to the [color=#FFC000]engine[/color].",
		"helpingModule": MODULE_TYPE.LIFE_SUPPORT,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.ENGINE, "failText": "[color=red]ALERT[/color]: Engine power decreased, damage = "}
	},
	5: {
		"text": "Our [color=#FFC000]computers[/color] are reporting a potential malfunction.  A crewmember can help find the root cause by boosting the [color=aqua]sensors[/color].",
		"helpingModule": MODULE_TYPE.SENSORS,
		"startingOdds": 40,
		"failure": {"moduleId": MODULE_TYPE.COMPUTER, "failText": "[color=red]ALERT[/color]: Computer system failure, damage = "}
	},
}
