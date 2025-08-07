extends TextureProgressBar

@onready var ghost_bar = $"../Ghost_bar"

var textures = {
	"green": preload("res://.godot/imported/progress.png-83c80b1a071770e2a7ba66b36f1a0061.ctex"),
	"yellow": preload("res://.godot/imported/progress_yellow.png-fe0001ac89fb3fa3376c6aad50f7730c.ctex"),
	"red": preload("res://.godot/imported/progress_red.png-e7d64faca0641d6a02053492163b3f96.ctex"),
}

var current_color = ""

func _ready():
	max_value = global.maxhealth
	ghost_bar.max_value = max_value
	value = global.health
	_update_style(value)

func _process(delta: float) -> void:
	# upewnij się, że value jest aktualizowane
	value = global.health

	if ghost_bar.value > value:
		ghost_bar.value = lerp(ghost_bar.value, value, delta * 4.0)
	else:
		ghost_bar.value = value

	if abs(ghost_bar.value - value) < 1.0:
		ghost_bar.value = value

	_update_style(value)

func _update_style(health_value: float) -> void:

	var color = ""
	# proste, czytelne progi
	if health_value > 50:
		color = "green"
	elif health_value > 30:
		color = "yellow"
	else:
		color = "red"

	# jeszcze debug — który kolor wybrano

	# zabezpieczenie: sprawdź czy tekstura istnieje
	if not textures.has(color) or textures[color] == null:
		push_error("Brakuje tekstury dla koloru: " + color)
		return

	# jeśli inny kolor niż był — przypisz teksturę
	if color != current_color:
		# opcjonalnie: wyczyść i ustaw ponownie, żeby wymusić refresh
		texture_progress = null
		texture_progress = textures[color]
		current_color = color
		printt("texture_progress changed to:", color)
