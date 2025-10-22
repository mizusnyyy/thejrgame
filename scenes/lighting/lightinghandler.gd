extends Node2D

#lighting
var time=0.0 #godzina
var time_flow:=true
var time_speed:= 12.0 #ile godzin na sekunde
var day=24
var dawncolor=Color(1,7,0)
var normalcolor=Color(0.5,0.6,0.9)

func _process(delta: float) -> void:
	if time_flow:
		time += delta * time_speed
	if time >= day:
		time -= day
		print("day passed")
