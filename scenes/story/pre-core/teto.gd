extends Area2D

var player_in_range := false
var can_talk := true
var currentpage = 0

@onready var dialog = $"../../CanvasLayer/dialoge"
@onready var typesound = $AudioStreamPlayer2D
@export var whoid:int
@export var texturenpc: Texture
@export var path:String
@export var startdialog:String="start"

func _on_body_entered(body):
	if body.name=="player":
		player_in_range = true

func _on_body_exited(body):
	if body.name=="player":
		player_in_range = false
		can_talk = true

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact") and can_talk:
		DialogueManager.startandload(startdialog,path,dialog,typesound)
		can_talk=false

func dialogf(text,texture,sound,optionid):
	dialog.show_dialogue(text,texture,sound,optionid)

func _on_ready() -> void:
	$Sprite2D.texture = texturenpc
	#path = "res://data/"+path+".json"
	
