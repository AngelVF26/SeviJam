extends TextureRect

@onready var animation_player: AnimationPlayer = $TextureRect2/AnimationPlayer
@onready var texture_rect_2: TextureRect = $TextureRect2
@onready var texture_rect: TextureRect = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect_2.size.x = texture_rect.size.x
	texture_rect_2.size.y = texture_rect.size.y
	animation_player.play("RESET")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interfaz_señal_imagen(bool: Variant) -> void:
	texture_rect_2.size.x = texture_rect.size.x
	texture_rect_2.size.y = texture_rect.size.y
	animation_player.play("RESET")
