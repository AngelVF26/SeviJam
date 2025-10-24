extends Area2D


@export var imagen:CompressedTexture2D


func _on_body_entered(body: Node2D) -> void:
	if body is physics_player:
		(body as physics_player).current_area = self
