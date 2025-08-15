extends Node2D

@onready var cursor = $"../../choice/indicator"
@onready var lock = $lockscreen/lock


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
