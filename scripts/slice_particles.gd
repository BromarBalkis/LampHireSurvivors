extends CPUParticles2D


var damage

#okay but it also has to inherit size and duration buffs,
#possibly # of targets as well but that's in the slicer script
#in this script: size, hurtbox duration
#in slicer: attack speed/damage(already done)

func _ready() -> void:
	emitting = true
	damage = SignalBus.damage

func _on_finished() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.collision_layer == 4:
		body.take_damage(damage)
