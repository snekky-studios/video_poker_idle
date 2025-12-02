class_name PayTableData
extends Resource

@export var entries : Array[PayTableEntry] = []
var has_four_of_a_kind : bool = false
var has_four_of_a_kind_5_king : bool = false
var has_four_of_a_kind_2_3_4 : bool = false
var has_four_of_a_kind_ace : bool = false
var has_four_of_a_kind_2_3_4_kicker : bool = false
var has_four_of_a_kind_ace_kicker : bool = false

func add_entry(pay_table_entry : PayTableEntry) -> void:
	entries.append(pay_table_entry)
	if(pay_table_entry.hand_rank == Hand.Rank.FOUR_OF_A_KIND):
		has_four_of_a_kind = true
	elif(pay_table_entry.hand_rank == Hand.Rank.FOUR_OF_A_KIND_5_KING):
		has_four_of_a_kind_5_king = true
	elif(pay_table_entry.hand_rank == Hand.Rank.FOUR_OF_A_KIND_2_3_4):
		has_four_of_a_kind_2_3_4 = true
	elif(pay_table_entry.hand_rank == Hand.Rank.FOUR_OF_A_KIND_ACE):
		has_four_of_a_kind_ace = true
	elif(pay_table_entry.hand_rank == Hand.Rank.FOUR_OF_A_KIND_2_3_4_KICKER):
		has_four_of_a_kind_2_3_4_kicker = true
	elif(pay_table_entry.hand_rank == Hand.Rank.FOUR_OF_A_KIND_ACE_KICKER):
		has_four_of_a_kind_ace_kicker = true
	return

# sorts entries from highest payout to lowest payout
func sort() -> void:
	for index_primary : int in range(entries.size() - 1):
		for index_secondary : int in range(index_primary, entries.size()):
			if(entries[index_primary].payout < entries[index_secondary].payout):
				var temp : PayTableEntry = entries[index_primary]
				entries[index_primary] = entries[index_secondary]
				entries[index_secondary] = temp
	return

func get_payout(hand_rank : Hand.Rank) -> int:
	for entry : PayTableEntry in entries:
		if(entry.hand_rank == hand_rank):
			return entry.payout
	return 0

func _to_string() -> String:
	var output : String = ""
	for entry : PayTableEntry in entries:
		output += entry._to_string() + "\n"
	return output
