extends ShapeCast2D

var enemies_in_range
var target_enemy
var player

#player-affected stats
@export var damage: float = 35
var bullet_size #kinda redundant? maybe for further enemies it matters #could have bullet penetration upgrade
var projectile_count: float = 1


var bullet_scene = preload("res://bullet.tscn")

@onready var gun_sprite = $WeaponPivot/Pistol
@onready var bullet_container = $bulletContainer

func _ready() -> void:
	SignalBus.value_update.connect(update_values)
	player = get_tree().get_first_node_in_group("player")
	

func _physics_process(_delta: float) -> void:
	enemies_in_range = collision_result #returns array
	if enemies_in_range.size() > 0:
		target_enemy = get_collider(0) #gets the closest guy
		if target_enemy != null: #tldr use target_enemy for anything targetting enemies
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
		for i in projectile_count:
			bullet_container.add_child(bullet_instance)
			bullet_instance.global_position = $WeaponPivot/Pistol/Bullethole.global_position
			bullet_instance.global_rotation = $WeaponPivot/Pistol/Bullethole.global_rotation

func update_values() -> void:
	$FiringSpeed.wait_time = 0.5/player.player_atk_spd
	damage = 35*player.player_dmg_mult
	projectile_count = player.player_projectile_count
	bullet_size = player.player_projectile_size
