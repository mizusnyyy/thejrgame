extends Node2D

@onready var player = $AudioStreamPlayer2D

func play_music(music: AudioStream):
	player.stream = music
	player.play()
