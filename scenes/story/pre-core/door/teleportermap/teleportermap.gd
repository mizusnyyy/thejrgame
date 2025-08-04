extends Area2D
@onready var playersprite = $"../../../ysorting/player/player/AnimatedSprite2D"
@onready var velocityplayer = $"../../../ysorting/player/player"
@export var ishorizontal = true
@export var namescene:String

func _on_body_entered(body: Node2D) -> void:
	var lrud = velocityplayer.lrud
	if body.is_in_group("player"):
		player.can_move = false
		var temp = playersprite.global_position
		var velocitytemp = velocityplayer.direction
		if ishorizontal:
			for i in range(45):
				playersprite.set_global_position(Vector2(playersprite.global_position.x+lrud[0],playersprite.global_position.y))
				await get_tree().create_timer(0.015).timeout
			playersprite.set_global_position(Vector2(playersprite.global_position.x-(45*lrud[0]),playersprite.global_position.y))
		else:
			for i in range(45):
				playersprite.set_global_position(Vector2(playersprite.global_position.x,playersprite.global_position.y+lrud[1]))
				await get_tree().create_timer(0.015).timeout
			playersprite.set_global_position(Vector2(playersprite.global_position.x,playersprite.global_position.y-(45*lrud[1])))
		player.can_move = true
		get_tree().change_scene_to_file("res://scenes/story/pre-core/"+namescene)
		#get_tree().change_scene_to_file("res://scenes/battle/battle.tscn")
		
