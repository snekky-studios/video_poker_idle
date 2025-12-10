class_name ButtonBuyUpgrade
extends Button

var cost_indicator : CostIndicator = null

func _ready() -> void:
	cost_indicator = %CostIndicator
	return

func set_cost(value : Dictionary[int, int]) -> void:
	cost_indicator.cost = value
	return

func _on_focus_entered() -> void:
	cost_indicator.show()
	return

func _on_focus_exited() -> void:
	cost_indicator.hide()
	return
