extends Area2D

@onready var anim = $defend
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
	if selected and visible and Input.is_action_just_pressed("interact") and Global.current_state==Global.state.PLAYER_TURN:
		selected = false
		print("Wybrałeś defensa, chuja się dzieję")
		if notui and notui.has_method("enemyturn"):
			notui.enemyturn()
