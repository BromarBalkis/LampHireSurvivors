extends Control

#@onready var character_select = preload("res://scenes/UI/character_select.tscn")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/character_select.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
