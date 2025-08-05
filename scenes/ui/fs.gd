extends Node2D

var pauza := false
@onready var screen := $"../ColorRect"
@onready var label := $"../ColorRect/Label"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fs"):
		var win := get_tree().get_root().get_window()
		if win.mode == Window.MODE_FULLSCREEN:
			win.mode = Window.MODE_WINDOWED
		else:
			win.mode = Window.MODE_FULLSCREEN

	if event.is_action_pressed("pause"):
		pauza = !pauza
		get_tree().paused = pauza
		screen.visible = pauza
		label.visible = pauza
