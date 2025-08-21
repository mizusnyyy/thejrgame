extends Area2D
@onready var playersprite = $"../../../ysorting/player/player/AnimatedSprite2D"
@onready var velocityplayer = $"../../../ysorting/player/player"
@export var ishorizontal = true

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	
	global.can_move=false
	global.can_phone=false
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
