extends Node2D

@onready var cursor = $"../../choice/indicator"
@onready var lock = $lockscreen/lock
@onready var val = $MarginContainer/ScrollContainer/VBoxContainer/ScrollContainer
var apps = []
var ins
var s
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
	val.scroll_horizontal=0
	var tween = create_tween()
	tween.tween_property(val, "scroll_horizontal", val.get_h_scroll_bar().max_value, 3)
	await tween.finished
	val.scroll_horizontal=0
	await get_tree().create_timer(1).timeout
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
	global.glapps(["Pumsapp","Jumbo maps","Junior Music","Jack\'n\'gram"])
	for i in len(global.phoneapps):
		var path = preload("res://scenes/ui/phoneapp.tscn")
		ins = path.instantiate()
		s = global.phoneapps[i]
		$MarginContainer/ScrollContainer/VBoxContainer/GridContainer.add_child(ins)
		setapplabel()
		print(i, " hisejnhh i ", s)
		ins.setphoto(s)
		apps.append(ins)

func setapplabel():
	var label = preload("res://scenes/ui/appname.tscn").instantiate()
	ins.add_child(label)
	label.position.y += 18
	label.setname(s)
	#return
	#label.set_anchors_preset(Control.PRESET_CENTER)
	#label.add_theme_font_size_override("font_size", 6)
	#label.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
	#label.vertical_alignment=VERTICAL_ALIGNMENT_CENTER
	#label.global_position.y += 20
