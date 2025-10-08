extends Area2D

@export var exp_value: int = 5

var picking_up: bool = false
var target
@onready var player = get_tree().get_first_node_in_group("player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if exp_value == 20:
		$Sprite2D.texture = preload("res://assets/entities/xp_orb_1.png")
	elif exp_value == 40:
		$Sprite2D.texture = preload("res://assets/entities/xp_orb_2.png")
	elif exp_value == 60:
		$Sprite2D.texture = preload("res://assets/entities/xp_orb_3.png")

func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 1:
		SignalBus.exp_collected.emit(exp_value)
		queue_free()

func _physics_process(delta: float) -> void:
	if picking_up:
		in_pickup_range(delta)
	
func in_pickup_range(delta) -> void:
	if player != null:
		global_position = global_position.move_toward(player.global_position, delta*1250)
