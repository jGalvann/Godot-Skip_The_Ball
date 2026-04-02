extends Node2D

@onready var score_label = $score
@onready var player = $player
@onready var canvas = $GameOverUI
@onready var score = $GameOverUI/Control/CenterContainer/TextureRect/VBoxContainer/coisoFinal
@onready var bomba = $bomba

var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	

func game_over():
	print("Entrou na func Game Over")
	get_tree().paused = true	
	canvas.visible = true
	score.text = "Score:" +str(points)
	
	
func add_points():
	print("Graxa veia, pegou a estrela")
	points +=1
	score_label.text = "Score: " +str(points)


func _on_button_pressed() -> void:
	get_tree().paused = false	
	get_tree().reload_current_scene()

func ice_slow():
	player.movimento -= 100
	if player.movimento <= 0:
		player.movimento = 50

func light_speed():
	player.movimento += 50

func desativar_itens_temporario():
	var todos_itens = get_tree().get_nodes_in_group("itens")
	
	for item in todos_itens:
		item.set_deferred("monitoring", false) 
		print("sumiu")
		item.visible = false
	await get_tree().create_timer(5.0).timeout
	for item in todos_itens:
		item.set_deferred("monitoring", true)
		item.visible = true
		
		print("apareceu")

func pontos_dobrados():
	points += 1

func _on_timer_timeout():
	player.movimento += 100
	criar_nova_bomba()
	
func criar_nova_bomba():
	var nova_bomba = bomba.duplicate()
	add_child(nova_bomba)
	nova_bomba.reposicionar()

func heavy_ball():
	player.pancada = -300

func _on_timer_2_timeout():
	player.pancada = -900
