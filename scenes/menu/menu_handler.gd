extends Node

@export var menu_scene: PackedScene = preload("res://scenes/menu/main_menu.tscn")

var menu_instance: Node = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		if menu_instance == null:
			menu_instance = menu_scene.instantiate()
			get_tree().root.add_child(menu_instance)
			menu_instance.set_process_input(true)
		else:
			menu_instance.queue_free()
			menu_instance = null
