extends Control


func _ready():
	pass
	

func _on_PlayGame_pressed():
	get_tree().change_scene("res://UI/Menus/CharacterSelection/CharacterSelection.tscn")


func _on_Tutorial_pressed():
	get_tree().change_scene("res://UI/Menus/Tutorial/Tutorial.tscn")


func _on_Credits_pressed():
		get_tree().change_scene("res://UI/Menus/Credits/CreditsMenu.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Options_pressed():
	get_tree().change_scene("res://UI/Menus/Options/Options.tscn")
