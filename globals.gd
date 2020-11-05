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

var shipPowerMax = 10
var shipPowerCurrent = 5

var roundNumber = 1
