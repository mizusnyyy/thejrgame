extends Node2D
@onready var lss := $lockscreensprite
@onready var lock := $lock/locked
func _on_lockshape_body_entered(body: Node2D) -> void:
	if body.name=="indicator":
		lock.visible=false

func _on_lockshape_body_exited(body: Node2D) -> void:
	if body.name=="indicator":
		lock.visible=true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if !lock.visible:
			bgup()

func bgup():
	var tween = create_tween()
	tween.tween_property(lss.material, "shader_parameter/cut_amount", 1.0, 0.5)
	tween.set_parallel(true)
	tween.tween_property(self, "position:y", position.y - 124, 0.42)
	tween.tween_property($lock, "modulate", Color(1,1,1,0), 0.4)
	tween.tween_property($Label, "modulate", Color(1,1,1,0), 0.1)
	if get_parent().apps==[]:
		get_parent().makeapps()
	get_parent().scrollit()
	await tween.finished
	lss.material.set("shader_parameter/cut_amount", 0.0)
	self.queue_free()
	
func _on_ready() -> void:
	lss.texture = preload("res://assets/ui/phonebg.png")
	lss.material.set("shader_parameter/cut_amount", 1.0)
