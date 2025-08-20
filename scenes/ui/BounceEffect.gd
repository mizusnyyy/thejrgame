extends RichTextEffect
class_name BounceEffect

var bbcode := "bounce"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var speed := 6.0
	var height := 8.0
	var delay_step := 0.08
	var i := char_fx.range.x + char_fx.relative_index
	var t := (Time.get_ticks_msec() / 1000.0) - (i * delay_step)

	if t > 0:
		char_fx.offset.y = -abs(sin(t * speed)) * height
	else:
		char_fx.offset.y = 0
	return true
