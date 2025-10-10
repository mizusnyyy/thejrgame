extends Area2D

var speed := 0.5
var direction := Vector2.DOWN
@onready var player = get_tree().get_root().get_node("/root/fight/soul")
@export var bullet_scene: PackedScene
signal attack_finished

func _process(delta):
	if player.soul_is_alive():
		position += direction * speed * delta
		if position.y < -50 or position.y > 700:
			queue_free()

func _on_body_entered(body):
	if body.name == "soul":
		Global.soultakedamage(body, 10)

func summoned(bullet, soul, speed, posx):
	#var random_x = randf_range(258, 382)
	bullet.global_position = Vector2(posx,0)
	bullet.rotation = 0
	bullet.scale = Vector2.ONE
	bullet.direction = Vector2.DOWN
	bullet.speed = speed
	
	#var wave_count = randi_range(1, 10)
	#for wave_index in range(wave_count):
		#var wave_size = randi_range(1, 3)
		#var positions_x = []
		#while positions_x.size() < wave_size:
			#var candidate = randf_range(258, 382)
			#var too_close = false
			#for pos in positions_x:
				#if abs(candidate - pos) < 5:
					#too_close = true
					#break
			#if not too_close:
				#positions_x.append(candidate)
		#for pos_x in positions_x:
			#bullet.modulate.a = 0.0
			#var tween = get_tree().create_tween()
			#tween.tween_property(bullet, "modulate:a", 0.5, 0.25) \
				 #.set_trans(Tween.TRANS_SINE) \
				 #.set_ease(Tween.EASE_IN_OUT)
		#await get_tree().create_timer(randf_range(0.5, 1)).timeout
	returnbullet()

func summon_wave(soul, speed):
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.summoned(bullet, soul, speed)

func returnbullet():
	await get_tree().create_timer(2).timeout
	emit_signal("attack_finished")
	
func summoned_with_position(bullet, soul, speed, pos_x):
	bullet.global_position = Vector2(pos_x, 0)
	bullet.rotation = 0
	bullet.scale = Vector2.ONE
	bullet.direction = Vector2.DOWN
	bullet.speed = speed
	returnbullet()
