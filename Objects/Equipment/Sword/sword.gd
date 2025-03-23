extends Equipment

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sword_cooldown: Timer = $SwordCooldown

signal attackComplete

func equipmentAffect():
	if randf() > 0.5:
		animation_player.play("leftSwing")
	else:
		animation_player.play("rightSwing")
	
	#playAnimation()

func playAnimation():
	animation_player.play("swing")
	
func endAnimation():
	animation_player.play("RESET")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "leftSwing" or anim_name == "rightSwing":
		animation_player.play("RESET")
		attackComplete.emit()


func _on_hit_detection_body_entered(body: Node2D) -> void:
	# Assummed that the parent of a weapon is the bot
	if body is Bot and body != get_parent():
		body.damage_bot(1)
