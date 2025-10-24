extends Control

@onready var lanzar_rover: Button = $ColorRect/GridContainer/LanzarRover
@onready var configuracion: Button = $ColorRect/GridContainer/Configuracion
@onready var creditos: Button = $ColorRect/GridContainer/Creditos
@onready var abortar_mision: Button = $ColorRect/GridContainer/AbortarMision

@onready var audio_fx: AudioStreamPlayer2D = $AudioFX
@onready var audio_ambient: AudioStreamPlayer2D = $AudioAmbient



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_fx.stream = load("res://Assets/FX/HoverMenu.mp3")
	audio_ambient.play()
	pass




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	volume_update()
	
	

func volume_update():
	var music_volume = $ColorRect/MenuOpciones/MusicaBar
	var sfx_volume = $ColorRect/MenuOpciones/FXBar
	AudioGlobal.music_volume = music_volume.value
	AudioGlobal.sfx_volume = sfx_volume.value


func _on_lanzar_rover_pressed() -> void:
	audio_fx.play()
	get_tree().change_scene_to_file("res://Escenas/Escenario_interfaz.tscn")


func _on_abortar_mision_pressed() -> void:
	get_tree().quit()


func _on_lanzar_rover_mouse_entered() -> void:
	audio_fx.play()



func _on_configuracion_mouse_entered() -> void:
	audio_fx.play()


func _on_creditos_mouse_entered() -> void:
	audio_fx.play()


func _on_abortar_mision_mouse_entered() -> void:
	audio_fx.play()
