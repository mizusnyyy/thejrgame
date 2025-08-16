extends Control
@onready var labele = $label

func setname(name):
	print(self)
	print(name, "!!!!!!")
	labele.text = name
