extends Control

var powerEmpty = load("res://PowerEmpty.tscn")
var powerFilled = load("res://PowerFilled.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	refreshPowerIndicators()

func refreshPowerIndicators():
	print("Refreshing power indicators")
	for child in $PowerIndicators.get_children():
		$PowerIndicators.remove_child(child)
	for i in range(globals.shipPowerCurrent):
		var newNode = powerFilled.instance()
		$PowerIndicators.add_child(newNode)
		print("Added filled orange sprite")
	for i in range(globals.shipPowerCurrent, globals.shipPowerMax):
		var newNode = powerEmpty.instance()
		$PowerIndicators.add_child(newNode)
		print("Added empty sprite")
