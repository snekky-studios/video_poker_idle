class_name LevelData
extends Resource

@export var deck : Deck = null
@export var pay_table_data : PayTableData = null
@export var starting_money : int = 0
@export var deal_cost : int = 0
@export var num_draws : int = 1

func _to_string() -> String:
	var output : String = ""
	output += deck._to_string() + "\n"
	output += pay_table_data._to_string() + "\n"
	return output
