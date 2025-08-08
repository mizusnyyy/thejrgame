extends Area2D

@export var option_name: String
@onready var label = $Label

func _on_body_exited(body):
	if body.name == "indicator":
		label.add_theme_color_override("font_color", Color.WHITE)


func _on_body_entered(body):
	if body.name == "indicator":
		label.add_theme_color_override("font_color", Color.YELLOW)
	if body.name == "indicator" and Input.is_action_pressed("interact"):
		label.add_theme_color_override("font_color", Color.YELLOW)
		# W momencie wejścia i naciśnięcia wybieramy opcję
		print("chosen: ", option_name)
		body.can_choose = false
		body.hide()
		body.emit_signal("chosen", option_name)
