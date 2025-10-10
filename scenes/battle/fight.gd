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
	if selected and Global.current_state == Global.state.PLAYER_TURN and Input.is_action_just_pressed("interact") and visible:
		selected = false

		dmg.global_position = Vector2(randf_range(224, 416), randf_range(64, 128))
		if dmg.global_position.x > 640:
			dmg.global_rotation = randf_range(0, -0.5)
		else:
			dmg.global_rotation = randf_range(0, 0.5)
		dmg.play()
		audio.play()
		deal_damage(10) 
		await dmg.animation_finished
		print("the very evil enemy: ", Global.enemy_hp)
		notui.enemyturn()

func deal_damage(amount: float) -> void:
	Global.enemy_hp -= amount
	Global.mana += 10
	if Global.enemy_hp <= 0:
		Global.enemy_hp = 0
		call_deferred("_back_to_house")

func _back_to_house() -> void:
	await get_tree().process_frame
	var can_move = true
	get_tree().change_scene_to_file("res://scenes/story/pre-core/house.tscn")
