extends Area2D

@onready var anim = $item
@onready var info_box = $ColorRect
@onready var info_label = $ColorRect/Label

var selected = false

func _ready() -> void:
	info_box.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "soul":
		anim.play("select")
		selected = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "soul":
		anim.play("default")
		selected = false

func _process(_delta: float) -> void:
	if selected and global.current_state == global.state.PLAYER_TURN and Input.is_action_just_pressed("interact"):
		toggle_item()

func toggle_item():
	info_box.visible = not info_box.visible
