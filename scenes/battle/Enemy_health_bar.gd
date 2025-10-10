extends TextureProgressBar


func _ready():
	max_value = Global.mana_max
	value = Global.mana

func _process(delta: float) -> void:
	# upewnij się, że value jest aktualizowane
	value = Global.mana

	
