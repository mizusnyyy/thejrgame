extends Control


class Body_part:
	var name: String
	var max_health: int
	var current_health: int
	
	func _init(part_name: String, max_health: int):
		name = part_name
		self.max_health = max_health
		self.current_health = max_health
	
var body_parts: Dictionary = {}

var color_health = Color.GREEN
var color_demaged = Color.YELLOW
var color_critical = Color.RED

func _ready():
	setup_health_system()
	create_ui()
	for key in body_parts:
		var part = body_parts[key]
		print("Część: ", key, " -> Nazwa: ", part.name, " HP: ", part.current_health, "/", part.max_health)

func setup_health_system():
	body_parts["Head"] = Body_part.new("Head", 20) 
	body_parts["Torso"] = Body_part.new("Torso", 40) 
	body_parts["R_arm"] = Body_part.new("R_arm", 10) 
	body_parts["L_arm"] = Body_part.new("L_arm", 10) 
	body_parts["R_leg"] = Body_part.new("R_leg", 10) 
	body_parts["L_leg"] = Body_part.new("L_leg", 10) 
	

func create_ui():
	var main_vbox = VBoxContainer.new()
	add_child(main_vbox)
	
	var body_container = Control.new()
	body_container.custom_minimum_size = Vector2(400, 500)
	main_vbox.add_child(body_container)
	
	create_body_part_ui(body_container, "head", Vector2(200, 50), Vector2(150, 30))
	create_body_part_ui(body_container, "torso", Vector2(175, 150), Vector2(200, 30))
	create_body_part_ui(body_container, "left_arm", Vector2(50, 120), Vector2(120, 25))
	create_body_part_ui(body_container, "right_arm", Vector2(380, 120), Vector2(120, 25))
	create_body_part_ui(body_container, "left_leg", Vector2(150, 350), Vector2(120, 25))
	create_body_part_ui(body_container, "right_leg", Vector2(280, 350), Vector2(120, 25))
	create_control_panel(main_vbox)

func create_body_part_ui(parent: Control, part_name: String, position: Vector2, size: Vector2):
	var body_parts = body_parts[name]
	var part_container = VBoxContainer.new()
	part_container.position = position
	part_container.size = size
	parent.add_child(part_container)
	
func create_control_panel(parent: VBoxContainer):
	var panel = VBoxContainer.new()
	parent.add_child(panel)
	
	var panel_title = Label.new()
	panel_title.text = "PANEL KONTROLNY"
	panel_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	panel_title.add_theme_font_size_override("font_size", 16)
	panel.add_child(panel_title)
	


	
	


	
	
	
