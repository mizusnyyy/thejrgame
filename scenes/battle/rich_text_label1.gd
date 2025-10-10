extends RichTextLabel
@onready var hp_bar = $"../Player_health_bar"
var hp = 0
func _process(delta: float) -> void:
	hp_bar.value = Global.health
	clear()
	push_color(Color("#ffffff"))
	append_text(("%d / %d"%[int(Global.health), int(Global.maxhealth)]))
	pop()
	
	if Global.health <= 0:
		Global.health = 0
	
