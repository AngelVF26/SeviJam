extends Node

# Called when the node enters the scene tree for the first time.
signal proceso(Vector2)
@onready var player: CharacterBody2D = $"../../PhysicsScene/Player"

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_comand_controller_procesar_señal() -> void:
	print("HOLA COLEGA", Vector2(player.position.x, player.position.y))
	proceso.emit(Vector2(player.position.x, player.position.y))
