extends Node

const act_e := preload("res://data/action_enum.gd").act

var current_scene: Node = null

func register_scene(scene: Node):
	current_scene = scene
	print("✅ Zarejestrowano scenę:", scene.name)

func do_action(action:String):
	print(act_e[action])
	var enum_val:int = act_e[action]
	match enum_val:
		act_e.home_bed_action:
			current_scene.changebed(true)
			
		act_e.home_couch_action:
			print("couch")
			
		_:
			print("nico")
			
