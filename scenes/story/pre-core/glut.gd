extends Area2D

var player_in_range := false
var can_talk := true

@export var dialogue_text := "o nie jestes jackiem a teraz walcz ze mnon"
@export var portrait_texture: Texture
@onready var dialog = $"../../CanvasLayer/dialoge"
@export var preloadscena = preload("res://scenes/battle/battle.tscn")
@onready var audio = $AudioStreamPlayer2Dhere
func _ready() -> void:
	dialog.typesound=audio

func _on_body_entered(body):
		player_in_range = true

func _on_body_exited(body):
	if body.name == "player":
		print(audio)
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact") and can_talk:
		if not dialog.dialogue_active:
			can_talk = false
			dialog.show_dialogue(dialogue_text, portrait_texture)
			await dialog.dialogue_finished
			#global.
			get_tree().change_scene_to_packed(preloadscena)
