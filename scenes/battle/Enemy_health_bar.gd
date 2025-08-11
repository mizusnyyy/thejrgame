extends TextureProgressBar
@onready var ghost_bar = $"../Mana__Ghost_bar"

var textures = {
	"Mana": preload("res://assets/sprite/battle/mana_progress.png"),
}

var current_color = ""

func _ready():
	max_value = global.mana_max
	ghost_bar.max_value = max_value
	value = global.mana
	_update_style(value)

func _process(delta: float) -> void:
	# upewnij się, że value jest aktualizowane
	value = global.mana

	if ghost_bar.value > value:
		ghost_bar.value = lerp(ghost_bar.value, value, delta * 4.0)
	else:
		ghost_bar.value = value

	if abs(ghost_bar.value - value) < 1.0:
		ghost_bar.value = value

	_update_style(value)

func _update_style(mana_value: float) -> void:

	var color = ""
	color = "Mana"


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
