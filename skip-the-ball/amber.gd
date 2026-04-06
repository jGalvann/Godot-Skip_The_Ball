extends "res://itemBase.gd" # recebe o itemBase.gd pa deixar o código mais enxuto e concentrado 

func _on_body_entered(body: Node2D):
	if body.name == "player":
		get_parent().desativar_itens_temporario()
		
		visible = false
		set_deferred("monitoring", false)
		await get_tree().create_timer(15.0).timeout
		
		reposicionar()
		visible = true
		set_deferred("monitoring", true)
		
