extends State

@export var approach: State

func enter()->void:
	me.path_finder.target_position = Vector2(100,100)
	me.travelTo = true
	
func update()->void:
	if me.canAttack:
		tranistion.emit(self, approach)
