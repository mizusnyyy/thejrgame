extends Label

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	loadscreens()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Odradzanie się :3")
		get_tree().change_scene_to_file("res://scenes/story/pre-core/house.tscn")

func loadscreens():
	var texture_rects = [
		$"../../TextureRect",
		$"../../TextureRect2",
		$"../../TextureRect3",
		$"../../TextureRect4"
	]
	
	for i in texture_rects.size():
		var path = "user://screens/alangooner" + str(i + 1) + ".png"
		if FileAccess.file_exists(path):
			var img = Image.load_from_file(path)
			img.resize(300, 200, Image.INTERPOLATE_LANCZOS) # 🖼️ Ustalony rozmiar (szerokość, wysokość)
			var tex = ImageTexture.create_from_image(img)
			texture_rects[i].texture = tex
