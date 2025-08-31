extends Node2D
@onready var anim := $AnimationPlayer
@onready var item := preload("res://scenes/items/iteminteract.tscn")
func _ready():
	#CutsceneManager.cutsceneset()
	$ysorting/player/player/ColorRect.visible=false
	print(CutsceneManager.has_played(CutsceneManager.cutscenes.intro))
	if CutsceneManager.has_played(CutsceneManager.cutscenes.intro):
		anim.stop()
	else:
		global.can_move=false
		global.can_phone=false
		anim.play("intro")
		CutsceneManager.set_played(CutsceneManager.cutscenes.intro)
		await anim.animation_finished
		global.can_move=true
func spawnphone():
	var ins = item.instantiate()
	$ysorting.add_child(ins)
	ins.position=Vector2(48.0,-256.0)
