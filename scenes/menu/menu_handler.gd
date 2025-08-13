extends Node

@export var menu_scene: PackedScene = preload("res://main_menu.tscn")
var menu_instance: Node = null
var menu_canvas: CanvasLayer = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		_toggle_menu()

func _toggle_menu():
	if menu_instance == null:
		# Tworzymy menu i dodajemy do CanvasLayer
		menu_instance = menu_scene.instantiate()
		menu_canvas = CanvasLayer.new()
		menu_canvas.layer = 100  # nad grą
		menu_canvas.add_child(menu_instance)
		get_tree().root.add_child(menu_canvas)
	else:
		_hide_menu()

func _hide_menu():
	if menu_instance != null and menu_canvas != null:
		menu_canvas.queue_free()  # usuwa menu + CanvasLayer
		menu_instance = null
		menu_canvas = null

# Automatyczne ukrycie menu przy zmianie sceny
func _ready():
	get_tree().connect("scene_changed", Callable(self, "_hide_menu"))


func _on_graj_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/story/pre-core/house.tscn")
	print("Hmmmm maybe")
