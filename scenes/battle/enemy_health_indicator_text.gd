
extends RichTextLabel	
@onready var mana = $"../Mana_bar"

func _process(delta: float) -> void:
	mana.value = Global.mana
	clear()
	push_color(Color("#ffffff"))
	append_text(("%d / %d"%[int(Global.mana), int(Global.mana_max)]))
	pop()
	
	if Global.mana <= 0:
		Global.mana = 0
