extends CharacterBody2D


# Función para mover al jugador un numero determinado de pixeles
func move_player_x (x:int  = 1):
	self.position.x += x
func move_player_y (y:int = 1):
	self.position.y += y
