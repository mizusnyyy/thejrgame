extends Sprite2D
@onready var hp_bar

func _process(delta: float) -> void:
	change_heart_texture()
func change_heart_texture():
	hp_bar = Global.health
	if hp_bar > 50:
		self.region_rect.position.y=0
	elif hp_bar > 20:
		self.region_rect.position.y=16
	else:
		self.region_rect.position.y=32
	
