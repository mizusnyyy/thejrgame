extends CharacterBody2D

var SPEED = 150.0
const JUMP_VELOCITY = -300
var alive = true
var overlapping_button: Area2D = null
var direction_choose=0
var can_move=true
var invincible := false
var state := false
var tempspeed = SPEED
var circle
var mana_timer := 0.0
var mana_drain_rate := 0.2

@onready var haudio:=$hurt
@onready var sprite := $heart
@onready var soul:=$"."
@onready var jack:=$jack

func flash_effect():
	invincible = true
	var flash_times = 4
	if global.health == 0:
		haudio.pitch_scale = 0.5
		haudio.play()
	else:
		haudio.pitch_scale = 1.0
		haudio.play()
	for i in flash_times:
		sprite.modulate.a = 0.3
		await get_tree().create_timer(0.1).timeout
		sprite.modulate.a = 1.0
		await get_tree().create_timer(0.1).timeout
	invincible = false
func take_damage(amount, blue=false):
	if velocity.x == 0 and velocity.y == 0 and blue:
		print("bullet oh no im invicible oh no")
		pass
	else:
		if invincible:
			return
		global.health -= amount
		print("bullet taken:", amount, " → the one holding the gun:", global.health)
		flash_effect()
func soul_is_alive():
	return alive

		
func _physics_process(delta: float) -> void:
	if alive and global.current_mode == global.mode.RED:
		var directionlr := Input.get_axis("left", "right")
		var directionud := Input.get_axis("up", "down")
		var direction := Vector2(directionlr, directionud)
		
		if direction.length() > 0:
			direction = direction.normalized()
			velocity = direction * SPEED
			if abs(direction.x) > abs(direction.y):
				jack.play("leftright")
				if direction.x < 0:
					jack.flip_h = false
				else:
					jack.flip_h = true
			else:
				jack.play("frontback")
		else:
			velocity.x = move_toward(velocity.x, 0.0, SPEED)
			velocity.y = move_toward(velocity.y, 0.0, SPEED)
			jack.stop()
	
	if global.health <= 0:
		alive = false
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://scenes/battle/gg/gg.tscn")
	else:
		alive = true

	move_and_slide()
