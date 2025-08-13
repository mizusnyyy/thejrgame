extends Node2D
#GLUT
var gloo_scene: PackedScene
var timer := 0.0
var runda = 1

var spawn_interval
var bullet_speed
var soul
var notui

#WAZNE -> GDY GRACZ WEJDZIE W KOLIZJE CHOCIAZBY Z NIEBIESKIM TO DOPOKI NIE WYJDZIE JEST NIESMIERTELNY
#NAPRAWIC!!!
#SPIERDLAALLAJJ!!
#ALE OKEEEJ!!!

func start():
	spawn_interval = 1.0
	bullet_speed = 200.0
	soul = $"../soul"
	notui = $"../notui"
	nextturn()
	print("Start gry, runda:", runda)

func nextturn():
	print("\n--- Tura przeciwnika ---")
	notui.enemyturn()
	var ended = false
	for i in range(runda + 1):
		print("Atak nr", i + 1, "z", runda + 1)
		ended = await attack()
		if ended:
			break
		await get_tree().create_timer(2.0).timeout
	print("--- Tura gracza ---")
	notui.playerturn()
	global.current_mode = global.mode.RED
	runda += 1
	print("Koniec tury, runda:", runda)
	await notui.enemy_turn
	nextturn()

func attack() -> bool:
	print("Rozpoczynam attack()")
	notui.enemyturn()
	var bullet = null
	var ran = randi() % 7
	print("Wylosowany atak:", ran)

	if ran == 0:
		gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_bonepit.tscn")
		bullet = instantiateall(gloo_scene)
		bullet.summoned(bullet, soul, bullet_speed)
		return false

	elif ran == 1:
		gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_bonetunnel.tscn")
		bullet = instantiateall(gloo_scene)
		bullet.summoned(bullet, soul, bullet_speed)
		return false

	elif ran == 2:
		global.current_mode = global.mode.RED
		gloo_scene = preload("res://scenes/attackscenes/gloo/gloo.tscn")
		bullet = instantiateall(gloo_scene)
		bullet.summoned(bullet, soul, bullet_speed)
		bullet.modulate.a = 0.0
		var tween = get_tree().create_tween()
		tween.tween_property(bullet, "modulate:a", 1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		return false

	elif ran == 3:
		gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_boneside.tscn")
		bullet = instantiateall(gloo_scene)
		bullet.summoned(bullet, soul, bullet_speed)
		return false

	elif ran == 4:
		await get_tree().create_timer(0.5).timeout
		gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_pillar_vertical.tscn")
		bullet = instantiateall(gloo_scene)
		bullet.summoned(bullet, soul, bullet_speed)
		return false

	elif ran == 5:
		await get_tree().create_timer(0.5).timeout
		gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_pillar_horizontal.tscn")
		bullet = instantiateall(gloo_scene)
		bullet.summoned(bullet, soul, bullet_speed)
		return false

	elif ran == 6:
		global.current_mode = global.mode.RED
		gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_projectile.tscn")
		var bullet_count = 5
		for j in range(bullet_count):
			bullet = instantiateall(gloo_scene)
			bullet.summoned(bullet, soul, bullet_speed)
			bullet.modulate.a = 0.0
			var tween = get_tree().create_tween()
			tween.tween_property(bullet, "modulate:a", 0.5, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
			await get_tree().create_timer(1.0).timeout
		print("Wszystkie pociski wystrzelone — koniec tury")
		return true
	return false

func instantiateall(scene):
	var instance = scene.instantiate()
	add_child(instance)
	return instance
