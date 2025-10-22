extends Area2D

var text_id:String=""

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#var where_looking : Vector2 = body.direction
		#print("-------------", where_looking)
		var where_to_go : Vector2
		
		DialogueManager.begin_dialogue(text_id,body.dialog,$AudioStreamPlayer2D)
