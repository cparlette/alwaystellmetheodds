extends Control

export(globals.MODULE_TYPE) var type
var percentage = 90
var moduleName = ""
var changeAmount = 5
var maxPercentage = 100
var bonus = 0

signal module_change
signal game_over

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
	if bonus > 0:
		$PercentLabel.text = str(percentage) + "% + " + str(bonus) + " % / " + str(maxPercentage) + "%"
	else:
		$PercentLabel.text = str(percentage) + "% / " + str(maxPercentage) + "%"

func _on_Plus_pressed():
	if percentage <= (maxPercentage - changeAmount) and globals.shipPowerCurrent < globals.shipPowerMax:
		percentage += changeAmount
		globals.shipPowerCurrent += 1
		updateModuleUI()
		emit_signal("module_change")

func _on_Minus_pressed():
	if percentage >= changeAmount and globals.shipPowerCurrent > 0:
		percentage -= changeAmount
		globals.shipPowerCurrent -= 1
		updateModuleUI()
		emit_signal("module_change")

func causeDamage(damageAmount):
	maxPercentage -= damageAmount
	if percentage > maxPercentage:
		percentage = maxPercentage
	updateModuleUI()
	if maxPercentage == 0:
		emit_signal("game_over")
