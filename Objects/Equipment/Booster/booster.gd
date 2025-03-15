extends Equipment

@onready var booster_animation: AnimatedSprite2D = $BoosterAnimation


func equipmentAffect():
	print_debug("Effect")

func playAnimation():
	booster_animation.play("boost")
	
func endAnimation():
	booster_animation.play("default")
