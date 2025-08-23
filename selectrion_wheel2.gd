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
@export var number_of_lines = []
@export var rotation_step_degrees: float = 60
var current_rotation: float = 0.0
var rotation_phase: float = 0.0
var hearts: Array = []
var selected_heart_index: int = -1
func _ready():
	self.hide()
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
	



func _draw():
	var center = Vector2.ZERO
	
	# Tło i okręgi
	draw_arc(center, inner_radius, 0, TAU, 128, line_color, line_width, true)
	draw_arc(center, outer_radius, 0, TAU, 128, line_color, line_width, true)
	
	# Linie stałe względem ekranu
	var angle1 = 60 * (-TAU / 360)      # pierwsza linia
	var angle2 = -120 * (TAU / 360)     # druga linia
	
	var start_pos1 = Vector2(cos(angle1), sin(angle1)) * inner_radius
	var end_pos1 = Vector2(cos(angle1), sin(angle1)) * outer_radius
	draw_line(start_pos1, end_pos1, line_color, line_width, true)
	
	var start_pos2 = Vector2(cos(angle2), sin(angle2)) * inner_radius
	var end_pos2 = Vector2(cos(angle2), sin(angle2)) * outer_radius
	draw_line(start_pos2, end_pos2, line_color, line_width, true)

	


func _update_hearts_position():
	if hearts.size() == 0:
		return
	var angle_step = -TAU / number_of_hearts
	var center_angle = (60 * (-TAU / 360) + -120 * (TAU / 360)) / 2
	var closest_heart_index = 0
	var min_diff = TAU
	for i in range(number_of_hearts):
		var angle = i * angle_step - PI / 2 + rotation_phase
		hearts[i].position = Vector2(cos(angle), sin(angle)) * heart_radius
		hearts[i].rotation = 0
		
		var diff = abs(fmod(angle - center_angle + TAU, TAU))
		if diff < min_diff:
			min_diff = diff
			closest_heart_index = i
	selected_heart_index = closest_heart_index 
			
			
func _process(delta):
	if player != null:
		global_position = player.global_position  
	
	if Input.is_action_just_pressed("heart_select"):
		self.show()
		rotation_phase = 0.0
	if Input.is_action_just_released("heart_select"):
		self.hide()
	if Input.is_action_just_pressed("changeheart"):
		rotation_phase += 60 * (TAU / 360)
	if Input.is_action_just_pressed("ui_accept"):
		if player != null:
			player.region_rect = hearts[selected_heart_index].region_rect
			self.hide()
	_update_hearts_position()
	queue_redraw()
		


		





func set_heart_state(index: int, sprite_index: int):
	if index >= hearts.size():
		return
	var rect = hearts[index].region_rect
	rect.position.x = sprite_index * heart_size.x
	hearts[index].region_rect = rect
