extends TextureProgressBar
@onready var hp_bar = $"."
func _process(delta: float) -> void:
	hp_bar.value = global.health
