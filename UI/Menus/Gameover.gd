extends Control

#onready var _AnimatedSprite = $VBoxContainer/HBoxContainer/CharacterDeadAs/AnimatedSprite

func _ready():
	$VBoxContainer/Label2.text = str(GameState.age)
	$VBoxContainer/Label3.text = "Your best age: " + str(GameState.oldest_age)

	var animation_sprite = $VBoxContainer/HBoxContainer/CharacterDeadAs/AnimatedSprite_Male
	if !GameState.p1_is_male:
		animation_sprite = $VBoxContainer/HBoxContainer/CharacterDeadAs/AnimatedSprite_Female
		$VBoxContainer/HBoxContainer/CharacterDeadAs/AnimatedSprite_Male.visible = false
		$VBoxContainer/HBoxContainer/CharacterDeadAs/AnimatedSprite_Female.visible = true		
	else:
		$VBoxContainer/HBoxContainer/CharacterDeadAs/AnimatedSprite_Female.visible = false			
		$VBoxContainer/HBoxContainer/CharacterDeadAs/AnimatedSprite_Male.visible = true
	animation_sprite.frame = GameState.age_state


func _input(event):
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://Scenes/Levels/LevelTemplate.tscn")


func _on_BackToMenu_pressed():
	get_tree().change_scene("res://UI/Menus/MainMenu.tscn")


func _on_PlayAgain_pressed():
	get_tree().change_scene("res://Scenes/Levels/LevelTemplate.tscn")
