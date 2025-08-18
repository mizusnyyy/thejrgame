extends Node2D

var dialogue_list = {}
const dialogue_json_pth = "res://data/dialogue.json"
const dlg_e = preload("res://data/dlg_enum.gd").dg # enum with all of dialogue
const sprite_directory = "res://assets/sprite/characters/"
var dialog: Node = null
var sound
var speakername
var portrait: Texture

func _ready() -> void:
	load_dialogues()

func load_dialogues() -> void:
	var file = FileAccess.open(dialogue_json_pth, FileAccess.READ)
	if file:
		file = JSON.parse_string(file.get_as_text())
		for entry in file:
			var id_enum = dlg_e[entry.id]
			var next_enum
			if(typeof(entry.next) != TYPE_ARRAY and entry.next!= null):
				next_enum = dlg_e[entry.next]
			else:
				next_enum = entry.next
			dialogue_list[id_enum] = Dialogue_node.new( 
				entry.text,
				next_enum,
				entry.speaker,
				entry.portrait
			)
	else:
			push_error("Nie udało się otworzyć pliku dialogów : " + dialogue_json_pth)


func begin_dialogue(character: String, dialogset: Node, soundset):
	sound = soundset
	print(character)
	
	dialog = dialogset
	if dialog == null:
		push_error("Nie znaleziono CanvasLayer/dialoge")
		return
	show_dialog(character+"_start")


func show_dialog(id) -> void:
	
	var d = dialogue_list[dlg_e[id]]
	if d.speaker!=null:
		print("yey")
		speakername = d.speaker
		dialog.setname(speakername)
	if d.portrait!=null:
		print(d.portrait)
		portrait = load(sprite_directory+d.portrait+".png")

	# 1) Jeśli next to array (opcje)
	if typeof(d.next) == TYPE_ARRAY:
		# Pokaż tekst i poczekaj tylko do końca pisania (bez zamykania okna)
		await dialog.show_dialogue(d.text, portrait, sound, true) # false = nie czekaj na dialogue_finished
		# Wyślij listy id "next" oraz tekstów opcji do dialogu
		var next_ids: Array = []
		var choice_texts: Array = []
		for choice in d.next:
			choice_texts.append(choice.get("text", ""))
			next_ids.append(choice.get("next", ""))
			print("fni ", choice.next)
		dialog.choose(next_ids, choice_texts)
		# Czekamy na WYBÓR
		var picked_index: int = await dialog.choice_selected
		var next_id = next_ids[picked_index]
		#if next_id != TYPE_INT:
		print(next_id)
		if next_id:
			print("11111?")
			get_tree().change_scene_to_packed(preload("res://scenes/battle/battle.tscn"))
			print("???")
		dialog.typing = true
		show_dialog(next_id)
		return
	await dialog.show_dialogue(d.text, portrait, sound, true)

	if d.next!=null:
		if d.next=="battle":
			print("11111?")
			get_tree().change_scene_to_packed(preload("res://scenes/battle/battle.tscn"))
		show_dialog(d.next)
