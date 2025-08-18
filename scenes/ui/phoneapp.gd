extends Control
@onready var txt=$txt

func _on_appshape_body_entered(body: Node2D) -> void:
	if body.name=="indicator":
		txt.modulate=Color(0.6,0.6,0.6,1)

func _on_appshape_body_exited(body: Node2D) -> void:
	if body.name=="indicator":
		txt.modulate=Color(1,1,1,1)

func setphoto(x):
	txt.texture = load("res://assets/ui/apps/"+x+".png")
<<<<<<< Updated upstream
	#print(txt.texture, "y =?", y)
=======
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact")&&caninteract:
		if app == "Junior Music":
			var y = load("res://scenes/ui/Junior Music.tscn")
			var pum = y.instantiate()
			get_node("../../../../../apps").add_child(pum)
>>>>>>> Stashed changes
