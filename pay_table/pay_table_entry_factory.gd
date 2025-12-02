@tool
class_name PayTableEntryFactory
extends EditorScript

const dir_path : String = "res://pay_table/data/entries/"
const file_prefix : String = "pay_table_entry_"
const file_suffix : String = ".tres"

func _run() -> void:
	_jacks_or_better()
	_double_double_bonus()
	return

func _jacks_or_better() -> void:
	var error : Error = OK
	var file_name : String = ""
	var pay_table_entry : PayTableEntry = null
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.JACKS_OR_BETTER, 1)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.TWO_PAIR, 2)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.THREE_OF_A_KIND, 3)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.STRAIGHT, 4)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FLUSH, 6)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FULL_HOUSE, 9)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FOUR_OF_A_KIND, 25)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.STRAIGHT_FLUSH, 50)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.ROYAL_FLUSH, 800)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	return

func _double_double_bonus() -> void:
	var error : Error = OK
	var file_name : String = ""
	var pay_table_entry : PayTableEntry = null
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.JACKS_OR_BETTER, 1)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.TWO_PAIR, 1)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.THREE_OF_A_KIND, 3)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.STRAIGHT, 4)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FLUSH, 6)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FULL_HOUSE, 9)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FOUR_OF_A_KIND_5_KING, 50)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FOUR_OF_A_KIND_2_3_4, 80)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FOUR_OF_A_KIND_2_3_4_KICKER, 160)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FOUR_OF_A_KIND_ACE, 160)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.FOUR_OF_A_KIND_ACE_KICKER, 400)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.STRAIGHT_FLUSH, 50)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	
	pay_table_entry = _create_pay_table_entry(Hand.Rank.ROYAL_FLUSH, 800)
	file_name = _replace_spaces_with_underscores(str(Hand.RankName[pay_table_entry.hand_rank].to_lower())) + "_" + str(pay_table_entry.payout)
	print(pay_table_entry._to_string())
	error = _save(pay_table_entry, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	return

func _create_pay_table_entry(hand_rank : Hand.Rank, payout : int) -> PayTableEntry:
	var pay_table_entry : PayTableEntry = PayTableEntry.new()
	pay_table_entry.hand_rank = hand_rank
	pay_table_entry.payout = payout
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
