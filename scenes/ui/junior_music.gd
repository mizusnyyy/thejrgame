extends Node2D
var can:=false
var music:Array[String]=["crashpeak","pineap","f.maska","testyyy","cumzone"]
var scroll:=false

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
	ins.changename(x)
	ins.changephoto(x)

func _on_ready() -> void:
	for i in len(music):
		print(music[i])
		addmusic(music[i])

func _on_scrolldown_body_entered(body: Node2D) -> void:
	if body.name != "indicator":
		return
	print("igorpum")
	scroll=true
	var x = $mc/sc
	var tween = create_tween()
	while scroll:
		if x.scroll_vertical < x.get_v_scroll_bar().max_value:
			x.scroll_vertical+=1
		await get_tree().process_frame

func _on_scrolldown_body_exited(body: Node2D) -> void:
	if body.name != "indicator":
		return
	scroll=false

func _on_scrollup_body_entered(body: Node2D) -> void:
	if body.name != "indicator":
		return
	print("igorpum")
	scroll=true
	var x = $mc/sc
	while scroll:
		if x.scroll_vertical > 0:
			x.scroll_vertical-=1
		await get_tree().process_frame

func _on_scrollup_body_exited(body: Node2D) -> void:
	if body.name != "indicator":
		return
	scroll=false
