extends Node

const MARKER_2D = preload("uid://bkhbijng6yhgb")

@export_category("References")
@export var player:CharacterBody2D
@export_category ("Parameter")
@export var cell_size: int = 10



func cell_posx(x:float,y:float)->Vector2:

	var chunk_x:float = ((x )  / (cell_size)/2) 
	var chunk_z:float = ((y ) / (cell_size)/2) 
	return Vector2i (floori(chunk_x), floori(chunk_z))
