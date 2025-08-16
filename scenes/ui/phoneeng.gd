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
	global.glapps(["Pumsapp","Jumbo maps","Junior Music"])
	for i in len(global.phoneapps):
		var path = preload("res://scenes/ui/phoneapp.tscn")
		var ins = path.instantiate()
		var s = global.phoneapps[i]
		$GridContainer.add_child(ins)
		var label = Label.new()
		label.text = s
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		ins.add_child(label)
		apps.append(ins)
		print("hawhg", $GridContainer.get_child(i))
		
