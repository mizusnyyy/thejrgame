extends Area2D
@onready var text = $textoptions
@onready var dobry = 0
var zasieg = false
signal choice_finished
signal done
var selfid = 0

func settext(settext):
	text.text = settext

func _on_body_entered(body: Node2D) -> void:
	if body.name=="indicator":
		self.modulate = Color(1, 1, 1, 0.5)
		zasieg = true

func _on_body_exited(body: Node2D) -> void:
	if body.name=="indicator":
		self.modulate = Color(1, 1, 1, 1)
		zasieg = false

func _unhandled_input(event):
	if event.is_action_pressed("interact") && zasieg:
		emit_signal("choice_finished")
func disappearbut(v):
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, v)
	tween.tween_callback(Callable(self, "queue_free"))
