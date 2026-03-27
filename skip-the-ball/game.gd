extends Node2D

@onready var score_label = $score
@onready var player = $player
@onready var canvas = $GameOverUI
@onready var score = $GameOverUI/Control/CenterContainer/TextureRect/VBoxContainer/coisoFinal

var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func game_over():
	print("Entrou na func Game Over")
	get_tree().paused = true	
	canvas.visible = true
	score.text = "Score:" +str(points)
	
	
func add_points():
	print("Graxa veia, pegou a estrela")
	points +=1
	score_label.text = "Score: " +str(points)
	player.movimento +=100


func _on_button_pressed() -> void:
	get_tree().paused = false	
	get_tree().reload_current_scene()
