extends Area2D

@onready var anim = $mercy
@onready var battle = $"../.."
@onready var notui = $".." 

var selected = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "soul":
		anim.play("select")
	selected = true


func _on_body_exited(body: Node2D) -> void:
	anim.play("default")
	selected = false
	
func _process(delta: float) -> void:
	if selected and visible and Input.is_action_just_pressed("interact") and global.current_state==global.state.PLAYER_TURN:
		selected = false
		if battle.mercy >= 100:
			print("Mercy osiągnęło 100, koniec walki :3")
			var powrot_house = load("res://scenes/story/pre-core/house.tscn") 
			get_tree().change_scene_to_packed(powrot_house)
			return
		global.mercy += 10
		print("mercy: " + str(global.mercy))
		notui.enemyturn()
