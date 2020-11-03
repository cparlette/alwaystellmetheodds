extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_Quit_pressed():
	get_tree().quit()


func _on_NewGame_pressed():
	get_tree().change_scene("Game.tscn")
