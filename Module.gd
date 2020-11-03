extends Control

export(globals.MODULE_TYPE) var type
var percentage = 90
var moduleName = ""
var changeAmount = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	if type == globals.MODULE_TYPE.ENGINE:
		moduleName = "Engine"
	elif type == globals.MODULE_TYPE.CONTROLS:
		moduleName = "Controls"
	elif type == globals.MODULE_TYPE.COMPUTER:
		moduleName = "Computer"
	elif type == globals.MODULE_TYPE.LIFE_SUPPORT:
		moduleName = "Life Support"
	elif type == globals.MODULE_TYPE.HULL:
		moduleName = "Hull"
	elif type == globals.MODULE_TYPE.COMMUNICATIONS:
		moduleName = "Communications"
	$NameLabel.text = moduleName
	updateModuleUI()

func updateModuleUI():
	$PercentLabel.text = str(percentage) + " %"

func _on_Plus_pressed():
	if percentage <= (100 - changeAmount):
		percentage += changeAmount
		updateModuleUI()

func _on_Minus_pressed():
	if percentage >= changeAmount:
		percentage -= changeAmount
		updateModuleUI()
