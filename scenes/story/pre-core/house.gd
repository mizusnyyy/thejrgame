extends Node2D
@onready var anim := $AnimationPlayer
@onready var item := preload("res://scenes/items/iteminteract.tscn")
@onready var tilesetobj := $ysorting/objects

func _ready():
	$ysorting/player/player/ColorRect.visible=false
	print(CutsceneManager.has_played(CutsceneManager.cutscenes.intro))
	if CutsceneManager.has_played(CutsceneManager.cutscenes.intro):
		anim.stop()
	else:
		Global.can_move=false
		Global.can_phone=false
		anim.play("intro")
		CutsceneManager.set_played(CutsceneManager.cutscenes.intro)
		await anim.animation_finished
		Global.can_move=true
	await get_tree().create_timer(4).timeout
	changebed(true)
		
func spawnphone():
	var ins = item.instantiate()
	$ysorting.add_child(ins)
	ins.position=Vector2(29.0,-134.0)
	
func changebed(make:bool):
	var coordbeddown = tilesetobj.get_used_cells_by_id(5)
	var coordbedup = tilesetobj.get_used_cells_by_id(4)
	if make:
		tilesetobj.set_cell(coordbeddown[0],5,Vector2i(12, 0),0)
		tilesetobj.set_cell(coordbedup[0],4,Vector2i(4, 0),0)
	else:
		tilesetobj.set_cell(coordbeddown[0],5,Vector2i(4, 0),0)
		await get_tree().create_timer(0.08).timeout
		tilesetobj.set_cell(coordbeddown[0],5,Vector2i(8, 0),0)
