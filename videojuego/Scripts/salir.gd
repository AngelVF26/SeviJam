extends Node



func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_comand_controller_salir_señal() -> void:
	get_tree().change_scene_to_file("res://Escenas/Escenario_interfaz.tscn")
	
