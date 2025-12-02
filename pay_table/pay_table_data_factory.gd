@tool
class_name PayTableDataFactory
extends EditorScript

const dir_path : String = "res://pay_table/data/"
const file_prefix : String = "pay_table_"
const file_suffix : String = ".tres"

#const PAY_TABLE_ENTRY_NONE_0 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_none_0.tres")
#const PAY_TABLE_ENTRY_HIGH_CARD_0 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_high_card_0.tres")
#const PAY_TABLE_ENTRY_PAIR_1 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_pair_1.tres")
const PAY_TABLE_ENTRY_JACKS_OR_BETTER_1 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_jacks_or_better_1.tres")
const PAY_TABLE_ENTRY_TWO_PAIR_1 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_two_pair_1.tres")
const PAY_TABLE_ENTRY_TWO_PAIR_2 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_two_pair_2.tres")
const PAY_TABLE_ENTRY_THREE_OF_A_KIND_3 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_three_of_a_kind_3.tres")
const PAY_TABLE_ENTRY_STRAIGHT_4 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_straight_4.tres")
const PAY_TABLE_ENTRY_FLUSH_6 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_flush_6.tres")
const PAY_TABLE_ENTRY_FULL_HOUSE_9 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_full_house_9.tres")
const PAY_TABLE_ENTRY_FOUR_OF_A_KIND_25 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_four_of_a_kind_25.tres")
const PAY_TABLE_ENTRY_FOUR_OF_A_KIND_5_KING_50 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_four_of_a_kind_5_king_50.tres")
const PAY_TABLE_ENTRY_FOUR_OF_A_KIND_2_3_4_80 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_four_of_a_kind_2_3_4_80.tres")
const PAY_TABLE_ENTRY_FOUR_OF_A_KIND_2_3_4_KICKER_160 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_four_of_a_kind_2_3_4_kicker_160.tres")
const PAY_TABLE_ENTRY_FOUR_OF_A_KIND_ACE_160 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_four_of_a_kind_ace_160.tres")
const PAY_TABLE_ENTRY_FOUR_OF_A_KIND_ACE_KICKER_400 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_four_of_a_kind_ace_kicker_400.tres")

const PAY_TABLE_ENTRY_STRAIGHT_FLUSH_50 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_straight_flush_50.tres")
const PAY_TABLE_ENTRY_ROYAL_FLUSH_800 : PayTableEntry = preload("res://pay_table/data/entries/pay_table_entry_royal_flush_800.tres")

func _run() -> void:
	_jacks_or_better()
	_double_double_bonus()
	return

func _save(pay_table_data : PayTableData, file_path : String) -> Error:
	return ResourceSaver.save(pay_table_data, file_path)

func _jacks_or_better() -> void:
	var error : Error = OK
	var file_name : String = "jacks_or_better"
	var pay_table_data : PayTableData = PayTableData.new()
	
	pay_table_data.add_entry(PAY_TABLE_ENTRY_JACKS_OR_BETTER_1)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_TWO_PAIR_2)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_THREE_OF_A_KIND_3)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_STRAIGHT_4)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FLUSH_6)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FULL_HOUSE_9)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FOUR_OF_A_KIND_25)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_STRAIGHT_FLUSH_50)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_ROYAL_FLUSH_800)
	
	_save(pay_table_data, dir_path + file_prefix + file_name + file_suffix)
	return

func _double_double_bonus() -> void:
	var error : Error = OK
	var file_name : String = "double_double_bonus"
	var pay_table_data : PayTableData = PayTableData.new()
	
	pay_table_data.add_entry(PAY_TABLE_ENTRY_JACKS_OR_BETTER_1)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_TWO_PAIR_1)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_THREE_OF_A_KIND_3)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_STRAIGHT_4)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FLUSH_6)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FULL_HOUSE_9)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FOUR_OF_A_KIND_5_KING_50)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FOUR_OF_A_KIND_2_3_4_80)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FOUR_OF_A_KIND_2_3_4_KICKER_160)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FOUR_OF_A_KIND_ACE_160)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_FOUR_OF_A_KIND_ACE_KICKER_400)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_STRAIGHT_FLUSH_50)
	pay_table_data.add_entry(PAY_TABLE_ENTRY_ROYAL_FLUSH_800)
	
	_save(pay_table_data, dir_path + file_prefix + file_name + file_suffix)
	return
