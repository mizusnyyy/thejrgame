extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
@onready var anim = get_node("AnimatedSprite2D")
var lrud = [0,0]
var directionstop = 0
@export var direction:= Vector2()
func _physics_process(delta: float) -> void:
	var directionlr := Input.get_axis("left", "right")
	var directionud := Input.get_axis("up", "down")
	direction = Vector2(directionlr, directionud)
	if direction.length() > 0 && player.can_move:
		if directionlr != 0:
			lrud[0] = directionlr
		if directionud != 0:
			lrud[1] = directionud
		direction = direction.normalized()
		velocity = direction * SPEED
		if direction.x != 0:
			if direction.x>0:
				anim.play("sider")
				directionstop = 2
			else:
				anim.play("sidel")
				directionstop = 3
		elif direction.y > 0:
			anim.play("front")
			directionstop = 0
		elif direction.y < 0:
			anim.play("back")
			directionstop = 1
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
		velocity.y = move_toward(velocity.y, 0.0, SPEED)
		if directionstop == 0:
			anim.play("idle")
		elif directionstop == 1:
			anim.play("back")
			anim.stop()
		elif directionstop == 2:
			anim.play("sider")
			anim.stop()
		elif directionstop == 3:
			anim.play("sidel")
			anim.stop()
	move_and_slide()
