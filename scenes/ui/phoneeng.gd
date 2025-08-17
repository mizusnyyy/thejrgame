extends Node2D

@onready var cursor = $"../../choice/indicator"
@onready var lock = $lockscreen/lock
@onready var val = $MarginContainer/ScrollContainer/VBoxContainer/ScrollContainer
var apps = []
var ins
var s
var scroll=false
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("interact"):
		#COS CO BEDZIE WCZESNIEJ TU
		#if $lockscreen && !$lockscreen/lock/locked.visible:
			#$lockscreen.bgup()

func inslockscreen():
	var path = preload("res://scenes/ui/lockscreen.tscn")
	var ins = path.instantiate()
	add_child(ins)

func deleng():
	if $lockscreen:
		$lockscreen.queue_free()

func _on_ready() -> void:
	inslockscreen()
	makeapps()
	scrollit()

func scrollit():
	var tween = create_tween()
	tween.tween_property(val, "scroll_horizontal", val.get_h_scroll_bar().max_value, 3)
	await tween.finished
	val.scroll_horizontal=0
	await get_tree().create_timer(1.5).timeout
	#val.scroll_horizontal += 1
	#var max_scroll = val.get_h_scroll_bar().max_value
	#print(val.scroll_horizontal," 1hiweje ", val.get_h_scroll_bar().max_value)
	#if val.scroll_horizontal >= max_scroll:
		#await get_tree().create_timer(1).timeout
		#val.scroll_horizontal = 0
	#else:
		#await get_tree().create_timer(0.1).timeout
	scrollit()

func makeapps():
	global.glapps(["Pumsapp","Jumbo maps","Junior Music","Jack\'n\'gram","CalPUMlator","igorapp","igorapp","igorapp","igorapp","igorapp"])
	for i in len(global.phoneapps):
		var path = preload("res://scenes/ui/phoneapp.tscn")
		ins = path.instantiate()
		s = global.phoneapps[i]
		$MarginContainer/ScrollContainer/VBoxContainer/GridContainer.add_child(ins)
		setapplabel()
		ins.setphoto(s)
		apps.append(ins)

func setapplabel():
	var label = preload("res://scenes/ui/appname.tscn").instantiate()
	ins.add_child(label)
	label.position.y += 18
	label.setname(s)

func _on_scrolldown_body_entered(body: Node2D) -> void:
	scroll=true
	var x = $MarginContainer/ScrollContainer
	var tween = create_tween()
	while scroll:
		if x.scroll_vertical < x.get_v_scroll_bar().max_value:
			x.scroll_vertical+=1
		await get_tree().process_frame
	print("downing")

func _on_scrolldown_body_exited(body: Node2D) -> void:
	scroll=false


func _on_scrollup_body_entered(body: Node2D) -> void:
	scroll=true
	var x = $MarginContainer/ScrollContainer
	#var tween = create_tween()
	while scroll:
		if x.scroll_vertical > 0:
			x.scroll_vertical-=1
		await get_tree().process_frame
		#tween.tween_property(x, "scroll_vertical", 0, 3)
	print("upping")


func _on_scrollup_body_exited(body: Node2D) -> void:
	scroll=false
