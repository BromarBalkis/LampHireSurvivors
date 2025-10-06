extends ShapeCast2D

var enemies_in_range
var target_enemy
var player

@export var initial_damage: float = 50

var damage = 50
var slicer_scene = preload("res://scenes/slicerparticles2.tscn")

@onready var Slice_container = $SliceContainer

func _ready() -> void:
	SignalBus.value_update.connect(update_values)
	SignalBus.damage = damage
	player = get_tree().get_first_node_in_group("player")
	

func _physics_process(_delta: float) -> void:
	enemies_in_range = collision_result #returns array
	if enemies_in_range.size() > 0:
		target_enemy = get_collider(0) #gets the closest guy

func _on_firing_speed_timeout() -> void:
	if enemies_in_range.size() > 0 && target_enemy != null:
		var slicer_instance = slicer_scene.instantiate()
		#Slice_container.add_child(slicer_instance)
		target_enemy.get_parent().add_child(slicer_instance)
		slicer_instance.global_position = target_enemy.global_position
		#target_enemy.take_damage(damage)

func update_values() -> void:
	$FiringSpeed.wait_time = 2/player.player_atk_spd
	damage = initial_damage*player.player_dmg_mult #might be brain farting here
	SignalBus.damage = damage
