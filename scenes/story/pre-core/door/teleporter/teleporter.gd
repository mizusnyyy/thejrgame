extends Area2D
@onready var playersprite = $"../../../ysorting/player/player/AnimatedSprite2D"
@onready var velocityplayer = $"../../../ysorting/player/player"
@export var ishorizontal = true

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	blackout()
	global.can_phone=false
	phone.get_child(2).get_child(0)._hide_phone(true)
	global.can_move=false
	var dir = Vector2.LEFT.rotated(rotation).normalized()
	if scale.x < 0:
		dir = Vector2.RIGHT.rotated(rotation).normalized()
	#print(dir," !!!")
	# Odległość i kroki
	var distance = 45.0
	var steps = 45
	var speed = 170.0
	var temp = playersprite.get_position()
	for i in range(steps):
		var step = speed * get_process_delta_time()
		playersprite.global_position += dir * step
		await get_tree().create_timer(0.015).timeout
	playersprite.position = temp
	# Możesz ustawić dokładną pozycję docelową względem punktu "gdzie"
	velocityplayer.global_position.x = $gdzie.global_position.x
	
	global.can_move=true
	global.can_phone=true

func blackout():
	var anim = $"../../../AnimationPlayer"
	anim.play("tp")
	#var anim = $"../../../AnimationPlayer"
	#var x = $"../../../ysorting/player/player"
	#var rect = ColorRect.new()
	#print("made rect!!! ", rect)
	#rect.size = Vector2(320,180)
	#rect.z_index = 2
	#rect.position = Vector2(-160,-90)
	#x.add_child(rect)
	##$"../../../ColorRect".global_position = Vector2(x.x-320,x.y-180)
	#anim.play("tp")
	#await anim.animation_finished
	#var del = x.find_child("ColorRect")
	#del.queue_free()
	
