extends Node



@export var texto:String 
@export var animator: AnimationPlayer
@export var label: RichTextLabel

signal cuadernoSeñal()

func clonar():
	label.text = "\n
 > Iniciando proceso de electroforesis...
 > Rompiendo membranas celulares...
 > Centrifugando muestra...
 > Identificando ácidos nucleicos...
 > Aislando moléculas de ADN...
 > ...
 > ...
 > [color=red]ERROR[/color].
 > ADN insuficiente. Muestra incompleta.
 > 
 > 
 > Un solo pelo hubiera bastado. 
 > 
 > ¿Abrir CUADERNO de bitácora?
 > S/N" 

	animator.play("clonar")
	emit_signal("cuadernoSeñal") 


func _on_comand_controller_clonar_señal() -> void:
	clonar()
