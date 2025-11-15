extends Control
@onready var labele := $ScrollContainer/CenterContainer/labela
@onready var val := $ScrollContainer
func setname(name_get:String):
	labele.text = name_get

func _on_ready() -> void:
	scrollit()

func scrollit():
	while true:
		val.scroll_horizontal=0
		var tween := create_tween()
		tween.tween_property(val, "scroll_horizontal", val.get_h_scroll_bar().max_value, 2)
		await tween.finished
		val.scroll_horizontal=0
		await get_tree().create_timer(1).timeout
