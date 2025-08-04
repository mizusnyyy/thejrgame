extends Node2D

var gloo_scene: PackedScene
@export var spawn_interval: float = 1.0
@export var bullet_speed: float = 200
@onready var soul = $"../soul"
@onready var notui = $"../notui"
var timer := 0.0
var runda = 1

#WAZNE -> GDY GRACZ WEJDZIE W KOLIZJE CHOCIAZBY Z NIEBIESKIM TO DOPOKI NIE WYJDZIE JEST NIESMIERTELNY
#NAPRAWIC!!!
#SPIERDLAALLAJJ!!
#ALE OKEEEJ!!!

func _ready():
	nextturn()
	print(runda)
func nextturn():
	for i in range(runda+1):
		attack()
		await get_tree().create_timer(4000.0).timeout
	notui.playerturn()
	await notui.enemy_turn
	runda+=1
	print(runda)
	nextturn()

func attack():
	notui.enemyturn()
	var bullet
	var ran = randi()%4
	await get_tree().create_timer(4000.0).timeout
	
	#gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_boneside.tscn")
	#bullet = instantiateall(gloo_scene)
	#bullet.summoned(bullet, soul, bullet_speed)
	#if ran == 0: 
		#gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_bonepit.tscn")
		#bullet = instantiateall(gloo_scene)
		#bullet.summoned(bullet, soul, bullet_speed)
	#elif ran == 1: 
		#gloo_scene = preload("res://scenes/attackscenes/attack_sequence/attack_bonetunnel.tscn")
		#bullet = instantiateall(gloo_scene)
		#bullet.summoned(bullet, soul, bullet_speed)
	#elif ran == 2: 
		#battle.current_mode=battle.mode.RED
		#gloo_scene = preload("res://scenes/attackscenes/gloo/gloo.tscn")
		##gloo_scene = preload("res://attackscenes/bone/bone.tscn")
		#bullet = instantiateall(gloo_scene)
		##bullet.summoned(bullet, soul, bullet_speed, true, randi()%10+3)
		#bullet.summoned(bullet, soul, bullet_speed)
		#bullet.modulate.a = 0.0
		#var tween = get_tree().create_tween()
		#tween.tween_property(bullet, "modulate:a", 1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
#
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
