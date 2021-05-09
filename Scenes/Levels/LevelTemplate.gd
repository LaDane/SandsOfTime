extends Node2D

onready var AgeLabel = $CanvasLayer/Control/AgeLabel
onready var HighScoreLabel = $CanvasLayer/Control/HighScoreLabel

onready var progress = GameState.game_progress
onready var AudioPlayer = $AudioStreamPlayer
onready var AudioPlayer2 = $AudioStreamPlayer2


func _ready():
	GameState.age = 0
	GameState.game_progress = 0
	GameState.max_platform_length_current = GameState.max_platform_length_original
	LobbyMusic.playing = false
	if GameState.is_2_player == false:
		$Player2.queue_free()



func _physics_process(delta):
	AgeLabel.text = "Age: " + str(GameState.age)
	
	if GameState.oldest_age == 0:
		HighScoreLabel.text = "High score: "+ str(GameState.age)
	elif GameState.oldest_age < GameState.age:
		HighScoreLabel.text = "High score: "+ str(GameState.age)
	else:
		HighScoreLabel.text = "High score: "+ str(GameState.oldest_age)

	GameState.game_progress += 1
	
	if GameState.game_progress % GameState.game_interval == 10:
		GameState.age += 1
	
func _on_AudioStreamPlayer_finished():
	AudioPlayer2.play()
