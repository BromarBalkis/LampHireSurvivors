extends Node2D

@onready var player = SignalBus.selected_character.instantiate()
@onready var mob_spawn_path = preload("res://mob_spawn_path.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_child.call_deferred(player)
	player.add_child(mob_spawn_path)
	#player.global_position = Vector2(820, 550) #could adjust spawn point
