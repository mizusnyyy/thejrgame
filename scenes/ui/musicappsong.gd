extends ColorRect
@onready var label := $hb/sc/cc/mc/l
@onready var texture := $songtxt
@onready var but := $button
var caninteract := false
var playing := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	but.modulate = Color(0.6,0.6,0.6,1)
	caninteract=true


func _on_area_2d_body_exited(body: Node2D) -> void:
	but.modulate = Color(1,1,1,1)
	caninteract=false

func _input(event: InputEvent) -> void:
	if event.is_actionpressed("interact") && caninteract:
		if playing:
			but.texture = load("res://assets/ui/song/play.png")
			caninteract=false
			playing=false
		else:
			but.texture = load("res://assets/ui/song/stop.png")
			caninteract=true
			playing=true

func changename(x):
	$hb/sc/cc/mc/l.text = x

func changephoto(y):
	var z:int
	match y:
		"crashpeak":z = 1
		"pineap":z = 2
		_: 
			$songtxt.texture = load("res://assets/sprite/characters/jr/teto_front.png")
			return
	$songtxt.texture = load("res://assets/ui/song/music"+str(z)+".png")
