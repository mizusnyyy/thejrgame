extends Node2D

var full_text = "ten kids in ten years who do you wanna be when you grow up steven igors hello steven yes master i am igor"
var current_index = 0
var done=false
@onready var label = $CanvasLayer/RichTextLabel
@onready var timer = $CanvasLayer/Timer

func _ready():
	label.text = ""
	timer.timeout.connect(_on_Timer_timeout)
	timer.start()
	

@onready var typesound = $AudioStreamPlayer2D
func _on_Timer_timeout():
	if current_index < full_text.length():
		label.text += full_text[current_index]
		current_index += 1
		typesound.pitch_scale=randf_range(0.95,1.05)
		typesound.play()
	else:
		timer.stop()
		done=true
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action") and done:
		get_tree().change_scene_to_file("res://scenes/battle/battle.tscn")
