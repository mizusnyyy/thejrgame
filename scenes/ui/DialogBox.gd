extends RichTextLabel

func _ready() -> void:
	bbcode_enabled = true
	install_effect(BounceEffect.new())
	set_process(true)

func _process(_delta: float) -> void:
	queue_redraw()
