extends "res://itemBase.gd"

func _on_body_entered(body: Node2D):
	if body.name == "player":
		print("acabou")
		get_parent().game_over()
