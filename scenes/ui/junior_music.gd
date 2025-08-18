extends Node2D
var can:=false
var music:Array[String]=["crashpeak","pineap","igor song","testyyy","cumzone"]
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name=="indicator":
		$TextureRect.modulate=Color(0.6,0.6,0.6,1)
		can=true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name=="indicator":
		$TextureRect.modulate=Color(1,1,1,1)
		can=false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact")&&can:
		self.queue_free()

func addmusic(x):
	var path = preload("res://scenes/ui/musicappsong.tscn")
	var ins = path.instantiate()
	$mc/sc/vbc.add_child(ins)
	print(ins)
	ins.changename(x)
	ins.changephoto(x)
	#$mc/sc.scroll_vertical=0

func _on_ready() -> void:
	for i in len(music):
		print(music[i])
		addmusic(music[i])
