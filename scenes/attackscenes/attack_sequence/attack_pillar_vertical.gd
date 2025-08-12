extends Node2D

@onready var blok1: Node2D = $Blok1
@onready var blok2: Node2D = $Blok2

@export var gap: int = 30
@export var max_total_height: int = 128
signal attack_finished

func summoned(bullet, soul, speed):
	var vp = get_viewport().get_visible_rect()
	var midscreen_x = vp.size.x / 2.0

	var min_height = 10
	var max_height = max_total_height - gap - min_height

	var height1 = 0
	var height2 = 0

	while true:
		height1 = randi() % (max_height - min_height + 1) + min_height
		height2 = randi() % (max_height - min_height + 1) + min_height
		if height1 + height2 + gap <= max_total_height:
			break

	var rect1: ColorRect = blok1.get_node("ColorRect")
	var rect2: ColorRect = blok2.get_node("ColorRect")

	rect1.size = Vector2(rect1.size.x, height1)
	rect2.size = Vector2(rect2.size.x, height2)

	blok1.position = Vector2(midscreen_x, 194)
	blok2.position = Vector2(midscreen_x, 318)

	rect1.position = Vector2(-rect1.size.x * 0.5, 0)
	rect2.position = Vector2(-rect2.size.x * 0.5, -rect2.size.y)

	blok1.call_deferred("update_hitbox", blok1.get_node("Area2D/CollisionShape2D"), rect1)
	blok2.call_deferred("update_hitbox", blok2.get_node("Area2D/CollisionShape2D"), rect2)

	blok1.call_deferred("activate", soul, speed)
	blok2.call_deferred("activate", soul, speed)
	returnbullet()

func returnbullet():
	await get_tree().create_timer(2).timeout
	emit_signal("attack_finished")
