extends Node2D

@onready var minLable = $ScoreBoard/VBoxContainer/Panel/min
@onready var secLable = $ScoreBoard/VBoxContainer/Panel/sec
@onready var fellaLable = $ScoreBoard/VBoxContainer/VBoxContainer2/fellacount
@onready var maxminLable = $HighScoreBoard/VBoxContainer/Panel/min
@onready var maxsecLable = $HighScoreBoard/VBoxContainer/Panel/sec
@onready var maxfellaLable = $HighScoreBoard/VBoxContainer/VBoxContainer2/fellacount

# Called when the node enters the scene tree for the first time.
func _ready():
	minLable.text = str(Scoring.cur_min)
	secLable.text = str(Scoring.cur_sec)
	fellaLable.text = str(Scoring.cur_count)
	maxminLable.text = str(Scoring.max_min)
	maxsecLable.text = str(Scoring.max_sec)
	maxfellaLable.text = str(Scoring.max_count)

#@onready var scene = preload("res://main.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("look")):
		var scene2 = load("res://main.tscn")
		get_tree().change_scene_to_packed(scene2)
	pass
