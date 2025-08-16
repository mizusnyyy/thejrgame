extends Control
@onready var txt=$txt

func _on_appshape_body_entered(body: Node2D) -> void:
	if body.name=="indicator":
		txt.modulate=Color(0.6,0.6,0.6,1)


func _on_appshape_body_exited(body: Node2D) -> void:
	if body.name=="indicator":
		txt.modulate=Color(1,1,1,1)
