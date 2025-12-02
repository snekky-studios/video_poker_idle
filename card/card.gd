extends Area2D
class_name Card

signal selected(card : Card)

const SPRITE_SIZE : int = 32

var data : CardData = null : set = _set_data
var is_hovered : bool = false
var is_selected : bool = false

var sprite_2d : Sprite2D = null

func _ready() -> void:
	sprite_2d = %Sprite2D
	return

func _unhandled_input(event : InputEvent) -> void:
	if(is_hovered and event.is_action_pressed("select")):
		selected.emit(self)
	return

func _set_data(value : CardData) -> void:
	data = value
	sprite_2d.region_rect.position = Vector2(data.texture_coordinates) * SPRITE_SIZE
	return

func _to_string() -> String:
	return data._to_string()

func _on_mouse_entered() -> void:
	is_hovered = true
	return

func _on_mouse_exited() -> void:
	is_hovered = false
	return
