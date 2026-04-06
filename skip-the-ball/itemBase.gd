extends Area2D

func reposicionar(): # cata um local apropriado para reposicionamento no mapa 
	var nova_posicao = Vector2.ZERO
	var posicao_valida = false
	var margem_player = 150.0 	# distancia aceitavel do jogador
	var margem_itens = 80.0 	# distancia aceitavel de outros itens
	
	var player = get_parent().get_node("player")
	
	while not posicao_valida:
		var x = randf_range(75,725)
		var y = randf_range(50,550)
		nova_posicao = Vector2(x,y)
		posicao_valida = true
		
		if player and nova_posicao.distance_to(player.global_position) < margem_player: # checando se n ta mto perto do jogador
			posicao_valida = false
			continue
		
		var todos_itens = get_tree().get_nodes_in_group("itens")
		for item in todos_itens:
			if item == self:
					continue
			if nova_posicao.distance_to(item.global_position) < margem_itens:
					posicao_valida = false
					break
		if posicao_valida:
				global_position = nova_posicao
	
func tempo_de_vida(): # chuta oq q é 
	
	visible = false
	set_deferred("monitoring", false)
	# começa inv pq tava dando problema deixar isso dentro dos itens 

	await get_tree().create_timer(randf_range(0.5, 5.0)).timeout
	
	reposicionar()
	visible = true
	set_deferred("monitoring", true)
	modulate.a = 1.0
	# primeiro spawn no mapa 
	
	await get_tree().create_timer(4.0).timeout
	
	if not visible: return
	
	for i in range(5):
		modulate.a = 0.2
		await get_tree().create_timer(0.1).timeout
		modulate.a = 1.0
		await get_tree().create_timer(0.1).timeout
	
	tempo_de_vida() # funcao recursiva :thumbsUp
