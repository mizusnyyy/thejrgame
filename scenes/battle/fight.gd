extends Area2D

@onready var anim = $fight
@onready var dmg = $dmg
@onready var soul = $"../../soul"
@onready var notui = $".."
@onready var audio = $dmgsound
var selected = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "soul":
		anim.play("select")
	selected = true

func _on_body_exited(body: Node2D) -> void:
	anim.play("default")
	selected = false
func _process(delta: float) -> void:
	if selected and global.current_state==global.state.PLAYER_TURN and Input.is_action_just_pressed("interact") and visible:
		selected = false
		dmg.global_position=Vector2(randf_range(450,800),randf_range(125,250))
		if dmg.global_position.x > 640:
			dmg.global_rotation=randf_range(0,-0.5)
		else:
			dmg.global_rotation=randf_range(0,0.5)
		dmg.play()
		audio.play()
		await dmg.animation_finished
		print("the very evil enemy: ", global.enemy_hp)
		notui.enemyturn()
		
