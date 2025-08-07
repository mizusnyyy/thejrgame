extends TextureProgressBar
@onready var hp_bar = $"."
@onready var timer = $"."
@onready var ghost_bar = $"../Ghost_bar"


func _ready():
	max_value=global.maxhealth
	ghost_bar.max_value = max_value


func _process(delta: float) -> void:
	hp_bar.value = global.health
	if ghost_bar.value > value:
		ghost_bar.value = lerp(ghost_bar.value, value, delta * 4.0)
		
		
	else:
		ghost_bar.value = value
	if abs(ghost_bar.value - value) < 1.0:
		ghost_bar.value = value
	
	
