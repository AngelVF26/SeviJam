extends CharacterBody2D



var current_imagen: CompressedTexture2D
var current_area:Area2D:
	set(t):
		current_area = t
		print(current_area.name)
		if current_area.imagen != null:
			
			current_imagen = current_area.imagen
		print(current_area.name)

func _process(delta: float) -> void:
	move_and_slide()


# Función para mover al jugador un numero determinado de pixeles
func move_player_x (x:int  = 1):
	x = clamp(x, -50,50)
	self.position.x += x
func move_player_y (y:int = 1):
	y = clamp(y, -50,50)
	self.position.y += y
