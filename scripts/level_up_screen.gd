extends Control
var player
var gun
var selected_upgrade_1
var selected_upgrade_2
var selected_upgrade_3

func _ready() -> void:
	SignalBus.level_up.connect(level_up_screen)
	player = get_tree().get_first_node_in_group("player")
	gun = get_tree().get_first_node_in_group("gun")
	
func level_up_screen(): #get player info
	visible = true
	get_tree().paused = true
	
	var upgrades = LootManager.get_random_upgrades(3)
	
	selected_upgrade_1 = upgrades[0]
	selected_upgrade_2 = upgrades[1]
	selected_upgrade_3 = upgrades[2]
	
	var value_1 = upgrades[0].enhanced_value if upgrades[0].get("is_enhanced") else upgrades[0].base_value
	$Option1/OptionDetails.text = upgrades[0].name + " +" + str(value_1)
	if upgrades[0].get("is_enhanced", false):
		$Option1.modulate = Color(0.5, 0.7, 1.0)  # Light blue
	else:
		$Option1.modulate = Color(1, 1, 1)  # White/normal
	
	var value_2 = upgrades[1].enhanced_value if upgrades[1].get("is_enhanced") else upgrades[1].base_value
	$Option2/OptionDetails.text = upgrades[1].name + " +" + str(value_2)
	if upgrades[1].get("is_enhanced", false):
		$Option2.modulate = Color(0.5, 0.7, 1.0)
	else:
		$Option2.modulate = Color(1, 1, 1)
	
	var value_3 = upgrades[2].enhanced_value if upgrades[2].get("is_enhanced") else upgrades[2].base_value
	$Option3/OptionDetails.text = upgrades[2].name + " +" + str(value_3)
	if upgrades[2].get("is_enhanced", false):
		$Option3.modulate = Color(0.5, 0.7, 1.0)
	else:
		$Option3.modulate = Color(1, 1, 1)

func _on_option_1_pressed() -> void:
	if visible:
		visible = false
		LootManager.apply_upgrade(player, selected_upgrade_1)
		SignalBus.value_update.emit()
		get_tree().paused = false

func _on_option_2_pressed() -> void:
	if visible:
		visible = false
		LootManager.apply_upgrade(player, selected_upgrade_2)
		SignalBus.value_update.emit()
		get_tree().paused = false

func _on_option_3_pressed() -> void:
	if visible:
		visible = false
		LootManager.apply_upgrade(player, selected_upgrade_3)
		SignalBus.value_update.emit()
		get_tree().paused = false
