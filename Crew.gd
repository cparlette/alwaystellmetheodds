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

var crewChoice = 0

signal crew_choice

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


func _on_Assignment_item_selected(index):
	crewChoice = index
	emit_signal("crew_choice")
