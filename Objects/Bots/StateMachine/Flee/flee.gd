extends State

@export var approach: State
@export var fleeDistance: float = 1000

var oldFoePosition: Vector2

func enter()->void:
	# Get direction to foe
	var fleeVector: Vector2 = (foe.position + me.position.direction_to(foe.position).rotated(PI)*fleeDistance)
	me.path_finder.target_position = fleeVector
	oldFoePosition = foe.position
	me.travelTo = true
	
func update()->void:
	# Only update flee direction if foe has moved
	if foe.position != oldFoePosition:
		var fleeVector: Vector2 = (foe.position + me.position.direction_to(foe.position).rotated(PI)*fleeDistance)
		me.path_finder.target_position = fleeVector
		oldFoePosition = foe.position
		me.travelTo = true
	
	if me.canAttack:
		tranistion.emit(self, approach)
