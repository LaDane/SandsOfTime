extends KinematicBody2D

# Platform length
var platform_length_min = 3
#var platform_length_max = 13

# Objects
var tile_left = preload("res://Scenes/Levels/TileSprites/GlassTiles/GlassTile_Left.tscn")
var tile_mid = preload("res://Scenes/Levels/TileSprites/GlassTiles/GlassTile_Mid.tscn")
var tile_right = preload("res://Scenes/Levels/TileSprites/GlassTiles/GlassTile_Right.tscn")
var camera

# Called when the node enters the scene tree for the first time.
func _ready():
#	camera = get_node("../../Camera2D")
	pass

func create_platform(var posX, var posY):
	_calc_platform_length()
	
	var platform_length = int(rand_range(platform_length_min, GameState.max_platform_length_current + 1))
#	print("Max Length = "+ str(GameState.max_platform_length_current) +"		Random Length = "+ str(platform_length))
	
	for n in platform_length:
		var tile_current
		
		if n == 0:
			tile_current = tile_left.instance()
		elif n == platform_length-1:
			tile_current = tile_right.instance()
		else:
			tile_current = tile_mid.instance()

		get_parent().add_child(tile_current)

		tile_current.position.x = posX + (n * 19)
		tile_current.position.y = posY


func _calc_platform_length():
	match GameState.age:
		10:
			GameState.max_platform_length_current = GameState.max_platform_length_original - 1
		20:
			GameState.max_platform_length_current = GameState.max_platform_length_original - 2
		30:
			GameState.max_platform_length_current = GameState.max_platform_length_original - 3
		45:
			GameState.max_platform_length_current = GameState.max_platform_length_original - 4
		60:
			GameState.max_platform_length_current = GameState.max_platform_length_original - 5
		80:
			GameState.max_platform_length_current = GameState.max_platform_length_original - 6
		100:
			GameState.max_platform_length_current = GameState.max_platform_length_original - 7
		120:
			GameState.max_platform_length_current = GameState.max_platform_length_original - 8
			


func _process(delta):
	pass

