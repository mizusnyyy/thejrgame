extends Node2D

@export var warning_time: float = 1.0
@export var active_time: float = 1.0
@export var blink_color: Color = Color(1, 0.5, 0.7)
@export var blink_interval: float = 0.05

@onready var rect: ColorRect = $ColorRect
@onready var area: Area2D = $Area2D
@onready var hitbox: CollisionShape2D = $Area2D/CollisionShape2D

var is_attacking: bool = false
var original_color: Color
var blink_toggle: bool = false
var blink_timer: float = 0.0

func _ready():
	hitbox.disabled = true

func update_hitbox(hitbox: CollisionShape2D, rect: ColorRect) -> void:
	var shape = hitbox.shape
	if shape is RectangleShape2D:
		shape.extents = Vector2(rect.size.x / 2, rect.size.y / 2)
		hitbox.position = rect.position + rect.size / 2

func activate(soul, speed) -> void:
	original_color = rect.color
	rect.modulate.a = 0.4
	hitbox.disabled = true

	await get_tree().create_timer(warning_time).timeout

	rect.modulate.a = 1.0
	hitbox.disabled = false
	is_attacking = true

	var callable = Callable(self, "_on_body_entered")
	if not area.is_connected("body_entered", callable):
		area.connect("body_entered", callable)

	await get_tree().create_timer(active_time).timeout

	is_attacking = false
	rect.color = original_color
	hitbox.disabled = true
	queue_free()

func _process(delta):
	if is_attacking:
		blink_timer += delta
		if blink_timer >= blink_interval:
			blink_timer = 0.0
			blink_toggle = !blink_toggle
			rect.color = blink_color if blink_toggle else original_color

func _on_body_entered(body):
	if body.name == "soul" and is_attacking:
		global.soultakedamage(body, 10)
