extends Area2D

var inbody := false
var player : Node2D
@export var where_need_look: Array[int] = [0]
@export var text_id: String = ""

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		inbody = true
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		inbody = false
		Global.can_talk=true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		talk()

func talk():
	
	#WHERE NEED LOOK --> 1 GORA 2 PRAWO 3 LEWO 0 DOL
	
	if inbody and Global.can_talk and player.directionstop in where_need_look and !Global.isincutscene:
		DialogueManager.begin_dialogue(text_id,player.dialog,$"../AudioStreamPlayer2D")
		Global.toggle_can_phone(false)
		Global.can_talk=false
		await DialogueManager.dialogue_done
		Global.can_talk=true
		
		#NIESTETY NIE WIEM JAK ZROBIC ABY POD KONIEC CUTSCENKI MOZNA BYLO OD RAZU DO INNEGO INTERACTABLE GADAC

				
#func _physics_process(delta: float) -> void:
	#if inbody and player and !Global.isincutscene:
		#if player.directionstop == where_need_look:
			#DialogueManager.begin_dialogue(text_id,player.dialog,$"../AudioStreamPlayer2D")
