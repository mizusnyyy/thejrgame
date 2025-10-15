extends Node2D

@onready var player : CharacterBody2D

var tp_to: PackedScene
var tp_to_pos : Vector2

var playersprite : AnimatedSprite2D
var anim : AnimationPlayer

var ishorizontal : bool
var s:String
var step:float
var v:Vector2

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	tp_to_pos = get_parent().tp_pos
	playersprite = player.get_child(1)
	anim = get_tree().get_first_node_in_group("anim_player")
	ishorizontal = get_parent().ishorizontal

func immobilize_player(body: Node2D):
	body.smoke.changeemit(false)
	blackout()
	Global.can_phone=false
	Phone.get_child(1).get_child(0)._hide_phone(true)
	Global.can_move=false

func mobilize_player(body: Node2D):
	body.smoke.changeemit(true)
	Global.can_phone=true
	Global.can_move=true

func which_side():
	print("youre going ")
	
	var rotation_int: float = round(global_rotation_degrees)
	
	print("----------------")
	print(player.global_position)
	print(global_position)
	print(rotation_int)
	print("----------------")
	
	#IF LEFT ALBO RIGHT
	if rotation_int==0.0 or rotation_int==180.0 or rotation_int==-180.0: 
		if player.global_position.x<self.global_position.x:
			print("right")
		else:
			print("left")
			
	#IF DOWN ALBO UP
	else:
		if player.global_position.y<self.global_position.y:
			print("down")
		else:
			print("up")
			
func _on_areatp_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	
	which_side()
	
	#IMMOBILIZE
	immobilize_player(body)
	
	#IDZ
	
	
	#TP
	player.global_position = tp_to_pos
	
	#IDZ
	
	
	#MOBILIZE
	await anim.animation_finished
	mobilize_player(body)
	
	
	#var dir:Vector2
	#if scale.x < 0:
		#dir = Vector2.RIGHT.rotated(rotation).normalized()
	#else:
		#dir = Vector2.LEFT.rotated(rotation).normalized()
	#body.transporting=true
	#if dir.y == 0.0:
		#v=Vector2(2.0,0.0)
		#ishorizontal = true
		#if dir.x==-1.0:
			#s="sidel"
		#else:
			#s="sider"
			#v*=-1
	#else:
		#v=Vector2(0.0,2.0)
		#ishorizontal = false
		#if dir.y==-1:
			#s="back"
			#v*=-1
		#else:
			#s="front"
	#if not ishorizontal && is_instance_valid($Area2D):
		#$Area2D/door1.z_index = 1
	#body.anim.play(s)
	#const distance := 45.0
	#const steps := 45
	#const speed := 37.5
	#const offset:=22
	#var temp:Vector2 = playersprite.get_position()
	#
	#for i in range(steps-offset):
		#step = setstep(speed)
		#playersprite.global_position += dir * step
		#await get_tree().create_timer(0.015).timeout
		#
	#playersprite.position = temp
	#if ishorizontal:
		#player.global_position.x = tp_to_pos.x
	#else:
		#player.global_position.y = tp_to_pos.y
	#playersprite.global_position -= dir * step * offset
	#
	#for i in range(offset):
		#step = setstep(speed)
		#playersprite.global_position += dir * step
		#await get_tree().create_timer(0.015).timeout
		#
	#await anim.animation_finished
	#
	#Global.can_move=true
	#Global.can_phone=true
	#body.transporting=false

#func setstep(spd):
	#return spd * get_process_delta_time()

func blackout():
	anim.play("tp")
	
	
