extends CanvasLayer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		visible = !visible
		if visible:
			get_tree().paused = true
		else:
			get_tree().paused = false


func _on_resume_button_pressed() -> void:
	if visible:
		visible = false
		get_tree().paused = false

func _on_main_menu_button_pressed() -> void:
	if visible:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
