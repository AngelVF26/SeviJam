extends Node

# Called when the node enters the scene tree for the first time.
signal proceso()
@onready var player: physics_player = $"../../PhysicsScene/Player"

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_comand_controller_procesar_señal() -> void:
	proceso.emit()
