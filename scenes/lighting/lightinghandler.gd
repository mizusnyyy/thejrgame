extends Node2D

#lighting
var time=0.0 #godzina
var time_flow:=true
var time_speed:= 12.0 #ile godzin na sekunde
var day=24
var dawncolor :Color= Color(254.0/255.0, 174.0/255.0, 0.0/255.0)      # złocisty wschód słońca
var daycolor :Color= Color(109.0/255.0, 149.0/255.0, 226.0/255.0)  # niebieski dzień
var nightcolor :Color= Color(0.0/255.0, 26.0/255.0, 51.0/255.0)       # ciemny nocny

func _process(delta: float) -> void:
	if time_flow:
		time += delta * time_speed
	if time >= day:
		time -= day
		#print("day passed")
