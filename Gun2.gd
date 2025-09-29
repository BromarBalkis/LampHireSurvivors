extends ShapeCast2D

var enemies_in_range
var target_enemy

var bullet_scene = preload("res://bullet.tscn")

@onready var gun_sprite = $WeaponPivot/Pistol
@onready var bullet_container = $bulletContainer

func _physics_process(_delta: float) -> void:
	enemies_in_range = collision_result #returns array
	if enemies_in_range.size() > 0:
		target_enemy = get_collider(0) #gets the closest guy
		if target_enemy != null:
			look_at(target_enemy.global_position)
	rotate_gun()

	
func rotate_gun():
	rotation = fmod(rotation, 2*PI) #modulo of 2pi (its in rads)
	#flips the gun properly to avoid funny arm breaking angles
	if ((abs(rotation) >= (3*PI)/2) || (abs(rotation) <= (PI)/2)):
		gun_sprite.flip_v = false
	else:
		gun_sprite.flip_v = true


func _on_firing_speed_timeout() -> void:
	if enemies_in_range.size() > 0:
		var bullet_instance = bullet_scene.instantiate()
		bullet_container.add_child(bullet_instance)
		bullet_instance.global_position = $WeaponPivot/Pistol/Bullethole.global_position
		bullet_instance.global_rotation = $WeaponPivot/Pistol/Bullethole.global_rotation
