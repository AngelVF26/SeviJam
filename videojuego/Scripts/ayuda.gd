extends Node

signal recibir_señal(valor: String)
signal enviar_mensaje(texto: String)

func _ready() -> void:
	recibir_señal.connect(_on_recibir_señal)

func _on_recibir_señal(valor: String) -> void:
	var mensaje = "Ayuda recibió: " + valor
	enviar_mensaje.emit(mensaje)
