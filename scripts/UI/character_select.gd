extends Control

@onready var char1 = preload("res://player.tscn")
@onready var char2 = preload("res://scenes/characters/standy.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_char_1_button_pressed() -> void:
	SignalBus.selected_character = char1
	get_tree().change_scene_to_file("res://game.tscn")


func _on_char_2_button_pressed() -> void:
	SignalBus.selected_character = char2
	get_tree().change_scene_to_file("res://game.tscn")
