extends Node2D

#lighting
var time=0.0 #godzina
var time_flow:=true
var time_speed:= 12.0 #ile godzin na sekunde
var day=24
var dawncolor = Color(254/255, 174/255, 0/255)      # złocisty wschód słońca
var daycolor = Color(109/255, 149/255, 226/255)  # niebieski dzień
var nightcolor = Color(0/255, 26/255, 51/255)       # ciemny nocny

func _process(delta: float) -> void:
	if time_flow:
		time += delta * time_speed
	if time >= day:
		time -= day
		#print("day passed")
