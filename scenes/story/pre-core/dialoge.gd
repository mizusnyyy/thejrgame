extends Control

@export var text_speed := 0.05
@onready var tempspeed := text_speed
@onready var label: RichTextLabel = $RichTextLabel
@onready var portrait := $TextureRect
@onready var choice := $choice/indicator
@onready var hand := $TextureRect/hand
@onready var grid = $opt/gc

var spd_multiply := 1.0
var just_chose := false
const pathhand := "res://assets/dialogue/hand/hand"

signal dialogue_started
signal dialogue_finished         # sygnał końca linii BEZ opcji (zamknięcie okna)
signal text_typed                # ✅ NOWY: koniec animacji pisania
signal choice_selected(index:int)# ✅ NOWY: wybrano opcję (zwraca index)
signal dialogue_done

var full_text := ""
var char_index := 0
var typing := false
var dialogue_active := false
var choosing := false
var type_sound_player: AudioStreamPlayer2D = null

func _process(_delta: float) -> void:
	label.queue_redraw()

func _ready() -> void:
	hide()
	self.modulate.a = 0.0
	label.bbcode_enabled = true
	var BounceEffect = preload("res://scenes/ui/BounceEffect.gd")
	label.install_effect(BounceEffect.new())
	set_process(true)
func delhand():
	hand.hide()
func sethand(handset):
	hand.get_child(0).texture = load(pathhand+handset+".png")
	hand.show()
	#print("is hand visible - ", hand.visible)

func setname(textset):
	$TextureRect/speaker.text = textset
func show_dialogue(
	text: String,
	portrait_texture: Texture = null,
	typesound: AudioStreamPlayer2D = null,
	wait_for_close: bool = true
) -> void:
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	Global.can_move = false
	
	Global.toggle_can_phone(false)

	full_text = text
	char_index = 0
	label.text = ""
	typing = true
	dialogue_active = true
	choice.can_choose = true
	choosing = false

	type_sound_player = typesound

	if portrait_texture:
		portrait.texture = portrait_texture
		portrait.visible = true
	else:
		portrait.visible = false
	
	showanim()
	
	emit_signal("dialogue_started")

	_type_text()
	await text_typed
	print("text typed")

	if wait_for_close:
		await dialogue_finished
		if !Global.isincutscene:
			Global.can_move = true
	else:
		return

func choose(options: Array, texts: Array):
	choosing = true
	choice.global_position = Vector2(359,309)
	show()
	choice.show()
	choice.can_choose = true
	if !Global.isincutscene:
		Global.can_move = false

	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.text = ""

	await setoptions(options, texts)

func setoptions(options: Array, texts: Array) -> void:
	var up := false
	var sceneopt = preload("res://scenes/ui/buttonopt.tscn")
	var alan: Array = []
	var whenup := options.size()/2
	print(snapped(options.size(),3)/2)
	if options.size()<=4:
		grid.columns = 2
		grid.add_theme_constant_override("h_separation", 30)
	else:
		grid.columns = snapped(options.size(),3)/2
		grid.add_theme_constant_override("h_separation", 5)
	for i in range(options.size()):
		var ins = sceneopt.instantiate()
		grid.add_child(ins)
		ins.selfid = i
		ins.settext(texts[i])
		alan.append(ins)
		ins.choice_finished.connect(func():
			emit_signal("choice_selected", ins.selfid)
		)
	var picked_index: int = await choice_selected
	just_chose = true
	var time := 0.1
	for b in alan:
		b.disappearbut(time)
	await get_tree().create_timer(time).timeout
	#_type_text()
	choosing = false
	choice.hide()
	choice.can_choose = false
	
func _type_text() -> void:
	while char_index < full_text.length() and typing:
		var letter : String = full_text[char_index]
		var spd := tempspeed * spd_multiply
		
		#TO NIE JEST KURWA SPEED TYLKO DELAY XD DEBIL MIZU
		
		match letter:
			".", "!", "?": #DUZY DELAY
				spd *= 9
			",", ";": #MALY DELAY
				spd *= 5
			"/": #ZMIENIA PREDKOSC NA WOLNIEJSZY TEKST
				letter = ""
				spd_multiply=2.0
			"\\": #ZMIENIA PREDKOSC NA SZYBSZY TEKST
				letter = ""
				spd_multiply=0.7
			"|":
				letter = ""
				spd_multiply=1.0
				
			#"(":
			#TO ZMIENIAC BEDZIE NASTEPNA LITERE NA COS (TU AKURAT NA NIC)
				#print(char_index)
				#letter=""
				#if len(full_text)>char_index:
					#letter=""
		label.append_text(letter)
		
		#label.append_text("[bounce]" + letter + "[/bounce]")
		
		char_index += 1
		if type_sound_player && letter!=" ":
			type_sound_player.pitch_scale = randf_range(0.95, 1.05)
			type_sound_player.play()
		await get_tree().create_timer(spd).timeout
	spd_multiply=1.0
	typing = false
	emit_signal("text_typed")

func showanim():
	#print("show:")
	self.visible=true
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0,1.0,1.0,1.0), 0.1)
	
func hideanim():
	#print("hide:")
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0,1.0,1.0,0.0), 0.1)
	await tween.finished
	self.visible=false

func _unhandled_input(event):
	if just_chose:
		if event.is_action_released("interact"):
			just_chose = false
		return

	if not dialogue_active or choosing:
		return

	if event.is_action_pressed("interact"):
		#print(typing)
		if typing:
			typing = false
			label.clear()
			
			#USUWANIE NIECHCIANYCH ZNAKOW Z TEKSTU
			var full_text_complete = full_text.replace("/","").replace("\\","").replace("|","")
			
			label.append_text(full_text_complete)
			
			#label.append_text("[bounce]%s[/bounce]" % full_text)
			emit_signal("text_typed")
		else:
			dialogue_active = false
			label.text = ""
			emit_signal("dialogue_finished")
