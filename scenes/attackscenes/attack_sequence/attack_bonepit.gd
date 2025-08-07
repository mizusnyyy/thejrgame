extends Node2D
@onready var gloo_scene = preload("res://scenes/attackscenes/bone/bone.tscn")
@onready var midscreen = get_viewport().get_visible_rect().size.x / 2

func summoned(bullet, soul, speed):
	global.current_mode=global.mode.BLUE
	#startsequence(bullet, soul, 40,true,5)
	#await get_tree().create_timer(2.0).timeout
	#startsequence(bullet, soul, 60, true,50)
	#await get_tree().create_timer(2.0).timeout
	startsequence(bullet, soul, 480, true,8)
	startsequence(bullet, soul, 480, false,8)
	await get_tree().create_timer(0.04).timeout
	startsequence(bullet, soul, 480, true,6)
	startsequence(bullet, soul, 480, false,6)
	await get_tree().create_timer(0.04).timeout
	startsequence(bullet, soul, 480, true,4)
	startsequence(bullet, soul, 480, false,4)
	await get_tree().create_timer(0.04).timeout
	startsequence(bullet, soul, 480, true,3)
	startsequence(bullet, soul, 480, false,3)
	await get_tree().create_timer(0.04).timeout
	startsequence(bullet, soul, 480, true,2)
	startsequence(bullet, soul, 480, false,2)
	await get_tree().create_timer(0.04).timeout
	startsequence(bullet, soul, 480, true,2)
	startsequence(bullet, soul, 480, false,2)

func startsequence(bullet, soul, speed, left,size,ylevel=310):
	bullet = instantiateall(gloo_scene)
	bullet.summoned(bullet,soul, speed, left,size,ylevel)
	bullet.modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(bullet, "modulate:a", 1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func instantiateall(scene):
	var instance = scene.instantiate()
	add_child(instance)
	return instance
