extends Area2D

var speed := 0.5
var direction := Vector2.DOWN
signal attack_finished
@onready var midscreen = get_viewport().get_visible_rect().size / 2

@onready var player = get_tree().get_root().get_node("/root/fight/soul")
func _on_body_entered(body):
	if body.name == "soul":
		Global.soultakedamage(body,10)
func summoned(bullet, soul, speed, value1, value2):
		phase1(bullet, soul, speed, value1, value2)
func phase1(bullet, soul, speed, value1, value2):
		for i in range(100):
			if not is_inside_tree():
				return
			bullet.global_position.x = soul.global_position.x - (100*value1)
			bullet.global_position.y = soul.global_position.y - (100*value2)
			await get_tree().create_timer(0.01).timeout
		phase2(bullet,soul,speed, value1, value2)
func phase2(bullet, soul,speed, value1, value2):
	bullet.global_position.x = soul.global_position.x - (100*value1)
	bullet.global_position.y = soul.global_position.y - (100*value2)
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
		bullet.global_position += direction * speed*4 * get_process_delta_time()
		if not is_inside_tree():
			return
		await get_tree().process_frame
