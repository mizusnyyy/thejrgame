extends Area2D

var player_in_range := false
var can_talk := true
var currentpage = 0

@onready var dialog = $"../../CanvasLayer/dialoge"
@onready var typesound = $AudioStreamPlayer2D
@export var whoid:int
@export var texturenpc: Texture
@export var character:String

func _on_body_entered(body):
	if body.name=="player":
		player_in_range = true

func _on_body_exited(body):
	if body.name=="player":
		player_in_range = false
		can_talk=true

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		talk()

func talk():
	if player_in_range and can_talk:
		DialogueManager.begin_dialogue(character,dialog,typesound)
		global.can_phone=false
		can_talk=false
		print("WWWWWAGWAG")
		await DialogueManager.dialogue_done
		can_talk=true
		print("KURWA")

func dialogf(text,texture,sound,optionid):
	print("WWWWWAGWAG")
	dialog.show_dialogue(text,texture,sound,optionid)
	can_talk=true
	print("KURWA")
	

func _on_ready() -> void:
	$Sprite2D.texture = texturenpc
	
