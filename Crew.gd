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
	$BoostCheck.pressed = true


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
	# uncomment this to display just numbers
	#$XPLevel.text = newCrewUItext
	
	var newXPnumberText = ""
	for i in level:
		if level[i] == 0:
			newXPnumberText += "[color=#02020C]0[/color]\n"
		else:
			newXPnumberText += "[color=#26A9E0]"+str(level[i])+"[/color]\n"
	$XPNumber.bbcode_text = newXPnumberText
	
	$EngBar.value = level[0]
	$EngBar.hint_tooltip = "Engine Level "+str(level[0])
	$NavBar.value = level[1]
	$NavBar.hint_tooltip = "Navigation Level "+str(level[1])
	$ComBar.value = level[2]
	$ComBar.hint_tooltip = "Computers Level "+str(level[2])
	$LifeBar.value = level[3]
	$LifeBar.hint_tooltip = "Life Support Level "+str(level[3])
	$HulBar.value = level[4]
	$HulBar.hint_tooltip = "Hull Level "+str(level[4])
	$SenBar.value = level[5]
	$SenBar.hint_tooltip = "Sensors Level "+str(level[5])

func getLevel(moduleID):
	return level[moduleID]


func _on_BoostCheck_toggled(button_pressed):
	taskAssigned = 0
	#$BoostCheck.button_pressed = true
	#$RepairCheck.button_pressed = false
	emit_signal("crew_AssignmentChanged")


func _on_RepairCheck_toggled(button_pressed):
	taskAssigned = 1
	#$BoostCheck.button_pressed = false
	#$RepairCheck.button_pressed = true
	emit_signal("crew_AssignmentChanged")
