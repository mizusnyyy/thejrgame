extends Node2D

@onready var parts = [
	$enemy_face,$enemy_hair,$enemy_torso,$enemy_hand_r,$enemy_hand_l,$enemy_down
]
var part_names = ["face", "hair", "torso", "hand_r", "hand_l", "down"]
var started = false
var temp

func _process(delta):
	temp = parts[0].global_position
	parts[0].global_position += Vector2(randf()*8,randf()*8)
	await get_tree().process_frame
	parts[0].global_position = temp
	if global.swing:
		global.swing=false
		swinghand()
	
func changesprite(enemid):
	match enemid:
		0:
			forparts("shadow")
		1:
			forparts("shadow")
		2:
			forparts("shadow")
		_:
			forparts("shadow")
func forparts(name):
	for index in range(len(parts)):
		var whichpart = part_names[index]
		parts[index].texture = load(
		"res://assets/sprite/characters/%s/enemypart/%s_%s.png" % [name, name, whichpart]
		)

func swinghand():
	var speed = 270.0  # stopni na sekundę
	var target_up = 48.0
	var target_down = -88.0
	var delta = 0.0
	started = true

	# Swing up
	while parts[3].rotation_degrees < target_up:
		delta = get_process_delta_time()
		parts[3].rotation_degrees += speed * delta/2
		await get_tree().process_frame
	# Mała przerwa
	await get_tree().create_timer(0.4).timeout

	# Swing down
	while parts[3].rotation_degrees > target_down:
		delta = get_process_delta_time()
		parts[3].rotation_degrees -= speed * delta*1.5
		await get_tree().process_frame
	# Mała przerwa
	await get_tree().create_timer(0.2).timeout

	# Powrót do pozycji startowej (0 stopni)
	while parts[3].rotation_degrees < 0:
		delta = get_process_delta_time()
		parts[3].rotation_degrees += speed * delta
		await get_tree().process_frame

	parts[3].rotation_degrees = 0
	started = false

func swingboth():
	var speed = 270.0  # stopni na sekundę
	var target_up = 48.0
	var target_down = -88.0
	var delta = 0.0
	started = true

	# Swing up
	while parts[3].rotation_degrees < target_up:
		delta = get_process_delta_time()
		parts[3].rotation_degrees += speed * delta/2
		parts[4].rotation_degrees += speed * delta/2
		await get_tree().process_frame
	# Mała przerwa
	await get_tree().create_timer(2).timeout

	# Swing down
	while parts[3].rotation_degrees > target_down:
		delta = get_process_delta_time()
		parts[3].rotation_degrees -= speed * delta*1.5
		parts[4].rotation_degrees += speed * delta*1.5
		await get_tree().process_frame
	# Mała przerwa
	await get_tree().create_timer(0.2).timeout

	# Powrót do pozycji startowej (0 stopni)
	while parts[3].rotation_degrees < 0:
		delta = get_process_delta_time()
		parts[3].rotation_degrees += speed * delta
		parts[4].rotation_degrees += speed * delta
		await get_tree().process_frame

	parts[3].rotation_degrees = 0
	parts[4].rotation_degrees = 0
	started = false
