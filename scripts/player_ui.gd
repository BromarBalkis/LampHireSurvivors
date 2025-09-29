extends Control

@onready var expbar = $ExpBar

func _ready() -> void:
	SignalBus.exp_updated.connect(exp_update)

func exp_update(exp_ratio) -> void:
	expbar.value = exp_ratio
