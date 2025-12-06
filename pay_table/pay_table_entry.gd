class_name PayTableEntry
extends Resource

@export var hand_rank : Hand.Rank = Hand.Rank.NONE
@export var index : int = 0
@export var level : int = 1
@export var base_payouts : Dictionary[int, int] = {}
@export var upgrade_base_costs : Dictionary[int, int] = {}

func add_base_payout(currency_tier : int, payout : int) -> void:
	base_payouts[currency_tier] = payout
	return

func add_upgrade_base_cost(currency_tier : int, upgrade_base_cost : int) -> void:
	upgrade_base_costs[currency_tier] = upgrade_base_cost
	return

func _to_string() -> String:
	var output : String = ""
	output += Hand.RankName[hand_rank] + "\ncurrency tier,"
	for key : int in base_payouts.keys():
		output += str(key) + ","
	output += "\npayout,"
	for key : int in base_payouts.keys():
		output += str(base_payouts[key]) + ","
	output += "\nupgrade base cost,"
	for key : int in upgrade_base_costs.keys():
		output += str(upgrade_base_costs[key]) + ","
	return output
