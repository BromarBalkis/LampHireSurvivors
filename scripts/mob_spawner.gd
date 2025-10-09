extends Path2D

#array of spawnable mobs that's selected based on the number of times mobs have been spawned?


var waveCount = 0

func _ready() -> void:
	spawn_slime()


func spawn_slime() -> void:
	#fresh_mob.instantiate()
	var fresh_mob = preload("res://slime.tscn").instantiate()
	$PathFollow2D.progress_ratio = randf()
	fresh_mob.global_position = $PathFollow2D.global_position
	get_tree().get_first_node_in_group("mob_container").add_child.call_deferred(fresh_mob) #so the spawn path can follow the player without moving the fresh slimes with the player

func spawn_ranged_slime() -> void:
	#fresh_mob.instantiate()
	var fresh_mob = preload("res://scenes/enemies/ranged_slime.tscn").instantiate()
	$PathFollow2D.progress_ratio = randf()
	fresh_mob.global_position = $PathFollow2D.global_position
	get_tree().get_first_node_in_group("mob_container").add_child.call_deferred(fresh_mob) 

func _on_spawn_timer_timeout() -> void:
	waveCount += 1
	
	for i in waveCount:
		spawn_slime()
		
	for i in (waveCount)/3: #increase number of ranged slimes every 3 waves
		spawn_ranged_slime()
	
