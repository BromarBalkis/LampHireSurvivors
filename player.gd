extends CharacterBody2D


@onready var happyboo = $HappyBoo

@export var player_speed_mult: float = 1 #movespeed
@export var player_dmg_mult: float = 1 #of all weapons
@export var player_atk_spd: float = 1 #of all weapons
@export var player_max_hp: float = 100
@export var player_defense: float = 0 #flat damage reduction
@export var player_hp_regen: float = 0
@export var player_projectile_size: float = 0
@export var player_projectile_count: float = 0 #maybe
@export var player_luck: float = 1
@export var player_exp_mult: float = 1

var SPEED: float = 450.0
var player_hp: float = 100
var direction

var player_exp: float = 0
var next_level_req: float = 100

func _ready() -> void:
	signal_connector()
	
func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	
	velocity = direction*SPEED*player_speed_mult
	
	animation_handler()
	
	move_and_slide()

func animation_handler() -> void:
	if direction != Vector2.ZERO:
		happyboo.play_walk_animation()
		
	else:
		happyboo.play_idle_animation()
		
	if direction.x != 0:
		$HappyBoo.transform.x.x = sign(direction.x)
	
	

func experience_handler(exp_value): #exp_value received from signal
	player_exp += exp_value
	print(player_exp)
	if player_exp >= next_level_req: #level up
		player_exp -= next_level_req
		next_level_req += 50 #exp required growth, gonna need math
	SignalBus.exp_updated.emit(player_exp/next_level_req)
	
	
func signal_connector() -> void:
	SignalBus.mob_death.connect(experience_handler)

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("move_left"):
		#pass
	#pass
