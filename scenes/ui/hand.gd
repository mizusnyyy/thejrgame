extends Control
@onready var hand = $handtxt
var x := 0.0
func _ready() -> void:
	x = hand.position.x
	bounce()

func bounce():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(hand, "position", Vector2(x,-4.0), 1)
	tween.tween_property(hand, "position", Vector2(x,-8.0), 1)
	await tween.finished
	bounce()
