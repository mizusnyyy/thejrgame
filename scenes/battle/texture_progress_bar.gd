extends TextureProgressBar
@onready var hp_bar = $"."
func ready():
	max_value=global.maxhealth
func _process(delta: float) -> void:
	hp_bar.value = global.health
