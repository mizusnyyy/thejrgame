extends RichTextLabel
@onready var hp_bar = $"../TextureProgressBar"
const Max_health := 100
var max_hp = global.health
func _process(delta: float) -> void:
	hp_bar.value = global.health
	text = "%d / %d" %[int(global.health), int(Max_health)]
