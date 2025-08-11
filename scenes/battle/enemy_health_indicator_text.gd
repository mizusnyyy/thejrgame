
extends RichTextLabel	
@onready var mana = $"../Mana__Ghost_bar"

func _process(delta: float) -> void:
	mana.value = global.mana
	clear()
	push_color(Color("#ffffff"))
	append_text(("%d / %d"%[int(global.mana), int(global.mana_max)]))
	pop()
	
	if global.mana <= 0:
		global.mana = 0
