extends Area2D

var player_in_range := false
var can_talk := true

@export var dialogue_text := "dzien dobry muahhahahah"
@export var portrait_texture: Texture


func _on_body_entered(body):
	if body.name == "player":
		player_in_range = true

func _on_body_exited(body):
	if body.name == "player":
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact") and can_talk:
		var dialog = get_node("/root/test/CanvasLayer/dialogue")
		if not dialog.dialogue_active:
			can_talk = false
			dialog.show_dialogue(dialogue_text, portrait_texture)
			await dialog.dialogue_finished
			await get_tree().create_timer(0.2).timeout
			can_talk = true
