extends CharacterBody2D


@onready var happyboo = $HappyBoo

const SPEED = 450.0
const JUMP_VELOCITY = -400.0
var direction

func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	
	velocity = direction*SPEED
	
	animation_handler()
	
	move_and_slide()

func animation_handler() -> void:
	if direction != Vector2.ZERO:
		happyboo.play_walk_animation()
		
	else:
		happyboo.play_idle_animation()
		
	if direction.x != 0:
		$HappyBoo.transform.x.x = sign(direction.x)
	
	

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("move_left"):
		#pass
	#pass
