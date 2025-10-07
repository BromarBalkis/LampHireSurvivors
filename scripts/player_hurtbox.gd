extends Area2D


@onready var player = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 4:
		player.take_damage(body.damage_to_player)
