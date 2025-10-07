extends CanvasLayer


@export var game_instance: PackedScene
# Called every frame. 'delta' is the elapsed time since the previous frame.
#var tween = get_tree().create_tween()

#func _process(delta: float) -> void:
	##tween.tween_property($ColorRect, "modulate:a", 255, 10)
	#$ColorRect.self_modulate.a = move_toward(0.5, 1, delta*40)
	#print($ColorRect.self_modulate.a)


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
