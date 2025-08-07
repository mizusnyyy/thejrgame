extends Area2D

@onready var anim = $item
@onready var info_box = $ColorRect
@onready var info_label = $ColorRect/Label

var selected = false
var interacting = false

func _ready() -> void:
	info_box.visible = false

func _on_body_entered(body: Node2D) -> void:
	if _is_soul_or_child(body):
		anim.play("select")
		selected = true

func _on_body_exited(body: Node2D) -> void:
	if _is_soul_or_child(body):
		anim.play("default")
		# Nie wyłączamy interacting, bo interakcja może trwać
		selected = false

func _process(_delta: float) -> void:
	if selected and global.current_state == global.state.PLAYER_TURN and Input.is_action_just_pressed("interact"):
		if not interacting:
			interacting = true
			toggle_item()

# Umożliwia ponowną interakcję np. po zamknięciu info_box z Labela
func reset_interacting():
	interacting = false

func toggle_item():
	info_box.visible = not info_box.visible
	if not info_box.visible:
		reset_interacting()

# Obsługuje także "Heart"
func _is_soul_or_child(node: Node) -> bool:
	while node != null:
		if node.name == "soul":
			return true
		node = node.get_parent()
	return false
