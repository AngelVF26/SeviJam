extends Node2D
@onready var typing_fx: AudioStreamPlayer2D = $TypingFX
@onready var submit_fx: AudioStreamPlayer2D = $SubmitFX
@onready var music_index = AudioServer.get_bus_index("Music")
@onready var master_index = AudioServer.get_bus_index("Master")
@onready var sfx_index = AudioServer.get_bus_index("Sound Effects")
@onready var terminal: LineEdit = $TerminalComandos
@onready var player: CharacterBody2D = $CanvasLayer/SubViewportContainer/SubViewport/PhysicsScene/Player
@onready var imagen_explorada: Sprite2D = $ImagenExplorada
var listaComandos: Array
var comandosPosition: int
@onready var infoComandos: RichTextLabel = $InfoComandos

signal señalControl(String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	AudioServer.set_bus_volume_db(music_index,AudioGlobal.music_volume)
	AudioServer.set_bus_volume_db(sfx_index,AudioGlobal.sfx_volume)
	AudioServer.set_bus_effect_enabled(master_index,0,false)

	
	$AnimationPlayer.play("start")
	terminal.grab_focus()
	
	var visible_characters = 0
	if visible_characters != $InfoComandos.visible_characters:
		visible_characters = $InfoComandos.visible_characters
		$TypingDisplayFX.play()
	set_process_input(true)
	#terminal.text_submitted.connect(_texto_pa_comandos)
	

func _input(ev):
	if Input.is_action_pressed("ui_up") && listaComandos.size()>0 && comandosPosition < listaComandos.size():
		terminal.clear()
		comandosPosition +=1
		terminal.text = listaComandos[listaComandos.size()-comandosPosition]
		
	if Input.is_action_pressed("ui_down") && listaComandos.size()>0 && comandosPosition > 1:
		terminal.clear()
		comandosPosition -=1
		terminal.text = listaComandos[listaComandos.size()-comandosPosition]
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _texto_pa_comandos(texto: String) -> void:	
	if Comandos.COMANDOS.has(texto) :
		infoComandos.text = Comandos.COMANDOS[texto].commanddescription
	else : # podemos poner este texto en rojo?
		infoComandos.text = "> ERROR: Comando no reconocido. Escribe AYUDA para obtener lista de comandos."
	
	
func _process(_delta: float) -> void:
	if $AnimationPlayer.is_playing():
		$CanvasLayer.visible = false
	else:
		$CanvasLayer.visible = true
	pass
	


func _on_terminal_comandos_text_submitted(comando: String) -> void:
	#terminal.text_submitted.connect(_texto_pa_comandos)
	emit_signal("señalControl", comando)
	print("este es el comando:", comando)
	listaComandos.append(comando)
	comandosPosition = 0
	
	terminal.clear()


func _on_terminal_comandos_text_changed(new_text: String) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		submit_fx.play()
	else:
		typing_fx.play()


func _on_ayuda_help(ayuda: Variant) -> void:
	infoComandos.text = ayuda
	


func _on_procesar_proceso() -> void:
	infoComandos.clear()
	imagen_explorada.texture = player.current_imagen
	imagen_explorada.visible = true
	print("dim patatas")
	


func _on_salir_ocultar() -> void:
	#imagen_explorada.visible = false
	pass


func _on_interactuar_interact(interactuar: Variant) -> void:
	infoComandos.text = interactuar
