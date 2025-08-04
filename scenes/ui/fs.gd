extends Node2D
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fs"):
		var win := get_tree().get_root().get_window()
		if win.mode == Window.MODE_FULLSCREEN:
			win.mode = Window.MODE_WINDOWED
		else:
			win.mode = Window.MODE_FULLSCREEN

func pause():
	get_tree().paused = true
func resume():
	get_tree().paused = false
func testpause():
	if Input.is_action_pressed("pause") and !get_tree().paused:
		pause()
	if Input.is_action_pressed("pause") and get_tree().paused:
		resume()
		

func _process(delta: float) -> void:
	testpause()
