extends Area2D
@onready var anim = $item

var selected = false
signal show_items
signal hide_items

func _on_body_entered(body: Node2D) -> void:
	if body.name == "soul":
		anim.play("select")
		selected = true
		emit_signal("show_items")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "soul":
		anim.play("default")
		selected = false
		emit_signal("hide_items")
