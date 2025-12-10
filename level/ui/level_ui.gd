class_name LevelUI
extends Control

signal deal_draw_pressed
signal passive_currency_pressed
signal animations_finished

enum State
{
	DEAL,
	DRAW
}

const CURRENCY_INCREMENT_SPEED_SLOW : float = 0.3
const CURRENCY_INCREMENT_SPEED_MEDIUM : float = 0.1
const CURRENCY_INCREMENT_SPEED_FAST : float = 0.01

var state : State = State.DEAL : set = _set_state
var currency_increment_speed : Dictionary[int, float] = {} # the speed at which the currency counter label increments on a payout
var currency_current : Dictionary[int, int] = {}
var currency_target : Dictionary[int, int] = {} : set = _set_currency_target
var currency_increment_progress : Dictionary[int, float] = {}
var is_incrementing_currency : Dictionary[int, bool] = {}
var is_indicating_payout : bool = false
var are_all_animations_finished : bool = true

var pay_table : PayTable = null
var currency_list : CurrencyList = null
var payout_indicator : PayoutIndicator = null
var button_passive_currency : ButtonPassiveCurrency = null
var button_deal_draw : Button = null

func _ready() -> void:
	pay_table = %PayTable
	currency_list = %CurrencyList
	payout_indicator = %PayoutIndicator
	button_passive_currency = %ButtonPassiveCurrency
	button_deal_draw = %ButtonDealDraw
	
	button_passive_currency.pressed.connect(_on_button_passive_currency_pressed)
	return

func _process(delta: float) -> void:
	if(are_all_animations_finished):
		return
	are_all_animations_finished = true
	for currency_tier : int in is_incrementing_currency.keys():
		if(not is_incrementing_currency[currency_tier]):
			continue
		currency_increment_progress[currency_tier] += delta
		if(currency_increment_progress[currency_tier] > currency_increment_speed[currency_tier]):
			while(currency_increment_progress[currency_tier] > currency_increment_speed[currency_tier]):
				currency_increment_progress[currency_tier] -= currency_increment_speed[currency_tier]
				currency_current[currency_tier] += 1
				currency_list.update_currency(currency_tier, currency_current[currency_tier])
			currency_increment_progress[currency_tier] = 0.0
			if(currency_current[currency_tier] >= currency_target[currency_tier]):
				is_incrementing_currency[currency_tier] = false
	for currency_tier : int in is_incrementing_currency.keys():
		are_all_animations_finished = are_all_animations_finished and (not is_incrementing_currency[currency_tier])
	if(are_all_animations_finished):
		animations_finished.emit()
	return

func _set_state(value : State) -> void:
	state = value
	match state:
		State.DEAL:
			button_deal_draw.text = "DEAL"
		State.DRAW:
			button_deal_draw.text = "DRAW"
		_:
			print("error: invalid level_ui state - ", state)
	return

func _set_currency_target(value : Dictionary[int, int]) -> void:
	currency_target = value
	are_all_animations_finished = true
	for currency_tier : int in currency_current.keys():
		if(currency_current[currency_tier] < currency_target[currency_tier]):
			is_incrementing_currency[currency_tier] = true
			are_all_animations_finished = false
			var currency_delta : int = currency_target[currency_tier] - currency_current[currency_tier]
			if(currency_delta < 5):
				currency_increment_speed[currency_tier] = CURRENCY_INCREMENT_SPEED_SLOW
			elif(currency_delta < 26):
				currency_increment_speed[currency_tier] = CURRENCY_INCREMENT_SPEED_MEDIUM
			else:
				currency_increment_speed[currency_tier] = CURRENCY_INCREMENT_SPEED_FAST
		else:
			currency_current[currency_tier] = currency_target[currency_tier]
			currency_list.update_currency(currency_tier, currency_current[currency_tier])
	if(are_all_animations_finished):
		animations_finished.emit()
	return

func set_initial_currency(value : Dictionary[int, int]) -> void:
	for currency_tier : int in value.keys():
		currency_current[currency_tier] = value[currency_tier]
		currency_target[currency_tier] = currency_current[currency_tier]
		currency_increment_speed[currency_tier] = CURRENCY_INCREMENT_SPEED_SLOW
		currency_increment_progress[currency_tier] = 0.0
		is_incrementing_currency[currency_tier] = false
	return

func set_pay_table_data(value : PayTableData) -> void:
	pay_table.data = value
	pay_table.update()
	return

func set_passive_currency_payout(value : Dictionary[int, int]) -> void:
	button_passive_currency.payout = value
	return

func _on_button_deal_draw_pressed() -> void:
	deal_draw_pressed.emit()
	return

func _on_button_passive_currency_pressed() -> void:
	passive_currency_pressed.emit()
	return
