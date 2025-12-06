class_name PayTable
extends Control

const color_hightlight : Color = Color.YELLOW

@export var data : PayTableData = null : set = _set_data

var vbox_container_hands : VBoxContainer = null
var vbox_container_payouts : VBoxContainer = null
var labels_hands : Array[Label] = []
var labels_payouts : Array[Label] = []

func _ready() -> void:
	vbox_container_hands = %VBoxContainerHands
	vbox_container_payouts = %VBoxContainerPayouts
	
	# delete dummy labels used for development/debugging
	for child : Label in vbox_container_hands.get_children():
		child.queue_free()
	for child : Label in vbox_container_payouts.get_children():
		child.queue_free()
	
	return

func _set_data(value : PayTableData) -> void:
	data = value
	return

func update() -> void:
	for child : Label in vbox_container_hands.get_children():
		child.queue_free()
	for child : Label in vbox_container_payouts.get_children():
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
	var label_payout : Label = Label.new()
	label_hand.text = data.get_hand_rank_name(pay_table_entry.hand_rank)
	label_payout.text = str(pay_table_entry.base_payouts[0])
	label_payout.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	labels_hands.append(label_hand)
	labels_payouts.append(label_payout)
	vbox_container_hands.add_child(label_hand)
	vbox_container_payouts.add_child(label_payout)
	return

func highlight(hand_rank : Hand.Rank) -> void:
	if(not data):
		return
	for index_pay_table_entry : int in range(data.entries.size()):
		if(data.entries[index_pay_table_entry].hand_rank == hand_rank):
			labels_hands[index_pay_table_entry].modulate = color_hightlight
			labels_payouts[index_pay_table_entry].modulate = color_hightlight
	return

func clear_highlights() -> void:
	for index_pay_table_entry : int in range(data.entries.size()):
		labels_hands[index_pay_table_entry].modulate = Color.WHITE
		labels_payouts[index_pay_table_entry].modulate = Color.WHITE
	return
