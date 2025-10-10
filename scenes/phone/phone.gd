extends Control

@onready var app_container: Control = $TextureRect/Control
@onready var app_list: VBoxContainer = $TextureRect/VBoxContainer

var current_app_name: String = ""
var active:= true
var is_animating:= false

# Dodaj tu inne aplikacje wedle potrzeby
var apps = {
	"console": preload("res://scenes/phone/apps/console/console.tscn")
}

func _ready():
	position = Vector2(128, 720)
	visible = false

	if app_container == null or app_list == null:
		push_error("Phone: app_container or app_list not found!")
		active = false
		return

	for app_name in apps.keys():
		var btn = Button.new()
		btn.text = app_name.capitalize()
		btn.pressed.connect(_on_app_button_pressed.bind(app_name))
		app_list.add_child(btn)

func _process(_delta):
	if not active or is_animating:
		return
	if Input.is_action_just_pressed("phone"):
		if visible:
			_hide_phone()
		else:
			_show_phone()
func _show_phone():
	if not Global.can_phone:
		return
	visible = true
	is_animating = true
	
	showcursor()
	$TextureRect/phoneeng.inslockscreen()
	
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(40, 384), 0.25)
	tween.finished.connect(func():
		is_animating = false
	)

func _hide_phone(prevent=false):
	var x := get_tree().get_first_node_in_group("appsnode")
	if prevent:
		visible=false
		hidecursor()
		$TextureRect/phoneeng.deleng()
		await get_tree().create_timer(0.6).timeout
		self.position = Vector2(128, 720)
		return
	is_animating = true

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", Vector2(128, 720), 0.25)
	#_clear_app() < do ukrywania apki po wylaczeniu phonea ale narazie hasztaguje bo musze cos naprawic!!!
	tween.finished.connect(func():
		visible = false
		is_animating = false
	)
	await tween.finished
	for i in x.get_child_count():
		x.get_child(i).queue_free()
		print(get_tree().get_first_node_in_group("appsnode").get_child_count())
	hidecursor()
	$TextureRect/phoneeng.deleng()

func _on_app_button_pressed(app_name: String):
	if current_app_name == app_name:
		_clear_app()
		return

	_clear_app()

	if apps.has(app_name):
		var app = apps[app_name].instantiate()
		app_container.add_child(app)
		current_app_name = app_name

func _clear_app():
	if app_container:
		for child in app_container.get_children():
			child.queue_free()
	current_app_name = ""

func showcursor():
	var choice := $choice/indicator
	choice.position=Vector2(0,0)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN)
	#tween.tween_property(choice, "modulate", Color(1,1,1,1), 0.5)
	#choice.global_position = Vector2(128, 720)
	show()
	choice.show()
	choice.can_choose = true
	Global.can_move = false

func hidecursor():
	var choice := $"choice/indicator"
	choice.hide()
	choice.can_choose = false
	Global.can_move = true
	
