extends Resource
class_name Item

@export var name: String
@export var heal_amount: int

func is_consumable() -> bool:
	return heal_amount > 0
