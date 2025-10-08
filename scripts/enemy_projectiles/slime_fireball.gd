extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

var damage: float = 35
var target
var starting_position
var speed = Vector2(1000,1000)


func _ready() -> void:
	if player != null: #sometimes game would crash if it targeted a queue_freed enemy
		target = player.global_position
		target = (target - starting_position).normalized()

func _physics_process(delta: float) -> void:
	if target != null:
		position += speed*target*delta
	if target == null: #not sure if this will fix bullets stuck in place, i think that's caused by the target enemy being right on top of the gun then killed by something else
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 2: #layer 2 (tree)
		$FireballParticles.emitting = false
		$Sprite2D.visible = false
		
	if body.collision_layer == 1: #player
		body.take_damage(damage)
		$FireballParticles.emitting = false
		$Sprite2D.visible = false

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$FireballParticles.emitting = false
	
func _on_fireball_particles_finished() -> void:
	queue_free()
