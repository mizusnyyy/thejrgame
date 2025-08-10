extends Node2D

@onready var blok1: Node2D = $Blok1
@onready var blok2: Node2D = $Blok2

@export var gap: int = 30
@export var max_total_width: int = 128  # max suma szerokości bloków

func summoned(soul, speed):
	var vp = get_viewport().get_visible_rect()
	var midscreen_y = vp.size.y / 2.0

	var min_width = 10
	var max_width = max_total_width - gap - min_width

	var width1 = 0
	var width2 = 0

	while true:
		width1 = randi() % (max_width - min_width + 1) + min_width
		width2 = randi() % (max_width - min_width + 1) + min_width
		if width1 + width2 + gap <= max_total_width:
			break

	var rect1: ColorRect = blok1.get_node("ColorRect")
	var rect2: ColorRect = blok2.get_node("ColorRect")

	# ustawiamy wylosowane szerokości
	rect1.size = Vector2(width1, rect1.size.y)
	rect2.size = Vector2(width2, rect2.size.y)

	# pozycje bloków niezmienione
	blok1.position.x = 384
	blok1.position.y = 256
	blok2.position.x = 256
	blok2.position.y = 256

	# ustawienie środka dla prostokątów
	rect1.position = Vector2(-rect1.size.x, -rect1.size.y * 0.5)
	rect2.position = Vector2(0, -rect2.size.y * 0.5)

	blok1.call_deferred("activate", soul, speed)
	blok2.call_deferred("activate", soul, speed)
