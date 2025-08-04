extends Node2D
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fs"):
		var win := get_tree().get_root().get_window()
		if win.mode == Window.MODE_FULLSCREEN:
			win.mode = Window.MODE_WINDOWED
		else:
			win.mode = Window.MODE_FULLSCREEN
