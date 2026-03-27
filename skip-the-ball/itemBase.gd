extends Area2D

func reposicionar():
	var nova_posicao = Vector2.ZERO
	var posicao_valida = false
	
	while not posicao_valida:
		var x = randf_range(100,730)
		var y = randf_range(80,350)
		nova_posicao = Vector2(x,y)
		posicao_valida = true
		
		var todos_itens = get_tree().get_nodes_in_group("itens")
		
		for item in todos_itens:
			if item == self:
					continue
			if nova_posicao.distance_to(item.global_position) < 80:
					posicao_valida = false
					break
		if posicao_valida:
				global_position = nova_posicao
