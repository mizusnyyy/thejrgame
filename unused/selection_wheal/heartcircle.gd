extends Node2D

var angle := 0

func _process(delta):
	if angle < 360:
		angle += 1440 * delta * (1/Engine.time_scale)
		queue_redraw()
	while self.scale.x < 1:
		self.scale += Vector2(0.01,0.01)
		#await get_tree().process_frame
		await get_tree().create_timer(0.05).timeout
	self.scale = Vector2(1,1)

func _draw():
	draw_arc(Vector2.ZERO, 18, 0, deg_to_rad(angle), 36, Color.RED, 12)

func selfdel():
	self.queue_free()
