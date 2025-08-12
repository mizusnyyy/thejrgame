extends Control

@export var text_speed := 0.05
@onready var tempspeed = text_speed
@onready var label := $RichTextLabel
@onready var portrait := $TextureRect
@onready var choice = $choice/indicator
@onready var markeropt = $RichTextLabel/optsetter
signal dialogue_started
signal dialogue_finished
signal label_choice_finished

signal choice_finished
signal any_choice_finished

var full_text := ""
var char_index := 0
var typing := false
var dialogue_active := false
var type_sound_player: AudioStreamPlayer2D = null
var curoptid = 0

func _ready() -> void:
	hide()

func show_dialogue(text: String, portrait_texture: Texture = null, typesound: AudioStreamPlayer2D = null, optid = null) -> void:
	if text.begins_with("*"):
		text = text.substr(1)
		var parts = text.split(",", false, 0)
		choose(parts, optid[curoptid])
		curoptid+=1
		await choice_finished
		#await get_tree().create_timer(3).timeout
		emit_signal("dialogue_finished")
		return
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	global.can_move = false
	full_text = text
	char_index = 0
	label.text = ""
	typing = true
	dialogue_active = true
	choice.can_choose = true

	type_sound_player = typesound

	if portrait_texture:
		portrait.texture = portrait_texture
		portrait.visible = true
	else:
		portrait.visible = false
	show()
	emit_signal("dialogue_started")
	_type_text()
	await dialogue_finished
	hide()
	global.can_move = true
	curoptid=0

func choose(options: Array, optid):
	choice.global_position = Vector2(359,309)
	show()
	choice.show()
	choice.can_choose = true
	global.can_move = false

	# GDYBY CO ZROBILEM NA DOLE ZE POPROSTU TEXT STARY USTAWIA NA "" A NIE CLEARUJE NWM CZY CI SIE PRZYDA

	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.text=""
	#for i in range(len(options)):
		#label.text += options[i] + "\n"
	setoptions(options,optid)
	
func setoptions(options,optid):
	var setteropt = $RichTextLabel/optsetter
	var sceneopt = load("res://scenes/ui/buttonopt.tscn")
	var alan = []
	for i in range(len(options)):
		var ins = sceneopt.instantiate()
		add_child(ins)

		var mar = markeropt.global_position
		match i:
			0:
				ins.global_position = Vector2(mar.x-40, mar.y-20)
			1:
				ins.global_position = Vector2(mar.x+40, mar.y-20)
			2:
				ins.global_position = Vector2(mar.x-40, mar.y+20)
			3:
				ins.global_position = Vector2(mar.x+40, mar.y+20)
			_:
				ins.global_position = Vector2(mar.x, mar.y)
		ins.dobry = optid[i]
		alan.append(ins)

		typing = true
		ins.settext(options[i])
		
	for a in alan:
		a.choice_finished.connect(func(): emit_signal("any_choice_finished"))
	await any_choice_finished
	if not is_inside_tree():
		return
	var tempalan = len(alan)
	var time = 0.1
	for i in tempalan:
		alan[i].disappearbut(time)
	await get_tree().create_timer(time).timeout
	choice.hide()
	choice.can_choose = false
	emit_signal("dialogue_finished")

		
func _type_text() -> void:
	while char_index < full_text.length() and typing:
		label.text += full_text[char_index]
		text_speed = tempspeed
		if full_text[char_index] == "." or full_text[char_index] == "!" or full_text[char_index] == "?":
			text_speed*=9
		elif full_text[char_index] == "," or full_text[char_index] == ";":
			text_speed*=5
			
		char_index += 1
		if type_sound_player:
			type_sound_player.pitch_scale = randf_range(0.95, 1.05)
			type_sound_player.play()
		await get_tree().create_timer(text_speed).timeout
	typing = false

func _unhandled_input(event):
	if not dialogue_active:
		return
	if event.is_action_pressed("interact"):
		if typing:
			typing = false
			label.text = full_text
		else:
			dialogue_active = false
			hide()
			label.text = ""
			emit_signal("dialogue_finished")
			
#func _process(delta: float) -> void:
	#print(get_viewport().get_mouse_position())
	#print("--- " , markeropt.position , " --- " , mar)
