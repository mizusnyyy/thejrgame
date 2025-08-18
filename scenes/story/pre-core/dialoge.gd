extends Control

@export var text_speed := 0.05
@onready var tempspeed = text_speed
@onready var label := $RichTextLabel
@onready var portrait := $TextureRect
@onready var choice = $choice/indicator
@onready var markeropt = $RichTextLabel/optsetter
var just_chose := false

signal dialogue_started
signal dialogue_finished         # sygnał końca linii BEZ opcji (zamknięcie okna)
signal text_typed                # ✅ NOWY: koniec animacji pisania
signal choice_selected(index:int)# ✅ NOWY: wybrano opcję (zwraca index)

var full_text := ""
var char_index := 0
var typing := false
var dialogue_active := false
var choosing := false
var type_sound_player: AudioStreamPlayer2D = null

func _ready() -> void:
	hide()

func setname(textset):
	$TextureRect/speaker.text = textset
# wait_for_close:
# true  -> zachowanie jak dotąd: czekamy na interact i emitujemy dialogue_finished
# false -> tylko napisz tekst litera-po-literze i ZWRÓĆ po text_typed (bez zamykania)
func show_dialogue(
	text: String,
	portrait_texture: Texture = null,
	typesound: AudioStreamPlayer2D = null,
	wait_for_close: bool = true
) -> void:
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	global.can_move = false

	full_text = text
	char_index = 0
	label.text = ""
	typing = true
	dialogue_active = true
	choice.can_choose = true
	choosing = false

	type_sound_player = typesound

	if portrait_texture:
		portrait.texture = portrait_texture
		portrait.visible = true
	else:
		portrait.visible = false

	show()
	emit_signal("dialogue_started")

	_type_text()
	await text_typed

	if wait_for_close:
		await dialogue_finished
		hide()
		global.can_move = true
	else:
		# Nie zamykamy okna – pozwalamy managerowi pokazać opcje
		return

func choose(options: Array, texts: Array):
	choosing = true
	choice.global_position = Vector2(359,309)
	show()
	choice.show()
	choice.can_choose = true
	global.can_move = false

	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.text = ""

	await setoptions(options, texts) # czeka do momentu wyboru (obsługa w setoptions)

func setoptions(options: Array, texts: Array) -> void:
	print("wwwzz",typing)
	var sceneopt = load("res://scenes/ui/buttonopt.tscn")
	var alan: Array = []
	for i in range(options.size()):
		var ins = sceneopt.instantiate()
		add_child(ins)
		ins.selfid = i
		# rozstawienie
		var mar = markeropt.global_position
		match i:
			0: ins.global_position = Vector2(mar.x-40, mar.y-20)
			1: ins.global_position = Vector2(mar.x+40, mar.y-20)
			2: ins.global_position = Vector2(mar.x-40, mar.y+20)
			3: ins.global_position = Vector2(mar.x+40, mar.y+20)
			_: ins.global_position = Vector2(mar.x, mar.y)

		ins.settext(texts[i])
		alan.append(ins)
		ins.choice_finished.connect(func():
			emit_signal("choice_selected", ins.selfid)
		)
	var picked_index: int = await choice_selected
	just_chose = true
	var time := 0.1
	for b in alan:
		b.disappearbut(time)
	await get_tree().create_timer(time).timeout
	#_type_text()
	choosing = false
	choice.hide()
	choice.can_choose = false
	
func _type_text() -> void:
	while char_index < full_text.length() and typing:
		label.text += full_text[char_index]
		var spd = tempspeed
		match full_text[char_index]:
			".", "!", "?":
				spd *= 9
			",", ";":
				spd *= 5
			_:
				pass

		char_index += 1
		if type_sound_player:
			type_sound_player.pitch_scale = randf_range(0.95, 1.05)
			type_sound_player.play()
		print("spd: ",spd," ts1: ",tempspeed," ts2: ",text_speed)
		await get_tree().create_timer(1).timeout
	typing = false
	emit_signal("text_typed")

func _unhandled_input(event):
	if just_chose:
		if event.is_action_released("interact"):
			just_chose = false
		return

	if not dialogue_active or choosing:
		return

	if event.is_action_pressed("interact"):
		if typing:
			typing = false
			label.text = full_text
			emit_signal("text_typed")
		else:
			dialogue_active = false
			hide()
			label.text = ""
			emit_signal("dialogue_finished")
