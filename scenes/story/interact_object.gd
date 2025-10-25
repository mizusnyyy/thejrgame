extends Area2D

var inbody := false
var player : Node2D
@export var where_need_look: int = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		inbody = true
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		inbody = false
		player = null

func _physics_process(delta: float) -> void:
	if inbody and player:
		if player.directionstop == where_need_look:
			print(player.directionstop)
