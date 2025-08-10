
extends RichTextLabel	
@onready var hp_bar = $"../Enemy_health_bar"

func _process(delta: float) -> void:
	hp_bar.value = global.enemy_hp
	clear()
	push_color(Color("#ffffff"))
	append_text(("%d / %d"%[int(global.enemy_hp), int(global.maxenemy_hp)]))
	pop()
	
	if global.enemy_hp <= 0:
		global.enemy_hp = 0
