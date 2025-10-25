extends Node

signal help(String)

func _ready() -> void:
	pass

func _on_comand_controller_ayuda_señal() -> void:
	help.emit("ESTO ES LA AYUDA, QUE PASA COLEGA")
	
