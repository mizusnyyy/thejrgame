extends Node2D
var musicvolume:=-12
var soundvolume:=-6
@onready var musicstream := $music
@onready var soundstream := $sound

func play_music(music: AudioStream):
	musicstream.stream = music
	musicstream.volume_db=musicvolume
	musicstream.play()
func play_sound(sound: AudioStream):
	soundstream.stream = sound
	soundstream.volume_db = soundvolume
	soundstream.play()
