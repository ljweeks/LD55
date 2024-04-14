extends Node2D

@export var spacing_x : int = 80
@export var spacing_y : int = 80
@export var vis_cutoff : int = -400


var rune1 = preload("res://assets/rune1.png")
var rune2 = preload("res://assets/rune2.png")
var rune3 = preload("res://assets/rune3.png")
var rune4 = preload("res://assets/rune4.png")
var rune5 = preload("res://assets/rune5.png")

var runes = []

var keys = []
var sprites = []
var texture = preload("res://icon.svg")
var rng = RandomNumberGenerator.new()
var gen_num = 12
func gen_runes(num):
	for i in num:
		var x = rng.randi_range(0,3)
		var y = -spacing_y * (i + 1)
		keys.append(x)
		var sprite = Sprite2D.new()
		add_child(sprite)
		sprites.append(sprite)
		sprite.set_texture(runes[rng.randi_range(0,4)])
		sprite.apply_scale(Vector2(0.3, 0.3))
		sprite.position.x = x * spacing_x
		sprite.position.y = y
# Called when the node enters the scene tree for the first time.
func visibility():
	for sprite in sprites:
		if sprite.position.y < vis_cutoff:
			sprite.visible = false
		else:
			sprite.visible = true

func _ready():
	runes.append(rune1)
	runes.append(rune2)
	runes.append(rune3)
	runes.append(rune4)
	runes.append(rune5)
	
	$left.position.x = spacing_x * 0
	$down.position.x = spacing_x * 1
	$up.position.x = spacing_x * 2
	$right.position.x = spacing_x * 3
	
	gen_runes(12)
	visibility()
	pass # Replace with function body.

func move_runes():
	keys.pop_front()
	var s =sprites.pop_front()
	s.queue_free()
	for sprite in sprites:
		sprite.position.y += spacing_y
	visibility()

var delay = 0
var delay_max = 0.5
var shake_amount = 0
var shake_time = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shake_time -= delta
	if shake_amount > 20 and shake_time < 0:
		shake_amount -= 2
		shake_time += 0.3
		position.x += rng.randi_range(-shake_amount, shake_amount)
		print("shake")
	else:
		position.x = 0
	delay -= delta
	if Input.is_action_pressed("look"):
		if delay < 0 and keys.size() > 0:
			if Input.is_action_just_pressed("up"):
				if keys[0] == 2:
					print("up")
					move_runes()
				else:
					delay = delay_max
					shake_amount = 28
			if Input.is_action_just_pressed("left"):
				if keys[0] == 0:
					print("left")
					move_runes()
				else:
					delay = delay_max
					shake_amount = 28
			if Input.is_action_just_pressed("down"):
				if keys[0] == 1:
					print("down")
					move_runes()
				else:
					delay = delay_max
					shake_amount = 28
			if Input.is_action_just_pressed("right"):
				if keys[0] == 3:
					print("right")
					move_runes()
				else:
					delay = delay_max
					shake_amount = 28
	if keys.size() <= 0:
		var nodes = get_tree().get_nodes_in_group("main")
		nodes[0].spawn_fella()
		gen_runes(gen_num)
		gen_num += 1
		visibility()

	pass
