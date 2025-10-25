extends Node2D
@onready var typing_fx: AudioStreamPlayer2D = $TypingFX
@onready var submit_fx: AudioStreamPlayer2D = $SubmitFX
@onready var music_index = AudioServer.get_bus_index("Music")
@onready var sfx_index = AudioServer.get_bus_index("Sound Effects")
@onready var terminal: LineEdit = $TerminalComandos
@onready var infoComandos: TextEdit =$InformacionComandos
signal señalControl(String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_db(music_index,AudioGlobal.music_volume)
	AudioServer.set_bus_volume_db(sfx_index,AudioGlobal.sfx_volume)
	
	terminal.grab_focus()
	#terminal.text_submitted.connect(_texto_pa_comandos)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _texto_pa_comandos(texto: String) -> void:	
	if Comandos.COMANDOS.has(texto) :
		infoComandos.text = Comandos.COMANDOS[texto].commanddescription
	else : # podemos poner este texto en rojo?
		infoComandos.text = "> ERROR: Comando no reconocido. Escribe AYUDA para obtener lista de comandos."
	
	
func _process(_delta: float) -> void:
	pass
	


func _on_terminal_comandos_text_submitted(comando: String) -> void:
	#terminal.text_submitted.connect(_texto_pa_comandos)
	emit_signal("señalControl", comando)
	print(comando)
	terminal.clear()


func _on_terminal_comandos_text_changed(new_text: String) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		submit_fx.play()
	else:
		typing_fx.play()


func _on_ayuda_help(ayuda: Variant) -> void:
	infoComandos.text = ayuda
	
