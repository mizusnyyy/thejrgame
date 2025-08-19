extends Node2D

var pauza := false
var screen : ColorRect
var label : Label

func toggle_fullscreen():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _ready():
	# Spróbuj przypisać od razu
	if has_node("ColorRect"):
		screen = $ColorRect
		if screen.has_node("Label"):
			label = $ColorRect/Label

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		# Jeśli nie mamy przypisanych nodów, spróbuj wyszukać
		if screen == null:
			screen = find_child("ColorRect", true, false)
		if label == null:
			label = find_child("Label", true, false)

		# Teraz dopiero przełącz pauzę
		if screen and label:
			pauza = !pauza
			get_tree().paused = pauza
			screen.visible = pauza
			label.visible = pauza
			print("Jest pauza :3" if pauza else "Nie ma pauzy :3")
		else:
			print("⚠️ Nie znaleziono ColorRect lub Label, pauza pominięta")
	if event.is_action_pressed("fs"):
		print("fullscreen")
		toggle_fullscreen()
	
