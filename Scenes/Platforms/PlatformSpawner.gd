extends Node

export var log_platform_y_pos = false

# Spawn Positions
var startX = -100
var endX = 950

var start_max_x = 400
var end_max_x = 600

var lowY = -2
var highY = 2

var last_platform_x = 999999
var min_platform_dist = 100

# Increments
var currentY = -600
#var currentY = 0
var incrementY = 40

# Min distance between platforms
#var min_platform_distance = 200

# Amount of platforms
var min_platforms = 2
var max_platforms = 3

# Math
#var distance_between_points = abs(startX) + abs(endX)

# Objects
var spawning_platform = false
var platform = preload("res://Scenes/Platforms/Platform.tscn")
var camera

func _ready():
	randomize()
	camera = get_node("../../Camera2D")
	
#	currentY = camera.position.y - 500
	pass

func _process(delta):
	GameState.camera_pos = camera.global_position
	
	if startX < start_max_x:
		startX += delta * 3
	if endX > end_max_x:
		endX -= delta * 3
#	print("startX = "+ str(startX)+ "		endX = "+ str(endX))
	
	
	if currentY > camera.global_position.y - 500 and spawning_platform == false:
		spawning_platform = true
		if log_platform_y_pos:
			print("Spawing Platform "+ str(currentY) +"		Camera pos y = "+ str(camera.position.y + 500))
		
		_calculate_random_position()
	
	pass
	

func _calculate_random_position():
	var platform_object = platform.instance()
	get_parent().add_child(platform_object)

	var randomX
	while(true):
		randomX = rand_range(startX, endX)
		if (abs(randomX - last_platform_x) > min_platform_dist):
#			print(str(abs(randomX - last_platform_x)))
			break
		else:
			continue
			
	platform_object.position.x = randomX
	
	var randomY = rand_range(lowY, highY)
	platform_object.position.y = currentY + randomY
	
	platform_object.create_platform(platform_object.position.x, platform_object.position.y)
	last_platform_x = platform_object.position.x
		
	currentY -= incrementY
	GameState.y_progress = currentY
	
	spawning_platform = false

#	var random_platforms_amount = int(rand_range(min_platforms, max_platforms + 1))
#	var pos_array = []
#	pos_array.resize(random_platforms_amount)
	
#	for n in random_platforms_amount:
#		var platform_object = platform.instance()
#		get_parent().add_child(platform_object)
#
#		var randomX = rand_range(startX, endX)
#		if n == 0:
#			pos_array[n] = randomX
#			platform_object.position.x = randomX
#			continue
#		else:
#			while(true):
#				randomX = rand_range(startX, endX)
#				if abs((randomX + 5000) - (pos_array[n - 1] + 5000)) < min_platform_distance:
##					print("HERE!")
#					continue
#				else:
#					pos_array[n] = randomX
#					break





	
	
	
