extends Node2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for child in $Modules.get_children():
		child.connect("module_change", self, "updatePower")
		child.connect("game_over", self, "gameOver")


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("MainMenu.tscn")

func updatePower():
	$ShipPower.refreshPowerIndicators()


func _on_NewRoundButton_pressed():
	newRound()


func newRound():
	var newText = "Starting round " + str(globals.roundNumber) + "\n\n"
	globals.roundNumber += 1
	for module in $Modules.get_children():
		var randomNumber = rng.randi_range(0,100)
		if randomNumber > module.percentage:
			# Failure, so cause damage
			module.causeDamage(5)
			newText += "ALERT: Module "+module.moduleName+" took 5 damage!\n"
		else:
			newText += "Module "+module.moduleName+" is fine!\n"
	$Output/OutputText.text = newText
	

func gameOver():
	get_tree().change_scene("GameOver.tscn")
