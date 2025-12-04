class_name PayTableData
extends Resource

const HAND_RANK_NAMES : Dictionary[Hand.Rank, String] = {
	Hand.Rank.NONE : "NONE",
	Hand.Rank.HIGH_CARD : "HIGH CARD",
	Hand.Rank.PAIR : "PAIR",
	Hand.Rank.JACKS_OR_BETTER : "JACKS OR BETTER",
	Hand.Rank.TWO_PAIR : "2 PAIR",
	Hand.Rank.THREE_OF_A_KIND : "3 OF A KIND",
	Hand.Rank.STRAIGHT : "STRAIGHT",
	Hand.Rank.FLUSH : "FLUSH",
	Hand.Rank.FULL_HOUSE : "FULL HOUSE",
	Hand.Rank.FOUR_OF_A_KIND : "4 OF A KIND",
	Hand.Rank.FOUR_OF_A_KIND_5_KING : "4 5S THRU KINGS",
	Hand.Rank.FOUR_OF_A_KIND_2_3_4 : "4 2S, 3S, 4S",
	Hand.Rank.FOUR_OF_A_KIND_ACE : "4 ACES",
	Hand.Rank.FOUR_OF_A_KIND_2_3_4_KICKER : "4 2S, 3S, 4S W/ ACE, 2, 3, 4",
	Hand.Rank.FOUR_OF_A_KIND_ACE_KICKER : "4 ACES W/ 2, 3, 4",
	Hand.Rank.STRAIGHT_FLUSH : "STRAIGHT FLUSH",
	Hand.Rank.ROYAL_FLUSH : "ROYAL FLUSH",
	Hand.Rank.FIVE_OF_A_KIND : "5 OF A KIND",
	Hand.Rank.FLUSH_HOUSE : "FLUSH HOUSE",
	Hand.Rank.FLUSH_FIVE : "FLUSH 5"
}

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

func get_hand_rank_name(hand_rank : Hand.Rank) -> String:
	return HAND_RANK_NAMES[hand_rank]

func _to_string() -> String:
	var output : String = ""
	for entry : PayTableEntry in entries:
		output += entry._to_string() + "\n"
	return output
