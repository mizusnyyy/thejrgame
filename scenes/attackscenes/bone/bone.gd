extends Area2D

var speed := 0.5
var direction := Vector2.DOWN
var amount
var bonebody = load("res://scenes/attackscenes/bone/bonebody.tscn")
@onready var lastbone = $Sprite2Dlast
@onready var collisionbone = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var spritelast =$Sprite2Dlast
var inbody=false
var bluecount = 6

@onready var player = get_tree().get_root().get_node("/root/fight/soul")
func _process(delta):
<<<<<<< HEAD
	if player.is_alive():
		position += direction * speed * delta
		if position.y < -50 or position.y > 700 or position.y > 500 or position.y < -5000:
			queue_free()

func _on_body_entered(body):
	if body.name == "soul":
		body.take_damage(10) #BYL TRUE

func size(wielkosc):
	for i in range(wielkosc):
		var bonebodyinst = instantiateall(bonebody)
		bonebodyinst.global_position = Vector2(self.global_position.x, self.global_position.y + (6 * (i + 1)))
	lastbonefunc(wielkosc)
	self.global_position.y -= wielkosc * 8

func lastbonefunc(nr):
	lastbone.global_position = Vector2(self.global_position.x, self.global_position.y + (6 * (nr + 1)))
	changecollision(nr)

func changecollision(nr):
	# nr = amount (liczba segmentów ciała)
	var head_height = 8 # dwie głowy po 4 px = 8 px
	var body_segment_height = 3 # wysokość segmentu ciała w kolizji
	
	var total_collision_height = head_height + (body_segment_height * nr)
	
	var shape = collisionbone.shape
	var base_height = shape.extents.y * 2 # pełna wysokość kształtu
	collisionbone.scale.y = total_collision_height / base_height
	collisionbone.position.y = total_collision_height / 2 - (head_height / 2)+1.8
=======
	if player:
		if player.soul_is_alive():
			position += direction * speed * delta
			if position.y < -50 or position.y > 700 or position.y > 500 or position.y < -5000:
				queue_free()
func _on_body_entered(body):
	if body.name == "soul":
			if amount<bluecount:
				body.take_damage(10) #BYL TRUE
			else:
				body.take_damage(10,true)
			
func size(wielkosc):
	for i in range(wielkosc):
		var bonebodyinst = instantiateall(bonebody)
		bonebodyinst.global_position = Vector2(self.global_position.x,self.global_position.y+(8*(i+1)))
	lastbonefunc(wielkosc)
	self.global_position.y-=wielkosc*8
		
func lastbonefunc(nr):
	lastbone.global_position = Vector2(self.global_position.x,self.global_position.y+(8*(nr+1)))
	changecollision(nr+1)

func changecollision(nr):
	collisionbone.scale.y += (nr*1.35)
	collisionbone.position.y += (nr*2.65)
>>>>>>> 8e677ec1e56a7f04b8669e2035c981a7ed31a2e4

func instantiateall(scene: PackedScene) -> Node2D:
	var instance = scene.instantiate()
	add_child(instance)
	return instance
<<<<<<< HEAD

func getsizepls():
	return amount

func summoned(bullet, soul, speed, left, size, ylevel=620):
=======
	
func summoned(bullet, soul, speed, left, size, ylevel=620):
	#var random = randf_range(-196,-384)
>>>>>>> 8e677ec1e56a7f04b8669e2035c981a7ed31a2e4
	var random = 0#-384
	if left:
		random *= -1
		bullet.direction = Vector2.LEFT
	else:
		bullet.direction = Vector2.RIGHT
<<<<<<< HEAD
	bullet.global_position = Vector2(get_viewport().get_visible_rect().size.x / 2 + random, ylevel)
	size(size)
	amount = size
	bullet.speed = speed / 2
=======
	bullet.global_position = Vector2(get_viewport().get_visible_rect().size.x/2+random,ylevel)
	#if amount<bluecount:
		#self.modulate.hex(255)
	size(size)
	amount = size
	bullet.speed = speed/2
>>>>>>> 8e677ec1e56a7f04b8669e2035c981a7ed31a2e4
