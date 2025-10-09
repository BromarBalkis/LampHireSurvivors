extends ShapeCast2D

var enemies_in_range
var target_enemy
var player
var shot_primed: bool = false

@export var initial_damage: float = 20

var damage = 20
var banana_scene = preload("res://scenes/weapons/bananarang.tscn")

#@onready var Slice_container = $SliceContainer

func _ready() -> void:
	SignalBus.value_update.connect(update_values)
	player = get_tree().get_first_node_in_group("player")
	

func _physics_process(_delta: float) -> void:
	enemies_in_range = collision_result #returns array
	if enemies_in_range.size() > 0:
		target_enemy = get_collider(0) #gets the closest guy
		shoot()

func _on_firing_speed_timeout() -> void: #!null stops crashes in certain cases
	shot_primed = true
	
func shoot() -> void:
	if enemies_in_range.size() > 0 && target_enemy != null && shot_primed:
		shot_primed = false
		$FiringSpeed.start()
		
		var banana_instance = banana_scene.instantiate()
		$BananaContainer.call_deferred("add_child", banana_instance)
		banana_instance.global_position = global_position


func update_values() -> void:
	$FiringSpeed.wait_time = 2/player.player_atk_spd
	damage = initial_damage*player.player_dmg_mult #might be brain farting here
	SignalBus.damage = damage
