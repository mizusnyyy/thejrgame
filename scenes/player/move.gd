extends CharacterBody2D

var SPEED := 75.0
@onready var anim := $AnimatedSprite2D
@onready var obtainpart := preload("res://assets/particles/obtainpart.tscn")
@onready var smoke := $AnimatedSprite2D/smokerun
@onready var dialog := $"../../../CanvasLayer/dialoge"

@export var direction := Vector2()

var directionstop := 0
var anim_locked := false
var transporting := false
var s:String
var last_position: Vector2
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("gyro") and !anim_locked:
		#anim_locked=true
		#anim.play("obtain")
	#if event.is_action_released("gyro"):
		#anim_locked=false

func _physics_process(delta: float) -> void:
	#print(anim_locked)
	#print(Global.can_move)
	if anim_locked or transporting:
		anim.speed_scale = 1
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var directionlr := Input.get_axis("left", "right")
	var directionud := Input.get_axis("up", "down")
	direction = Vector2(directionlr, directionud)

	var speed_sprint := 1.0
	anim.speed_scale = 1
	smoke.speed_scale=1.0
	if Input.is_action_pressed("sprint") && velocity!=Vector2.ZERO:
		speed_sprint = 2.0
		smoke.speed_scale=2.0
		anim.speed_scale = 3.0
	if direction.length() > 0 and Global.can_move:
		direction = direction.normalized()
		velocity = direction * SPEED * speed_sprint
		if direction.x != 0:
			if direction.x > 0:
				s="sider"
				directionstop = 2
				smokerot(180)
			else:
				s="sidel"
				smokerot(0)
				directionstop = 3
		elif direction.y > 0:
			s="front"
			smokerot(270)
			directionstop = 0
		elif direction.y < 0:
			s="back"
			smokerot(90)
			directionstop = 1
		smoke.changeemit(true)
		anim.play(s)
	else:
		smoke.changeemit(false)
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
		velocity.y = move_toward(velocity.y, 0.0, SPEED)
		match directionstop:
			0:s="idle"
			1:s="idleb"
			2:s="idler"
			3:s="idlel"
		anim.play(s)
	move_and_slide()

func obtainanim(txt):
	if anim_locked:
		return
	var tween1 := create_tween().set_parallel(true)
	var pos :Vector2= anim.position
	tween1.tween_property(anim,"scale",Vector2(1.4,0.6),0.6)
	tween1.tween_property(anim,"position",Vector2(0.0,-6.6),0.6)
	Global.can_phone = false
	anim_locked = true
	velocity = Vector2.ZERO
	anim.play("obtain")
	await get_tree().create_timer(0.6).timeout
	anim.play("obtainfull")
	await get_tree().create_timer(0.1).timeout
	itemupanim(txt)
	var ins := obtainpart.instantiate()
	add_child(ins)
	ins.global_position -= Vector2(0,16)
	var tween2 := create_tween().set_parallel(true)
	tween2.tween_property(anim,"scale",Vector2(0.8,1.3),0.1)
	tween2.tween_property(anim,"position",Vector2(0.0,-17.8),0.1)
	await tween2.finished
	var tween3 := create_tween().set_parallel(true)
	tween3.tween_property(anim,"scale",Vector2(1.0,1.0),0.12)
	tween3.tween_property(anim,"position",Vector2(0.0,-13.0),0.12)
	await get_tree().create_timer(0.9).timeout
	ins.emitting = false
	ins.get_child(0).emitting = false
	anim_locked = false
	Global.can_phone = true
	await get_tree().create_timer(ins.lifetime).timeout
	ins.queue_free()

func itemupanim(txt):
	var item := $AnimatedSprite2D/item
	var tween := create_tween().set_parallel(true)
	item.texture=txt
	item.modulate = Color(1,1,1,1)
	item.show()
	tween.tween_property(item,"scale",Vector2(1.0,1.0),0.1)
	tween.tween_property(item,"position", Vector2(0.0, -16.0),0.1)
	await get_tree().create_timer(0.7).timeout
	var tween2 := create_tween()
	tween2.tween_property(item,"modulate", Color(1,1,1,0),0.2)
	await tween2.finished
	item.position.y=-7.0
	item.scale.y=0.4
	item.hide()
	
func animtoggle():
	anim_locked=!anim_locked

func playanim(a:String,b:bool) -> void:
	anim.play(a)
	if b:
		anim.stop()

func smokerot(x:int):
	smoke.rotation_degrees=x

func timetakescreen():
	Global.take_screenshot()
	timetakescreen()
