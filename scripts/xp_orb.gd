extends Area2D

@export var exp_value: int = 5

var target
var pickup: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if exp_value == 20:
		$Sprite2D.texture = preload("res://assets/entities/xp_orb_1.png")
	elif exp_value == 40:
		$Sprite2D.texture = preload("res://assets/entities/xp_orb_2.png")
	elif exp_value == 60:
		$Sprite2D.texture = preload("res://assets/entities/xp_orb_3.png")

func _physics_process(_delta: float) -> void:
	succ()

func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 1:
		SignalBus.exp_collected.emit(exp_value)

		queue_free()


func _on_succ_area_body_entered(body: Node2D) -> void:
	if body.collision_layer == 1:
		target = body.global_position
		pickup = true

func succ() -> void:
	if pickup:
		position = position.move_toward(target, 100) #looks like move_toward has delta by default
