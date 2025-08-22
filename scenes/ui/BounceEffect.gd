extends RichTextEffect
class_name BounceEffect

var bbcode := "bounce"
var random_phase: Dictionary = {}

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var speed: float = 10.0
	var height: float = 3.0

	var i: int = char_fx.range.x + char_fx.relative_index
	if not random_phase.has(i):
		random_phase[i] = randf_range(0.0, PI * 2.0)

	var phase: float = random_phase[i] as float
	var t: float = Time.get_ticks_msec() / 1000.0

	char_fx.offset.y = -abs(sin(t * speed + phase)) * height
	return true
