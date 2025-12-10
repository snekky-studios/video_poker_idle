class_name ButtonPassiveCurrency
extends TextureProgressBar

signal pressed

@export var cooldown : float = 5.0

var payout : Dictionary[int, int] = {} : set = _set_payout
var progress : float = 0.0

var payout_indicator : PayoutIndicator = null

func _ready() -> void:
	payout_indicator = %PayoutIndicator
	max_value = cooldown
	return

func _process(delta: float) -> void:
	progress += delta
	value = floor(progress)
	return

func _set_payout(value : Dictionary[int, int]) -> void:
	payout = value
	return

func _on_button_pressed() -> void:
	if(progress < max_value):
		return
	progress = 0
	value = 0
	payout_indicator.payout = payout
	pressed.emit()
	return
