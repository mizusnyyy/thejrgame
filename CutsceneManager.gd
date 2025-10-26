extends Node
var cutscenes := preload("res://data/cutscene_enum.gd").cutscene
var all := {}
func _ready():
	cutsceneset()
func has_played(id:int) -> bool:
	print(id in all and all[id])
	return id in all and all[id]

func set_played(id:int) -> void:
	all[id] = true
	
func cutsceneset():
	for i in len(cutscenes):
		#TRUE = POMINIECIE CUTSCENEK, FALSE = NIE
		all[i]=false
	print(all)
