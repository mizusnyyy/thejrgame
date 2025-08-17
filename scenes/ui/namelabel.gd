extends Control
@onready var labele = $ScrollContainer/CenterContainer/labela
@onready var val = $ScrollContainer
func setname(name):
	print("lnb ww ", labele)
	labele.text = name

func _on_ready() -> void:
	scrollit()

func scrollit():
	val.scroll_horizontal=0
	var tween = create_tween()
	tween.tween_property(val, "scroll_horizontal", val.get_h_scroll_bar().max_value, 2)
	await tween.finished
	val.scroll_horizontal=0
	await get_tree().create_timer(1).timeout
	#val.scroll_horizontal += 1
	#var max_scroll = val.get_h_scroll_bar().max_value
	#print(val.scroll_horizontal," 1hiweje ", val.get_h_scroll_bar().max_value)
	#if val.scroll_horizontal >= max_scroll:
		#await get_tree().create_timer(1).timeout
		#val.scroll_horizontal = 0
	#else:
		#await get_tree().create_timer(0.1).timeout
	scrollit()
