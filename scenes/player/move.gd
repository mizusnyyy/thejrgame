extends CharacterBody2D

var SPEED := 75.0
@onready var anim := $AnimatedSprite2D
var directionstop := 0
@export var direction := Vector2()
var anim_locked := false
var transporting := false
var s:String

func _physics_process(delta: float) -> void:
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
	if Input.is_action_pressed("sprint") && velocity!=Vector2.ZERO:
		speed_sprint = 2.0
		anim.speed_scale = 3
	if direction.length() > 0 and global.can_move:
		direction = direction.normalized()
		velocity = direction * SPEED * speed_sprint
			
		if direction.x != 0:
			if direction.x > 0:
				s="sider"
				directionstop = 2
			else:
				s="sidel"
				directionstop = 3
		elif direction.y > 0:
			s="front"
			directionstop = 0
		elif direction.y < 0:
			s="back"
			directionstop = 1
		anim.play(s)
	else:
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
	global.can_phone = false
	var item = $AnimatedSprite2D/item
	anim_locked = true
	velocity = Vector2.ZERO
	anim.play("obtain")
	item.texture=txt
	item.show()
	await get_tree().create_timer(0.8).timeout
	item.hide()
	anim_locked = false
	global.can_phone = true

func animtoggle():
	anim_locked=!anim_locked
func animl() -> void:
	anim.play("sidel")
	anim.stop()
func animr() -> void:
	anim.play("sider")
	anim.stop()
func animd() -> void:
	anim.play("idle")
	anim.stop()
func animu() -> void:
	anim.play("back")
	anim.stop()
func playanim(a:String,b:bool) -> void:
	anim.play(a)
	if b:
		anim.stop()

#func _on_ready() -> void:
	#await get_tree().create_timer(0.2).timeout
	#global.take_screenshot()
	#await get_tree().create_timer(1).timeout
	#global.take_screenshot()
	#await get_tree().create_timer(1).timeout
	#global.take_screenshot()
	#await get_tree().create_timer(1).timeout
	#global.take_screenshot()

func timetakescreen():
	pass
	#if randi() % 5 == 0:
		#global.take_screenshot()
		#timetakescreen()
	#else:
		#await get_tree().create_timer(5).timeout
		#timetakescreen()
