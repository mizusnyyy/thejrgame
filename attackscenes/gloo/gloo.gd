extends Area2D

var speed := 0.5
var direction := Vector2.DOWN

@onready var player = get_tree().get_root().get_node("/root/fight/soul")
func _process(delta):
	if player.is_alive():
		position += direction * speed * delta
		if position.y < -50 or position.y > 700:
			queue_free()
		rotation += randf_range(1,3) * delta
		scale += Vector2(randf() * delta,randf() * delta)
func _on_body_entered(body):
	if body.name == "soul":
		body.take_damage(10)
func give_tp():
	battle.tp+=1
	print(battle.tp)
func summoned(bullet, soul, speed):
		bullet.global_position.x = randf_range(512,768)
		bullet.global_position.y = 0
		bullet.direction = Vector2.DOWN
		bullet.speed = speed
