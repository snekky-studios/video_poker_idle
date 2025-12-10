class_name UpgradeData
extends Resource

const MULTIPLIER_CURRENCY_TIER : Array[float] = [1.2, 1.2, 1.2, 1.2]

const UPGRADE_COST_STATISTICS : Array[Dictionary] = [
	{
		0 : 10, 1 : 0, 2 : 0, 3 : 0
	},
	{
		0 : 100, 1 : 10, 2 : 0, 3 : 0
	},
	{
		0 : 1000, 1 : 100, 2 : 10, 3 : 0
	},
	{
		0 : 10000, 1 : 1000, 2 : 100, 3 : 10
	}
]

const UPGRADE_COST_DRAWS : Array[Dictionary] = [
	{
		0 : 10, 1 : 0, 2 : 0, 3 : 0
	},
	{
		0 : 1000, 1 : 100, 2 : 0, 3 : 0
	},
	{
		0 : 100000, 1 : 10000, 2 : 100, 3 : 0
	},
	{
		0 : 100000000, 1 : 10000000, 2 : 10000, 3 : 100
	}
]


@export var statistics_level : int = 0
@export var draws_level : int = 0
@export var passive_income_level : int = 0

func get_upgrade_cost_draws() -> Dictionary[int, int]:
	return UPGRADE_COST_DRAWS[draws_level]






func _calculate_upgrade_cost_draws(currency_tier : int) -> int:
	return 0
