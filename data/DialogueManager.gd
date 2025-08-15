extends Node2D

var dialogues: Array = []
var current_id := "start"
var dialog: Node = null
var sound
var speakername
var portrait: Texture
func startandload(curid: String, path: String, dialogset: Node, soundset):
	sound = soundset
	dialog = dialogset
	if dialog == null:
		push_error("Nie znaleziono CanvasLayer/dialoge")
		return

	load_dialogues(path)
	show_dialog(curid)

func load_dialogues(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Nie można otworzyć pliku dialogów: " + path)
		return
	var data := file.get_as_text()
	var json = JSON.parse_string(data)
	if typeof(json) == TYPE_ARRAY:
		dialogues = json
	else:
		push_error("Plik JSON nie zawiera tablicy!")

func get_dialog_by_id(id: String) -> Dictionary:
	for d in dialogues:
		if d.has("id") and d["id"] == id:
			return d
	return {}

func show_dialog(id: String) -> void:
	var d := get_dialog_by_id(id)
	if d.is_empty():
		print("Dialog o id ", id, " nie istnieje")
		return
	if d.has("speaker"):
		print("yey")
		speakername = d.speaker
		dialog.setname(speakername)

	current_id = id
	var text = d.get("text", "")
	if d.has("portrait") and typeof(d["portrait"]) == TYPE_STRING and d["portrait"] != "":
		print(d.portrait)
		portrait = load(d["portrait"])

	# 1) JEŚLI SĄ OPCJE
	if d.has("choices"):
		# Pokaż tekst i poczekaj tylko do końca pisania (bez zamykania okna)
		await dialog.show_dialogue(text, portrait, sound, true) # false = nie czekaj na dialogue_finished
		# Wyślij listy id "next" oraz tekstów opcji do dialogu
		var next_ids: Array = []
		var choice_texts: Array = []
		for choice in d["choices"]:
			choice_texts.append(choice.get("text", ""))
			next_ids.append(choice.get("next", ""))
			print("fni ", choice.next)
		dialog.choose(next_ids, choice_texts)
		# Czekamy na WYBÓR
		var picked_index: int = await dialog.choice_selected
		var next_id = next_ids[picked_index]
		#if next_id != TYPE_INT:
		print(next_id)
		if int(next_id) == 0:
			matchid(next_id)
			print("???")
		dialog.typing = true
		show_dialog(next_id)
		return
	await dialog.show_dialogue(text, portrait, sound, true)

	#if d.has("act"):
		#if d["act"]==
	if d.has("next"):
		if int(d.next) == 0:
			matchid(d.next)
		show_dialog(d["next"])
	#else:wa

func matchid(x):
	print("11111?")
	match x:
		"battle":get_tree().change_scene_to_packed(preload("res://scenes/battle/battle.tscn"))
		_:pass
