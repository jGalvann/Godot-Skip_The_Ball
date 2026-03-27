extends "res://itemBase.gd"

func _on_body_entered(body: Node2D):
	if body.name == "player":
			get_parent().add_points()
			reposicionar()	
