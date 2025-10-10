extends Node2D

@onready var cursor := $"../../choice/indicator"
@onready var lock := $lockscreen/lock
@onready var val := $MarginContainer/ScrollContainer/VBoxContainer/ScrollContainer
var apps := []
var ins
var s:String
var scroll:=false

func inslockscreen():
	var path := preload("res://scenes/ui/lockscreen.tscn")
	var ins := path.instantiate()
	add_child(ins)

func deleng():
	if $lockscreen:
		$lockscreen.queue_free()

func _on_ready() -> void:
	inslockscreen()

func scrollit():
	while true:
		var tween := create_tween()
		tween.tween_property(val, "scroll_horizontal", val.get_h_scroll_bar().max_value, 3)
		await tween.finished
		val.scroll_horizontal=0
		await get_tree().create_timer(1.5).timeout

func makeapps():
	Global.glapps(["Pumsapp","Jumbo maps","Junior Music","Jack\'n\'gram","CalPUMlator","igorapp","igorapp","igorapp","igorapp","igorapp"])
	var path = preload("res://scenes/ui/phoneapp.tscn")
	for i in len(Global.phoneapps):
		ins = path.instantiate()
		s = Global.phoneapps[i]
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
	if body.name != "indicator":
		return
	if get_node_or_null("lockscreen"):
		return
	if $apps.get_child_count()!=0:
		return
	scroll=true
	var x := $MarginContainer/ScrollContainer
	var tween := create_tween()
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
	if get_node_or_null("lockscreen"):
		return
	if $apps.get_child_count()!=0:
		return
	scroll=true
	var x := $MarginContainer/ScrollContainer
	while scroll:
		if x.scroll_vertical > 0:
			x.scroll_vertical-=1
		await get_tree().process_frame


func _on_scrollup_body_exited(body: Node2D) -> void:
	if body.name != "indicator":
		return
	scroll=false
