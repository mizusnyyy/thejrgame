extends Area2D

@export var text_id:String=""

var keep_moving := true

var temp_can_move: bool
var player: Node2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var direction : Vector2 = (((body.global_position - global_position)*1.7)+global_position)
		player = body
		
		immobilize_player()
		
		if text_id != "":
			DialogueManager.begin_dialogue(text_id,body.dialog,$"../AudioStreamPlayer2D")
			await DialogueManager.dialogue_done
		
		player_go_back()


func player_go_back():
		var animation_player : AnimatedSprite2D = player.get_child(1)
		var half_size_self_y : float = ($col/static/colstatic.shape.size.y/2.0)
		var half_size_self_x : float = ($col/static/colstatic.shape.size.x/2.0)
		var inside_half_size : bool = (
			(global_position.x+half_size_self_x) > player.global_position.x && player.global_position.x > (global_position.x-half_size_self_x)
		)
		
		if player.global_position.x > global_position.x && !inside_half_size:
			print("RIGHT!")
			move_back_player(player.global_position+Vector2(15.0,0.0))
			animation_player.play("sider")
			
		elif player.global_position.x < global_position.x && !inside_half_size:
			print("LEFT!")
			move_back_player(player.global_position+Vector2(-15.0,0.0))
			animation_player.play("sidel")
			
		elif player.global_position.y < global_position.y-half_size_self_y:
			print("UP!")
			move_back_player(player.global_position+Vector2(0.0,-15.0))
			animation_player.play("back")
			
		else:
			print("DOWN!")
			move_back_player(player.global_position+Vector2(0.0,15.0))
			animation_player.play("front")


func immobilize_player():
	keep_moving=true
	temp_can_move=Global.can_move
	Global.can_move=false
	
	await get_tree().process_frame
	
	player.anim_locked=true

func mobilize_player():
	keep_moving=false
	Global.can_move=temp_can_move
	
	player.anim_locked=false


#func set_player_anim():
	#var animation_player : AnimatedSprite2D = player.get_child(1)
	#if player.direction.x>player.direction.y:
		#if player.direction.x<self.direction.x:
			##right
			#animation_player.play("sider")
		#else:
			##left
			#animation_player.play("sidel")
			#
	##IF DOWN ALBO UP
	#else:
		#if player.direction.y<self.direction.y:
			##down
			#animation_player.play("front")
		#else:
			##up
			#animation_player.play("back")
	#print(player.direction.x)

func move_back_player(dir: Vector2):
	keep_moving=true
	while player.global_position.distance_to(dir) > 1.0 and keep_moving:
		player.global_position = player.global_position.move_toward(dir, player.SPEED * get_process_delta_time())
		await get_tree().process_frame
	
	await get_tree().create_timer(0.3).timeout
	mobilize_player()


func del():
	self.queue_free()
