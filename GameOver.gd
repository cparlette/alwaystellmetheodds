extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$ScoreText.text = str(globals.roundNumber) + " rounds completed"
	if globals.distanceTraveled >= globals.destinationTotalDistance:
		# win
		$Background.color = Color("5a7e3f")
	else:
		# lose
		$Background.color = Color("826363")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("MainMenu.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
