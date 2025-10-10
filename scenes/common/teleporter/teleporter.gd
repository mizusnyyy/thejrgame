extends Area2D
#@onready var playersprite := $"../../../ysorting/player/player/AnimatedSprite2D"
#@onready var velocityplayer := $"../../../ysorting/player/player"
#@onready var anim := $"../../../AnimationPlayer"
@export var playersprite:AnimatedSprite2D
@export var velocityplayer:CharacterBody2D
@export var anim:AnimationPlayer
var ishorizontal := true
var s:String
var step:float
var v:Vector2

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	body.smoke.changeemit(false)
	blackout(body)
	Global.can_phone=false
	Phone.get_child(1).get_child(0)._hide_phone(true)
	Global.can_move=false
	var dir:Vector2
	if scale.x < 0:
		dir = Vector2.RIGHT.rotated(rotation).normalized()
	else:
		dir = Vector2.LEFT.rotated(rotation).normalized()
	body.transporting=true
	if dir.y == 0.0:
		v=Vector2(2,0)
		ishorizontal = true
		if dir.x==-1.0:
			s="sidel"
		else:
			s="sider"
			v*=-1
	else:
		v=Vector2(0,2)
		ishorizontal = false
		if dir.y==-1:
			s="back"
			v*=-1
		else:
			s="front"
	if not ishorizontal && is_instance_valid($Area2D):
		$Area2D/door1.z_index = 1
	body.anim.play(s)
	const distance := 45.0
	const steps := 45
	const speed := 37.5
	const offset:=22
	var temp:Vector2 = playersprite.get_position()
	
	for i in range(steps-offset):
		step = setstep(speed)
		playersprite.global_position += dir * step
		await get_tree().create_timer(0.015).timeout
		
	playersprite.position = temp
	if ishorizontal:
		velocityplayer.global_position.x = $gdzie.global_position.x
	else:
		velocityplayer.global_position.y = $gdzie.global_position.y
	playersprite.global_position -= dir * step * offset
	
	for i in range(offset):
		step = setstep(speed)
		playersprite.global_position += dir * step
		await get_tree().create_timer(0.015).timeout
		
	await anim.animation_finished
	
	Global.can_move=true
	Global.can_phone=true
	body.transporting=false

func setstep(spd):
	return spd * get_process_delta_time()

func blackout(body):
	anim.play("tp")
	
