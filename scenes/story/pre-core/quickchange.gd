extends Area2D

@export var namescene:String
@export var diff:bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if diff:
			get_tree().change_scene_to_file(namescene)
		else:
			get_tree().change_scene_to_file("res://scenes/story/pre-core/"+namescene)
		Musicsounds.play_sound(preload("res://assets/sprite/intro/stevenafterpumming.wav"))
