extends Node2D
@onready var anim = $AnimationPlayer
func _ready():
	$ysorting/player/player/ColorRect.visible=false
	if CutsceneManager.has_played("intro"):
		anim.stop()  # albo w ogóle nie odpalasz
	else:
		anim.play("intro")
		CutsceneManager.set_played("intro")
