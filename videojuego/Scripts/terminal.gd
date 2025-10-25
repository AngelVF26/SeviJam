extends Node2D
@onready var typing_fx: AudioStreamPlayer2D = $TypingFX
@onready var submit_fx: AudioStreamPlayer2D = $SubmitFX
@onready var music_index = AudioServer.get_bus_index("Music")
@onready var master_index = AudioServer.get_bus_index("Master")
@onready var sfx_index = AudioServer.get_bus_index("Sound Effects")
@onready var terminal: LineEdit = $TerminalComandos
@export var player: CharacterBody2D 
@onready var imagen_explorada: Sprite2D = $ImagenExplorada
var listaComandos: Array
var pruebas: Array
var comandosPosition: int
@onready var infoComandos: RichTextLabel = $InfoComandos
var visible_characters = 0
@onready var transicion: Sprite2D = $Transicion
@onready var inicio_fx: AudioStreamPlayer2D = $InicioFX

signal señalControl(String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transicion.visible =true
	
	AudioServer.set_bus_volume_db(music_index,AudioGlobal.music_volume)
	AudioServer.set_bus_volume_db(sfx_index,AudioGlobal.sfx_volume)
	AudioServer.set_bus_effect_enabled(master_index,0,false)
	inicio_fx.play()
	$AnimationPlayer.play("start")
	terminal.grab_focus()		
	
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
	terminal.grab_focus()
		#esto es lo que hace que haya una animación de texto
	if visible_characters != $InfoComandos.visible_characters:
		visible_characters = $InfoComandos.visible_characters
		$TypingDisplayFX.play()
	
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
	infoComandos.clear()
	
	infoComandos.add_text("\n\n\n   > ")
	infoComandos.push_color(Color.WHITE)
	infoComandos.add_text("mover")
	infoComandos.pop()
	infoComandos.add_text(": " + Comandos.COMANDOS[["mover", "desplazar", "avanzar", "/mover", "/desplazar", "/avanzar"]].commandaction)
	
	infoComandos.add_text("\n   > ")
	infoComandos.push_color(Color.WHITE)
	infoComandos.add_text("procesar")
	infoComandos.pop()
	infoComandos.add_text(": " + Comandos.COMANDOS[["procesar", "imagen", "captura", "foto","/procesar", "/imagen", "/captura", "/foto"]].commandaction)
	
	infoComandos.add_text("\n   > ")
	infoComandos.push_color(Color.WHITE)
	infoComandos.add_text("interactuar")
	infoComandos.pop()
	infoComandos.add_text(": " + Comandos.COMANDOS[["interactuar", "/interactuar"]].commandaction)
	
	infoComandos.add_text("\n   > ")
	infoComandos.push_color(Color.WHITE)
	infoComandos.add_text("analizar")
	infoComandos.pop()
	infoComandos.add_text(": " + Comandos.COMANDOS[["analizar", "adn", "analisis","análisis","/analizar", "/adn", "/analisis","/análisis"]].commandaction)
	
	infoComandos.add_text("\n   > ")
	infoComandos.push_color(Color.WHITE)
	infoComandos.add_text("mapa")
	infoComandos.pop()
	infoComandos.add_text(": " + Comandos.COMANDOS[["mapa","minimapa","/mapa","/minimapa"]].commanddescription)
	
	infoComandos.add_text("\n   > ")
	infoComandos.push_color(Color.WHITE)
	infoComandos.add_text("salir")
	infoComandos.pop()
	infoComandos.add_text(": " + Comandos.COMANDOS[["salir", "cerrar","/salir", "/cerrar"]].commandaction)
	
	infoComandos.add_text("\n\n   [Esta guía no contiene comandos secretos.]")


func _on_procesar_proceso() -> void:
	infoComandos.clear()
	imagen_explorada.texture = player.current_imagen
	imagen_explorada.visible = true
	print("dim patatas")
	


func _on_salir_ocultar() -> void:
	imagen_explorada.visible = false
	$SubViewportContainer.visible = false
	infoComandos.add_text("\n\n\n   > ...")


func _on_interactuar_interact(interactuar: Variant) -> void:
	infoComandos.clear()
	print("area actual: ", player.current_area)
	print("objeto1: ", player.current_area.objeto1)
	interactuar = player.current_area.objeto_interactuar
	print("\n\n\n Interaccion :" + interactuar)
	infoComandos.text = "\n\n\n " + interactuar
	


func _on_comand_controller_return_error() -> void:
	$ErrorFX.play()
