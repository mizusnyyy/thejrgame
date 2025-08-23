extends Node2D
@onready var midscreen := get_viewport().get_visible_rect().size / 2
@onready var bg = $colfull/bg
@onready var walls:=[ #left, right, top, down
	$colfull/lcol,
	$colfull/rcol,
	$colfull/tcol,
	$colfull/dcol
]
func setall(x,y,posx,posy,posb:Vector2):
	posset(posx,posy,posb)
	sizeset(x,y)

func sizeset(x:float,y:float):
	bg.size = Vector2(x+1,y+1)
	bg.position = Vector2(-x/2-0.5,-y/2-0.5)
	for i in len(walls):
		var wall=walls[i]
		var temp:=[y,-y/2]
		match i:
			0:
				walls[i].position.x = -((x+4)/2)
			1:
				walls[i].position.x = (x+4)/2
			2:
				walls[i].position.y = -((y+4)/2)
				temp = [x,-x/2]
			3:
				walls[i].position.y = (y+4)/2
				temp = [x,-x/2]
		wall.shape.size.x = temp[0]
		wall.get_child(0).size.x = temp[0]
		wall.get_child(0).position.x = temp[1]
		if true:
			#var getposwall = wall.getposition
			var corner_tex := preload("res://assets/sprite/battle/box/boxcorner.png")
			var corner := TextureRect.new()
			corner.texture = corner_tex
			$colfull.add_child(corner)
			corner.size = Vector2(8,8)
			var tempx := x/2
			var tempy := y/2
			match i:
					0:
						corner.position=Vector2(-tempx-5,-tempy-5)
					1:
						corner.position=Vector2(tempx+5,-tempy-5)
						corner.rotation_degrees=90
					2:
						corner.position=Vector2(tempx+5,tempy+5)
						corner.rotation_degrees=180
					3:
						corner.position=Vector2(-tempx-5,tempy+5)
						corner.rotation_degrees=270
	
func posset(posx:float,posy:float,posb:Vector2):
	if posb.x!=-500:
		var temp := Vector2(midscreen.x + posx,midscreen.y + posy)
		var tween := create_tween()
		print("btw -> ",posb)
		#if posx>=posb.x:
		if temp.x>=posb.x:
			global_position=Vector2(midscreen.x + posx+122,midscreen.y + posy)
		else:
			global_position=Vector2(midscreen.x + posx-122,midscreen.y + posy)
		#else:
			#if posy>=posb.y:
				#global_position=Vector2(midscreen.x + posx-122,midscreen.y + posy)
			#else:
				#global_position=Vector2(midscreen.x + posx+122,midscreen.y + posy)
		self.modulate.a = 0.0
		tween.set_parallel(true)
		tween.tween_property(self, "modulate:a", 1.0, 0.4).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self,"global_position",temp,1.4)
		await tween.finished
		return
	global_position.x=midscreen.x + posx
	global_position.y=midscreen.y + posy
