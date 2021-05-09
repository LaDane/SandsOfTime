extends KinematicBody2D

# Speed
var speed = 0.7

# Position
var low_x = 0
var high_x = 1000

var is_moving = false
var random_x
var vector

var is_exploding = false
var delete_tick = 0
var delete_tick_trigger = 0.5
var playing_explode_sound = false

# impact FX
onready var AudioPlayer = $AudioStreamPlayer
onready var impactFX = preload("res://SFX/fx/impact.ogg")

# Particles
var meteor_trail_particles = preload("res://GFX/Particles/MeteorTrailParticle.tscn")
var meteor_explode_particles = preload("res://GFX/Particles/MeteorExplodeParticle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_exploding:
		if !playing_explode_sound:
			playing_explode_sound = true
			AudioPlayer.play()
			spawn_meteor_explode_particles(global_position.x, global_position.y, vector)
			
		delete_tick += delta
		if delete_tick > delete_tick_trigger:
			queue_free()
	
	if !is_moving:
		is_moving = true
		random_x = rand_range(low_x, high_x)
		
		var pos_y = position.y + 900
		vector = Vector2(random_x, pos_y)
		
	var position_difference = vector - position
	var velocity = position_difference * speed * delta
#	position += velocity
	
	var collision = move_and_collide(velocity)
	look_at(vector)
	
	if !is_exploding:
		spawn_meteor_particles(global_position.x, global_position.y, vector)
	
	if collision:
		if collision.collider.has_method("meteor_stun"):
#			print("Collided with player, starting explode anim")
			collision.collider.meteor_stun()
			$AnimatedSprite.play("Explode")
			is_exploding = true
	
	
func spawn_meteor_particles(pos_x, pos_y, look_vector):
	var meteor_particles = meteor_trail_particles.instance()
	get_parent().add_child(meteor_particles)
	meteor_particles.set_global_position(Vector2(pos_x, pos_y))
	meteor_particles.look_at(look_vector)
	meteor_particles.emitting = true	


func spawn_meteor_explode_particles(pos_x, pos_y, look_vector):
	var meteor_exp_particles = meteor_explode_particles.instance()
	get_parent().add_child(meteor_exp_particles)
	meteor_exp_particles.set_global_position(Vector2(pos_x, pos_y))
#	meteor_exp_particles.look_at(look_vector)
	meteor_exp_particles.emitting = true	

	

#func _on_AnimatedSprite_animation_finished():
#	if $AnimatedSprite.get_ani == "explode":
#		queue_free()
