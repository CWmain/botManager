extends Equipment

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sword_cooldown: Timer = $SwordCooldown

signal attackReset

func equipmentAffect():
	playAnimation()

func playAnimation():
	animation_player.play("swing")
	
func endAnimation():
	animation_player.play("RESET")
