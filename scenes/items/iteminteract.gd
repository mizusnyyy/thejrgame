extends Area2D
var igor:=false
var inrange:=false
var anime
var player : CharacterBody2D
var first : bool = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		inrange=true
		anime = body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		inrange=false

func _unhandled_input(event):
	if event.is_action_pressed("interact") && inrange && first:
		first = false
		anime.obtainanim($Sprite2D.texture)
		Musicsounds.play_sound(load("res://JacksWithHats.wav"))
		hide()
		await player.obtain_done
		phoneout()
		await get_tree().create_timer(1.4).timeout
		phonetalk()
		await DialogueManager.dialogue_done
		player.anim_locked=false
		#player.anim.play("idle")
		get_tree().current_scene.delbarrier()
		self.queue_free()
		
func _on_ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	idleanim()
	print($"../../AudioStreamPlayer2D")

func idleanim():
	var dur:=1
	var val:Array
	var beh:=$Sprite2D/behind
	while true:
		igor=!igor
		if igor:
			val=[Vector2(1.3,1.3),Color(1,1,1,0.5),-5]
		else:
			val=[Vector2(1.6,1.6),Color(0.2,0.2,1,0.2),5]
		var t := create_tween()
		t.set_ease(Tween.EASE_IN_OUT)
		t.set_parallel(true)
		t.tween_property(beh,"global_rotation",deg_to_rad(90),dur)
		t.tween_property(beh,"scale",val[0],dur)
		t.tween_property(beh,"modulate",val[1],dur)
		#t.tween_property($behind,"skew",deg_to_rad(val[2]),dur)
		beh.global_rotation=0
		await t.finished

func phonetalk():
	DialogueManager.begin_dialogue("introgame2",player.dialog,$"../../AudioStreamPlayer2D")

func phoneout():
	player.anim_locked=true
	player.anim.play("phone")
	
