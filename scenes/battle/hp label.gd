extends RichTextLabel
@onready var hp_bar = $".."

func _process(delta: float) -> void:
	hp_bar.value = Global.health
	text = "%d / %d" %[int(Global.health), int(Global.maxhealth)]
	
