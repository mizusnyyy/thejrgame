extends Node2D
@onready var gloo_scene = preload("res://scenes/attackscenes/qorus/clawswipe.tscn")
@onready var midscreen = get_viewport().get_visible_rect().size.x / 2

func summoned(bullet, soul, speed):
	global.current_mode=global.mode.RED
	startsequence(bullet, soul, 200)
	await get_tree().create_timer(0.6).timeout
	startsequence(bullet, soul, 200, -1)
	await get_tree().create_timer(0.6).timeout
	startsequence(bullet, soul, 200, 1,-1)
	await get_tree().create_timer(0.6).timeout
	startsequence(bullet, soul, 200, -1,-1)

func startsequence(bullet, soul, speed, value1=1,value2=1):
	bullet = instantiateall(gloo_scene)
	bullet.summoned(bullet, soul, speed, value1, value2)
	match value1:
		1: 
			match value2:
				-1:
					bullet.global_rotation = deg_to_rad(270)
		-1:
			match value2:
				1:
					bullet.global_rotation = deg_to_rad(90)
				-1:
					bullet.global_rotation = deg_to_rad(180)

func instantiateall(scene):
	var instance = scene.instantiate()
	add_child(instance)
	return instance
