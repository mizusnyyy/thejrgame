extends ParallaxBackground

@export var scroll_speed: Vector2 = Vector2(-100, 0)
@onready var sprite := $ParallaxLayer/AnimatedSprite2D
func ready():
	sprite.global_position=Vector2(220,randi_range(20,320))

func _process(delta):
	$ParallaxLayer.motion_offset += scroll_speed * delta
