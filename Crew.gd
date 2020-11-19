extends Control

export(globals.CREW_NAMES) var crewNameInput
var crewName
const choices = {
	0: "Engine",
	1: "Navigation",
	2: "Computer",
	3: "Life Support",
	4: "Hull",
	5: "Sensors"
}

var moduleAssigned = 0
var taskAssigned = 0
var xp = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0}
var level = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0}


signal crew_AssignmentChanged

# Called when the node enters the scene tree for the first time.
func _ready():
	if crewNameInput == globals.CREW_NAMES.Ann:
		crewName = globals.crew1Name
	elif crewNameInput == globals.CREW_NAMES.Bob:
		crewName = globals.crew2Name
	elif crewNameInput == globals.CREW_NAMES.Chad:
		crewName = globals.crew3Name
	elif crewNameInput == globals.CREW_NAMES.Deb:
		crewName = "Deb"
	$NameLabel.text = crewName


func _on_ModuleOption_item_selected(index):
	moduleAssigned = index
	emit_signal("crew_AssignmentChanged")


func _on_TaskOption_item_selected(index):
	taskAssigned = index
	emit_signal("crew_AssignmentChanged")

func raiseXP(xpGained):
	xp[moduleAssigned] += xpGained
	if xp[moduleAssigned] >= globals.xpLevels[level[moduleAssigned] + 1]:
		level[moduleAssigned] += 1
		globals.additionalOutputText += "[color=lime]BONUS[/color]: " + crewName + " has gained a level in " + choices[moduleAssigned] + "\n"
	updateCrewUI()

func updateCrewUI():
	var newCrewUItext = "ENG: " + str(level[0]) + "\n"
	newCrewUItext += "NAV: " + str(level[1]) + "\n"
	newCrewUItext += "COMP: " + str(level[2]) + "\n"
	newCrewUItext += "LIFE: " + str(level[3]) + "\n"
	newCrewUItext += "HULL: " + str(level[4]) + "\n"
	newCrewUItext += "SEN: " + str(level[5]) + "\n"
	$XPLevel.text = newCrewUItext

func getLevel(moduleID):
	return level[moduleID]
