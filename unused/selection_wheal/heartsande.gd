extends Sprite2D



func _on_ready() -> void:
	self.modulate = Color(randf(),randf(),randf(),0.9)
	await get_tree().create_timer(0.1).timeout
	self.modulate.a = 0.7
	await get_tree().create_timer(0.1).timeout
	self.modulate.a = 0.5
	await get_tree().create_timer(0.1).timeout
	self.modulate.a = 0.3
	await get_tree().create_timer(0.1).timeout
	self.modulate.a = 0.1
	await get_tree().create_timer(0.1).timeout
	self.queue_free()
	
func changeheart(txt,vx,vy):
	self.texture=txt
	self.region_rect.position.x = vx
	self.region_rect.position.y = vy
