extends KinematicBody2D

# Players
export var is_player_2 = false
export var is_male = true
var animated_sprite
var animated_sprite_run

# Vector
const UP = Vector2(0, -1)
var velocity = Vector2()
var movement = Vector2()

# Movement
var speed = 400
var speed_org
var gravity = 1800
var jump_force = -750
var in_sand = false

# Stun stuff
var is_stunned = false
var stunned_time = 0.9
var stunned_tick = 0
var playing_hit_sound = false

# Jump
var is_jumping = false

# Particles
var delta_time = 0
var delta_time_int = 0
var move_trail_particle = preload("res://GFX/Particles/MoveTrailParticles.tscn")
var glass_jump_particle = preload("res://GFX/Particles/GlassJumpConfetti.tscn")
var age_up_particle = preload("res://GFX/Particles/AgeUpParticle.tscn")

# Midlertidig highscore variabel, der styrer age animatoren
var highscore = 0

# preload VA files
onready var baby = preload("res://SFX/va/hit_baby.ogg")
onready var young1 = preload("res://SFX/va/hit_young1.ogg")
onready var young2 = preload("res://SFX/va/hit_young2.ogg")
onready var old1 = preload("res://SFX/va/hit_old1.ogg")
onready var old2 = preload("res://SFX/va/hit_old2.ogg")
onready var death = preload("res://SFX/va/death.ogg")

onready var AnimatedSpriteAge = $AnimatedSprite_Age
onready var AnimatedSpriteRun = $AnimatedSprite_Run


func _ready():
	speed_org = speed
	if !is_player_2:
		print(GameState.p1_is_male)
		is_male = GameState.p1_is_male
	else:
		is_male = GameState.p2_is_male

	if !GameState.is_2_player and is_player_2:
		visible = false
		

func _physics_process(delta):
	age_animate()
	adjust_physics()
	movement(delta)

	delta_time += delta * 5
	if int(delta_time) != delta_time_int:
		delta_time_int = int(delta_time)
		spawn_move_trail_particles(global_position.x, global_position.y)


# Switch case der styrer playerens animated sprite
func age_animate():
	animated_sprite = $AnimatedSprite_Age_Male
	animated_sprite_run = $AnimatedSprite_Run_Male
	if !is_male:
		print("here")
		animated_sprite.visible = false
		animated_sprite_run.visible = false
		animated_sprite = $AnimatedSprite_Age_Female
		animated_sprite_run = $AnimatedSprite_Run_Female
		animated_sprite.visible = true
		animated_sprite_run.visible = true
#	else:
#		animated_sprite = $AnimatedSprite_Age_Man
#		animated_sprite = $AnimatedSprite_Age_Female
	
	match GameState.age:
		0:
			animated_sprite.play("Age0")
			$va_player.stream = baby
			if GameState.age_state != 0:
				GameState.age_state = 0
				spawn_age_up_particles(global_position.x, global_position.y)
		5:
			animated_sprite.play("Age1")
			if GameState.age_state != 1:
				GameState.age_state = 1
				spawn_age_up_particles(global_position.x, global_position.y)
		10:
			animated_sprite.play("Age2")
			if GameState.age_state != 2:
				GameState.age_state = 2
				spawn_age_up_particles(global_position.x, global_position.y)
		20:
			animated_sprite.play("Age3")
			$va_player.stream = young1
			if GameState.age_state != 3:
				GameState.age_state = 3
				spawn_age_up_particles(global_position.x, global_position.y)
		30:
			animated_sprite.play("Age4")
			$va_player.stream = young2
			if GameState.age_state != 4:
				GameState.age_state = 4
				spawn_age_up_particles(global_position.x, global_position.y)
		45:
			animated_sprite.play("Age5")
			$va_player.stream = old1
			if GameState.age_state != 5:
				GameState.age_state = 5
				spawn_age_up_particles(global_position.x, global_position.y)
		60:
			animated_sprite.play("Age6")
			if GameState.age_state != 6:
				GameState.age_state = 6
				spawn_age_up_particles(global_position.x, global_position.y)
		80:
			animated_sprite.play("Age7")
			$va_player.stream = old2
			if GameState.age_state != 7:
				GameState.age_state = 7
				spawn_age_up_particles(global_position.x, global_position.y)
		100:
			animated_sprite.play("Age8")
			if GameState.age_state != 8:
				GameState.age_state = 8
				spawn_age_up_particles(global_position.x, global_position.y)

func movement(delta):
	if is_stunned:
		stunned_tick += delta
#		print(stunned_tick)
		if stunned_tick > stunned_time:
			is_stunned = false
			stunned_tick = 0
			playing_hit_sound = false
	
	if is_stunned:
		speed = 0
	else:
		speed = speed_org
		
	var right_button
	var left_button
	var jump_button
		
	if !is_player_2:			# player 1
		right_button = "right"
		left_button = "left"
		jump_button = "jump"
	else:						# player 2
		right_button = "right2"
		left_button = "left2"
		jump_button = "jump2"		
		
	movement.x = Input.get_action_strength(right_button) - Input.get_action_strength(left_button)
	movement.x = movement.x * speed
	
	if movement.x < 0:
		animated_sprite.flip_h = true
		animated_sprite_run.flip_h = true
	elif movement.x > 0:
		animated_sprite.flip_h = false
		animated_sprite_run.flip_h = false
	else:
		pass
	
		
	if Input.is_action_just_pressed(jump_button) and is_on_floor() && !is_stunned:
		movement.y = jump_force
		if is_jumping == false:
			is_jumping = true
			spawn_glass_particles(global_position.x, global_position.y)
	elif Input.is_action_just_released(jump_button) and !is_on_floor() and !is_stunned:
		movement.y = movement.y / 2
		
	elif is_on_floor():
		if is_jumping:
			spawn_glass_particles(global_position.x, global_position.y)
		is_jumping = false
		pass
	else:
		movement.y += gravity * delta
		
	if movement.x:
		#Player_Movement_X Animation here
		animated_sprite_run.play("Run")
	else:
		animated_sprite_run.play("Idle")
	
	move_and_slide(movement, UP, false)


func hurt_anim():
	 $AnimationPlayer.play("HurtAnimation")


func meteor_stun():
	hurt_anim()
	is_stunned = true
	if !playing_hit_sound:
		$va_player.play()
		playing_hit_sound = true
#	print("Player is stunned!")


func spawn_glass_particles(var pos_x, var pos_y):
	var jump_particles = glass_jump_particle.instance()
	get_parent().add_child(jump_particles)
	jump_particles.set_global_position(Vector2(pos_x, pos_y + 31))
	jump_particles.emitting = true


func spawn_move_trail_particles(var pos_x, var pos_y):
	var move_particles = move_trail_particle.instance()
	get_parent().add_child(move_particles)
	move_particles.set_global_position(Vector2(pos_x, pos_y + 31))
	move_particles.emitting = true


func spawn_age_up_particles(var pos_x, var pos_y):
	var age_particles = age_up_particle.instance()
	add_child(age_particles)
	age_particles.set_global_position(Vector2(global_position.x, global_position.y))
	age_particles.emitting = true


func adjust_physics():
	if in_sand:
		speed = 200
		gravity = 1000
		jump_force = -500
	else:
		speed = 400
		gravity = 1800
		jump_force = -750


func toggle_sand():
	if !in_sand:
		$va_player.stream = death
		$va_player.play()
		
	in_sand = !in_sand

# Timer der lægger til highscoren
func _on_Timer_timeout():
	highscore += 1
	
