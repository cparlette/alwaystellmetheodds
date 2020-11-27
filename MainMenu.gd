extends Node2D

var getLeaderboardAPI = "https://l97hrnxo39.execute-api.us-east-1.amazonaws.com/default/atmto-getLeaderboard"

func _ready():
	$EnterNameMenu.visible = false
	$Leaderboard.visible = false
	$NewGameMenu.visible = true
	for moonNum in globals.possibleMoons:
		var moon = globals.possibleMoons[moonNum]
		var optionString = moon['name']
		optionString += " - " + moon['difficulty']
		$EnterNameMenu/MoonOption.add_item(optionString, moon['moonID'])
	$EnterNameMenu/MoonOption.selected = 0
	buildLeaderboard()

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


func _on_Leaderboard_pressed():
	$EnterNameMenu.visible = false
	$NewGameMenu.visible = false
	$Leaderboard.visible = true


func _on_HowToPlay_pressed():
	$HowToPlayDialog.visible = true


func buildLeaderboard():
	$Leaderboard/HTTPRequest.request(getLeaderboardAPI)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = parse_json(body.get_string_from_utf8())
	var phobos = []
	var ganymede = []
	var titan = []
	var oberon = []
	for entry in json:
		if entry['moon'] == "Phobos":
			phobos.append(entry)
		elif entry['moon'] == "Ganymede":
			ganymede.append(entry)
		elif entry['moon'] == "Titan":
			titan.append(entry)
		elif entry['moon'] == "Oberon":
			oberon.append(entry)
	phobos.sort_custom(MyCustomSorter, "customComparison")
	ganymede.sort_custom(MyCustomSorter, "customComparison")
	titan.sort_custom(MyCustomSorter, "customComparison")
	oberon.sort_custom(MyCustomSorter, "customComparison")
	displayScores(phobos, $Leaderboard/TabContainer/Phobos)
	displayScores(ganymede, $Leaderboard/TabContainer/Ganymede)
	displayScores(titan, $Leaderboard/TabContainer/Titan)
	displayScores(oberon, $Leaderboard/TabContainer/Oberon)

func displayScores(scoreList, hbox):
	var maxEntriesToShow = 25
	var currentEntries = 0
	for entry in scoreList:
		if currentEntries < maxEntriesToShow:
			currentEntries += 1
			var newName = Label.new()
			newName.text = entry['name']
			var newScore = Label.new()
			newScore.text = str(entry['score'])
			var newDate = Label.new()
			var dateDict = OS.get_datetime_from_unix_time(int(entry['timestamp']))
			newDate.text = str(dateDict['year']) + "-" + str(dateDict['month']) + "-" + str(dateDict['day'])
			var newVictory = Label.new()
			if int(entry['victory']) == 0:
				newVictory.text = "No"
			else:
				newVictory.text = "Yes!"
			hbox.get_node("Name").add_child(newName)
			hbox.get_node("Score").add_child(newScore)
			hbox.get_node("Date").add_child(newDate)
			hbox.get_node("Victory").add_child(newVictory)

class MyCustomSorter:
	static func customComparison(a, b):
		if int(a['score']) > int(b['score']):
			return true
		elif int(a['score']) < int(b['score']):
			return false
		else:
			if int(a['timestamp']) < int(b['timestamp']):
				return true
			else:
				return false


func _on_BackToMainMenuFromLeaderboard_pressed():
	$EnterNameMenu.visible = false
	$Leaderboard.visible = false
	$NewGameMenu.visible = true


func _on_About_pressed():
	$AboutDialog.visible = true

