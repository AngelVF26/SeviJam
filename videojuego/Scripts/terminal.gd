extends Node2D
@onready var ambient_music: AudioStreamPlayer2D = $AmbientMusic
@onready var typing_fx: AudioStreamPlayer2D = $TypingFX
@onready var submit_fx: AudioStreamPlayer2D = $SubmitFX

@onready var intro_console_fx: AudioStreamPlayer2D = $IntroConsoleFX
@onready var terminal: LineEdit = $TerminalComandos
@onready var infoComandos: TextEdit =$InformacionComandos
signal señalControl(String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	terminal.grab_focus()
	terminal.text_submitted.connect(_texto_pa_comandos)

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _texto_pa_comandos(texto: String) -> void:
	
	
	
	if Comandos.COMANDOS.has(texto) :
		infoComandos.text = Comandos.COMANDOS[texto].commanddescription
	else :
		infoComandos.text = "POR FAVOR, INTRODUZCA UN COMANDO VÁLIDO, EN CASO DE NO RECORDAR CUALES ERAN, ESCRIBA AYUDA"
	
	
func _process(delta: float) -> void:

	pass
	


func _on_terminal_comandos_text_submitted(comando: String) -> void:
	#terminal.text_submitted.connect(_texto_pa_comandos)
	emit_signal("señalControl", comando)
	terminal.clear()


func _on_terminal_comandos_text_changed(new_text: String) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		submit_fx.play()
	else:
		typing_fx.play()
