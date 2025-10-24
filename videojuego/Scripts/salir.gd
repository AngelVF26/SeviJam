extends Node

signal prueba(valor: String)

func _ready() -> void:
	print("holaholaholita")
	prueba.connect(_on_prueba)
	prueba.emit("Salir")

func _on_prueba(valor: String) -> void:
	if valor == "Salir":
		_exit()

func _exit():
	print("holaholaholivecinito")
	#get_tree().change_scene_to_file("res://Escenas/Escenario_interfaz.tscn")

func _process(delta: float) -> void:
	pass
