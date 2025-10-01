extends Timer

@onready var player = get_tree().get_first_node_in_group("player")

var duration = 5

func damageOvertime() -> void:
	player.player_hp -= 5
	duration -= 1
	print(player.player_hp)
	if duration == 0:
		stop()
