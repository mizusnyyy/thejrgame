extends ColorRect
@onready var label := $hb/sc/cc/mc/l
@onready var texture := $songtxt
@onready var but := $button
var caninteract := false
var playing = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	but.modulate = Color(0.6,0.6,0.6,1)
	caninteract


func _on_area_2d_body_exited(body: Node2D) -> void:
	but.modulate = Color(1,1,1,1)
	!caninteract

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && caninteract:
		if playing:
			but.texture = load("res://assets/ui/song/play.png")
			caninteract
			!playing
		else:
			but.texture = load("res://assets/ui/song/stop.png")
			!caninteract
			playing
	
