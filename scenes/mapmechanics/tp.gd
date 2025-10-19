extends Node2D

@onready var player : CharacterBody2D

@export var tp_to_pos : Vector2

var tp_to: PackedScene

var playersprite : AnimatedSprite2D
var anim : AnimationPlayer

var ishorizontal : bool
var s:String
var step:float
var v:Vector2

var player_teleporting := false

var sprite_temp_pos_x : float
var sprite_temp_pos_y : float

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	if get_parent().is_in_group("teleporter"):
		tp_to_pos = get_parent().tp_pos
	playersprite = player.get_child(1)
	anim = get_tree().get_first_node_in_group("anim_player")
	sprite_temp_pos_x = playersprite.global_position.x
	sprite_temp_pos_y = playersprite.global_position.y

#func _physics_process(delta: float) -> void:
	#print("-----------")
	#print(playersprite.position)
	#print(playersprite.global_position)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("gyro") and !player.anim_locked:
		player.anim_locked=true
		playersprite.play("obtain")
	if event.is_action_released("gyro"):
		player.anim_locked=false

func immobilize_player(body: Node2D):
	body.smoke.changeemit(false)
	blackout()
	Global.can_phone=false
	Phone.get_child(1).get_child(0)._hide_phone(true)
	Global.can_move=false
	player.anim_locked=true

func mobilize_player(body: Node2D):
	body.smoke.changeemit(true)
	Global.can_phone=true
	Global.can_move=true
	player.anim_locked=false

func move_sprite_to(where: Vector2, move_speed: float) -> void:
	player_teleporting=true
	while playersprite.global_position.distance_to(where) > 1.0 and player_teleporting:
		var delta = get_process_delta_time()
		playersprite.global_position = playersprite.global_position.move_toward(where, move_speed * delta)
		await get_tree().process_frame

func which_side():
	
	var rotation_int: float = round(global_rotation_degrees)
	
	#print("----------------")
	#print(player.global_position)
	#print(global_position)
	#print(rotation_int)
	#print("----------------")
	
	
	#IF LEFT ALBO RIGHT
	if rotation_int==0.0 or rotation_int==180.0 or rotation_int==-180.0: 
		if player.global_position.x<self.global_position.x:
			#right
			return 0
		else:
			#left
			return 1
			
	#IF DOWN ALBO UP
	else:
		if player.global_position.y<self.global_position.y:
			#down
			return 2
		else:
			#up
			return 3
			
func update_sprite_temp():
		sprite_temp_pos_x = playersprite.global_position.x
		sprite_temp_pos_y = playersprite.global_position.y
		
func _on_areatp_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	print(player.global_position)
	print(playersprite.position)
	
	var side = which_side()
	print(side)
	
	#IMMOBILIZE
	immobilize_player(body)
	
	#IDZ
	sprite_temp_pos_x = playersprite.global_position.x
	sprite_temp_pos_y = playersprite.global_position.y
	
	var how_far := 15.0
	var speed_player : float = player.SPEED/3.0
	var tempsprite: Vector2 = playersprite.position
	
	match side:
		0: 
			playersprite.play("sider")
			move_sprite_to(Vector2(sprite_temp_pos_x+how_far,sprite_temp_pos_y),speed_player)
		1: 
			playersprite.play("sidel")
			move_sprite_to(Vector2(sprite_temp_pos_x-how_far,sprite_temp_pos_y),speed_player)
		2: 
			playersprite.play("front")
			move_sprite_to(Vector2(sprite_temp_pos_x,sprite_temp_pos_y+how_far),speed_player)
		3: 
			playersprite.play("back")
			move_sprite_to(Vector2(sprite_temp_pos_x,sprite_temp_pos_y-how_far),speed_player)
	await get_tree().create_timer(0.2).timeout
	#GRACZ NIE TELEPORTUJE SIE
	player_teleporting=false
	
	#TP
	player.global_position = tp_to_pos
	
	#TELEPORTACJA SPRITE GRACZA NA MIEJSCE
	
	playersprite.position = tempsprite
	
	await get_tree().create_timer(0.1).timeout
	
	#IDZ
	match side:
		0:
			playersprite.global_position.x -= how_far
			update_sprite_temp()
			move_sprite_to(Vector2(sprite_temp_pos_x+how_far,sprite_temp_pos_y),speed_player)
		1:
			playersprite.global_position.x += how_far
			update_sprite_temp()
			move_sprite_to(Vector2(sprite_temp_pos_x-how_far,sprite_temp_pos_y),speed_player)
		2:
			playersprite.global_position.y -= how_far
			update_sprite_temp()
			move_sprite_to(Vector2(sprite_temp_pos_x,sprite_temp_pos_y+how_far),speed_player)
		3:
			playersprite.global_position.y += how_far
			update_sprite_temp()
			move_sprite_to(Vector2(sprite_temp_pos_x,sprite_temp_pos_y-how_far),speed_player)
			
	
	#MOBILIZE
	await anim.animation_finished
	mobilize_player(body)
	
	#UPEWNIJ SIE ZE SPRITE WYLADUJE W DOBRYM MIEJSCU
	playersprite.position = tempsprite
	#GRACZ NIE TELEPORTUJE SIE
	player_teleporting=false
	
	
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
	
	
