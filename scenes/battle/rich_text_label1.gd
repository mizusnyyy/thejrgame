extends RichTextLabel
@onready var hp_bar = $"../Player_health_bar"

func _process(delta: float) -> void:
	hp_bar.value = global.health
	clear()
	push_color(Color("#ffffff"))
	append_text(("%d / %d"%[int(global.health), int(global.maxhealth)]))
	pop()
	
