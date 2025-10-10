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
					Global.add_item(item)
			file_name = dir.get_next()

	for item in Global.inventory:
		print(item.name, " < name healamount > ", item.heal_amount)
