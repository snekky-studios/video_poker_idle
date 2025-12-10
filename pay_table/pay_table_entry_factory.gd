@tool
class_name PayTableEntryFactory
extends EditorScript

const LEVEL : int = 0

const dir_path : String = "res://pay_table/data/entries/"
const file_prefix : String = "pay_table_entry_"
const file_suffix : String = ".tres"

func _run() -> void:
	_double_double_bonus()
	return

func _double_double_bonus() -> void:
	var error : Error = OK
	var file_name : String = ""
	var pay_table_entry : PayTableEntry = null
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.JACKS_OR_BETTER, 0, [1, 0, 0, 0], [1, 0, 0, 0])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.TWO_PAIR, 1, [1, 0, 0, 0], [1, 0, 0, 0])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.THREE_OF_A_KIND, 2, [3, 0, 0, 0], [3, 0, 0, 0])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.STRAIGHT, 3, [4, 1, 0, 0], [4, 0, 0, 0])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FLUSH, 4, [5, 2, 0, 0], [5, 1, 0, 0])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FULL_HOUSE, 5, [9, 3, 0, 0], [9, 1, 0, 0])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FOUR_OF_A_KIND_5_KING, 6, [50, 4, 1, 0], [50, 3, 0, 0])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FOUR_OF_A_KIND_2_3_4, 7, [80, 5, 2, 0], [80, 4, 1, 0])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FOUR_OF_A_KIND_ACE, 8, [160, 9, 3, 0], [160, 5, 2, 0])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FOUR_OF_A_KIND_2_3_4_KICKER, 9, [160, 25, 4, 1], [160, 9, 3, 0])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FOUR_OF_A_KIND_ACE_KICKER, 10, [400, 80, 9, 3], [400, 50, 5, 2])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.STRAIGHT_FLUSH, 11, [50, 50, 5, 2], [50, 25, 4, 1])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.ROYAL_FLUSH, 12, [800, 160, 25, 4], [800, 80, 9, 3])
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower()))
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print(pay_table_entry._to_string())
	
	return

func _create_pay_table_entry(hand_rank : Hand.Rank, index : int, base_payouts : Array[int], upgrade_base_costs : Array[int]) -> PayTableEntry:
	var pay_table_entry : PayTableEntry = PayTableEntry.new()
	pay_table_entry.hand_rank = hand_rank
	pay_table_entry.index = index
	pay_table_entry.level = LEVEL
	for index_payout : int in range(base_payouts.size()):
		pay_table_entry.add_base_payout(index_payout, base_payouts[index_payout])
	for index_upgrade_base_costs : int in range(upgrade_base_costs.size()):
		pay_table_entry.add_upgrade_base_cost(index_upgrade_base_costs, upgrade_base_costs[index_upgrade_base_costs])
	return pay_table_entry

func _replace_spaces_with_underscores(input : String) -> String:
	var output : String = ""
	for index_string : int in range(input.length()):
		if(input[index_string] == " "):
			output += "_"
		else:
			output += input[index_string]
	return output

func _save(pay_table_entry : PayTableEntry, file_path : String) -> Error:
	return ResourceSaver.save(pay_table_entry, file_path)
