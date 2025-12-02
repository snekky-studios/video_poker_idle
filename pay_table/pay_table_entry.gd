class_name PayTableEntry
extends Resource

@export var hand_rank : Hand.Rank = Hand.Rank.NONE
@export var payout : int = 0

func _to_string() -> String:
	var output : String = ""
	output += Hand.RankName[hand_rank] + " " + str(payout)
	return output
