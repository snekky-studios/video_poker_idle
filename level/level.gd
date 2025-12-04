class_name Level
extends Node

enum State
{
	WAITING_TO_DEAL,
	DEALING,
	WAITING_TO_DRAW,
	DRAWING,
	RESOLVING_HAND
}

var data : LevelData = null : set = _set_data
var state : State = State.WAITING_TO_DEAL : set = _set_state
var money : int = 0 : set = _set_money
var num_draws_remaining : int = 0

var ui : LevelUI = null
var hand : Array[Card] = []
var held_labels : Array[Label] = []

func _ready() -> void:
	ui = %LevelUI
	hand = [%Card0, %Card1, %Card2, %Card3, %Card4]
	held_labels = [%LabelHeld0, %LabelHeld1, %LabelHeld2, %LabelHeld3, %LabelHeld4]
	
	ui.deal_draw_pressed.connect(_on_ui_deal_draw_pressed)
	ui.money_target_reached.connect(_on_ui_money_target_reached)
	for card : Card in hand:
		card.selected.connect(_on_card_selected)
	
	return

func _set_data(value : LevelData) -> void:
	data = value
	data.deck.shuffle()
	ui.set_pay_table_data(data.pay_table_data)
	ui.money_current = data.starting_money
	money = data.starting_money
	num_draws_remaining = data.num_draws
	return

func _set_state(value : State) -> void:
	state = value
	match(state):
		State.WAITING_TO_DEAL:
			pass
		State.DEALING:
			data.deck.shuffle()
			unhold_hand()
			ui.pay_table.clear_highlights()
			deal()
		State.WAITING_TO_DRAW:
			unhold_hand()
		State.DRAWING:
			draw()
		State.RESOLVING_HAND:
			resolve_hand()
		_:
			print("error: invalid level state - ", state)
	return

func _set_money(value : int) -> void:
	money = value
	ui.money_target = money
	return

func deal() -> void:
	for card : Card in hand:
		card.data = data.deck.deal()
	money -= data.deal_cost
	ui.state = LevelUI.State.DRAW
	state = State.WAITING_TO_DRAW
	return

func draw() -> void:
	for card : Card in hand:
		if(not card.is_selected):
			card.data = data.deck.deal()
	num_draws_remaining -= 1
	if(num_draws_remaining <= 0):
		num_draws_remaining = data.num_draws
		state = State.RESOLVING_HAND
	else:
		state = State.WAITING_TO_DRAW
	return

func resolve_hand() -> void:
	var hand_data : Array[CardData] = []
	for card : Card in hand:
		hand_data.append(card.data)
	var hand_rank : Hand.Rank = Hand.rank(hand_data)
	var payout : int = data.pay_table_data.get_payout(hand_rank)
	money += payout
	ui.set_payout_text(payout)
	ui.pay_table.highlight(hand_rank)
	ui.state = LevelUI.State.DEAL
	return

func unhold_hand() -> void:
	for index_hand : int in range(hand.size()):
		hand[index_hand].is_selected = false
		held_labels[index_hand].visible = false
	return

func _on_ui_deal_draw_pressed() -> void:
	match(state):
		State.DEALING, State.DRAWING, State.RESOLVING_HAND:
			pass
		State.WAITING_TO_DEAL:
			state = State.DEALING
		State.WAITING_TO_DRAW:
			state = State.DRAWING
		_:
			print("error: invalid level state - ", state)
	return

func _on_ui_money_target_reached() -> void:
	state = State.WAITING_TO_DEAL
	return

func _on_card_selected(card : Card) -> void:
	match(state):
		State.WAITING_TO_DEAL, State.DEALING, State.DRAWING, State.RESOLVING_HAND:
			print("can't hold cards in this state - ", state)
		State.WAITING_TO_DRAW:
			card.is_selected = not card.is_selected
		_:
			print("error: invalid level state - ", state)
	for index_hand : int in range(hand.size()):
		if(hand[index_hand].is_selected):
			held_labels[index_hand].visible = true
		else:
			held_labels[index_hand].visible = false
	return
