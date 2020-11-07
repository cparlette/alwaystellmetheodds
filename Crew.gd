extends Control

export(globals.CREW_NAMES) var crewNameInput
var crewName

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

