extends Sprite2D

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("heart_select"):
		$SelectionWheel.show()
		Engine.time_scale = 0.5
	elif Input.is_action_just_released("heart_select"):
		Engine.time_scale = 1
		$SelectionWheel.hide()
