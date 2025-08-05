extends Node2D
enum state { PLAYER_TURN, ENEMY_TURN, WAITING }
enum mode { RED,BLUE }
var current_state = state.PLAYER_TURN
var current_mode = mode.BLUE
var battleenem
var tp = 0
var enemy_hp = 100.0
var health := 100.0
var can_move = true
var mercy=0
var photoid = 0
var playit = false
func take_screenshot():
	var image: Image = get_viewport().get_texture().get_image()
	photoid+=1
	var path = "user://screens/alangooner" + str(photoid) + ".png"

	var dir = DirAccess.open("user://")
	if not dir.dir_exists("screens"):
		dir.make_dir("screens")
		
	var err = image.save_png(path)
	#print("ZAPIS SCREENA DO:", path, " | SUKCES:", err == OK)
