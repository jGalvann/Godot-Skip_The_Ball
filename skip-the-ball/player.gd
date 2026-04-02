extends CharacterBody2D

var gravidade = 900
var pancada = -900
var movimento = 300

func _physics_process(delta: float):
	velocity.y += gravidade * delta 
	
	var direcao = 0
	direcao += Input.get_axis("mover_direita","mover_esquerda") * movimento
	
	velocity.x = - direcao 
	
	if is_on_floor(): 
		velocity.y = pancada
	move_and_slide() 
