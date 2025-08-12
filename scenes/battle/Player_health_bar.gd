extends TextureProgressBar

@onready var ghost_bar = $"../Player_Ghost_bar"

var textures = {
	"green": preload("res://assets/sprite/battle/progress.png"),
	"yellow": preload("res://assets/sprite/battle/progress_yellow.png"),
	"red": preload("res://assets/sprite/battle/HP_progress_red.png"),
}

var current_color = ""

func _ready():
	max_value = global.maxhealth
	ghost_bar.max_value = max_value
	value = global.health
	_update_style(value)

func _process(delta: float) -> void:
	value = global.health

	if ghost_bar.value > value:
		ghost_bar.value = lerp(ghost_bar.value, value, delta * 4.0)
	else:
		ghost_bar.value = value

	if abs(ghost_bar.value - value) < 1.0:
		ghost_bar.value = value
	

	

func _update_style(health_value: float) -> void:

	var color = ""
	if health_value > 50:
		color = "green"
	elif health_value > 30:
		color = "yellow"
	else:
		color = "red"
	if color != current_color:
		texture_progress = null
		texture_progress = textures[color]
		current_color = color
		printt("texture_progress changed to:", color)
