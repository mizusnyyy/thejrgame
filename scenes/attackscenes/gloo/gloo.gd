extends Area2D

var speed := 0.5
var direction := Vector2.DOWN
@onready var midscreen = get_viewport().get_visible_rect().size.x / 2
signal attack_finished

@onready var player = get_tree().get_root().get_node("/root/fight/soul")
func _process(delta):
	if player.soul_is_alive():
		position += direction * speed * delta
		if position.y < -50 or position.y > 700:
			queue_free()
		rotation += randf_range(1,3) * delta
		scale += Vector2(randf() * delta,randf() * delta)
func _on_body_entered(body):
	if body.name == "soul":
		global.soultakedamage(body,10)
func summoned(bullet, soul, speed):
		bullet.global_position.x = midscreen + randf_range(-midscreen*1/8,midscreen*1/8)
		bullet.global_position.y = 0
		bullet.direction = Vector2.DOWN
		bullet.speed = speed
		returnbullet()

func returnbullet():
	await get_tree().create_timer(2).timeout
	emit_signal("attack_finished")
