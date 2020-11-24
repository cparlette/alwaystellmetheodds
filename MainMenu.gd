extends Node2D

func _ready():
	$EnterNameMenu.visible = false
	$NewGameMenu.visible = true
	for moonNum in globals.possibleMoons:
		var moon = globals.possibleMoons[moonNum]
		var optionString = moon['name']
		optionString += " - " + moon['difficulty']
		$EnterNameMenu/MoonOption.add_item(optionString, moon['moonID'])
	$EnterNameMenu/MoonOption.selected = 0

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_Quit_pressed():
	get_tree().quit()


func _on_NewGame_pressed():
	$NewGameMenu.visible = false
	$EnterNameMenu.visible = true


func _on_StartGameButton_pressed():
	if $EnterNameMenu/CaptainName.text == "":
		globals.captainName = "Captain"
	else:
		globals.captainName = $EnterNameMenu/CaptainName.text
	if $EnterNameMenu/Crew1Name.text == "":
		globals.crew1Name = "Ann"
	else:
		globals.crew1Name = $EnterNameMenu/Crew1Name.text
	if $EnterNameMenu/Crew2Name.text == "":
		globals.crew2Name = "Bob"
	else:
		globals.crew2Name = $EnterNameMenu/Crew2Name.text
	if $EnterNameMenu/Crew3Name.text == "":
		globals.crew3Name = "Chad"
	else:
		globals.crew3Name = $EnterNameMenu/Crew3Name.text
	if $EnterNameMenu/MoonOption.selected == -1 or $EnterNameMenu/MoonOption.selected == 0:
		# Something wasn't picked, so choose the first option
		globals.destinationMoon = globals.possibleMoons[0]
	print("Destination moon is ",globals.destinationMoon)
	get_tree().change_scene("Game.tscn")


func _on_BackButton_pressed():
	$EnterNameMenu.visible = false
	$NewGameMenu.visible = true


func _on_MoonOption_item_selected(index):
	globals.destinationMoon = globals.possibleMoons[$EnterNameMenu/MoonOption.get_item_id(index)]
