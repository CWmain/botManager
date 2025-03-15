extends Equipment

@onready var booster_animation: AnimatedSprite2D = $BoosterAnimation


func equipmentAffect():
	booster_animation.play("boost")
