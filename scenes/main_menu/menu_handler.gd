extends Node

var menu_instance: Node2D = null

func _ready():
	_spawn_menu()

func _process(delta):
	if Input.is_action_just_pressed("menu"):
		_toggle_menu()

func _toggle_menu():
	if menu_instance and is_instance_valid(menu_instance):
		if menu_instance.visible:
			menu_instance.queue_free()
			menu_instance = null
		else:
			menu_instance.visible = true
	else:
		_spawn_menu()


func _spawn_menu():
	var menu_scene = load("res://scenes/main_menu/main_menu.tscn")
	menu_instance = menu_scene.instantiate()
	if get_tree().current_scene:
		get_tree().current_scene.add_child(menu_instance)
	else:
		print("⚠️ Brak bieżącej sceny!")
		return
	menu_instance.visible = true
	menu_instance.get_node("CanvasLayer/Panel/graj_button").pressed.connect(_on_play_pressed)
	menu_instance.get_node("CanvasLayer/Panel/settings_button").pressed.connect(_on_settings_pressed)
	menu_instance.get_node("CanvasLayer/Panel/quit_button").pressed.connect(_on_quit_pressed)

func _on_play_pressed():
	if menu_instance and is_instance_valid(menu_instance):
		menu_instance.queue_free()
		menu_instance = null
	get_tree().change_scene_to_file("res://scenes/story/pre-core/house.tscn")

func _on_settings_pressed():
	if menu_instance and is_instance_valid(menu_instance):
		menu_instance.queue_free()
		menu_instance = null
	get_tree().change_scene_to_file("res://scenes/story/pre-core/house.tscnw")

func _on_quit_pressed():
	get_tree().quit()
