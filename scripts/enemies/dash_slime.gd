extends CharacterBody2D


var player
const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
const EXP_SCENE = preload("res://scenes/entities/xp_orb.tscn")

@export var hp: float = 100
@export var experience: float = 20

var max_hp
var SPEED: = Vector2(1500.0,1500.0)
var direction: Vector2
var damage_to_player: float = 25
var distance_to_player: float

func get_player_for_testing()-> void:
	await get_tree().create_timer(0.2).timeout
	player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	max_hp = hp
	$Slime.play_walk()
	get_player_for_testing()
	
func _physics_process(_delta: float) -> void:
	if player != null:
		distance_to_player = (global_position - player.global_position).length()
		direction = global_position.direction_to(player.global_position)

	velocity = velocity.move_toward(Vector2.ZERO, 25) #friction
	
	move_and_slide()

func dash():
	velocity += direction * SPEED

func take_damage(damage: float) -> void:
	hp -= damage
	$Slime.play_hurt()
	SignalBus.take_damage.emit()
	
	if hp <= 0: #death
		var smoke = SMOKE_SCENE.instantiate()
		var exp_orb = EXP_SCENE.instantiate()
		
		var roll = randf()
		if roll < 0.80:
			exp_orb.exp_value = 20
		elif roll < 0.95: 
			exp_orb.exp_value = 40
		else:
			exp_orb.exp_value = 60
		get_parent().add_child(smoke) #adds as a sibling of slimemob, so it doesnt get deleted
		get_parent().call_deferred("add_child", exp_orb)
		smoke.global_position = global_position
		exp_orb.global_position = global_position
		queue_free()

func _on_dash_timer_timeout() -> void:
	dash()


func _on_hurtbox_body_entered(body: Node2D) -> void: #for some reason smashing into the player wont cause damage, so this is the fix for now
	if body.is_in_group("player"):
		body.take_damage(damage_to_player)
