extends Node2D

@export var gloo_scene: PackedScene
@onready var soul = $"../soul"

var instance: Node2D
var size: int = 10
var savepos: float = 0.0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug.bone"):
		# Restart instancji, jeśli już istnieje
		if instance != null:
			instance.queue_free()
		
		instance = gloo_scene.instantiate()
		add_child(instance)
		instance.summoned(instance, soul, 0, true, size, 570)

	if Input.is_action_pressed("debug.bone.y.up") and instance:
		instance.global_position.y -= 1

	if Input.is_action_pressed("debug.bone.y.down") and instance:
		instance.global_position.y += 1

	if Input.is_action_just_pressed("debug.bone.size.up") and instance:
		size += 1
		savingpos()

	if Input.is_action_just_pressed("debug.bone.size.down") and instance:
		if size > 1:
			size -= 1
			savingpos()
	if Input.is_action_just_pressed("debug.bone.checkpos") and instance:
		print(size, " size --- position ", instance.global_position.y)
		

func savingpos() -> void:
	if instance == null:
		return
	
	savepos = instance.global_position.y + (7 * size)
	instance.queue_free()
	makenew(savepos)

func makenew(pos: float) -> void:
	instance = gloo_scene.instantiate()
	add_child(instance)
	instance.summoned(instance, soul, 0, true, size, pos)

func _on_debug_ready() -> void:
	print("-----------------------")
	print("l-create bone(del previous). p-check stats. i-pos.y up. k-pos.y down. u-size up. j-size down.")
	print("-----------------------")
