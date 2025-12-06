class_name CurrencyList
extends Control

const CURRENCY_0 : Currency = preload("res://currency/data/currency_0.tres")
const CURRENCY_1 : Currency = preload("res://currency/data/currency_1.tres")
const CURRENCY_2 : Currency = preload("res://currency/data/currency_2.tres")
const CURRENCY_3 : Currency = preload("res://currency/data/currency_3.tres")

var vbox_container_currencies : VBoxContainer = null
var label_currencies : Dictionary[int, Label] = {}

func _ready() -> void:
	vbox_container_currencies = %VBoxContainerCurrencies 
	for child : HBoxContainer in vbox_container_currencies.get_children():
		child.queue_free()
	add_currency(CURRENCY_0)
	add_currency(CURRENCY_1)
	add_currency(CURRENCY_2)
	add_currency(CURRENCY_3)
	return

func add_currency(currency : Currency) -> void:
	var hbox_container_currency : HBoxContainer = HBoxContainer.new()
	var texture_rect_currency : TextureRect = TextureRect.new()
	var label_currency : Label = Label.new()
	hbox_container_currency.add_child(texture_rect_currency)
	hbox_container_currency.add_child(label_currency)
	texture_rect_currency.texture = currency.texture
	texture_rect_currency.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
	texture_rect_currency.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label_currency.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	label_currency.text = str(0)
	label_currency.custom_minimum_size = Vector2(40.0, 0.0)
	vbox_container_currencies.add_child(hbox_container_currency)
	label_currencies[currency.tier] = label_currency
	return

func update_currency(currency_tier : int, value : int) -> void:
	label_currencies[currency_tier].text = str(value)
	return
