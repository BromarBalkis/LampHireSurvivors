extends CharacterBody2D


@onready var player = get_tree().get_first_node_in_group("player")
const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
const EXP_SCENE = preload("res://scenes/entities/xp_orb.tscn")

@export var hp: float = 100
@export var experience: float = 20

var max_hp
var SPEED: = Vector2(200.0,200.0)
var direction: Vector2


func _ready() -> void:
	max_hp = hp
	$Slime.play_walk()

func _physics_process(_delta: float) -> void:
	direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED
	
	move_and_slide()

func take_damage(damage: float) -> void:
	hp -= damage
	$Slime.play_hurt()
	SignalBus.take_damage.emit()
	
	if hp <= 0: #death
		var smoke = SMOKE_SCENE.instantiate()
		var exp = EXP_SCENE.instantiate()
		
		var roll = randf()
		if roll < 0.80:
			exp.exp_value = 20
		elif roll < 0.95: 
			exp.exp_value = 40
		else:
			exp.exp_value = 60
		get_parent().add_child(smoke) #adds as a sibling of slimemob, so it doesnt get deleted
		get_parent().add_child(exp)
		smoke.global_position = global_position
		exp.global_position = global_position
		queue_free()
