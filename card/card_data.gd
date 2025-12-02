extends Resource
class_name CardData

enum Rank
{
	ACE = 0,
	TWO = 1,
	THREE = 2,
	FOUR = 3,
	FIVE = 4,
	SIX = 5,
	SEVEN = 6,
	EIGHT = 7,
	NINE = 8,
	TEN = 9,
	JACK = 10,
	QUEEN = 11,
	KING = 12,
	ERROR = 13
}

enum Suit
{
	SPADE = 0,
	HEART = 1,
	DIAMOND = 2,
	CLUB = 3,
	ERROR = 4
}

const RankName : Dictionary = {
	Rank.ACE : "A",
	Rank.TWO : "2",
	Rank.THREE : "3",
	Rank.FOUR : "4",
	Rank.FIVE : "5",
	Rank.SIX : "6",
	Rank.SEVEN : "7",
	Rank.EIGHT : "8",
	Rank.NINE : "9",
	Rank.TEN : "T",
	Rank.JACK : "J",
	Rank.QUEEN : "Q",
	Rank.KING : "K",
	Rank.ERROR : "E",
}

const SuitName : Dictionary = {
	Suit.SPADE : "s",
	Suit.HEART : "h",
	Suit.DIAMOND : "d",
	Suit.CLUB : "c",
	Suit.ERROR : "e"
}

const LUT_RANK : Array[String] = ['A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'E']
const LUT_SUIT : Array[String] = ['s', 'h', 'd', 'c', 'e']
const LUT_RANK_NAME : Array[String] = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
const LUT_SUIT_NAME : Array[String] = ["Spade", "Heart", "Diamond", "Club"]

const NUM_RANKS : int = 13
const NUM_SUITS : int = 4

const RANK_ACE : int = 0
const RANK_TEN : int = 9
const RANK_JACK : int = 10
const RANK_QUEEN : int = 11
const RANK_KING : int = 12
const RANK_ERROR : int = 13
const RANKS : Array[int] = [RANK_ACE, 1, 2, 3, 4, 5, 6, 7, 8, RANK_TEN, RANK_JACK, RANK_QUEEN, RANK_KING]

const SUIT_SPADE : int = 0
const SUIT_HEART : int = 1
const SUIT_DIAMOND : int = 2
const SUIT_CLUB : int = 3
const SUIT_ERROR : int = 4
const SUITS : Array[int] = [SUIT_SPADE, SUIT_HEART, SUIT_DIAMOND, SUIT_CLUB]

const TEXTURE_COORDINATES_ERROR_X : int = 13
const TEXTURE_COORDINATES_ERROR_Y : int = 0

@export var rank : int = RANK_ERROR : set = _set_rank
@export var suit : int = RANK_ERROR : set = _set_suit

var texture_coordinates : Vector2i = Vector2i.ZERO

func _set_rank(value : int) -> void:
	rank = value
	if(rank == Rank.ERROR):
		texture_coordinates.x = TEXTURE_COORDINATES_ERROR_X
	else:
		texture_coordinates.x = rank
	return

func _set_suit(value : int) -> void:
	suit = value
	if(suit == Suit.ERROR):
		texture_coordinates.y = TEXTURE_COORDINATES_ERROR_Y
	else:
		texture_coordinates.y = suit
	return

func _to_string() -> String:
	return LUT_RANK[rank] + LUT_SUIT[suit]
