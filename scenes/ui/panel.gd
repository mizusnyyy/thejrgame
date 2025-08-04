extends Panel

var dragging := false
var drag_offset := Vector2.ZERO

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and get_global_rect().has_point(event.position):
				dragging = true
				drag_offset = event.position - global_position
			elif not event.pressed:
				dragging = false
	elif event is InputEventMouseMotion and dragging:
		var new_pos = event.position - drag_offset
		global_position = _clamp_to_screen(new_pos)

func _clamp_to_screen(pos: Vector2) -> Vector2:
	var screen_size = get_viewport_rect().size
	var panel_size = size

	var clamped_x = clamp(pos.x, 0, screen_size.x - panel_size.x)
	var clamped_y = clamp(pos.y, 0, screen_size.y - panel_size.y)

	return Vector2(clamped_x, clamped_y)
