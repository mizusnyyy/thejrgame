extends Node2D
@export var background_color: Color
@export var line_color: Color
@export var outer_radius: int = 256
@export var heart_texture: Texture2D = preload("res://assets/sprite/battle/hearts.png")
@export var number_of_hearts: int = 6
@export var inner_radius: int = 128
@export var line_width: int = 4
@export var heart_size: Vector2 = Vector2(16, 16)
@export var heart_radius: int = 25
@export var player: Sprite2D
@export var options: Array = []

var hearts: Array = []

func _ready():
	for i in range(number_of_hearts):
		var heart = Sprite2D.new()
		heart.texture = heart_texture
		heart.region_enabled = true
		heart.region_rect = Rect2(Vector2.ZERO, heart_size)
		add_child(heart)
		hearts.append(heart)
	for i in range(number_of_hearts):
		set_heart_state(i, i)
	_update_hearts_position()

func _process(delta):
	if player != null:
		global_position = player.global_position  # Node2D podąża za graczem
	_update_hearts_position()
	queue_redraw()

func _draw():
	var center = Vector2.ZERO 
	draw_circle(center, outer_radius, background_color)
	draw_arc(center, inner_radius, 0, TAU, 128, line_color, line_width, true)
	draw_arc(center, outer_radius, 0, TAU, 128, line_color, line_width , true)

	if options == null or len(options) < 1:
		return

	var total = len(options)
	for i in range(total):
		var rads = i * (TAU / total)
		var point = Vector2.from_angle(rads)
		draw_line(center + point * inner_radius, center + point * outer_radius, line_color, line_width)

func _update_hearts_position():
	if hearts.size() == 0:
		return

	var angle_step = TAU / hearts.size()
	for i in range(hearts.size()):
		var angle = i * angle_step - TAU / 4
		hearts[i].position = Vector2(cos(angle) * heart_radius, sin(angle) * heart_radius)

func set_heart_state(index: int, sprite_index: int):
	if index >= hearts.size():
		return
	var rect = hearts[index].region_rect
	rect.position.x = sprite_index * heart_size.x
	hearts[index].region_rect = rect
