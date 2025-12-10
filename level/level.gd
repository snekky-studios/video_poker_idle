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
var currency : Dictionary[int, int] = {}
var num_draws_remaining : int = 0

var ui : LevelUI = null
var hand : Array[Card] = []
var held_labels : Array[Label] = []

func _ready() -> void:
	ui = %LevelUI
	hand = [%Card0, %Card1, %Card2, %Card3, %Card4]
	held_labels = [%LabelHeld0, %LabelHeld1, %LabelHeld2, %LabelHeld3, %LabelHeld4]
	
	ui.deal_draw_pressed.connect(_on_ui_deal_draw_pressed)
	ui.passive_currency_pressed.connect(_on_ui_passive_currency_pressed)
	ui.animations_finished.connect(_on_ui_animations_finished)
	for card : Card in hand:
		card.selected.connect(_on_card_selected)
	
	return

func _set_data(value : LevelData) -> void:
	data = value
	data.deck.shuffle()
	currency = data.starting_currency
	num_draws_remaining = data.num_draws
	ui.set_pay_table_data(data.pay_table_data)
	ui.set_initial_currency(currency)
	ui.set_passive_currency_payout(data.passive_currency)
	for currency_tier : int in currency.keys():
		ui.currency_list.update_currency(currency_tier, currency[currency_tier])
	return

func _set_state(value : State) -> void:
	state = value
	match(state):
		State.WAITING_TO_DEAL:
			ui.state = LevelUI.State.DEAL
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

func deal() -> void:
	for card : Card in hand:
		card.data = data.deck.deal()
	for currency_tier : int in currency.keys():
		currency[currency_tier] -= data.deal_cost[currency_tier]
	ui.currency_target = currency
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
	var payout : Dictionary[int, int] = data.pay_table_data.get_payout(hand_rank)
	if(payout.keys().size() > 0):
		for currency_tier : int in currency.keys():
			currency[currency_tier] += payout[currency_tier]
	ui.pay_table.highlight(hand_rank)
	ui.payout_indicator.payout = payout
	ui.currency_target = currency
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

func _on_ui_passive_currency_pressed() -> void:
	for currency_tier : int in currency.keys():
		currency[currency_tier] += data.passive_currency[currency_tier]
	ui.currency_target = currency
	return

func _on_ui_animations_finished() -> void:
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
