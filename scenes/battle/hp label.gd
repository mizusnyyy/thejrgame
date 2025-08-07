extends RichTextLabel
@onready var hp_bar = $"../TextureProgressBar"
func _process(delta: float) -> void:
	hp_bar.value = global.health
	text = "%d / %d" %[int(global.health), int(global.maxhealth)]
	
