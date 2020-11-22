extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var newText = str(globals.roundNumber) + " rounds completed\n"
	if globals.distanceTraveled >= globals.destinationMoon['distance']:
		# win
		$Background.color = Color("5a7e3f")
		newText += "You successfully made it to " + globals.destinationMoon['name'] + "!\n"
		newText += str(globals.distanceTraveled) +  " million miles traveled\n"
	else:
		# lose
		$Background.color = Color("826363")
		newText += str(globals.distanceTraveled) +  " million miles traveled\n"
		newText += str(globals.destinationMoon['distance'] - globals.distanceTraveled) + " million miles remained"
	$ScoreText.text = newText

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("MainMenu.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
