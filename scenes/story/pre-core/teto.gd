extends Area2D

var player_in_range := false
var can_talk := true

@onready var dialog = $"../../CanvasLayer/dialoge"
@onready var typesound = $AudioStreamPlayer2D
@export var pages: Array[String]
@export var portrait_texture: Array[Texture]
@export var optionid: Array[Array]
@export var whoid:int
@export var texturenpc: Texture


func _on_body_entered(body):
	if body.name=="player":
		player_in_range = true

func _on_body_exited(body):
	if body.name=="player":
		player_in_range = false
		can_talk = true

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact") and can_talk:
		var currentpage = 0
		while currentpage!=len(pages):
			if not dialog.dialogue_active:
				can_talk = false
				dialogf(pages[currentpage], portrait_texture[currentpage],typesound,optionid)
				await dialog.dialogue_finished
			currentpage+=1
		Battlepreset.enemidpreset = whoid
		await get_tree().create_timer(0.1).timeout
		can_talk = true

func dialogf(text,texture,sound,optionid):
	dialog.show_dialogue(text,texture,sound,optionid)

func _on_ready() -> void:
	$Sprite2D.texture = texturenpc
