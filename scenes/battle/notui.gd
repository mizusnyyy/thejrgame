extends Node2D

signal enemy_turn
signal player_turn
@onready var box = $"../box"
@onready var notui = $"."
@onready var soul = $"../soul"
func _ready() -> void:
	modulate.a=0


func shownoutui():
	var shownotuitween = get_tree().create_tween()
	shownotuitween.tween_property(self, "modulate:a", 1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
func hidenotui():
	var hidenotuitween = get_tree().create_tween()
	hidenotuitween.tween_property(self, "modulate:a", 0.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
func enemyturn():
	hidenotui()
	global.current_state=global.state.ENEMY_TURN
	
	var boxcentertween: Tween
	boxcentertween = create_tween()
	boxcentertween.tween_property(
		box, 
		"scale:x",          # <- tylko oś X
		1.0,                # końcowa wartość skali X
		0.5                 # czas trwania w sekundach
	)
	
	var boxcentersizetween: Tween
	boxcentersizetween = create_tween()
	boxcentersizetween.tween_property(
		box, 
		"position",          # <- tylko oś X
		Vector2(320, 256),                # końcowa wartość skali X
		0.5                 # czas trwania w sekundach
	)
	emit_signal("enemy_turn")


func playerturn():
	shownoutui()
	global.current_state=global.state.PLAYER_TURN
	
	var boxdowntween: Tween
	boxdowntween = create_tween()
	boxdowntween.tween_property(
		box, 
		"position",          # <- tylko oś X
		Vector2(320, 264),        		        # końcowa wartość skali X
		0.5                 # czas trwania w sekundach
	)
	
	var boxdownsizetween: Tween
	boxdownsizetween = create_tween()
	boxdownsizetween.tween_property(
		box, 
		"scale:x",          # <- tylko oś X
		2.0,                # końcowa wartość skali X
		0.5                 # czas trwania w sekundach
	)
