# Utility class that generates decks and saves them to resource files
@tool
extends EditorScript
class_name DeckFactory

const dir_path : String = "res://deck/data/"
const file_prefix : String = "deck_"
const file_name : String = "standard"
const file_suffix : String = ".tres"

func _run() -> void:
	var error : Error = OK
	var deck : Deck = Deck.new()
	for index_suit : int in range(CardData.NUM_SUITS):
		for index_rank : int in range(CardData.NUM_RANKS):
			var card : CardData = CardData.new()
			card.rank = index_rank
			card.suit = index_suit
			deck.add_card(card)
	print(deck._to_string())
	error = _save(deck, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	return

func _save(deck : Deck, file_path : String) -> Error:
	return ResourceSaver.save(deck, file_path)
