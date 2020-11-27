extends Node2D

var postToLeaderboardURL = "https://n66ezcafo7.execute-api.us-east-1.amazonaws.com/default/atmto-addScoreToLeaderboard"
var victory = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var newText = str(globals.roundNumber) + " rounds completed\n"
	if globals.distanceTraveled >= globals.destinationMoon['distance']:
		# win
		victory = 1
		$Background.color = Color("5a7e3f")
		newText += "You successfully made it to " + globals.destinationMoon['name'] + "!\n"
		newText += str(globals.distanceTraveled) +  " million miles traveled\n"
	else:
		# lose
		$Background.color = Color("826363")
		newText += str(globals.distanceTraveled) +  " million miles traveled\n"
		newText += str(globals.destinationMoon['distance'] - globals.distanceTraveled) + " million miles remained\n"
	newText += "Score: " + str(globals.score)
	$ScoreText.text = newText
	
	# Pull the current captain name
	$LeaderboardEntry/NameEntry.text = globals.captainName

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("MainMenu.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_NameSubmit_pressed():
	if $LeaderboardEntry/NameEntry.text == "":
		pass
	else:
		globals.captainName = $LeaderboardEntry/NameEntry.text
		# Send to leaderboard
		var data = {
			'name': globals.captainName,
			'score': globals.score,
			'timestamp': OS.get_unix_time(),
			'moon': globals.destinationMoon['name'],
			'victory': victory
		}
		var query = JSON.print(data)
		var headers = ["Content-Type: application/json"]
		$LeaderboardEntry/HTTPRequest.request(postToLeaderboardURL, headers, true, HTTPClient.METHOD_POST, query)
		$LeaderboardEntry.visible = false
