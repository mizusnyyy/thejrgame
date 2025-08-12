extends TextureProgressBar


func _ready():
	max_value = global.mana_max
	value = global.mana

func _process(delta: float) -> void:
	# upewnij się, że value jest aktualizowane
	value = global.mana

	
