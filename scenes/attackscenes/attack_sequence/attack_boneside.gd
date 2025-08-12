extends Node2D
@onready var gloo_scene = preload("res://scenes/attackscenes/bone/bone.tscn")
@onready var midscreen = get_viewport().get_visible_rect().size.x / 2
signal attack_finished

func summoned(bullet, soul, speed):
	global.current_mode=global.mode.RED
	#startsequence(bullet, soul, 40,true,5)
	#await get_tree().create_timer(2.0).timeout
	#startsequence(bullet, soul, 60, true,50)
	#await get_tree().create_timer(2.0).timeout
	startsequence(bullet, soul, 500, true,17,331)
	await get_tree().create_timer(0.7).timeout
	startsequence(bullet, soul, 500, false,17,400)
	await get_tree().create_timer(0.7).timeout
	startsequence(bullet, soul, 500, true,17,331)#lewonagorze
	await get_tree().create_timer(0.7).timeout
	startsequence(bullet, soul, 500, false,17,400)
	returnbullet()

func startsequence(bullet, soul, speed, left,size,ylevel=320):
	bullet = instantiateall(gloo_scene)
	bullet.summoned(bullet,soul, speed, left,size,ylevel)
	bullet.modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(bullet, "modulate:a", 1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func instantiateall(scene):
	var instance = scene.instantiate()
	add_child(instance)
	return instance

func returnbullet():
	await get_tree().create_timer(3.5).timeout
	emit_signal("attack_finished")
