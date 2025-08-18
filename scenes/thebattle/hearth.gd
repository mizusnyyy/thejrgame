extends AnimatedSprite2D
@onready var anim :=$"."


func _process(delta: float) -> void:
	checkhearthsprite()

func checkhearthsprite():
	if global.health>50:
		anim.frame=0
	elif global.health>20:
		anim.frame=1
	else:
		anim.frame=2
