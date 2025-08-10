extends Label

var original_scale := Vector2.ONE
var shown_text := "dying is gay son!! press enter son!!!"
var text_speed := 0.05
var typing := false

func play_text(text: String) -> void:
	self.text = ""
	typing = true
	for i in text.length():
		if not typing:
			break
		var char := text[i]
		self.text += char
		await get_tree().create_timer(text_speed).timeout
	typing = false

func _ready() -> void:
	play_text(shown_text)
	original_scale = scale
	loadscreens()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://scenes/story/pre-core/house.tscn")
		global.health += 100
		global.enemy_hp = 100

func loadscreens():
	var texture_rects = [
		$"../../TextureRect",
		$"../../TextureRect2",
		$"../../TextureRect3",
		$"../../TextureRect4"
	]
	
	for i in texture_rects.size():
		var path = "user://screens/alangooner" + str(i + 1) + ".png"
		if FileAccess.file_exists(path):
			var img = Image.load_from_file(path)
			img.resize(300, 200, Image.INTERPOLATE_LANCZOS)
			var tex = ImageTexture.create_from_image(img)
			texture_rects[i].texture = tex
