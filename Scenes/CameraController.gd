extends Camera2D

export var speed = 0.5
var amount_of_deaths = 0


func _ready():
	amount_of_deaths = 0

func _physics_process(delta):
	adjust_speed()
	position.y -= speed


func _on_SlowZone_body_exited(body):
	if body.has_method("toggle_sand"):
		body.toggle_sand()


func _on_SlowZone_body_entered(body):
	if body.has_method("toggle_sand"):
		body.toggle_sand()


func _on_Sand_body_entered(body):
	if !body.has_method("movement"):
		body.queue_free()
	else:
		#GameState.restart()
		if GameState.is_2_player:
			amount_of_deaths += 1
			if amount_of_deaths >= 2:
				game_over_screen()
		else:			# 1 player
			game_over_screen()


func game_over_screen():
	get_tree().change_scene("res://UI/Menus/Gameover.tscn")
	if GameState.age > GameState.oldest_age:
		GameState.oldest_age = GameState.age


func adjust_speed():
	match GameState.age:
		0:
			speed = 1.25
		5:
			speed = 1.5
		10:
			speed = 1.75
		20:
			speed = 2
		30:
			speed = 2.25
		45:
			speed = 2.5
		60:
			speed = 2.75
		80:
			speed = 3
		100:
			speed = 3.25
