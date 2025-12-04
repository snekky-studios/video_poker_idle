extends Node
class_name Hand

enum Rank {
	NONE,
	HIGH_CARD,
	PAIR,
	JACKS_OR_BETTER,
	TWO_PAIR,
	THREE_OF_A_KIND,
	STRAIGHT,
	FLUSH,
	FULL_HOUSE,
	FOUR_OF_A_KIND,
	FOUR_OF_A_KIND_5_KING,
	FOUR_OF_A_KIND_2_3_4,
	FOUR_OF_A_KIND_ACE,
	FOUR_OF_A_KIND_2_3_4_KICKER,
	FOUR_OF_A_KIND_ACE_KICKER,
	STRAIGHT_FLUSH,
	ROYAL_FLUSH,
	FIVE_OF_A_KIND,
	FLUSH_HOUSE,
	FLUSH_FIVE
}

const RankName : Dictionary[Rank, String] = {
	Rank.NONE : "NONE",
	Rank.HIGH_CARD : "HIGH CARD",
	Rank.PAIR : "PAIR",
	Rank.JACKS_OR_BETTER : "JACKS OR BETTER",
	Rank.TWO_PAIR : "TWO PAIR",
	Rank.THREE_OF_A_KIND : "THREE OF A KIND",
	Rank.STRAIGHT : "STRAIGHT",
	Rank.FLUSH : "FLUSH",
	Rank.FULL_HOUSE : "FULL HOUSE",
	Rank.FOUR_OF_A_KIND : "FOUR OF A KIND",
	Rank.FOUR_OF_A_KIND_5_KING : "FOUR OF A KIND 5 KING",
	Rank.FOUR_OF_A_KIND_2_3_4 : "FOUR OF A KIND 2 3 4",
	Rank.FOUR_OF_A_KIND_ACE : "FOUR OF A KIND ACE",
	Rank.FOUR_OF_A_KIND_2_3_4_KICKER : "FOUR OF A KIND 2 3 4 KICKER",
	Rank.FOUR_OF_A_KIND_ACE_KICKER : "FOUR OF A KIND ACE KICKER",
	Rank.STRAIGHT_FLUSH : "STRAIGHT FLUSH",
	Rank.ROYAL_FLUSH : "ROYAL FLUSH",
	Rank.FIVE_OF_A_KIND : "FIVE OF A KIND",
	Rank.FLUSH_HOUSE : "FLUSH HOUSE",
	Rank.FLUSH_FIVE : "FLUSH FIVE"
}

const NUM_RANKS : int = 15
const NUM_CARDS_FULL_HAND : int = 5

func _ready() -> void:
	return

# sorts the hand by rank, smallest to largest, and returns a sorted copy of the hand
static func sort(hand : Array[CardData]) -> Array[CardData]:
	# copy hand into new array
	var hand_sorted : Array[CardData] = []
	hand_sorted.resize(hand.size())
	for index_hand : int in range(hand.size()):
		hand_sorted[index_hand] = hand[index_hand]
	# sort hand by rank, smallest to largest
	for index_primary : int in range(hand_sorted.size() - 1):
		for index_secondary : int in range(index_primary + 1, hand_sorted.size()):
			if(hand_sorted[index_primary].rank > hand_sorted[index_secondary].rank):
				var card_temp : CardData = hand_sorted[index_primary]
				hand_sorted[index_primary] = hand_sorted[index_secondary]
				hand_sorted[index_secondary] = card_temp
	return hand_sorted

