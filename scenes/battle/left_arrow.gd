extends Area2D

@onready var anim = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	anim.play("select")

func _on_body_exited(body: Node2D) -> void:
	anim.play("default")
