extends Node

@export var _physics_player : CharacterBody2D
var points_dict = { 
	"sur": Vector2(0,1),"s":Vector2(0,1),
	"norte":Vector2(0,-1),"n":Vector2(0,-1),
	"este":Vector2(1,0),"e":Vector2(1,0),
	"oeste":Vector2(-1,0),"o":Vector2(-1,0) }


func _on_comand_controller_mover_señal(distancia: int, direccion: String) -> void:
	
	if !$"../../SubViewportContainer".visible:  
		var dir:Vector2 = points_dict[direccion.to_lower()]
		var displacement:Vector2 = dir * distancia
		_physics_player.move_player_x(displacement.x)
		_physics_player.move_player_y(displacement.y)
		print("Se ha desplzado " ,distancia, " en dirección ", direccion )
