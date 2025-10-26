extends Area2D

var anim_player : AnimationPlayer
var cutscene : String

func _ready() -> void:
	anim_player = $"../AnimationPlayer"

func _on_body_entered(body: Node2D) -> void:
	print("WGHIWNHGAUBHGNWWH")
	play_cutscene()
	queue_free()

func changes(name : String, new_pos: Vector2, new_size: Vector2):
	cutscene = name
	global_position = new_pos
	$col.shape.size = new_size

func play_cutscene():
	anim_player.play(cutscene)