# evaluates the hand and returns its rank
static func rank(hand : Array[CardData]) -> Rank:
	var hand_size : int = hand.size() # avoids repeated .size() calls
	
	# no cards in hand, or too many cards, therefore no hand rank
	if(hand_size == 0 or hand_size > NUM_CARDS_FULL_HAND):
		return Rank.NONE
	
	# one card in hand, therefore must be highcard
	if(hand_size == 1):
		return Rank.HIGH_CARD
	
	var hand_sorted : Array[CardData] = sort(hand)
	
	# store these in variables to avoid processing more than once
	var is_flush : bool = _is_flush(hand_sorted)
	var is_straight : bool = _is_straight(hand_sorted)
	
	# check for straight flush and flush
	if(is_flush and is_straight):
		if(hand_sorted[4].rank == CardData.Rank.KING):
			return Rank.ROYAL_FLUSH
		return Rank.STRAIGHT_FLUSH
	elif(is_flush):
		return Rank.FLUSH
	
	# check for straight
	if(is_straight):
		return Rank.STRAIGHT
	
	var counter : Array[int] = []
	counter.resize(CardData.NUM_RANKS)
	counter.fill(0)
	var pairs : int = 0
	var triples : int = 0
	var is_jacks_or_better : bool = false
	var has_kicker : bool = false
	
	# count how many of each rank appears in the hand
	for index_hand : int in range(hand_size):
		counter[hand_sorted[index_hand].rank] += 1
	
	# check for kicker (relevant for certain 4s of a kind)
	if(counter[CardData.Rank.ACE] == 1 or counter[CardData.Rank.TWO] == 1 or counter[CardData.Rank.THREE] == 1 or counter[CardData.Rank.FOUR] == 1):
		has_kicker = true
	
	# check for four of a kinds, three of a kinds, and pairs
	for index_counter : int in range(CardData.NUM_RANKS):
		if(counter[index_counter] == 4):
			if(index_counter == CardData.Rank.ACE):
				if(has_kicker):
					return Rank.FOUR_OF_A_KIND_ACE_KICKER
				else:
					return Rank.FOUR_OF_A_KIND_ACE
			elif(index_counter == CardData.Rank.TWO or index_counter == CardData.Rank.THREE or index_counter == CardData.Rank.FOUR):
				if(has_kicker):
					return Rank.FOUR_OF_A_KIND_2_3_4_KICKER
				else:
					return Rank.FOUR_OF_A_KIND_2_3_4
			else:
				return Rank.FOUR_OF_A_KIND_5_KING
		elif(counter[index_counter] == 3):
			triples += 1
		elif(counter[index_counter] == 2):
			pairs += 1
			if(index_counter == CardData.Rank.ACE or index_counter >= CardData.Rank.JACK):
				is_jacks_or_better = true
	
	# check for full house and three of a kind
	if(triples == 1):
		if(pairs == 1):
			return Rank.FULL_HOUSE
		else:
			return Rank.THREE_OF_A_KIND
	
	# check for two pair
	if(pairs == 2):
		return Rank.TWO_PAIR
	
	# check for pair
	if(pairs == 1):
		if(is_jacks_or_better):
			return Rank.JACKS_OR_BETTER
		else:
			return Rank.PAIR
	
	# was not anything else, must be high card
	return Rank.HIGH_CARD

# returns the card rank that appears most often in the hand, or CarData.RANK_ERROR if all appear equal amounts of times
static func card_rank_mode(hand : Array[CardData]) -> int:
	var counter : Array[int] = []
	counter.resize(CardData.NUM_RANKS)
	counter.fill(0)
	# count how many of each rank appears in the hand
	for index_hand : int in range(hand.size()):
		counter[hand[index_hand].rank] += 1
	# find the rank that appears the most
	var card_rank_count_max : int = 0
	var card_rank_max : int = CardData.RANK_ERROR
	for index_counter : int in range(counter.size()):
		if(counter[index_counter] > card_rank_count_max):
			card_rank_count_max = counter[index_counter]
			card_rank_max = index_counter
	return card_rank_max

# returns the card suit that appears most often in the hand, or CarData.SUIT_ERROR if all appear equal amounts of times
static func card_suit_mode(hand : Array[CardData]) -> int:
	var counter : Array[int] = []
	counter.resize(CardData.NUM_SUITS)
	counter.fill(0)
	# count how many of each suit appears in the hand
	for index_hand : int in range(hand.size()):
		counter[hand[index_hand].suit] += 1
	# find the suit that appears the most
	var card_suit_count_max : int = 0
	var card_suit_max : int = CardData.SUIT_ERROR
	for index_counter : int in range(counter.size()):
		if(counter[index_counter] > card_suit_count_max):
			card_suit_count_max = counter[index_counter]
			card_suit_max = index_counter
	return card_suit_max

# returns true if the hand has five cards of the same suit, false otherwise
static func _is_flush(hand : Array[CardData]) -> bool:
	# only a full 5 card hand can be a flush
	if(hand.size() != NUM_CARDS_FULL_HAND):
		return false
	for index_hand : int in range(1, NUM_CARDS_FULL_HAND):
		if(hand[0].suit != hand[index_hand].suit):
			return false
	return true

# returns true if the hand has five sequential cards, false otherwise
static func _is_straight(hand : Array[CardData]) -> bool:
	# only a full 5 card hand can be a straight
	if(hand.size() != NUM_CARDS_FULL_HAND):
		return false
	# check for ace high straight first
	if(hand[0].rank == CardData.RANK_ACE and
		hand[1].rank == CardData.RANK_TEN and
		hand[2].rank == CardData.RANK_JACK and
		hand[3].rank == CardData.RANK_QUEEN and
		hand[4].rank == CardData.RANK_KING):
		return true
	# now check for general case
	for index_hand : int in range(NUM_CARDS_FULL_HAND - 1):
		if(hand[index_hand].rank != hand[index_hand + 1].rank - 1):
			return false
	return true

# returns a combined string of the cards in hand
static func hand_to_string(hand : Array[CardData]) -> String:
	var output : String = ""
	for index_hand : int in range(hand.size()):
		output += hand[index_hand]._to_string() + ","
	return output
