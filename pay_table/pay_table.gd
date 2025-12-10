class_name PayTable
extends Control

const BUTTON_BUY_UPGRADE : PackedScene = preload("res://level/ui/upgrade_menu/button_buy_upgrade/button_buy_upgrade.tscn")
const color_hightlight : Color = Color.YELLOW

@export var data : PayTableData = null : set = _set_data

var vbox_container_hands : VBoxContainer = null
var vbox_containers_payouts : Array[VBoxContainer] = []
var vbox_container_buy_upgrade : VBoxContainer = null
var labels_hands : Array[Label] = []
var labels_payouts : Array[Array] = []
var buttons_buy_upgrade : Array[ButtonBuyUpgrade]

func _ready() -> void:
	vbox_container_hands = %VBoxContainerHands
	vbox_containers_payouts = [%VBoxContainerPayouts0, %VBoxContainerPayouts1, %VBoxContainerPayouts2, %VBoxContainerPayouts3]
	vbox_container_buy_upgrade = %VBoxContainerBuyUpgrade
	
	# delete dummy labels used for development/debugging
	for child : Node in vbox_container_hands.get_children():
		if(child is Label):
			child.queue_free()
	for vbox_container_payout : VBoxContainer in vbox_containers_payouts:
		for child : Node in vbox_container_payout.get_children():
			if(child is Label):
				child.queue_free()
	for child : Node in vbox_container_buy_upgrade.get_children():
		if(child is ButtonBuyUpgrade):
			child.queue_free()
	return

func _set_data(value : PayTableData) -> void:
	data = value
	return

func update() -> void:
	for child : Node in vbox_container_hands.get_children():
		if(child is Label):
			child.queue_free()
	for vbox_container_payout : VBoxContainer in vbox_containers_payouts:
		for child : Node in vbox_container_payout.get_children():
			if(child is Label):
				child.queue_free()
	labels_hands.clear()
	labels_payouts.clear()
	if(data):
		data.sort()
		for pay_table_entry : PayTableEntry in data.entries:
			add_entry(pay_table_entry)
	return

func add_entry(pay_table_entry : PayTableEntry) -> void:
	var label_hand : Label = Label.new()
	var labels_payouts_entry : Array[Label] = []
	var button_buy_upgrade : ButtonBuyUpgrade = BUTTON_BUY_UPGRADE.instantiate()
	
	vbox_container_buy_upgrade.add_child(button_buy_upgrade) # must add this as a child first so its children can call _ready()
	
	label_hand.text = data.get_hand_rank_name(pay_table_entry.hand_rank)
	for currency_tier : int in pay_table_entry.base_payouts.keys():
		var label_payout : Label = Label.new()
		label_payout.text = Utility.engineering_notation(pay_table_entry.calculate_payout(currency_tier))
		label_payout.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		labels_payouts_entry.append(label_payout)
	if(pay_table_entry.level == 0):
		button_buy_upgrade.text = "BUY"
	else:
		button_buy_upgrade.text = "UPGRADE"
	var cost_buy_upgrade : Dictionary[int, int] = pay_table_entry.get_upgrade_cost()
	button_buy_upgrade.set_cost(cost_buy_upgrade)
	button_buy_upgrade.custom_minimum_size = Vector2(44.0, 9.0)
	button_buy_upgrade.add_theme_font_size_override("font_size", 16)
	
	labels_hands.append(label_hand)
	labels_payouts.append(labels_payouts_entry)
	buttons_buy_upgrade.append(button_buy_upgrade)
	
	vbox_container_hands.add_child(label_hand)
	for currency_tier : int in pay_table_entry.base_payouts.keys():
		vbox_containers_payouts[currency_tier].add_child(labels_payouts_entry[currency_tier])
	
	return

func highlight(hand_rank : Hand.Rank) -> void:
	if(not data):
		return
	for index_pay_table_entry : int in range(data.entries.size()):
		if(data.entries[index_pay_table_entry].hand_rank == hand_rank):
			labels_hands[index_pay_table_entry].modulate = color_hightlight
			for currency_tier : int in data.entries[index_pay_table_entry].base_payouts.keys():
				labels_payouts[index_pay_table_entry][currency_tier].modulate = color_hightlight
	return

func clear_highlights() -> void:
	for index_pay_table_entry : int in range(data.entries.size()):
		labels_hands[index_pay_table_entry].modulate = Color.WHITE
		for currency_tier : int in data.entries[index_pay_table_entry].base_payouts.keys():
			labels_payouts[index_pay_table_entry][currency_tier].modulate = Color.WHITE
	return
