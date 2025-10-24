extends CharacterBody2D
class_name physics_player


var current_imagen: CompressedTexture2D
var current_area:Area2D:
	set(t):
		current_area = t
		if current_area.imagen != null:
			current_imagen = current_area.imagen
		print(current_area.name)

# Función para mover al jugador un numero determinado de pixeles
func move_player_x (x:int  = 1):
	self.position.x += x
func move_player_y (y:int = 1):
	self.position.y += y
