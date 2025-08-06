extends Area2D

var player_in_range := false
var can_talk := true

@export var portrait_texture: Texture
@onready var dialog = $"../../CanvasLayer/dialoge"
@export var preloadscena = preload("res://scenes/battle/battle.tscn")
@export var typesound = AudioStreamPlayer2D
@export var pages: Array[String]

func _on_body_entered(body):
	if body.name=="player":
		player_in_range = true

func _on_body_exited(body):
	if body.name=="player":
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact") and can_talk and player_in_range:
		var currentpage = 0
		while currentpage!=len(pages):
			#print(pages[currentpage])
			if not dialog.dialogue_active:
				can_talk = false
				dialogf(pages[currentpage], portrait_texture,typesound)
				await dialog.dialogue_finished
				#choosef(["alan", "baran"])
			currentpage+=1
		get_tree().change_scene_to_packed(preloadscena)
			
func dialogf(text,texture,sound):
	dialog.show_dialogue(text,texture,sound)
	
func choosef(options: Array):
	dialog.choose(options)
