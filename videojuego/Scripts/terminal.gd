extends Node2D

@onready var terminal: LineEdit = $TerminalComandos
@onready var infoComandos: TextEdit =$InformacionComandos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	terminal.grab_focus()
	terminal.text_submitted.connect(_texto_pa_comandos)

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _texto_pa_comandos(texto: String) -> void:
	
	if Comandos.COMANDOS.comando.has(texto) :
		infoComandos.text = Comandos.COMANDOS.comando[texto].commanddescription
	else :
		infoComandos.text = "POR FAVOR, INTRODUZCA UN COMANDO VÁLIDO, EN CASO DE NO RECORDAR CUALES ERAN, ESCRIBA AYUDA"
	
	
func _process(delta: float) -> void:
	pass


func _on_terminal_comandos_text_submitted(new_text: String) -> void:
	terminal.text_submitted.connect(_texto_pa_comandos)
	terminal.clear()
