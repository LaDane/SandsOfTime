extends Popup


func _ready():
	$CenterContainer/VBoxContainer/MasterSlider.value = GameState.master_volume
	$CenterContainer/VBoxContainer/MusicSlider.value = GameState.music_volume
	$CenterContainer/VBoxContainer/SoundSlider.value = GameState.SFX_volume


func _input(event):
	if Input.is_action_just_pressed("pause"):
		if not visible:
			open_popup()
		elif visible:
			close_popup()
	if visible:
		if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left"):
			close_popup()


func open_popup():
	popup_centered()
	get_tree().paused = true


func close_popup():
	visible = false
	get_tree().paused = false


func display_popup():
	popup()


func _on_SoundSlider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)
	GameState.SFX_volume = value


func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)
	GameState.music_volume = value


func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	GameState.master_volume = value


func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://UI/Menus/MainMenu.tscn")


func _on_ResumeButton_pressed():
	close_popup()


func _on_CheckBox_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen
