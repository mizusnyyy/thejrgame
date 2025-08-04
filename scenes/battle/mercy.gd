extends Area2D

@onready var anim = $mercy
@onready var battle = $"../.."
@onready var notui = $".." 

var selected = false

func _on_body_entered(body: Node2D) -> void:
	anim.play("select")
	selected = true


func _on_body_exited(body: Node2D) -> void:
	anim.play("default")
	selected = false
	
func _process(delta: float) -> void:
	if selected and visible and Input.is_action_just_pressed("interact"):
		selected = false
		battle.mercy += 10
		print(battle.mercy)
		notui.enemyturn()
