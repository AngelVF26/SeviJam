extends Node

signal ocultar()

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_comand_controller_salir_señal() -> void:
	emit_signal("ocultar")
	#get_tree().change_scene_to_file("res://Escenas/Escenario_interfaz.tscn")
	
