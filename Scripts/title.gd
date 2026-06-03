extends Control


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		Gamestate.reset_run()
		get_tree().change_scene_to_file("res://Scene/hub.tscn"
			)
