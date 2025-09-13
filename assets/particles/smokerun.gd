extends GPUParticles2D
@onready var child := $child

func _on_ready() -> void:
	pass # Replace with function body.

func changeemit(x:bool) -> void:
	self.emitting=x
	child.emitting=x
