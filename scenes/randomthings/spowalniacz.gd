extends Area2D

var temp
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		temp = body.SPEED
		body.SPEED /= 1.6


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.SPEED = temp
