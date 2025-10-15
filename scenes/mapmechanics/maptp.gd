extends Node2D
@export var tp_to: PackedScene
@export var keep_moving : bool = true
@onready var player : CharacterBody2D
@export var tp_to_pos : Vector2 = Vector2(0.0, 0.0)

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_areatp_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	
	#GDZIE ZACZYNA GRACZ
	Global.new_scene_player_pos = tp_to_pos
	
	#ZMIANA SCENY
	get_tree().change_scene_to_packed(tp_to)
