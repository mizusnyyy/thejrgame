class_name Dialogue_node
var text
var next
var speaker
var portrait
var hand

func _init(_text: String = "", _next = null, _speaker = null,_portrait = null,_hand = null):
	text = _text
	next = _next
	speaker = _speaker
	portrait = _portrait
	hand = _hand
