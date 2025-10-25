extends Area2D

@export var obstaculo:StaticBody2D

#@export var objeto_interactuar:string = Comandos.COMANDOS["NADA"]["OBJECTMSG"]

@export var imagen:CompressedTexture2D


@export var is_wall:bool = false


#func _ready() -> void:
	#(obstaculo.get_child(0) as CollisionShape2D).shape = $CollisionShape2D.shape
	#if is_wall:
		#obstaculo.process_mode = Node.PROCESS_MODE_INHERIT
	#else:
		#obstaculo.process_mode = Node.PROCESS_MODE_DISABLED

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		
		(body as CharacterBody2D).current_area = self
