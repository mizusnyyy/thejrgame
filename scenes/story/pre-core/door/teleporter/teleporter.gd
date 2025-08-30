extends Area2D
@onready var playersprite = $"../../../ysorting/player/player/AnimatedSprite2D"
@onready var velocityplayer = $"../../../ysorting/player/player"
@onready var anim = $"../../../AnimationPlayer"
@export var ishorizontal = true

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	blackout(body)
	global.can_phone=false
	phone.get_child(2).get_child(0)._hide_phone(true)
	global.can_move=false
	var dir = Vector2.LEFT.rotated(rotation).normalized()
	if scale.x < 0:
		dir = Vector2.RIGHT.rotated(rotation).normalized()
	body.transporting=true
	print(dir.x, " 0oooo0 ", dir.y)
	if dir.y == 0.0:
		if dir.x==-1.0:
			body.anim.play("sidel")
		else:
			body.anim.play("sider")
	else:
		if dir.y==-1:
			body.anim.play("back")
		else:
			body.anim.play("front")
	var distance = 45.0
	var steps = 45
	var speed = 170.0
	var temp = playersprite.get_position()
	for i in range(steps):
		var step = speed * get_process_delta_time()
		playersprite.global_position += dir * step
		await get_tree().create_timer(0.015).timeout
	playersprite.position = temp
	velocityplayer.global_position.x = $gdzie.global_position.x
	await anim.animation_finished
	global.can_move=true
	global.can_phone=true
	body.transporting=false

func blackout(body):
	anim.play("tp")
	#await anim.animation_finished
	#body.transporting=false
	
