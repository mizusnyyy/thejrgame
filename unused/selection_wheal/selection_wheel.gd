@tool
extends Control

@export var background_color: Color
@export var line_color: Color
@export var outer_radius: int = 256
@export var heart_texture: Texture2D = preload("res://assets/sprite/battle/hearts.png")
@export var number_of_hearts: int = 6
@export var inner_radius: int = 128
@export var line_width: int = 4
@export var heart_size: Vector2 = Vector2(16, 16)
@export var heart_radius: int = 25
@onready var player = $".."
@export var options: Array = []


var hearts: Array = []


func _ready():
	for i in range(number_of_hearts):
		var heart = Sprite2D.new()
		heart.texture = heart_texture
		heart.region_enabled = true
		heart.region_rect = Rect2(Vector2(0,0), heart_size)
		add_child(heart)
		hearts.append(heart)
	for i in range(number_of_hearts):
		set_heart_state(i, i)
	_update_hearts_position()
func _draw():
	if player == null:
		return
	var center = player.global_position
	var total = int(len(options))
	draw_circle(center, outer_radius, background_color)
	draw_arc(center, inner_radius, 0, TAU, 128, line_color, line_width, true)
	
	if options == null or len(options) < 1:
		return
		
	for i in range(total):
		var rads = i * (TAU / total)
		var point = Vector2.from_angle(rads)
		draw_line(
			center + point * inner_radius,
			center + point * outer_radius,
			line_color,
			line_width,
			true
			)
			
			
	

func _process(delta):
	queue_redraw()
	_update_hearts_position()
	
func _update_hearts_position():
	if hearts.size() == 0 or player == null:
		return
	
	var center = player.global_position
	var angle_step = TAU / number_of_hearts
	
	for i in range (hearts.size()):
		var angle = i * angle_step - TAU / 4
		var x =  center.x + heart_radius * cos(angle)
		var y =  center.y + heart_radius * sin(angle)
		hearts[i].position = Vector2(x, y)
		
func set_heart_state(index: int, sprite_index: int):
	if index >= hearts.size():
		return
	var rect = hearts[index].region_rect
	rect.position.x = sprite_index * heart_size.x
	hearts[index].region_rect = rect
