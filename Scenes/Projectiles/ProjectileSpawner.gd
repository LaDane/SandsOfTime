extends Node

# Positions
var spawn_range_x_low = 250
var spawn_range_x_high = 750
var spawn_y

# Spawn chance
var spawn_modulo = 200			# defualt value, gets changed in code
var spawn_rate_low = 50
var spawn_rate_high = 200		# lower number = more meteors


#var spawn_rate_start = 10
var delta_stack = 0
var start_tick = 0
var spawn_tick_trigger = 1000
var spawn_current_tick = 300


#var spawn_rate_limit = 90		# high number = lower chance of spawning
#var spawn_range_top = 100		# max to generate random numbers to

# Objects
var meteor_small = preload("res://Scenes/Projectiles/Projectile.tscn")
var has_spawned = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_y = GameState.y_progress
#
#	delta_stack += delta
#
#	print(delta_stack)
#	if int(delta)%10 == 1:
#		print(spawn_y)

	var random_tick = int(rand_range(1, 3))
#	var start_tick = GameState.age + spawn_rate_start
	spawn_current_tick += random_tick + int(GameState.age / 10)
#	print(spawn_current_tick)
	if spawn_current_tick > spawn_tick_trigger:
		spawn_metoer()
		spawn_current_tick = start_tick

#	print(abs(int(GameState.camera_pos.y)%spawn_modulo))
#	if abs(int(GameState.camera_pos.y)%spawn_modulo) == 10 and has_spawned == false:
#		has_spawned = true		
#		spawn_metoer()
#
#	if abs(int(GameState.camera_pos.y)%spawn_modulo) == 20 and has_spawned == true:
#		has_spawned = false
#		spawn_modulo = int(rand_range(spawn_rate_low, spawn_rate_high))
	

func spawn_metoer():
#		print("SPAWNED METOER!")
		var meteor_object = meteor_small.instance()
		get_parent().add_child(meteor_object)
		var spawn_x = rand_range(spawn_range_x_low, spawn_range_x_high)
		meteor_object.position.x = spawn_x
		meteor_object.position.y = spawn_y
		
		
		
		
		
		
		
		
