extends Node2D

var inanim := false
var dir := "res://assets/ui/pausemenu/animopenclose/"

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		if inanim: return
		
		var tween := create_tween()
		tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		inanim=true
		if self.visible:
			animmenu(false)
			tween.tween_property(self, "position", Vector2(0.0, 380.0),1.3)
			await tween.finished
			hide()
		else:
			$Bookanim.texture = load("res://assets/ui/pausemenu/bookanim.png")
			show()
			tween.tween_property(self, "position", Vector2(0.0, 0.0),1.3)
			await tween.finished
			animmenu(true)
			await get_tree().create_timer(1.0).timeout
		inanim=false

func animmenu(open:bool=true):
	if open:
		#$Handanim.hide()
		for i in range(9):
			i+=1
			var str : String = dir+str(i)+".png"
			$Bookanim.texture = load(str)
			await get_tree().create_timer(0.1).timeout
	else:
		for i in range(9):
			i+=1
			var str : String = dir+str(10-i)+".png"
			$Bookanim.texture = load(str)
			await get_tree().create_timer(0.1).timeout
