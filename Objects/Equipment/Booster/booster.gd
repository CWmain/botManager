extends Equipment

@export var moveSpeed: float = 15
@onready var booster_animation: AnimatedSprite2D = $BoosterAnimation

func _ready() -> void:
	booster_animation.play("boost")

func equipmentAffect():
	equipmentAffect
	
