extends Area2D

var speed := 0.5
var direction := Vector2.DOWN
var amount
var bonebody = load("res://scenes/attackscenes/bone/bonebody.tscn")

@onready var lastbone = $Sprite2Dlast
@onready var collisionbone = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var spritelast = $Sprite2Dlast
var inbody = false
var bluecount = 6

@onready var player = get_tree().get_root().get_node("/root/fight/soul")

func _process(delta):
	if player.soul_is_alive():
		position += direction * speed * delta
		if position.y < -50 or position.y > 700 or position.y < -5000:
			queue_free()

func _on_body_entered(body):
	if body.name == "soul":
		body.take_damage(10)

func size(wielkosc):
	for i in range(wielkosc):
		var bonebodyinst = instantiateall(bonebody)
		bonebodyinst.global_position = Vector2(self.global_position.x, self.global_position.y + (8 * (i + 1)))
	lastbonefunc(wielkosc)

func lastbonefunc(nr):
	lastbone.global_position = Vector2(self.global_position.x, self.global_position.y + (8 * (nr + 1)))
	changecollision(nr + 1)

func changecollision(nr):
	collisionbone.scale.y += (nr * 1.35)
	collisionbone.position.y += (nr * 2.65)

func instantiateall(scene: PackedScene) -> Node2D:
	var instance = scene.instantiate()
	add_child(instance)
	return instance

func summoned(bullet, soul, speed, left, size_val, ylevel = 620):
	var random = 0
	if left:
		random *= -1
		bullet.direction = Vector2.LEFT
	else:
		bullet.direction = Vector2.RIGHT

	# ❗️Poprawka: uwzględnij przesunięcie tutaj, zamiast w size()
	bullet.global_position = Vector2(get_viewport().get_visible_rect().size.x / 2, ylevel - (size_val * 8))
	size(size_val)
	amount = size_val
	bullet.speed = speed / 2
