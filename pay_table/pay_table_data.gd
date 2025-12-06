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
@export var has_hand_rank : Dictionary[Hand.Rank, bool] = {
	Hand.Rank.NONE : false,
	Hand.Rank.HIGH_CARD : false,
	Hand.Rank.PAIR : false,
	Hand.Rank.JACKS_OR_BETTER : false,
	Hand.Rank.TWO_PAIR : false,
	Hand.Rank.THREE_OF_A_KIND : false,
	Hand.Rank.STRAIGHT : false,
	Hand.Rank.FLUSH : false,
	Hand.Rank.FULL_HOUSE : false,
	Hand.Rank.FOUR_OF_A_KIND_5_KING : false,
	Hand.Rank.FOUR_OF_A_KIND_2_3_4 : false,
	Hand.Rank.FOUR_OF_A_KIND_ACE : false,
	Hand.Rank.FOUR_OF_A_KIND_2_3_4_KICKER : false,
	Hand.Rank.FOUR_OF_A_KIND_ACE_KICKER : false,
	Hand.Rank.STRAIGHT_FLUSH : false,
	Hand.Rank.ROYAL_FLUSH : false,
	Hand.Rank.FIVE_OF_A_KIND : false,
	Hand.Rank.FLUSH_HOUSE : false,
	Hand.Rank.FLUSH_FIVE : false
}

func add_entry(pay_table_entry : PayTableEntry) -> void:
	entries.append(pay_table_entry)
	has_hand_rank[pay_table_entry.hand_rank] = true
	return

# sorts entries from highest to lowest index
func sort() -> void:
	for index_primary : int in range(entries.size() - 1):
		for index_secondary : int in range(index_primary, entries.size()):
			if(entries[index_primary].index < entries[index_secondary].index):
				var temp : PayTableEntry = entries[index_primary]
				entries[index_primary] = entries[index_secondary]
				entries[index_secondary] = temp
	return

func get_payout(hand_rank : Hand.Rank, currency_tier : int) -> int:
	for entry : PayTableEntry in entries:
		if(entry.hand_rank == hand_rank):
			return entry.base_payouts[currency_tier] * entry.level
	return 0

func get_hand_rank_name(hand_rank : Hand.Rank) -> String:
	return HAND_RANK_NAMES[hand_rank]

func _to_string() -> String:
	var output : String = ""
	for entry : PayTableEntry in entries:
		output += entry._to_string() + "\n"
	return output
