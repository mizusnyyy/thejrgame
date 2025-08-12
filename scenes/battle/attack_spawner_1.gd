extends Node2D
#GLUT
var gloo_scene: PackedScene
var timer := 0.0
var runda = 1
signal attack_finished
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
	runda = 0
	nextturn()

func nextturn():
	notui.enemyturn()
	await attack(runda+1)
	notui.playerturn()
	global.current_mode = global.mode.RED
	runda += 1
	print("Koniec rundy:", runda)
	await notui.enemy_turn
	nextturn()

func attack(amount):
	for i in range(amount):
		global.swing=true
		var ran = randi() % 4
		var bullet = chooseattack(ran)
		print("Atak nr ", i+1)
		await bullet.attack_finished

func chooseattack(ran):
	var bullet
	var spriteinteract = get_node_or_null("enemy")
	print(spriteinteract)
	if spriteinteract:
		spriteinteract.swinghand()
	if ran == 0: 
		gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_bonepit.tscn")
		bullet = instantiateall(gloo_scene)
		bullet.summoned(bullet, soul, bullet_speed)
	elif ran == 1: 
		gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_bonetunnel.tscn")
		bullet = instantiateall(gloo_scene)
		bullet.summoned(bullet, soul, bullet_speed)
	elif ran == 2: 
		global.current_mode=global.mode.RED
		gloo_scene = preload("res://scenes/attackscenes/gloo/gloo.tscn")
		#gloo_scene = preload("res://attackscenes/bone/bone.tscn")
		bullet = instantiateall(gloo_scene)
		#bullet.summoned(bullet, soul, bullet_speed, true, randi()%10+3)
		bullet.summoned(bullet, soul, bullet_speed)
		bullet.modulate.a = 0.0
		var tween = get_tree().create_tween()
		tween.tween_property(bullet, "modulate:a", 1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	elif ran == 3: 
		gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_boneside.tscn")
		bullet = instantiateall(gloo_scene)
		bullet.summoned(bullet, soul, bullet_speed)
	elif ran == 4:
		gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_clawswipe.tscn")
		bullet = instantiateall(gloo_scene)
		bullet.summoned(bullet, soul, bullet_speed)
	return bullet

#func wywolaj(modeserca, res, bullet, soul, bullet_speed):
		#battle.current_mode=battle.mode.modeserca
		#gloo_scene = preload("res://attackscenes/attack_sequence/attack_bonepit.tscn")
		#bullet = instantiateall(gloo_scene)
		#print(bullet)
		#bullet.summoned(bullet, soul, bullet_speed)
	

func instantiateall(scene):
	var instance = scene.instantiate()
	add_child(instance)
	return instance
