extends Node2D

@onready var cm:=$CanvasModulate

func _process(delta: float) -> void:
	cm.color = Lighting.dawncolor.linear_interpolate(Lighting.normalcolor, Lighting.time / Lighting.day)
