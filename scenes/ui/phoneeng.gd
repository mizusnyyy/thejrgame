extends Node2D

@onready var cursor = $"../../choice/indicator"
@onready var lock = $lockscreen/lock
var apps = []

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

func makeapps():
	global.glapps(["Pumsapp","Jumbo maps","Junior Music","Jack\'n\'gram"])
	for i in len(global.phoneapps):
		var path = preload("res://scenes/ui/phoneapp.tscn")
		var ins = path.instantiate()
		var s = global.phoneapps[i]
		$MarginContainer/ScrollContainer/GridContainer.add_child(ins)
		setapplabel(ins,s)
		apps.append(ins)

func setapplabel(ins, s):
	var label = preload("res://scenes/ui/appname.tscn").instantiate()
	ins.add_child(label)
	var labela = label.get_node("labela")
	labela.text = s
	#return
	#label.set_anchors_preset(Control.PRESET_CENTER)
	#label.add_theme_font_size_override("font_size", 6)
	#label.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
	#label.vertical_alignment=VERTICAL_ALIGNMENT_CENTER
	#label.global_position.y += 20
