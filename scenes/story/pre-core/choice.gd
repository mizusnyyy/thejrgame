extends CharacterBody2D


const SPEED = 150.0
var can_choose = false
func _ready():
	position = Vector2(0,0)
	hide()
func _physics_process(delta: float) -> void:
	var directionlr := Input.get_axis("left", "right")
	var directionud := Input.get_axis("up", "down")
	var direction := Vector2(directionlr, directionud)
	if direction.length() > 0 and can_choose:
		direction = direction.normalized()
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
		velocity.y = move_toward(velocity.y, 0.0, SPEED)
	move_and_slide()
