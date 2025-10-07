extends Area2D

@export var exp_value: int = 5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if exp_value == 20:
		$Sprite2D.texture = preload("res://assets/entities/xp_orb_1.png")
	elif exp_value == 40:
		$Sprite2D.texture = preload("res://assets/entities/xp_orb_2.png")
	elif exp_value == 60:
		$Sprite2D.texture = preload("res://assets/entities/xp_orb_3.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 1:
		SignalBus.exp_collected.emit(exp_value)
		queue_free()
