extends TextureRect
@onready var text := $textoptions
@onready var dobry := 0
var zasieg := false
signal choice_finished
signal done
var selfid := 0
func settext(settext):
	text.text = settext
func _unhandled_input(event):
	if event.is_action_pressed("interact") && zasieg:
		emit_signal("choice_finished")
func disappearbut(v):
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 0.0, v)
	tween.tween_callback(Callable(self, "queue_free"))
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name=="indicator":
		$textoptions.modulate = Color(0.65, 0.65, 0.65, 1.0)
		zasieg = true
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name=="indicator":
		$textoptions.modulate = Color(1.0, 1.0, 1.0, 1.0)
		zasieg = false
