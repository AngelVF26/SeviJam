extends Control


#region Sale un error en el depurador sobre que no encuentras estos nodos
#@onready var lanzar_rover: Button = $ColorRect/GridContainer/LanzarRover
#@onready var configuracion: Button = $ColorRect/GridContainer/Configuracion
#@onready var creditos: Button = $ColorRect/GridContainer/Creditos
#@onready var abortar_mision: Button = $ColorRect/GridContainer/AbortarMision
#endregion


@onready var audio_fx: AudioStreamPlayer2D = $AudioFX
@onready var audio_ambient: AudioStreamPlayer2D = $AudioAmbient
@onready var grid_opciones: Control = $ColorRect/MenuOpciones

@onready var grid_main: GridContainer = $ColorRect/GridMain
@onready var sfx_volume: HScrollBar = $ColorRect/MenuOpciones/FXBar
@onready var music_volume: HScrollBar = $ColorRect/MenuOpciones/MusicaBar

@onready var music_index = AudioServer.get_bus_index("Music")
@onready var sfx_index = AudioServer.get_bus_index("Sound Effects")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioGlobal.music_volume = music_volume.value
	AudioGlobal.sfx_volume = sfx_volume.value
	AudioServer.set_bus_volume_db(music_index,AudioGlobal.music_volume)
	AudioServer.set_bus_volume_db(sfx_index,AudioGlobal.sfx_volume)
	grid_opciones.visible = false
	grid_main.visible = true
	audio_fx.stream = load("res://Assets/FX/HoverMenu.mp3")
	audio_ambient.play()
	pass




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	volume_update()
	pass
	

func volume_update():

	AudioGlobal.music_volume = music_volume.value
	AudioGlobal.sfx_volume = sfx_volume.value
	AudioServer.set_bus_volume_db(music_index,AudioGlobal.music_volume)
	AudioServer.set_bus_volume_db(sfx_index,AudioGlobal.sfx_volume)


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


func _on_configuracion_pressed() -> void:
	grid_main.visible = false
	grid_opciones.visible = true


func _on_aceptar_config_pressed() -> void:
	grid_main.visible = true
	grid_opciones.visible = false
