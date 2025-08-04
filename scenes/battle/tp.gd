extends TextureProgressBar
@onready var number = $number

func _process(delta: float) -> void:
	if player.health > 100:
		player.health = 100
	self.value=player.health
	number.text=str(player.health," HP")
