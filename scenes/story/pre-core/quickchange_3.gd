extends Area2D

@export var namescene:String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://platform.tscn"+namescene)
		musicsounds.play_music(preload("res://assets/sprite/intro/stevenafterpumming.wav"))
