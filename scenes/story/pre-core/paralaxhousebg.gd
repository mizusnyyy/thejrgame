extends ParallaxBackground

@export var scroll_speed: float = 0.5
@onready var player := $"../player"

func _process(delta: float) -> void:
	if not player:
		return
	var vel: Vector2 = player.velocity
	scroll_base_offset += -vel * scroll_speed * delta
