extends Node2D


var damage
var target
var bananarang
var target_vector: Vector2
var return_calculator
var returning: bool = false

var speed = Vector2(1000,1000)
var max_range = Vector2(1000, 1000)

var starting_position
var max_distance: Vector2

func _ready() -> void:
	timer_business()
	bananarang = get_parent().get_parent()
	damage = bananarang.damage
	if bananarang.target_enemy != null: #sometimes game would crash if it targeted a queue_freed enemy
		target = bananarang.target_enemy.global_position
		starting_position = bananarang.global_position
		
		return_calculator = target - starting_position
		target_vector = (target - starting_position).normalized()


func _physics_process(delta: float) -> void:
	if returning:
		return_to_player(delta)
	
	elif target_vector != null:
		position += speed*target_vector*delta
		
	elif target_vector == null: #not sure if this will fix bullets stuck in place, i think that's caused by the target enemy being right on top of the bananarang then killed by something else
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 2: #layer 2 (tree)
		queue_free()
	
	if body.collision_layer == 4: #actually layer 3 (mobs)
		body.take_damage(damage)
	
	if body.collision_layer == 1: #player (returned)
		queue_free()

func timer_business() -> void:
	$ReturnTimer.start()

func _on_return_timer_timeout() -> void:
	$Hurtbox.collision_mask = 	$Hurtbox.collision_mask | 1
	$Hurtbox/CollisionShape2D.disabled = true
	$Hurtbox/CollisionShape2D.disabled = false #so it can re-hit enemies at the returning point
	returning = true
	
func return_to_player(delta) -> void:
	position = position.move_toward(bananarang.global_position, delta*1000)
