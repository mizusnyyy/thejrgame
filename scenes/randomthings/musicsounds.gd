extends Node2D

@onready var player := $AudioStreamPlayer

func play_music(music: AudioStream):
	player.stream = music
	player.play()
