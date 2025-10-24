extends Control

@onready var lanzar_rover: Button = $ColorRect/GridContainer/LanzarRover
@onready var configuracion: Button = $ColorRect/GridContainer/Configuracion
@onready var creditos: Button = $ColorRect/GridContainer/Creditos
@onready var abortar_mision: Button = $ColorRect/GridContainer/AbortarMision


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_lanzar_rover_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Escenario_interfaz.tscn")




func _on_abortar_mision_pressed() -> void:
	get_tree().quit()
