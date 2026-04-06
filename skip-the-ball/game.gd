extends Node2D

# o @onready é uma anotação do godot que resolve um problema de tempo de execução 
# basicamente o godot executa a cena como se fosse um arvore, ent caso tenha alguma coisa que tu precise
# que esteja em uma raiz distante, vc da @onready para ele esperar o item ter o valor e assim continuar 
@onready var score_label = $score
@onready var player = $player
@onready var canvas = $GameOverUI
@onready var score = $GameOverUI/Control/CenterContainer/TextureRect/VBoxContainer/coisoFinal
@onready var bomba = $bomba

# -- var de estado 
var points = 0

# ciclo de vida 
func _ready():
	
	randomize() 		# gera numeros aleatórios para os itens
	$Timer.start()
	
	# pega todos os itens que estão no grupo "itens" da cena atual 
	var todos_itens_tela = get_tree().get_nodes_in_group("itens")
	for item in todos_itens_tela:
		if item.name.begins_with("bomba"):
				item.reposicionar()
				continue
		
		if item.has_method("tempo_de_vida"): # verifica se o item tem o método dentro dele
				item.tempo_de_vida()
		

# gerenciamento de estado 
func game_over(): # cabo o jogo
	print("Entrou na func Game Over")
	get_tree().paused = true	
	canvas.visible = true
	score.text = "Score:" +str(points)
	
	
func add_points(): # adiciona pontos ao score
	print("Graxa veia, pegou a estrela")
	points +=1
	score_label.text = "Score: " +str(points)


func _on_button_pressed() -> void: # recarrega a cena atual ( jogo ) 
	get_tree().paused = false	
	get_tree().reload_current_scene()

# mutação do jogador

func ice_slow(): # reduz a velocidade de movimento do jogador, caso chegue em 0, recebe 50
	player.movimento -= 100
	if player.movimento <= 0:
		player.movimento = 50

func light_speed(): # adiciona velocidade ao jogador
	player.movimento += 100

func desativar_itens_temporario(): 
	var todos_itens = get_tree().get_nodes_in_group("itens")
	
	for item in todos_itens:
		item.set_deferred("monitoring", false)  # desativa a capacidade da area2d de receber colisões 
												# agenda a mudança para o final do frame para não dar ruim
		print("sumiu")
		item.visible = false
	await get_tree().create_timer(5.0).timeout
	for item in todos_itens:
		item.set_deferred("monitoring", true)
		item.visible = true
		
		print("apareceu")

func pontos_dobrados():
	points += 1

func _on_timer_timeout(): # escala a dificuldade conforme o tempo passa 
	player.movimento += 100
	criar_nova_bomba()
	
func criar_nova_bomba(): # CABOOM mais vezes
	var nova_bomba = bomba.duplicate()
	add_child(nova_bomba)
	nova_bomba.reposicionar()

func heavy_ball(): # gruda no chão 
	player.pancada = -300

func _on_timer_2_timeout():
	player.pancada = -900
