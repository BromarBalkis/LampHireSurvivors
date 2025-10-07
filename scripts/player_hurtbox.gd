extends ShapeCast2D


@onready var player = get_parent()


func _physics_process(_delta: float) -> void:
	damage_taking_business()
	

func damage_taking_business() -> void:
	if is_colliding() && get_collider(0) != null: #as long as it can only collide with mobs this should be fine
		player.take_damage(get_collider(0).damage_to_player) #0 = closest to player
