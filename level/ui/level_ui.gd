class_name LevelUI
extends Control

signal deal_draw_pressed
signal money_target_reached

enum State
{
	DEAL,
	DRAW
}

const MONEY_INCREMENT_SPEED_SLOW : float = 0.3
const MONEY_INCREMENT_SPEED_MEDIUM : float = 0.1
const MONEY_INCREMENT_SPEED_FAST : float = 0.01

var state : State = State.DEAL : set = _set_state
var money_increment_speed : float = MONEY_INCREMENT_SPEED_SLOW # the speed at which the money counter label increments on a payout
var money_current : int = 0 : set = _set_money_current
var money_target : int = 0 : set = _set_money_target
var money_increment_progress : float = 0.0
var is_incrementing_money : bool = false

var pay_table : PayTable = null
var label_payout : Label = null
var label_money : Label = null
var button_deal_draw : Button = null

func _ready() -> void:
	pay_table = %PayTable
	label_payout = %LabelPayout
	label_money = %LabelMoney
	button_deal_draw = %ButtonDealDraw
	return

func _process(delta: float) -> void:
	if(not is_incrementing_money):
		return
	money_increment_progress += delta
	if(money_increment_progress > money_increment_speed):
		while(money_increment_progress > money_increment_speed):
			money_increment_progress -= money_increment_speed
			money_current += 1
		money_increment_progress = 0.0
		if(money_current >= money_target):
			is_incrementing_money = false
			money_target_reached.emit()
	return

func _set_state(value : State) -> void:
	state = value
	match state:
		State.DEAL:
			button_deal_draw.text = "DEAL"
		State.DRAW:
			button_deal_draw.text = "DRAW"
			label_payout.text = ""
		_:
			print("error: invalid level_ui state - ", state)
	return

func _set_money_current(value : int) -> void:
	money_current = value
	set_money_text(money_current)
	return

func _set_money_target(value : int) -> void:
	money_target = value
	if(money_current < money_target):
		is_incrementing_money = true
		var money_delta : int = money_target - money_current
		if(money_delta < 5):
			money_increment_speed = MONEY_INCREMENT_SPEED_SLOW
		elif(money_delta < 26):
			money_increment_speed = MONEY_INCREMENT_SPEED_MEDIUM
		else:
			money_increment_speed = MONEY_INCREMENT_SPEED_FAST
	else:
		money_current = money_target
		money_target_reached.emit()
	return

func set_pay_table_data(value : PayTableData) -> void:
	pay_table.data = value
	pay_table.update()
	return

func set_money_text(value : int) -> void:
	label_money.text = str(value) + " CREDITS"
	return

func set_payout_text(value : int) -> void:
	if(value < 1):
		label_payout.text = ""
	else:
		label_payout.text = "WIN " + str(value)
	return

func _on_button_deal_draw_pressed() -> void:
	deal_draw_pressed.emit()
	return
