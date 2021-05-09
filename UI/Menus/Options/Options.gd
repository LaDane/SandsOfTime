extends Control


func _ready():
	$VBoxContainer/MasterSlider.value = GameState.master_volume
	$VBoxContainer/MusicSlider.value = GameState.music_volume
	$VBoxContainer/SoundSlider.value = GameState.SFX_volume


func _on_SoundSlider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)
	GameState.SFX_volume = value


func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)
	GameState.music_volume = value

func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	GameState.master_volume = value


func _on_Button_pressed():
	get_tree().change_scene("res://UI/Menus/MainMenu.tscn")


func _on_CheckBox_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen
