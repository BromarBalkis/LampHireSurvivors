extends Area2D


@export var damage: float = 35

var target
var speed = Vector2(1000,1000)
var travelled_distance = 0
var starting_position

func _ready() -> void:
	target = get_tree().get_first_node_in_group("gun").target_enemy.global_position
	starting_position = get_tree().get_first_node_in_group("firing_point").global_position #gotta be an easier way to pass this but thats a later problem
	#without starting position the global_position is 0,0 in the calc
	target = (target - starting_position).normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += speed*target*delta


func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 2: #layer 2 (tree)
		queue_free()
	
	if body.collision_layer == 4: #actually layer 3 (mobs)
		body.take_damage(damage)
		queue_free()



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
