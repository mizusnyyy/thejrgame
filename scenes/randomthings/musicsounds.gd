extends Node2D
var musicvolume:=-24
var soundvolume:=-18
@onready var musicstream := $music
@onready var soundstream := $sound

func _ready() -> void:
	musicstream.volume_db = musicvolume
	soundstream.volume_db = soundvolume

func play_music(music: AudioStream):
	musicstream.stream = music
	musicstream.play()
func play_sound(sound: AudioStream):
	soundstream.stream = sound
	soundstream.play()
