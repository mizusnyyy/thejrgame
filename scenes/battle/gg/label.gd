extends Label

var original_scale := Vector2.ONE

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	original_scale = scale
	
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Odradzanie się :3")
		get_tree().change_scene_to_file("res://scenes/story/pre-core/house.tscn")

func _on_mouse_entered() -> void:
	scale = original_scale * 1.10

func _on_mouse_exited() -> void:
	scale = original_scale
