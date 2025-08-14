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
		global.soultakedamage(body, 10)

func summoned(bullet, soul, speed):
	var random_x = randf_range(258, 382)
	bullet.global_position = Vector2(random_x, 0)
	bullet.rotation = 0
	bullet.scale = Vector2.ONE
	bullet.direction = Vector2.DOWN
	bullet.speed = speed
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
