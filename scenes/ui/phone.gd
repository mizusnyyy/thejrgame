extends Control

var active := true  # <- będzie kontrolować, czy telefon działa

@onready var app_container = $Panel/Control
@onready var app_list = $Panel/VBoxContainer
var current_app_name: String = ""

var apps = {
	"console": preload("res://scenes/phone/apps/console/console.tscn")
}

func _ready():
	visible = true

	for app_name in apps.keys():
		var btn = Button.new()
		btn.text = app_name
		btn.pressed.connect(_on_app_button_pressed.bind(app_name))
		app_list.add_child(btn)

func _process(_delta):
	if active and Input.is_action_just_pressed("phone"):
		if visible:
			var posh = create_tween()
			posh.set_trans(Tween.TRANS_BACK)
			posh.set_ease(Tween.EASE_OUT)
			posh.tween_property(self, "position", Vector2(128, 720), 0.25)
			await posh.finished
			visible=!visible
		else:
			visible=!visible
			var pos = create_tween()
			pos.set_trans(Tween.TRANS_BACK)
			pos.set_ease(Tween.EASE_OUT)
			pos.tween_property(self, "position", Vector2(128, 384), 0.25)


func _on_app_button_pressed(app_name: String):
	if current_app_name == app_name:
		_clear_app()
		return

	_clear_app()
	var app = apps[app_name].instantiate()
	app_container.add_child(app)
	current_app_name = app_name

func _clear_app():
	for child in app_container.get_children():
		child.queue_free()
	current_app_name = ""
func queue_free_children(node: Node):
	for child in node.get_children():
		child.queue_free()
