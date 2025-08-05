extends Control

@export var text_speed := 0.05
@onready var label := $RichTextLabel
@onready var portrait := $TextureRect
@onready var choice = $choice/indicator

signal dialogue_started
signal dialogue_finished
signal label_choice_finished
signal choice_finished

var full_text := ""
var char_index := 0
var typing := false
var dialogue_active := false
var type_sound_player: AudioStreamPlayer2D = null

func _ready() -> void:
	hide()

func show_dialogue(text: String, portrait_texture: Texture = null, typesound: AudioStreamPlayer2D = null) -> void:
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

func choose(opt1 = null, opt2 = null, opt3 = null, opt4 = null):
	show()
	choice.show()
	choice.can_choose = true
	global.can_move = false

	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.text = opt1 + "\n" + opt2 + "\n" + opt3 + "\n" + opt4 + "\n"

func _type_text() -> void:
	while char_index < full_text.length() and typing:
		label.text += full_text[char_index]
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
			emit_signal("dialogue_finished")
