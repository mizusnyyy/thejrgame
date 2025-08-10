extends Area2D

var speed := 0.5
var direction := Vector2.DOWN
@onready var midscreen = get_viewport().get_visible_rect().size / 2

@onready var player = get_tree().get_root().get_node("/root/fight/soul")
func _process(delta):
	pass
	#if player.soul_is_alive():
		#position += direction * speed * delta
		#if position.y < -50 or position.y > 700:
			#queue_free()
		#rotation += randf_range(1,3) * delta
		#scale += Vector2(randf() * delta,randf() * delta)
func _on_body_entered(body):
	if body.name == "soul":
		global.soultakedamage(body,10)
func summoned(bullet, soul, speed):
		phase1(bullet, soul, speed)
func phase1(bullet, soul, speed):
		for i in range(100):
			bullet.global_position.x = soul.global_position.x - 100
			bullet.global_position.y = soul.global_position.y - 100
			await get_tree().create_timer(0.01).timeout
		phase2(bullet,soul,speed)
func phase2(bullet, soul,speed):
	bullet.global_position.x = soul.global_position.x - 100
	bullet.global_position.y = soul.global_position.y - 100
	#await get_tree().create_timer(1).timeout
	var soulpos = soul.global_position
	for i in range(7):
		var temp = bullet.global_position
		bullet.global_position = Vector2(bullet.global_position.x+randi()%8-3,bullet.global_position.y+randi()%8-3)
		await get_tree().create_timer(0.05).timeout
		bullet.global_position = temp
	phase3(bullet,soulpos,speed)
func phase3(bullet,soul,speed):
	var direction = (soul - bullet.global_position).normalized()
	while true:
		bullet.global_position += direction * speed*3 * get_process_delta_time()
		await get_tree().process_frame
	
