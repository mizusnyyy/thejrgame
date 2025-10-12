extends Node2D
var musicvolume:=-12
var soundvolume:=-6
@onready var musicstream := $music
@onready var soundstream := $sound

func play_music(music: AudioStream):
	if musicstream.playing:
		var tween := create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(musicstream,"volume_db",-80,1)
		await tween.finished
	musicstream.stream = music
	musicstream.volume_db=musicvolume
	musicstream.stream.loop=true
	musicstream.play()
func play_sound(sound: AudioStream):
	soundstream.stream = sound
	soundstream.volume_db = soundvolume
	soundstream.play()
