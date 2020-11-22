extends Node2D

var rng = RandomNumberGenerator.new()
var distanceThisRound = 0
var currentEvent = {
		"text": "",
		"helpingModule": 1,
		"startingOdds": 50,
		"failure": {"moduleId": 4, "failText": ""}
	}
var currentEventOdds = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	globals.reinitializeGame()
	rng.randomize()
	for child in $Modules.get_children():
		child.connect("game_over", self, "gameOver")
	for person in $Crew.get_children():
		person.connect("crew_AssignmentChanged", self, "newCrewModuleAssigned")
		person.updateCrewUI()
	newCrewModuleAssigned()
	#updatePower()
	var initialText = "As you begin your journey to " + globals.destinationMoon['name']
	initialText += ", you ask the computer to calculate the odds of a successful mission.  Judging by the distance of " + str(globals.destinationMoon['distance'])
	initialText += " million miles, the computer reads a 1% overall success rate.\n\n"
	initialText += "Time to assign the crew to their initial tasks and start the journey."
	$NewRoundOutput/OutputText.bbcode_text = initialText


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("MainMenu.tscn")


func _on_NewRoundButton_pressed():
	newRound()

func newRound():
	var newText = "Starting round " + str(globals.roundNumber) + "\n\n"
	globals.roundNumber += 1
	globals.distanceTraveled += distanceThisRound
	if globals.distanceTraveled > globals.destinationMoon['distance']:
		gameOver()
	newText += " - Distance traveled this round: " + str(distanceThisRound) + " million miles\n"
	newText += " - Distance traveled so far: " + str(globals.distanceTraveled) + " million miles\n"
	newText += " - Distance to " + globals.destinationMoon['name'] + ": " + str(globals.destinationMoon['distance'] - globals.distanceTraveled) + " million miles\n\n"
	if currentEvent['text']:
		newText += resolveEvent()
	for module in $Modules.get_children():
		if module.repair > 0 and module.health < 100:
			newText += "[color=lime]REPAIR[/color]: Module "+module.moduleName+" has been repaired!\n"
			module.health += module.repair
			if module.health > 100:
				module.health = 100
		module.updateModuleUI()
	
	# Add xp to crew
	for person in $Crew.get_children():
		person.raiseXP(5)
	# update everything after XP given
	newCrewModuleAssigned()
	# get a new event
	var randomEventNumber = rng.randi_range(0,globals.randomEvents.size() - 1)
	currentEvent = globals.randomEvents[randomEventNumber]
	currentEventOdds = currentEvent['startingOdds']
	updateEventOutput()
	# add any additional text from the global var, then reset it
	newText += globals.additionalOutputText
	globals.additionalOutputText = ""
	$NewRoundOutput/OutputText.bbcode_text = newText

func resolveEvent():
	var randomNumber = rng.randi_range(0,100)
	if randomNumber <= currentEventOdds:
		return "No damage taken this round\n"
	else:
		var affectedModule = $Modules.get_child(currentEvent['failure']['moduleId'])
		var damageTotal = randomNumber - currentEventOdds
		affectedModule.causeDamage(damageTotal)
		return (currentEvent['failure']['failText'] + str(damageTotal)) + "\n"
	

func updateEventOutput():
	if currentEvent['text']:
		# Damaged sensors reduces event output
		var newEventText = ""
		if $Modules/Sensors.health < 33:
			newEventText += "[color=red]ERROR[/color]: Event information unavailable due to damaged sensors!"
		else:
			newEventText += currentEvent['text'] + "\n\n"
			currentEventOdds = currentEvent['startingOdds']
			var helpingModule = $Modules.get_child(currentEvent['helpingModule'])
			currentEventOdds += helpingModule.boost
			if $Modules/Sensors.health > 66:
				newEventText += "Current Odds: " + str(currentEventOdds)
			else:
				newEventText += "[color=yellow]WARNING[/color]: Current odds unavailable due to damaged sensors!"
		$EventOutput/OutputText.bbcode_text = newEventText


func gameOver():
	get_tree().change_scene("GameOver.tscn")


func newCrewModuleAssigned():
	for module in $Modules.get_children():
		module.boost = 0
		module.repair = 0
	for person in $Crew.get_children():
		var changedModule = $Modules.get_child(person.moduleAssigned)
		# Crew bonus to module is 5x their module level
		var changeAmount = (3 * (person.getLevel(person.moduleAssigned) + 1))
		# Reduce crew effectiveness if life support is damaged
		var percentChange = float($"Modules/Life Support".health) / 100.0
		var newChangeAmount = float(changeAmount) * percentChange
		changeAmount = int(newChangeAmount)
		if person.taskAssigned == 0:
			changedModule.boost += changeAmount
		elif person.taskAssigned == 1:
			changedModule.repair += changeAmount
	for module in $Modules.get_children():
		module.updateModuleUI()
	calculateDistanceThisRound()
	updateEventOutput()
	

func calculateDistanceThisRound():
	distanceThisRound = 0
	# any damage to the engines will reduce distance traveled
	distanceThisRound += $Modules/Engine.boost * ($Modules/Engine.health / 100.0)
