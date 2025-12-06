class_name LevelData
extends Resource

@export var deck : Deck = null
@export var pay_table_data : PayTableData = null
@export var starting_currency : Dictionary[int, int] = {
	0 : 100,
	1 : 0,
	2 : 0,
	3 : 0
}
@export var deal_cost : Dictionary[int, int] = {
	0 : 1,
	1 : 0,
	2 : 0,
	3 : 0
}
@export var num_draws : int = 1

func _to_string() -> String:
	var output : String = ""
	output += deck._to_string() + "\n"
	output += pay_table_data._to_string() + "\n"
	return output
