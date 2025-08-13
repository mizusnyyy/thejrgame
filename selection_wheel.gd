@tool
extends Control

@export var background_color: Color
@export var line_color: Color
@export var outer_radius: int = 256
@export var inner_radius: int = 128
@export var line_width: int = 4
func _draw():
	draw_circle(Vector2.ZERO, outer_radius, background_color)
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)
	
func _process(delta):
	queue_redraw()
