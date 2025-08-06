extends RichTextLabel

@onready var original_scale = scale
@onready var color_rect = get_parent()
@onready var notui = $"../../.."
var hovered = false
var used = false

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	set_process(true)
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _process(delta: float) -> void:
	if hovered and not used and Input.is_action_just_pressed("interact"):
		used = true
		global.health += 10
		if global.health > global.maxhealth:
			global.health = global.maxhealth
		print("Żresz i zyskujesz 10 hp:", global.health)
		if is_instance_valid(color_rect):
			color_rect.visible = false
		queue_free()
		notui.enemyturn()

func _on_mouse_entered() -> void:
	hovered = true
	scale = original_scale * 1.1

func _on_mouse_exited() -> void:
	hovered = false
	scale = original_scale
