extends Sprite2D
@onready var hp_bar

func _process(delta: float) -> void:
	if global.current_heart >= 0 and global.current_heart < global.heart_textures.size():
		texture = global.heart_textures[global.current_heart]
		change_heart_texture()
func change_heart_texture():
	hp_bar = global.health
	if hp_bar > 50:
		self.region_rect.position.y=0
	elif hp_bar > 20:
		self.region_rect.position.y=16
	else:
		self.region_rect.position.y=32
	
