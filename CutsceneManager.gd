extends Node

var played_cutscenes = {"intro": false}  # słownik na cutscenki, np. {"intro": true}

func has_played(name: String) -> bool:
	return played_cutscenes.has(name) and played_cutscenes[name]

func set_played(name: String) -> void:
	played_cutscenes[name] = true

#func playanim(name:String) -> void:
	
