extends Area2D
@onready var text = $textoptions
@onready var dobry = false
var zasieg = false
signal choice_finished

func settext(settext):
	text.text = settext

func _on_body_entered(body: Node2D) -> void:
	if body.name=="indicator":
		self.modulate = Color(1, 1, 0, 0.5)
		zasieg = true

func _on_body_exited(body: Node2D) -> void:
	self.modulate = Color(1, 1, 1, 1)
	zasieg = false

func _unhandled_input(event):
	if event.is_action_pressed("interact") && zasieg:
		if dobry:
			emit_signal("choice_finished")
		else:
			while true:
					print("mizu jest glupi")
					print("mizu to igor")
