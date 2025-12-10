class_name CostIndicator
extends Control


var cost : Dictionary[int, int] = {} : set = _set_cost

var hbox_containers_currency : Array[HBoxContainer] = []
var labels_currency : Array[Label] = []

func _ready() -> void:
	hbox_containers_currency = [%HBoxContainerCurrency0, %HBoxContainerCurrency1, %HBoxContainerCurrency2, %HBoxContainerCurrency3]
	labels_currency = [%LabelCurrency0, %LabelCurrency1, %LabelCurrency2, %LabelCurrency3]
	var new_cost : Dictionary[int, int] = {
		0 : 10,
		1 : 5,
		2 : 7,
		3 : 1
	}
	cost = new_cost
	return

func _set_cost(value : Dictionary[int, int]) -> void:
	cost = value
	for hbox_container_currency : HBoxContainer in hbox_containers_currency:
		hbox_container_currency.hide()
	for currency_tier : int in cost.keys():
		hbox_containers_currency[currency_tier].show()
		labels_currency[currency_tier].text = str(cost[currency_tier])
	return
