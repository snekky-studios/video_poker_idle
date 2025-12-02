extends Resource
class_name Deck

@export var cards : Array[CardData] = [] # pool of cards that are drawn from
var index : int = 0 # index of the next card in the deck

func add_card(card : CardData) -> void:
	cards.append(card)
	return

# removes card from whatever pile it is in, if any
func remove_card(card : CardData) -> void:
	if(card in cards):
		cards.erase(card)
	else:
		print("error: card not found in deck - ", card.to_string(), " : ", card)
	return

func get_cards() -> Array[CardData]:
	return cards

# sorts the cards array and returns it
# sorts first by suit, smallest to largest [s < h < d < c]
# sorts next by rank, smallest to largest [A < 2 < ... < K]
func sort() -> Array[CardData]:
	# sort by suit
	for index_primary : int in range(cards.size() - 1):
		for index_secondary : int in range(index_primary, cards.size()):
			if(cards[index_primary].suit > cards[index_secondary].suit):
				var card_temp : CardData = cards[index_primary]
				cards[index_primary] = cards[index_secondary]
				cards[index_secondary] = card_temp
	# sort by rank
	var num_cards_of_suit : Array[int] = []
	num_cards_of_suit.resize(CardData.NUM_SUITS)
	num_cards_of_suit.fill(0)
	# count the number of cards of each suit
	for index_cards : int in range(cards.size()):
		num_cards_of_suit[cards[index_cards].suit] += 1
	# loop through each suit and sort by rank within each
	var index_cards : int = 0 # keep track of where we are in the deck overall
	for index_suit : int in range(CardData.NUM_SUITS):
		for index_primary : int in range(index_cards, index_cards + num_cards_of_suit[index_suit] - 1):
			for index_secondary : int in range(index_primary, index_cards + num_cards_of_suit[index_suit]):
				if(cards[index_primary].rank > cards[index_secondary].rank):
					var card_temp : CardData = cards[index_primary]
					cards[index_primary] = cards[index_secondary]
					cards[index_secondary] = card_temp
		index_cards += num_cards_of_suit[index_suit]
	return cards

# shuffles the deck
func shuffle() -> void:
	index = 0
	cards.shuffle()
	return

# returns the top card of the deck or returns null if the deck is empty
func deal() -> CardData:
	if(index < cards.size()):
		index += 1
		return cards[index - 1]
	return null

# returns the number of cards remaining in the deck
func remaining_cards() -> int:
	return cards.size() - index

func _to_string() -> String:
	var output : String = ""
	for index_card : int in range(cards.size()):
		output += cards[index_card]._to_string() + ","
		if((index_card + 1) % 13 == 0):
			output += "\n"
	return output
