extends CharacterBody2D

var SPEED = 150.0
const JUMP_VELOCITY = -300
var alive = true
var overlapping_button: Area2D = null
var direction_choose=0
var can_move=true
@onready var sprite=$Sprite2D
@onready var haudio=$hurt
var invincible := false
var state := false
var tempspeed = SPEED
@onready var soul=$"."
@onready var soulsande=load("res://scenes/battle/heartsande.tscn")
@onready var buttons = [
	get_node("../notui/fight"),
	get_node("../notui/act"),
	get_node("../notui/item"),
	get_node("../notui/mercy"),
	get_node("../notui/spell"),
	get_node("../notui/defend")
]
@onready var topbuttons = [
	get_node("../notui/left arrow"),
	get_node("../notui/right arrow")
]

var current_index := 0
var current_top_index := 0
var top=false
var heart

func update_soul_position():
	soul.global_position = buttons[current_index].global_position

func update_top_soul_position():
	soul.global_position = topbuttons[current_top_index].global_position

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
	
func toggle():
	state = !state
	print("Nowy stan:", state)
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("changeheart"):
		toggle()
		if state:
			tempspeed = SPEED
			Engine.time_scale = 0.5
			SPEED = SPEED/Engine.time_scale
			while state:
				if not is_inside_tree():
					return
				var instance = soulsande.instantiate()
				get_parent().get_parent().add_child(instance)
				instance.global_position = sprite.global_position
				await get_tree().process_frame
		else:
			Engine.time_scale = 1.0
			SPEED = tempspeed
	if alive and global.current_mode == global.mode.RED:
		var directionlr := Input.get_axis("left", "right")
		var directionud := Input.get_axis("up", "down")
		var direction := Vector2(directionlr, directionud)
		if direction.length() > 0:
			direction = direction.normalized()
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0.0, SPEED)
			velocity.y = move_toward(velocity.y, 0.0, SPEED)
	
	if alive and global.current_mode == global.mode.BLUE:
		sprite.play("blue")
		if not is_on_floor():
			velocity += get_gravity() * delta
		if Input.is_action_pressed("up") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if global.health <= 0:
		alive = false
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://scenes/battle/gg/gg.tscn")
	else:
		alive = true

	move_and_slide()

		
