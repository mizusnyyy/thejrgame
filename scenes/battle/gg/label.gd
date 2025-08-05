extends Label

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Odradzanie się :3")
		get_tree().change_scene_to_file("res://scenes/story/pre-core/house.tscn")
