extends Node2D

var dialogue_list := {}
const dialogue_json_pth := "res://data/dialogue.json"
const dlg_e := preload("res://data/dialogue_enum.gd").dg # enum with all of dialogue
const sprite_directory := "res://assets/sprite/characters/"
var dialog: Node = null
var sound
var speakername:String
var hand:String
var portrait: Texture
var temp := false
signal dialogue_done

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
				entry.portrait,
				entry.hand
			)
	else:
			push_error("Nie udało się otworzyć pliku dialogów : " + dialogue_json_pth)

func begin_dialogue(character: String, dialogset: Node, soundset):
	sound = soundset	
	dialog = dialogset
	if dialog == null:
		push_error("Nie znaleziono CanvasLayer/dialoge")
		return
	show_dialog(dlg_e[character+"_start"])

func show_dialog(id) -> void:
	
	var d = dialogue_list[id]
	if d.hand!=null:
		temp = true
		hand = d.hand
		dialog.sethand(hand)
	elif temp:
		dialog.delhand()
		temp = false
	if d.speaker!=null:
		speakername = d.speaker
		dialog.setname(speakername)
	if d.portrait!=null:
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
			#print("wybór: ", choice.next)
		dialog.choose(next_ids, choice_texts)
		# Czekamy na WYBÓR
		var picked_index: int = await dialog.choice_selected
		var next_id = next_ids[picked_index]
		if typeof(d.next) == TYPE_INT and d.next == dlg_e.battle:
			get_tree().change_scene_to_packed(preload("res://scenes/tempbattle/battle.tscn"))
		dialog.typing = true
		show_dialog(dlg_e[next_id])
		return
	await dialog.show_dialogue(d.text, portrait, sound, true)

	if d.next!=null:
		if typeof(d.next) == TYPE_INT and d.next == dlg_e.battle:
			get_tree().change_scene_to_packed(preload("res://scenes/tempbattle/battle.tscn"))
		else:
			show_dialog(d.next)
	else:
		global.can_phone = true
		await get_tree().create_timer(0.1).timeout
		emit_signal("dialogue_done")
