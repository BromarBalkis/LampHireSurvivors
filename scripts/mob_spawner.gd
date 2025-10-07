extends Path2D

#@onready var fresh_mob = preload("res://slime.tscn")

var mobCount = 5

func _ready() -> void:
	spawn_mob()


func spawn_mob() -> void:
	#fresh_mob.instantiate()
	var fresh_mob = preload("res://slime.tscn").instantiate()
	$PathFollow2D.progress_ratio = randf()
	fresh_mob.global_position = $PathFollow2D.global_position
	get_tree().get_first_node_in_group("mob_container").add_child.call_deferred(fresh_mob) #so the spawn path can follow the player without moving the fresh slimes with the player


func _on_spawn_timer_timeout() -> void:
	mobCount += 1
	for i in mobCount: #spawns 5 mods, can replace 5 to dynamically change spawn amount
		spawn_mob()
		
