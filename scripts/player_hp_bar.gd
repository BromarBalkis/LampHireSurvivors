extends ProgressBar

@onready var player = get_tree().get_first_node_in_group("player")

var health_percent: float = 1

func _ready() -> void:
	SignalBus.player_damaged.connect(update_bar)
	var health_color_fade := get_health_color_fade_by_percent(1) #make sure it isnt white on load
	set_modulate(health_color_fade)

func update_bar() -> void:
	health_percent = (player.player_hp/player.player_max_hp)
	value = health_percent*100 #move the bar itself
	var health_color_fade := get_health_color_fade_by_percent(health_percent)
	set_modulate(health_color_fade)
	
func get_health_color_fade_by_percent(percent: float) -> Color:
	var r: float = min(2 - (percent / 0.5), 1.0)
	var g: float = min(percent / 0.5, 1.0)
	return Color(r, g, 0.0)
