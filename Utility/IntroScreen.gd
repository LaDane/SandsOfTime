extends Control


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://UI/Menus/MainMenu.tscn")
