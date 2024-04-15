extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

#@onready var scene = preload("res://main.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("look")):
		var scene2 = load("res://main.tscn")
		get_tree().change_scene_to_packed(scene2)
	pass
