extends Node2D

@onready var input_field: LineEdit = $CanvasLayer/Panel/LineEdit
@onready var output_label: RichTextLabel = $CanvasLayer/Panel/RichTextLabel
@onready var canvas_layer: CanvasLayer = $CanvasLayer

var expression = Expression.new()
var custom_commands = {}
func goto_scene(path: String):
	get_tree().change_scene_to_file(path)
func set_var(variable, value):
	if has_variable(global, variable):
		global.set(variable, value)
		output("global." + str(variable) + " = " + str(value))
	else:
		output("[color=red]no such global variable: %s[/color]" % variable)

func _ready():
	canvas_layer.hide()
	input_field.text_submitted.connect(_on_text_submitted)
	register_command("goto_scene", Callable(self, "goto_scene"))
	register_command("set_var", Callable(self, "set_var"))
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("console"):
		if canvas_layer.visible==true:
			canvas_layer.hide()
		else:
			canvas_layer.show()





func register_command(name: String, callback: Callable):
	custom_commands[name] = callback
func output(text: String):
	output_label.append_text(text + "\n")

func _on_text_submitted(command: String):
	input_field.clear()

	if command.strip_edges() == "":
		return

	output("[color=white]> " + "[color=white]" + command)

	if _try_execute_custom_command(command):
		return

	var error = expression.parse(command)
	if error != OK:
		output("[color=red]error bro: %s[/color]" % expression.get_error_text())
		return

	var result = expression.execute()
	if expression.has_execute_failed():
		output("[color=red]no command bro[/color]")
	else:
		output(str(result))






func _try_execute_custom_command(command: String) -> bool:
	command = command.strip_edges()
	if command.find("(") == -1 or not command.ends_with(")"):
		return false

	var cmd_name = command.substr(0, command.find("(")).strip_edges()
	var args_string = command.substr(command.find("(") + 1, command.length() - command.find("(") - 2)

	if not custom_commands.has(cmd_name):
		return false

	var raw_args = args_string.split(",", false)
	var args = []

	for arg in raw_args:
		arg = arg.strip_edges()
		if arg.begins_with("\"") and arg.ends_with("\""):
			args.append(arg.substr(1, arg.length() - 2))
		elif arg.is_valid_float():
			args.append(arg.to_float())
		elif arg.is_valid_int():
			args.append(arg.to_int())
		else:
			args.append(arg)

	custom_commands[cmd_name].callv(args)
	return true



func has_variable(obj: Object, name: String) -> bool:
	for prop in obj.get_property_list():
		if prop.name == name:
			return true
	return false
