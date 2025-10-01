extends Control

var player
var gun

func _ready() -> void:
	SignalBus.level_up.connect(level_up_screen)
	player = get_tree().get_first_node_in_group("player")
	gun = get_tree().get_first_node_in_group("gun")
	
func level_up_screen(): #get player info
	visible = true
	get_tree().paused = true
	$Option1/OptionDetails.text = (str(player.player_atk_spd) + "x + 0.2x")
	$Option2/OptionDetails.text = (str(player.player_dmg_mult) + "x + 0.2x")
	$Option3/OptionDetails.text = (str(player.player_speed_mult) + "x + 0.2x")

func _on_option_1_pressed() -> void:
	if visible:
		visible = false
		player.player_atk_spd += 0.2
		SignalBus.value_update.emit()
		get_tree().paused = false

func _on_option_2_pressed() -> void:
	if visible:
		visible = false
		player.player_dmg_mult += 0.2
		SignalBus.value_update.emit()
		get_tree().paused = false

func _on_option_3_pressed() -> void:
	if visible:
		visible = false
		player.player_speed_mult += 0.2
		SignalBus.value_update.emit()
		get_tree().paused = false
		
