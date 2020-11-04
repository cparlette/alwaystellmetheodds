extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in $Modules.get_children():
		child.connect("module_change", self, "updatePower")


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("MainMenu.tscn")

func updatePower():
	$ShipPower.refreshPowerIndicators()
