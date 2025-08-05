extends Node2D

@onready var input_field: LineEdit = $CanvasLayer/Panel/LineEdit
@onready var output_label: RichTextLabel = $CanvasLayer/Panel/RichTextLabel
@onready var canvas_layer: CanvasLayer = $CanvasLayer
var initial_text="pablo game console™"

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
func get_var(variable):
	if has_variable(global, variable):
		var value = global.get(variable)
		output("global." + str(variable) + " = " + str(value))
	else:
		output("[color=red]no such global variable: %s[/color]" % variable)
func get_vars():
	var vars = global.get_property_list()
	var found = false	

	output("[color=light_blue]global variables:[/color]")

	for var_info in vars:
		if var_info.usage & PROPERTY_USAGE_SCRIPT_VARIABLE != 0:
			var name = var_info.name
			var value = global.get(name)
			output("- [color=white]%s[/color] = %s" % [name, str(value)])
			found = true

	if not found:
		output("[color=yellow]no global vars found lol[/color]")

func clear():
	output_label.text=initial_text

func _ready():
	canvas_layer.hide()
	input_field.text_submitted.connect(_on_text_submitted)
	register_command("goto_scene", Callable(self, "goto_scene"))
	register_command("set_var", Callable(self, "set_var"))
	register_command("get_var", Callable(self, "get_var"))
	register_command("clear",Callable(self,"clear"))
	register_command("get_vars", Callable(self, "get_vars"))
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

	output("[color=white]> " + command)

	if _try_execute_command_line(command):
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







func _try_execute_command_line(command: String) -> bool:
	var tokens = command.strip_edges().split(" ", false)
	if tokens.size() == 0:
		return false

	var cmd_name = tokens[0]
	var args = tokens.slice(1, tokens.size())

	# Automatyczne konwertowanie argumentów
	var parsed_args = []
	for arg in args:
		if arg.is_valid_float():
			parsed_args.append(arg.to_float())
		elif arg.is_valid_int():
			parsed_args.append(arg.to_int())
		elif (arg.begins_with('"') and arg.ends_with('"')) or (arg.begins_with("'") and arg.ends_with("'")):
			parsed_args.append(arg.substr(1, arg.length() - 2))
		else:
			parsed_args.append(arg)

	if custom_commands.has(cmd_name):
		custom_commands[cmd_name].callv(parsed_args)
		return true

	return false



func has_variable(obj: Object, name: String) -> bool:
	for prop in obj.get_property_list():
		if prop.name == name:
			return true
	return false
