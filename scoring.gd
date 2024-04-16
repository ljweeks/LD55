extends Node

var cur_count 
var cur_min
var cur_sec

var max_min
var max_sec
var max_count
# Called when the node enters the scene tree for the first time.
func _ready():
	cur_count = 0
	cur_min = 0
	cur_sec = 0

	max_min = 0
	max_sec = 0
	max_count = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cur_count > max_count:
		max_count = cur_count
	if cur_min >= max_min:
		max_min = cur_min
		if cur_sec > max_min:
			max_sec = cur_sec
