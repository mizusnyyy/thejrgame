extends Area2D

var anim_player : AnimationPlayer
var cutscene_play : String
var cutscene_enum

func _ready() -> void:
	anim_player = $"../AnimationPlayer"

func _on_body_entered(body: Node2D) -> void:
	print("WGHIWNHGAUBHGNWWH")
	if !CutsceneManager.has_played(get_enum_value(cutscene_play)):
		play_cutscene()
	CutsceneManager.set_played(get_enum_value(cutscene_play))

	queue_free()
	
func get_enum_value(name: String): 
	return CutsceneManager.cutscenes.get(name)

func changes(name : String, new_pos: Vector2, new_size: Vector2):
	cutscene_play = name
	global_position = new_pos
	$col.shape.size = new_size

func play_cutscene():
	print(cutscene_play)
	anim_player.play(cutscene_play)
