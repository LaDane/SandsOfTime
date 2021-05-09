extends Control

var maleSprite = preload("res://Scenes/Characters/Player/PlayerSprites/AgingSprites/PC_test_aging5.png")
var femaleSprite = preload("res://Scenes/Characters/Player/PlayerSprites/AgingSprites/PC_Female5.png")

var singleplayer_is_male = true
var player1_is_male = true
var player2_is_male = false

var gamemode_toggle = true

func _process(delta):
	if singleplayer_is_male:
		$VBoxContainer/VBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer/SingleplayerTextureRect.texture = maleSprite
	else:
		$VBoxContainer/VBoxContainer2/VBoxContainer/VBoxContainer/HBoxContainer/SingleplayerTextureRect.texture = femaleSprite

	if player1_is_male:
		$VBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer3/HBoxContainer2/HBoxContainer/TextureRect2.texture = maleSprite
	else:
		$VBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer3/HBoxContainer2/HBoxContainer/TextureRect2.texture = femaleSprite

	if player2_is_male:
		$VBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer3/HBoxContainer2/HBoxContainer2/TextureRect.texture = maleSprite
	else:
		$VBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer3/HBoxContainer2/HBoxContainer2/TextureRect.texture = femaleSprite


	if gamemode_toggle:
		$VBoxContainer/VBoxContainer2/VBoxContainer/VBoxContainer.show()
		$VBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer3.hide()
	else:
		$VBoxContainer/VBoxContainer2/VBoxContainer/VBoxContainer.hide()
		$VBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer3.show()

func _on_Button2_pressed():
	singleplayer_is_male = !singleplayer_is_male


func _on_CheckButton_toggled(button_pressed):
	gamemode_toggle = !gamemode_toggle
	GameState.is_2_player = !GameState.is_2_player


func _on_MP2Right_pressed():
	player2_is_male = !player2_is_male
	GameState.p2_is_male = !GameState.p2_is_male


func _on_MP2Left_pressed():
	player2_is_male = !player2_is_male
	GameState.p2_is_male = !GameState.p2_is_male


func _on_MP1Right_pressed():
	player1_is_male = !player1_is_male
	GameState.p1_is_male = !GameState.p1_is_male


func _on_MP1Left_pressed():
	player1_is_male = !player1_is_male
	GameState.p1_is_male = !GameState.p1_is_male


func _on_SingleplayerLeft_pressed():
	singleplayer_is_male = !singleplayer_is_male
	GameState.p1_is_male = !GameState.p1_is_male


func _on_SingleplayerRight_pressed():
	singleplayer_is_male = !singleplayer_is_male
	GameState.p1_is_male = !GameState.p1_is_male


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/LevelTemplate.tscn")
