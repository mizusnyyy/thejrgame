extends Area2D
var inbody := false
var lvl1 := 1
var lvl2 := 1
@export var tp_pos: Vector2
@export var ishorizontal : bool = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		inbody = true
		openclose(true,$door1,lvl1)
		openclose(true,$door2,lvl2)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		inbody = false
		openclose(false,$door1,lvl1)
		openclose(false,$door2,lvl2)

func openclose(open: bool,body:Sprite2D,lvl: int):
	if open:
		while lvl<6 && inbody:
			body.region_rect.position.x+=16
			body.region_rect.position.x = clampi(body.region_rect.position.x,0,80)
			lvl+=1
			if body == $door1:
				lvl1=lvl
			else:
				lvl2=lvl
			await get_tree().create_timer(0.07).timeout
	else:
		if lvl>4:
			body.region_rect.position.x=48
			lvl=4
		while lvl>1 && !inbody:
			body.region_rect.position.x-=16
			body.region_rect.position.x = clampi(body.region_rect.position.x,0,80)
			lvl-=1
			if body == $door1:
				lvl1=lvl
			else:
				lvl2=lvl
			await get_tree().create_timer(0.11).timeout
