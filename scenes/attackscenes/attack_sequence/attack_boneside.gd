extends Node2D
@onready var gloo_scene = preload("res://scenes/attackscenes/bone/bone.tscn")

func summoned(bullet, soul, speed):
	battle.current_mode=battle.mode.RED
	#startsequence(bullet, soul, 40,true,5)
	#await get_tree().create_timer(2.0).timeout
	#startsequence(bullet, soul, 60, true,50)
	#await get_tree().create_timer(2.0).timeout
	startsequence(bullet, soul, 300, true,9,650)
	await get_tree().create_timer(0.12).timeout
	startsequence(bullet, soul, 300, true,9,450)
	await get_tree().create_timer(0.12).timeout
	startsequence(bullet, soul, 300, true,9,550)
	await get_tree().create_timer(0.12).timeout
	startsequence(bullet, soul, 300, true,9,550)

func startsequence(bullet, soul, speed, left,size,ylevel=620):
	bullet = instantiateall(gloo_scene)
	bullet.summoned(bullet,soul, speed, left,size,ylevel)
	bullet.modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(bullet, "modulate:a", 1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func instantiateall(scene):
	var instance = scene.instantiate()
	add_child(instance)
	return instance
