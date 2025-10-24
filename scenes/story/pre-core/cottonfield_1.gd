extends Node2D
@onready var anim := $AnimationPlayer
@onready var item := preload("res://scenes/items/iteminteract.tscn")
@onready var tileset_house : TileMapLayer = $ysorting/house_ysort/housejr_objects
var player : CharacterBody2D
var barrier

func _ready():
	player = get_tree().get_first_node_in_group("player")
	$ysorting/player/blackout_screen.visible=false
	print(CutsceneManager.has_played(CutsceneManager.cutscenes.intro))
	if CutsceneManager.has_played(CutsceneManager.cutscenes.intro):
		anim.stop()
	else:
		Musicsounds.play_music(load("res://assets/sounds/music/0.ogg"))
		Global.can_move=false
		Global.can_phone=false
		
		play_cutscene("intro")
		
		CutsceneManager.set_played(CutsceneManager.cutscenes.intro)
		await anim.animation_finished
		Global.can_move=true
	Musicsounds.play_music(load("res://assets/sounds/music/1.ogg"))
	await get_tree().create_timer(3.0).timeout
	changebed(true)
		
func spawnphone():
	var ins : Area2D = item.instantiate()
	$ysorting.add_child(ins)
	ins.position=Vector2(29.0,-134.0)
	
func changebed(make:bool):
	var coordbeddown = tileset_house.get_used_cells_by_id(5)
	var coordbedup = tileset_house.get_used_cells_by_id(4)
	if make:
		tileset_house.set_cell(coordbeddown[0],5,Vector2i(12, 0),0)
		tileset_house.set_cell(coordbedup[0],4,Vector2i(4, 0),0)
	else:
		tileset_house.set_cell(coordbeddown[0],5,Vector2i(4, 0),0)
		await get_tree().create_timer(0.08).timeout
		tileset_house.set_cell(coordbeddown[0],5,Vector2i(8, 0),0)

func cutscene_talk(character:String, pause_cutscene: bool = true):
		DialogueManager.begin_dialogue(character,player.dialog,$AudioStreamPlayer2D)
		Global.isincutscene=true
		if pause_cutscene:
			$AnimationPlayer.pause()
			await DialogueManager.dialogue_done
			Global.isincutscene=false
			$AnimationPlayer.play()
			return
		await DialogueManager.dialogue_done
		Global.isincutscene=false

func makebarrier(text_id:String="", glob_pos:Vector2=Vector2(0.0,0.0), size_barrier:Vector2=Vector2(16.0,16.0)):
	
	var outer_size_barrier = Vector2(14.0,14.0)
	
	barrier = load("res://scenes/randomthings/no_enter.tscn").instantiate()
	add_child(barrier)
	
	barrier.get_child(0).get_child(0).get_child(0).shape.size = size_barrier
	barrier.get_child(0).shape.size = size_barrier + outer_size_barrier
	
	barrier.text_id=text_id
	barrier.global_position = glob_pos

func delbarrier():
	barrier.del()

func play_cutscene(cutscene:String):
	anim.play(cutscene)

func make_trigger_cutscene(name_t: String, pos_t: Vector2, size_t: Vector2):
	var trigger = load("res://scenes/story/trigger_cutscene.tscn").instantiate()
	add_child(trigger)
	
	trigger.changes(name_t,pos_t,size_t)
