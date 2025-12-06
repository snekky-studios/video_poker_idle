@tool
class_name PayTableDataFactory
extends EditorScript

const dir_path : String = "res://pay_table/data/"
const file_prefix : String = "pay_table_"
const file_suffix : String = ".tres"

const PAY_TABLE_ENTRY_JACKS_OR_BETTER : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_jacks_or_better.tres")
const PAY_TABLE_ENTRY_TWO_PAIR : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_two_pair.tres")
const PAY_TABLE_ENTRY_THREE_OF_A_KIND : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_three_of_a_kind.tres")
const PAY_TABLE_ENTRY_STRAIGHT : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_straight.tres")
const PAY_TABLE_ENTRY_FLUSH : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_flush.tres")
const PAY_TABLE_ENTRY_FULL_HOUSE : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_full_house.tres")
const PAY_TABLE_ENTRY_FOUR_OF_A_KIND_5_KING : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_four_of_a_kind_5_king.tres")
const PAY_TABLE_ENTRY_FOUR_OF_A_KIND_2_3_4 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_four_of_a_kind_2_3_4.tres")
const PAY_TABLE_ENTRY_FOUR_OF_A_KIND_2_3_4_KICKER : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_four_of_a_kind_2_3_4_kicker.tres")
const PAY_TABLE_ENTRY_FOUR_OF_A_KIND_ACE : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_four_of_a_kind_ace.tres")
const PAY_TABLE_ENTRY_FOUR_OF_A_KIND_ACE_KICKER : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_four_of_a_kind_ace_kicker.tres")
const PAY_TABLE_ENTRY_STRAIGHT_FLUSH : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_straight_flush.tres")
const PAY_TABLE_ENTRY_ROYAL_FLUSH : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_royal_flush.tres")

func _run() -> void:
	_double_double_bonus()
	return

func _save(pay_table_data : PayTableData, file_path : String) -> Error:
	return ResourceSaver.save(pay_table_data, file_path)

func _double_double_bonus() -> void:
	var error : Error = OK
	var file_name : String = "double_double_bonus"
	var pay_table_data : PayTableData = PayTableData.new()
	
	pay_table_data.add_entry(PAY_TABLE_ENTRY_JACKS_OR_BETTER)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_TWO_PAIR)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_THREE_OF_A_KIND)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_STRAIGHT)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FLUSH)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FULL_HOUSE)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FOUR_OF_A_KIND_5_KING)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FOUR_OF_A_KIND_2_3_4)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FOUR_OF_A_KIND_2_3_4_KICKER)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FOUR_OF_A_KIND_ACE)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FOUR_OF_A_KIND_ACE_KICKER)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_STRAIGHT_FLUSH)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_ROYAL_FLUSH)
	
	_save(pay_table_data, dir_path + file_prefix + file_name + file_suffix)
	return
