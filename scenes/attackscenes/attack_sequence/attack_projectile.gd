extends Node2D
@onready var gloo_scene = preload("res://scenes/attackscenes/projectileshadow/projectile.tscn")
@onready var midscreen = get_viewport().get_visible_rect().size.x / 2
signal attack_finished

func summoned(bullet, soul, speed):
	global.current_mode=global.mode.RED
	startsequence(bullet, soul, 180,midscreen-60)
	startsequence(bullet, soul, 180,midscreen-30)
	startsequence(bullet, soul, 180,midscreen)
	startsequence(bullet, soul, 180,midscreen+30)
	startsequence(bullet, soul, 180,midscreen+60)
	await get_tree().create_timer(2.2).timeout
	startsequence(bullet, soul, 720,midscreen)
	returnbullet()

func startsequence(bullet, soul, speed,posx):
	bullet = instantiateall(gloo_scene)
	bullet.summoned(bullet,soul, speed,posx)
	bullet.modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(bullet, "modulate:a", 1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func instantiateall(scene):
	var instance = scene.instantiate()
	add_child(instance)
	return instance
func returnbullet():
	await get_tree().create_timer(1).timeout
	emit_signal("attack_finished")
