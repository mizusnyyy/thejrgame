extends Node

var menu_instance: Node2D = null

#func _ready():
	#_spawn_menu()

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
	show_confirm_panel()

func _on_confirm_quit():
	get_tree().quit()

func _on_cancel_quit():
	hide_confirm_panel()

func show_confirm_panel():
	var confirm_panel = menu_instance.get_node("CanvasLayer/quit_confirm_panel")
	confirm_panel.scale = Vector2(0.5, 1)
	confirm_panel.modulate.a = 0.0
	confirm_panel.visible = true

	var tween = create_tween()
	tween.tween_property(confirm_panel, "scale:x", 1, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(confirm_panel, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	var yes_button = confirm_panel.get_node("button_yes")
	if not yes_button.is_connected("pressed", Callable(self, "_on_confirm_quit")):
		yes_button.pressed.connect(Callable(self, "_on_confirm_quit"))

	var no_button = confirm_panel.get_node("button_no")
	if not no_button.is_connected("pressed", Callable(self, "_on_cancel_quit")):
		no_button.pressed.connect(Callable(self, "_on_cancel_quit"))

func hide_confirm_panel():
	var confirm_panel = menu_instance.get_node("CanvasLayer/quit_confirm_panel")

	var tween = create_tween()
	tween.tween_property(confirm_panel, "scale:x", 0.5, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(confirm_panel, "modulate:a", 0.0, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	tween.finished.connect(func():
		confirm_panel.visible = false
	)
