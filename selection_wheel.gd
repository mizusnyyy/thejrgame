@tool
extends Control

@export var background_color: Color
@export var line_color: Color
@export var outer_radius: int = 256
@export var inner_radius: int = 128
@export var line_width: int = 4

@export var options = []
func _draw():
	draw_circle(Vector2.ZERO, outer_radius, background_color)
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)
	
	
	#if len(options) >= 3:
		
		#for i in range(len(options - 1)):
			#var rads = TAU * i / len(options)
			#var point = Vector2.from_angle(rads)
			#draw_line(
				#point * inner_radius,
				#point * outer_radius
				
			#)
func _process(delta):
	queue_redraw()
