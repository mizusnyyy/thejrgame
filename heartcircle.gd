extends Node2D

var angle := 0.0

func _process(delta):
	if angle < 360:
		angle += 1440 * delta
		queue_redraw()

func _draw():
	draw_arc(Vector2.ZERO, 18, 0, deg_to_rad(angle), 36, Color.RED, 12)

func selfdel():
	self.queue_free()
