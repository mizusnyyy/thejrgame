extends Node2D

var speed := 1.0
var direction := Vector2.DOWN
var player: Node = null
@onready var midscreen = get_viewport().get_visible_rect().size.x / 2


func _process(delta):
	if player and player.soul_is_alive():
		position += direction * speed * delta
		if position.y < -111 or position.y > 777:
			queue_free()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "soul":
		Global.soultakedamage(body,10)
func summoned(bullet, soul, speed:= 200.0):
		bullet.global_position.x = midscreen + randf_range(-midscreen*1/6,midscreen*1/6)
		bullet.global_position.y = 0
		bullet.direction = Vector2.DOWN
		bullet.speed = speed
		await get_tree().create_timer(2).timeout
