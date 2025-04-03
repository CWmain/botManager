extends CompoundBase
class_name ChassisBase

@export var s: Texture2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	assert(s != null)
	set_texture()
	
func set_texture():
	sprite_2d.texture = s
