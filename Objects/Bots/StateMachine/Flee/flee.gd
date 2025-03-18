extends State

@export var approach: State
@export var fleeDistance: float = 100
func enter()->void:
	# Get direction to foe
	var fleeVector: Vector2 = me.position + me.position.direction_to(foe.position).rotated(PI/2)*fleeDistance
	me.path_finder.target_position = fleeVector
	me.travelTo = true
	
func update()->void:
	if me.canAttack:
		tranistion.emit(self, approach)
