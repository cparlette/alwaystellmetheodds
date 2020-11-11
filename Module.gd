extends Control

export(globals.MODULE_TYPE) var type
var power = 0
var moduleName = ""
var changeAmount = 5
var health = 100
var bonus = 0
var repair = 0

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
	var newText = "[center]Power: " + str(power) + "% "
	if bonus > 0:
		newText += "[color=lime] + " + str(bonus) + " %[/color] \n "
	else:
		newText += "\n "
	newText += "Health: " + str(health) + "%"
	if repair > 0 and health < 100:
		if repair + health >= 100:
			newText += "[color=lime] + " + str((100 - health)) + "%[/color]"
		else:
			newText += "[color=lime] + " + str(repair) + "%[/color]"
	newText += "[/center]"
	$PercentLabel.bbcode_text = newText

func _on_Plus_pressed():
	if globals.shipPowerCurrent < globals.shipPowerMax:
		power += changeAmount
		globals.shipPowerCurrent += 1
		updateModuleUI()
		emit_signal("module_change")

func _on_Minus_pressed():
	if power >= changeAmount and globals.shipPowerCurrent > 0:
		power -= changeAmount
		globals.shipPowerCurrent -= 1
		updateModuleUI()
		emit_signal("module_change")

func causeDamage(damageAmount):
	health -= damageAmount
	updateModuleUI()
	if health == 0:
		emit_signal("game_over")
