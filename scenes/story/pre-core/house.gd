extends Node2D
@onready var anim = $AnimationPlayer
func _ready():
	$ysorting/player/player/ColorRect.visible=false
	if CutsceneManager.has_played("intro"):
		anim.stop()  # albo w ogóle nie odpalasz
	else:
		global.can_move=false
		global.can_phone=false
		anim.play("intro")
		CutsceneManager.set_played("intro")
		await anim.animation_finished
		global.can_move=true
