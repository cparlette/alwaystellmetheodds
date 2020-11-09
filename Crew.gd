extends Control

export(globals.CREW_NAMES) var crewNameInput
var crewName
const choices = {
	0: "Engine",
	1: "Controls",
	2: "Computer",
	3: "Life Support",
	4: "Hull",
	5: "Communications"
}

var moduleAssigned = 0
var taskAssigned = 0

signal crew_AssignmentChanged

# Called when the node enters the scene tree for the first time.
func _ready():
	if crewNameInput == globals.CREW_NAMES.Ann:
		crewName = "Ann"
	elif crewNameInput == globals.CREW_NAMES.Bob:
		crewName = "Bob"
	elif crewNameInput == globals.CREW_NAMES.Chad:
		crewName = "Chad"
	elif crewNameInput == globals.CREW_NAMES.Deb:
		crewName = "Deb"
	$NameLabel.text = crewName


func _on_ModuleOption_item_selected(index):
	moduleAssigned = index
	emit_signal("crew_AssignmentChanged")


func _on_TaskOption_item_selected(index):
	taskAssigned = index
	emit_signal("crew_AssignmentChanged")
