extends Control

export(globals.MODULE_TYPE) var type
var moduleName = ""
var changeAmount = 5
var health = 100
var boost = 0
var repair = 0

signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	if type == globals.MODULE_TYPE.ENGINE:
		moduleName = "Engine"
	elif type == globals.MODULE_TYPE.NAVIGATION:
		moduleName = "Navigation"
	elif type == globals.MODULE_TYPE.COMPUTER:
		moduleName = "Computer"
	elif type == globals.MODULE_TYPE.LIFE_SUPPORT:
		moduleName = "Life Support"
	elif type == globals.MODULE_TYPE.HULL:
		moduleName = "Hull"
	elif type == globals.MODULE_TYPE.SENSORS:
		moduleName = "Sensors"
	$NameLabel.text = moduleName
	updateModuleUI()

func updateModuleUI():
	var newText = "[center]Boost: "
	if boost == 0:
		newText += "0%\n"
	else:
		newText += "[color=lime] +" + str(boost) + " %[/color] \n "
	newText += "Health: " + str(health) + "%"
	if repair > 0 and health < 100:
		if repair + health >= 100:
			newText += "[color=lime] + " + str((100 - health)) + "%[/color]"
		else:
			newText += "[color=lime] + " + str(repair) + "%[/color]"
	newText += "[/center]"
	$PercentLabel.bbcode_text = newText
	# update module background color
	if health == 100:
		#green
		$Background.color = Color("5a7e3f")
	elif health > 50:
		#yellow
		$Background.color = Color("7f8263")
	else:
		#red
		$Background.color = Color("826363")


func causeDamage(damageAmount):
	health -= damageAmount
	updateModuleUI()
	if health == 0:
		emit_signal("game_over")
