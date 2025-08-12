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
		"res://assets/sprite/characters/party/%s/enemypart/%s_%s.png" % [name, name, whichpart]
		)

func swinghand():
	started = true
	while parts[3].rotation_degrees < 48:
		parts[3].rotation_degrees += 1.5
		await get_tree().create_timer(0.005 * get_process_delta_time()).timeout
	
	await get_tree().create_timer(60 * get_process_delta_time()).timeout
	
	while parts[3].rotation_degrees > -88:
		parts[3].rotation_degrees -= 1.5
		await get_tree().create_timer(0.002 * get_process_delta_time()).timeout
	
	await get_tree().create_timer(15 * get_process_delta_time()).timeout
	print(2 * get_process_delta_time())
	
	while parts[3].rotation_degrees < 0:
		parts[3].rotation_degrees += 1.5
		await get_tree().create_timer(0.008 * get_process_delta_time()).timeout
	
	parts[3].rotation_degrees = 0
	started = false
