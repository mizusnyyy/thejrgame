extends Node2D
@onready var gloo_scene = preload("res://attackscenes/bone/bone.tscn")

func summoned(bullet, soul, speed):
	#startsequence(bullet, soul, 40,true,5)
	#await get_tree().create_timer(2.0).timeout
	#startsequence(bullet, soul, 60, true,50)
	#await get_tree().create_timer(2.0).timeout
	for i in range(21):
		if i < 10:
			startsequence(bullet, soul, 300, true,4,420+(i*14))#musi,musi,speed,czyzlewej,wielkosc,poziom-y
			startsequence(bullet, soul, 300, true,4,570+(i*14))
			print(420+(i*14))
		else:
			startsequence(bullet, soul, 300, true,4,700-(i*14))
			startsequence(bullet, soul, 300, true,4,850-(i*14))
			print("nast ", 690-(i*14))
		await get_tree().create_timer(0.12).timeout

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
