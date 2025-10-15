extends Node2D
enum state { PLAYER_TURN, ENEMY_TURN, WAITING }
enum mode { RED,BLUE }
var current_state := state.PLAYER_TURN
var current_mode := mode.RED
var battleenem
var tp := 0
var mana := 0.0
var mana_max := 100.0
var have_hearts := [] #0 jack, 1 mizu, 2 shadoSw, 3 Pavey, 4 Igreavious, 5 bugzie
var enemy_hp := 100.0
var maxenemy_hp := 100.0
var health := 100.0
var maxhealth := 100.0
var can_move := true
var mercy:=0
var photoid := 0
var playit := false
var swing := false
var items:=[""]
var inventory: Array[Item] = []
var phoneapps: Array[String]

var new_scene_player_pos : Vector2

var can_phone := true

func glapps(app:Array[String]):
	for i in len(app):
		phoneapps.append(app[i])

func add_item(item: Item):
	inventory.append(item)

func remove_item(item: Item):
	inventory.erase(item)

func use_item(index: int, target):
	var item = inventory[index]
	if item.heal_amount > 0:
		Global.health=min(Global.health+item.heal_amount,Global.maxhealth)
	if item.is_consumable:
		inventory.remove_at(index)

func take_screenshot():
	pass
	#var image: Image = get_viewport().get_texture().get_image()
	#photoid+=1
	#var path = "user://screens/alangooner" + str(photoid) + ".png"
#
	#var dir = DirAccess.open("user://")
	#if not dir.dir_exists("screens"):
		#dir.make_dir("screens")
#
	#var err = image.save_png(path)

func soultakedamage(body, dmg):
		body.take_damage(dmg)
