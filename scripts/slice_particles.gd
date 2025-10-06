extends CPUParticles2D


var damage
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emitting = true
	damage = SignalBus.damage
	print(damage)

func _on_finished() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.collision_layer == 4:
		body.take_damage(damage)
