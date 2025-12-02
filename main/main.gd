class_name Main
extends Node

const LEVEL_0 : LevelData = preload("res://level/data/level_0.tres")

var level : Level = null

func _ready() -> void:
	level = %Level
	level.data = LEVEL_0
	return
