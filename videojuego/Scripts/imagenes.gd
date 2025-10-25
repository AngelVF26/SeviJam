extends TextureRect

@onready var animation_player: AnimationPlayer = $TextureRect2/AnimationPlayer
@onready var texture_rect_2: TextureRect = $TextureRect2
@onready var texture_rect: TextureRect = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect_2.size.x = texture_rect.size.x
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interfaz_señal_imagen(bool: Variant) -> void:
	texture_rect_2.size.x = texture_rect.size.x
	%Scanner.play()
	animation_player.play("RESET")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("patatas que hay de comer")
	%Scanner.stop()
