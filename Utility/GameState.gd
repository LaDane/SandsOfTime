extends Node

# Gets set in PlatformSpawner
var camera_pos
var y_progress

var master_volume = -5
var SFX_volume = -5
var music_volume = -5

var game_progress = 0
var game_interval = 50

# Age
var age = 0
var age_state = 0
var oldest_age = 0

# Character and 2 player
var is_male = true
var is_2_player = false

var p1_is_male = true
var p2_is_male = false


# Platforms
var max_platform_length_original = 13		# this value is used to subtract length
var max_platform_length_current

func restart():
	print("Gamestate restart worked")
	get_tree().change_scene("res://Scenes/Levels/LevelTemplate.tscn")
	age = 0


func _ready():
	AudioServer.set_bus_volume_db(0, GameState.master_volume)
	AudioServer.set_bus_volume_db(1, GameState.SFX_volume)
	AudioServer.set_bus_volume_db(2, GameState.music_volume)
