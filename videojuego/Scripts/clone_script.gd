extends Node



@export var texto:String 
@export var animator: AnimationPlayer
@export var label: RichTextLabel

func clonar():
	label.text = texto
	animator.play("typewriter")


func _on_comand_controller_clonar_señal() -> void:
	clonar()
