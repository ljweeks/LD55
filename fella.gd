extends Node2D


# Called when the node enters the scene tree for the first time.
@export var max_time : float = 10
var time

func _ready():
	time = max_time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var power = 1
func _process(delta):
	time -= delta
	power = time / max_time
	$Sprite2D.modulate = Color(1,1,1, power)
	if power <= 0.05:
		print("so long cruel world")
		queue_free()
		
