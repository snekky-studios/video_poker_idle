class_name PayoutIndicator
extends Control

signal finished

var payout : Dictionary[int, int] = {} : set = _set_payout

var vbox_container_currencies : VBoxContainer = null
var hbox_containers_currencies : Array[HBoxContainer] = []
var labels_currency : Array[Label] = []
var animation_player : AnimationPlayer = null

func _ready() -> void:
	vbox_container_currencies = %VBoxContainerCurrencies
	hbox_containers_currencies = [%HBoxContainerCurrency0, %HBoxContainerCurrency1, %HBoxContainerCurrency2, %HBoxContainerCurrency3]
	labels_currency = [%LabelCurrency0, %LabelCurrency1, %LabelCurrency2, %LabelCurrency3]
	animation_player = %AnimationPlayer
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)
	return

func _set_payout(value : Dictionary[int, int]) -> void:
	print("here1: ", value)
	payout = value
	if(payout.keys().size() < 1):
		finished.emit()
		return
	for currency_tier : int in payout:
		if(payout[currency_tier] > 0):
			hbox_containers_currencies[currency_tier].visible = true
			labels_currency[currency_tier].text = Utility.engineering_notation(payout[currency_tier])
		else:
			hbox_containers_currencies[currency_tier].visible = false
	build_animation()
	animation_player.stop(true)
	animation_player.play("play")
	animation_player.advance(0)
	print("here3: ", payout)
	return

func build_animation() -> void:
	var animation : Animation = Animation.new()
	var animation_player_root_node : Node = animation_player.get_node(animation_player.root_node)
	var track_index_vbox_container_position : int = animation.add_track(Animation.TYPE_VALUE)
	animation.length = 2.0
	var path : NodePath = animation_player_root_node.get_path_to(vbox_container_currencies)
	animation.track_set_path(track_index_vbox_container_position, "%s:position" % path)
	animation.track_insert_key(track_index_vbox_container_position, 0.0, Vector2(0.0, 0.0))
	animation.track_insert_key(track_index_vbox_container_position, 2.0, Vector2(0.0, -80.0))
	var key_offset : float = 0.0
	for currency_tier : int in payout:
		if(payout[currency_tier] > 0):
			print("here2: ", payout[currency_tier])
			var track_index_currency_tier_modulate : int = animation.add_track(Animation.TYPE_VALUE)
			path = animation_player_root_node.get_path_to(hbox_containers_currencies[currency_tier])
			animation.track_set_path(track_index_currency_tier_modulate, "%s:modulate" % path)
			animation.track_insert_key(track_index_currency_tier_modulate, key_offset, Color(1.0, 1.0, 1.0, 1.0))
			animation.track_insert_key(track_index_currency_tier_modulate, key_offset + 0.6666, Color(1.0, 1.0, 1.0, 0.0))
			var track_index_currency_tier_visible : int = animation.add_track(Animation.TYPE_VALUE)
			animation.track_set_path(track_index_currency_tier_visible, "%s:visible" % path)
			animation.track_insert_key(track_index_currency_tier_visible, 0.0, false)
			animation.track_insert_key(track_index_currency_tier_visible, key_offset, true)
			key_offset += 0.3333
	animation_player.get_animation_library("").add_animation("play", animation)
	return

func _on_animation_player_animation_finished(_animation_name : String) -> void:
	#finished.emit()
	return
