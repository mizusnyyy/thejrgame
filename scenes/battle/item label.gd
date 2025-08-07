extends RichTextLabel

@onready var notui = $"../../.."
@onready var label = $"."  # niepotrzebne, można używać self
@onready var button = $"."

func _ready():
	visible=false
	var dir = DirAccess.open("res://scenes/items")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var item = load("res://scenes/items/" + file_name)  # <--- poprawka tutaj
				if item != null:
					global.add_item(item)
			file_name = dir.get_next()

	for item in global.inventory:
		print(item.name, " - ", item.heal_amount)

func _process(delta: float) -> void:
	var text = ""
	for item in global.inventory:
		text += item.name + "\n"
		label.text=text
