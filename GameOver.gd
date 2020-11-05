extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$ScoreText.text = str(globals.roundNumber) + " rounds completed"

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("MainMenu.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
