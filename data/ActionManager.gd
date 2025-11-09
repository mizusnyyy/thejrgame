extends Node

const act_e := preload("res://data/action_enum.gd").act

var current_scene: Node = null

func register_scene(scene: Node):
	current_scene = scene
	print("✅ Zarejestrowano scenę:", scene.name)

func do_action(action:String):
	#print(act_e[action])
	var enum_val:int = act_e[action]
	#print(action)
	#print(enum_val)
	match enum_val:
		act_e.home_bed_action: current_scene.actionbed(true)
		act_e.home_couch_action: current_scene.actioncouch()
		act_e.home_crystal_action: current_scene.actioncrystal()
		act_e.home_wardrobe_action: current_scene.actionwardrobe()
		act_e.home_wardrobe1_action: current_scene.actionwardrobe1()
		act_e.home_bath_action: current_scene.actionbath()
		act_e.home_bookshelf_action: current_scene.actionbookshelf()
		act_e.home_desk_action: current_scene.actiondesk()
		act_e.home_mirror_action: current_scene.actionmirror()
		act_e.home_fridge_action: current_scene.actionfridge()
		
		
		_: print("nico")
