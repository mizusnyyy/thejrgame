extends Node2D

@export var warning_time: float = 1.0
@export var active_time: float = 1.0
@export var damage: int = 10

@onready var rect: ColorRect = $ColorRect
@onready var hitbox: CollisionShape2D = $Area2D/CollisionShape2D

func activate(soul, speed):
	rect.modulate.a = 0.4
	hitbox.disabled = true

	await get_tree().create_timer(warning_time).timeout

	rect.modulate.a = 1.0
	hitbox.disabled = false

	await get_tree().create_timer(active_time).timeout

	queue_free()

func _on_area_2d_body_entered(body: Node):
	if body.name == "soul" and not hitbox.disabled:
		if body.has_method("take_damage"):
			body.take_damage(damage)
