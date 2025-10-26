extends Area2D

var player_in_range := false
var currentpage := 0

var player : CharacterBody2D

@onready var typesound := $AudioStreamPlayer2D
@export var whoid:int
@export var texturenpc: Texture
@export var character:String
@export var region: Vector2 = Vector2(16.0, 32.0)

func _on_body_entered(body):
	if body.name=="player":
		player = body
		player_in_range = true

func _on_body_exited(body):
	if body.name=="player":
		player_in_range = false
		Global.can_talk=true

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		talk()

func talk():
	if player_in_range and Global.can_talk:
		DialogueManager.begin_dialogue(character,player.dialog,typesound)
		Global.toggle_can_phone(false)
		Global.can_talk=false
		await DialogueManager.dialogue_done
		Global.can_talk=true

func _on_ready() -> void:
	$Sprite2D.texture = texturenpc
	
