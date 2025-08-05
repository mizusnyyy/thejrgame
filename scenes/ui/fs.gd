extends Node2D

var pauza := false
@onready var ekran_pauzy := $"../ColorRect"  
@onready var napis_pauzy := $"../ColorRect/Napis"

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
		ekran_pauzy.visible = pauza
		napis_pauzy.visible = pauza
		if pauza:
			print("Jest pauza :3")
		else:
			print("Nie ma pauzy :3")
