extends CharacterBody2D


@onready var happyboo = $HappyBoo

@export var player_speed_mult: float = 1 #movespeed
@export var player_dmg_mult: float = 1 #of all weapons
@export var player_atk_spd: float = 1 #of all weapons
@export var player_hp: float = 100
@export var player_max_hp: float = 100
@export var player_defense: float = 0 #flat damage reduction
@export var player_hp_regen: float = 0
@export var player_luck: float = 1
@export var player_exp_mult: float = 1

@export var player_projectile_size: float = 1
@export var player_projectile_count: float = 1 #maybe

var SPEED: float = 450.0
var direction
var explosion_scene = preload("res://scenes/entities/death_explosion.tscn")
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
	if player_exp >= next_level_req: #level up
		SignalBus.level_up.emit()
		player_exp -= next_level_req
		next_level_req += 50 #exp required growth, gonna need math
	SignalBus.exp_updated.emit(player_exp/next_level_req)
	
	
func signal_connector() -> void:
	SignalBus.exp_collected.connect(experience_handler)

func take_damage(mob_damage) -> void:
	if $InvulnTimer.is_stopped(): #timer isnt alr running
		player_hp -= mob_damage
		SignalBus.player_damaged.emit() #to update healthbar
		$InvulnTimer.start()
		
		if player_hp <= 0:
			var death_explosion = explosion_scene.instantiate()
			$".".add_sibling(death_explosion)
			$Camera2D.reparent(get_parent()) #moves camera to higher level so it doesnt get freed with player (thus zooming in)
			
			death_explosion.global_position = global_position
			queue_free()


func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.collision_layer == 16:
		area.picking_up = true #for exp orbs exclusively
