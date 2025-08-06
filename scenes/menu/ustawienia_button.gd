extends TextureButton


func _on_pressed() -> void:
	if MenuHandler.menu_instance:
		MenuHandler.menu_instance.queue_free()
		MenuHandler.menu_instance = null
	get_tree().change_scene_to_file("res://scenes/menu/settings.tscn")
