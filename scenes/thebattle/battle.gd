extends Node2D

@onready var enemy := $enemy
@onready var jack := $soul/jack
@onready var soul := $soul
@onready var soulsprite := $soul/heart
@onready var label := $enemy/RichTextLabel
var turn := false
#false to enemy a true to player

signal itsplayerturn
signal itsenemyturn

func playerturn():
	emit_signal("itsplayerturn")
	
	var movesouldown = get_tree().create_tween()
	soul.can_move=false
	movesouldown.tween_property(soul, "position:y", 320.0, 1.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	soul.can_move=true
	turn = true
func enemyturn():
	emit_signal("itsenemyturn")
	
	await get_tree().create_timer(1.0).timeout
	
	#var movesoulup = get_tree().create_tween()
	#movesoulup.tween_property(soul, "position:y", 256.0, 1.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	turn = false
	
	say("janek... to ty omb omb serio janek!")

func _ready() -> void:
	label.text=""
	await get_tree().create_timer(3.0).timeout
	var showenemy = get_tree().create_tween()
	showenemy.tween_property(enemy, "position:y", 96.0, 1.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	
	enemyturn()
	await get_tree().create_timer(5.0).timeout
	playerturn()
func say(text: String, speed: float = 0.05) -> void:
	label.text = ""
	for i in text.length():
		label.text += text[i]
		await get_tree().create_timer(speed).timeout
		
func _process(delta: float) -> void:
	if turn:
		soulsprite.visible=false
		jack.visible=true
	else:
		soulsprite.visible=true
		jack.visible=false
