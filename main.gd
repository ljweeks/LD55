extends Node2D

@export var time_look_away_min : float = 4
@export var time_look_away_max : float = 11
@export var time_wait_min : float = 2
@export var time_wait_max : float = 9
@export var confidence_lower_rate : float = 2
@export var love_lower_rate : float = 1

var state
var guy_state
var cur_time
var cur_confidence_time
var cur_love_time
var rng = RandomNumberGenerator.new()
var fella = preload("res://fella.tscn")

var girl_left = preload("res://assets/head_forward.png")
var girl_right = preload("res://assets/head_turned.png")
var guy_left = preload("res://assets/guy_left.png")
var guy_right = preload("res://assets/guy_right.png")

var end = preload(("res://end.tscn"))

@onready var heart = $girl/girl/hearts
@onready var anger = $girl/girl/anger
@onready var minLable = $ScoreBoard/VBoxContainer/Panel/min
@onready var secLable = $ScoreBoard/VBoxContainer/Panel/sec
@onready var fellaLable = $ScoreBoard/VBoxContainer/VBoxContainer2/fellacount

var minute = 0
var second = 0
var fellacount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$lovesong.play()
	$summonsong.play()
	$summonsong.set_stream_paused(true)
	$circle.visible = false
	state = "look"
	$love.value = 100
	$confidence.value = 100
	cur_time = rng.randf_range(time_wait_min, time_wait_max)
	cur_confidence_time = confidence_lower_rate
	cur_love_time = love_lower_rate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawn_fella():
	fellacount += 1
	fellaLable.text = str(fellacount)
	var dude = fella.instantiate()
	add_child(dude)
	dude.position.x = $fella_spot.position.x + rng.randi_range(0, 350)
	dude.position.y = $fella_spot.position.y

var tick_max = 0.25
var tick = tick_max

func _process(delta):
	
	if second == 60:
		second = 0
		minute += 1
	
	minLable.text = str(minute)
	secLable.text = str(second)
	
	if($love.value <= 0):
		get_tree().change_scene_to_packed(end)
	
	tick -= delta
	
	cur_confidence_time -= delta
	cur_love_time -= delta
	cur_time -= delta
	
	if cur_confidence_time < 0:
		cur_confidence_time = confidence_lower_rate
		$confidence.value -= 1
		#lower confidence bar
	if cur_love_time < 0:
		cur_love_time = love_lower_rate
		$love.value -= 2
		print($love.value)
		#lower love bar
	if cur_time < 0:
		if(state == "look"):
			state = "away"
			#change girl sprite
			$girl.set_texture(girl_left)
			cur_time = rng.randf_range(time_look_away_min, time_look_away_max)
		elif(state == "away"):
			state = "look"
			$girl.set_texture(girl_right)
			cur_time = rng.randf_range(time_wait_min, time_wait_max)
			tick += 0.75
	if state == "look" and guy_state == "away":
		if tick < 0:
			$love.value -= 10
			$girl/anger.emitting = true
	else:
		$girl/anger.emitting = false
		#love chunks down
	if state == "look" and guy_state == "look" and $confidence.value > 0:
		if tick < 0:
			$love.value += 2
			$girl/hearts.emitting = true
			$confidence.value -= 1
	else:
		$girl/hearts.emitting = false
	if Input.is_action_just_pressed("look"):
		$guy.set_texture(guy_right)
		$circle.visible = true
		$lovesong.set_stream_paused(true)
		$summonsong.set_stream_paused(false)
		guy_state = "away"
		#swap guy sprite
	if Input.is_action_just_released("look"):
		guy_state = "look"
		$guy.set_texture(guy_left)
		$circle.visible = false
		$lovesong.set_stream_paused(false)
		$summonsong.set_stream_paused(true)

	#guy look fill
	if guy_state == "away" and tick < 0:
		var fellers = get_tree().get_nodes_in_group("fellas")
		for fella in fellers:
			$confidence.value += (fella.power * 2)
			

	if tick < 0:
		tick = tick_max


func _on_timer_timeout():
	second += 1# Replace with function body.
