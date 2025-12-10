class_name PayTableEntry
extends Resource

const MULTIPLIER_CURRENCY_TIER : Array[float] = [1.2, 1.2, 1.2, 1.2]

@export var hand_rank : Hand.Rank = Hand.Rank.NONE
@export var index : int = 0
@export var level : int = 1
@export var base_payouts : Dictionary[int, int] = {}
@export var base_upgrade_costs : Dictionary[int, int] = {}

func add_base_payout(currency_tier : int, payout : int) -> void:
	base_payouts[currency_tier] = payout
	return

func add_upgrade_base_cost(currency_tier : int, upgrade_base_cost : int) -> void:
	base_upgrade_costs[currency_tier] = upgrade_base_cost
	return

func get_payout() -> Dictionary[int, int]:
	var payout : Dictionary[int, int] = {}
	for currency_tier : int in base_payouts.keys():
		payout[currency_tier] = calculate_payout(currency_tier)
	return payout

func get_upgrade_cost() -> Dictionary[int, int]:
	var upgrade_cost : Dictionary[int, int] = {}
	for currency_tier : int in base_upgrade_costs.keys():
		upgrade_cost[currency_tier] = calculate_upgrade_cost(currency_tier)
	return upgrade_cost

func calculate_payout(currency_tier : int) -> int:
	return int(float(base_payouts[currency_tier]) * pow(float(level), MULTIPLIER_CURRENCY_TIER[currency_tier]))

func calculate_upgrade_cost(currency_tier : int) -> int:
	return int(float(base_upgrade_costs[currency_tier]) * pow(MULTIPLIER_CURRENCY_TIER[currency_tier], float(level)) + 1.0) # + 1 for CEILING function

func _to_string() -> String:
	var output : String = ""
	output += Hand.RankName[hand_rank] + "\ncurrency tier,"
	for key : int in base_payouts.keys():
		output += str(key) + ","
	output += "\npayout,"
	for key : int in base_payouts.keys():
		output += str(base_payouts[key]) + ","
	output += "\nupgrade base cost,"
	for key : int in base_upgrade_costs.keys():
		output += str(base_upgrade_costs[key]) + ","
	return output
