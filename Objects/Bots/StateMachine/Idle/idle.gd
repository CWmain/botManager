extends State

@export var approach: State
@export var flee: State

func enter()->void:
	print("In the idle state")
	
func update()->void:
	if foe != null:
		if me.canAttack:
			tranistion.emit(self, approach)
		else:
			tranistion.emit(self, flee)
