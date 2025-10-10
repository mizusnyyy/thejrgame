extends Node2D

@onready var gloo_scene = preload("res://scenes/attackscenes/projectileshadow/projectile.tscn")
signal attack_finished
var attack_in_progress = false

func summoned(bullet, soul, speed):
	if attack_in_progress:
		return
	attack_in_progress = true
	Global.current_mode = Global.mode.RED
	var min_x = 258
	var max_x = 382
	var min_dist = 15
	var wave_count = randi_range(1, 5)
	for wave in range(wave_count):
		var bullet_count = randi_range(1, 5)
		var positions_x = []
		while positions_x.size() < bullet_count:
			var candidate = randf_range(min_x, max_x)
			if positions_x.size() == 0 or abs(candidate - positions_x[0]) >= min_dist:
				positions_x.append(candidate)
		for pos_x in positions_x:
			var b = instantiateall(gloo_scene)
			b.summoned(b, soul, speed, pos_x)
			b.modulate.a = 0.0
			var tween = get_tree().create_tween()
			tween.tween_property(b, "modulate:a", 1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		await get_tree().create_timer(0.8).timeout
	var fast_bullet = instantiateall(gloo_scene)
	fast_bullet.summoned(fast_bullet, soul, speed * 4, (min_x + max_x) / 2)
	fast_bullet.modulate.a = 0.0
	var fast_tween = get_tree().create_tween()
	fast_tween.tween_property(fast_bullet, "modulate:a", 1.0, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(1).timeout
	attack_in_progress = false
	emit_signal("attack_finished")

func instantiateall(scene):
	var instance = scene.instantiate()
	add_child(instance)
	return instance

func returnbullet():
	await get_tree().create_timer(1).timeout
	emit_signal("attack_finished")
