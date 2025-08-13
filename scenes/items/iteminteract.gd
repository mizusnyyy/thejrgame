extends Area2D
var igor=false
var inrange=false
var anime
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		inrange=true
		anime = body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		inrange=false

func _unhandled_input(event):
	if event.is_action_pressed("interact") && inrange:
		anime.obtainanim($Sprite2D.texture)
		musicsounds.play_music(load("res://JacksWithHats.wav"))
		self.queue_free()
		
func _on_ready() -> void:
	idleanim()

func idleanim():
	igor=!igor
	var dur=1
	var val=[20,Vector2(1.6,1.6),Color(0.2,0.2,1,0.2),10]
	if igor:
		val=[-20,Vector2(1.3,1.3),Color(1,1,1,0.5),-10]
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property($behind,"global_rotation",deg_to_rad(val[0]),dur)
	tween.tween_property($behind,"scale",val[1],dur)
	tween.tween_property($behind,"modulate",val[2],dur)
	tween.tween_property($behind,"skew",deg_to_rad(val[3]),dur)
	await tween.finished
	idleanim()
