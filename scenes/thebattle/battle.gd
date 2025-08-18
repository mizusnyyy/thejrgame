extends Node2D

@onready var enemy := $enemy
@onready var jack := $soul/jack
@onready var soul := $soul
@onready var soulsprite := $soul/heart
@onready var label := $enemy/RichTextLabel
@onready var fbox := $box
@onready var bg := $bg
@onready var musicplayer := $music

var shaking := false
var urturn := false
var is_rectangle = false

signal itsplayerturn
signal itsenemyturn
signal yousawitcoming
signal said

func playerturn():
	emit_signal("itsplayerturn")
	if soulsprite.visible:
		changevisibilty()
	var boxscaleplayerturn = get_tree().create_tween()
	boxscaleplayerturn.tween_property(fbox, "scale", 1.5, 1.0)

func enemyturn():
	emit_signal("itsenemyturn")
	if !soulsprite.visible:
		changevisibilty()
	
	var boxscaleenemyturn = get_tree().create_tween()
	boxscaleenemyturn.tween_property(fbox, "scale", 1.0, 1.0)
	
	await get_tree().create_timer(1.0).timeout

	#var movesoulup = get_tree().create_tween()
	#movesoulup.tween_property(soul, "position:y", 256.0, 1.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	urturn = false



func _ready() -> void:
	label.text=""
	youneverseeitcoming()
	await yousawitcoming
	say("YOU... STUPID\nJAAAAACK!",2)
	await said
	say("ITS PUM TIME!!!",1)
	await said
	enemyturn()
	
	#playerturn()



func say(text: String, decaytime: float = 3.0, speed: float = 0.05) -> void:
	label.text = ""
	for i in text.length():
		label.text += text[i]
		
		if text[i] == ".":
			await get_tree().create_timer(speed * 6).timeout
		elif text[i] == " ":
			await get_tree().create_timer(speed * 2).timeout
		else:
			await get_tree().create_timer(speed).timeout
	
	await get_tree().create_timer(decaytime).timeout
	label.text = ""
	emit_signal("said")


func youneverseeitcoming():
	bg.visible=false
	fbox.visible=false
	soul.can_move=false
	soulsprite.visible=false
	jack.visible=true
	soul.position=Vector2(320,180)
	
	await get_tree().create_timer(2.0).timeout
	var movesouldown = get_tree().create_tween()
	movesouldown.tween_property(soul, "position:y", 304.0, 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	fbox.visible=true
	
	var showenemy = get_tree().create_tween()
	showenemy.tween_property(enemy, "position:y", 96.0, 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.2).timeout
	shake(self,1,2.5)
	shake(self,0.25,1)
	musicplayer.play()
	await showenemy.finished
	shake(enemy,0.2,4)
	for i in range(2):
		jack.visible=false
		bg.visible=true
		soulsprite.visible=true
		await get_tree().create_timer(0.1).timeout
		jack.visible=true
		soulsprite.visible=false
		await get_tree().create_timer(0.1).timeout
	soul.can_move=true
	emit_signal("yousawitcoming")

func changevisibilty():
	for i in range(5):
		soulsprite.visible=!soulsprite.visible
		jack.visible=!jack.visible
		await get_tree().create_timer(0.1).timeout

func shake(who: Node2D, duration: float = 0.3, strength: float = 5.0) -> void:
	if shaking:
		return
	shaking = true
	_do_shake(who, duration, strength)
func _do_shake(who: Node2D, duration: float, strength: float) -> void:
	var timer := duration
	var original_pos := who.position

	while timer > 0:
		who.position = original_pos + Vector2(
			randf_range(-strength, strength),
			randf_range(-strength, strength)
		)
		await get_tree().create_timer(0.02).timeout
		timer -= 0.02

	who.position = original_pos
	shaking = false
	who.position = original_pos
	shaking = false
