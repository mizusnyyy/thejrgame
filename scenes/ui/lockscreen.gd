extends Sprite2D

func _on_lockshape_body_entered(body: Node2D) -> void:
	if body.name=="indicator":
		$lock/locked.visible=false

func _on_lockshape_body_exited(body: Node2D) -> void:
	if body.name=="indicator":
		$lock/locked.visible=true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if !$lock/locked.visible:
			bgup()

func bgup():
	var tween = create_tween()
	tween.tween_property($lockscreensprite.material, "shader_parameter/cut_amount", 1.0, 0.5)
	tween.set_parallel(true)
	tween.tween_property(self, "position:y", position.y - 122, 0.5)
	tween.tween_property($lock, "modulate", Color(1,1,1,0), 0.2)
	tween.tween_property($Label, "modulate", Color(1,1,1,0), 0.2)
	await tween.finished
	self.queue_free()


func _on_ready() -> void:
	print("przed ", texture)
	texture = preload("res://assets/ui/phonebg.png")
	print("po ", texture)
