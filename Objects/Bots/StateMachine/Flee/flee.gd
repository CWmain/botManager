extends State

@export var approach: State
@export var fleeDistance: float = 1000
@export var rayCast: RayCast2D

var oldFoePosition: Vector2
var perpendicular: bool = false
func enter()->void:
	# Get direction to foe
	var fleeVector: Vector2 = (foe.position + me.position.direction_to(foe.position).rotated(PI)*fleeDistance)
	me.path_finder.target_position = fleeVector
	oldFoePosition = foe.position
	me.travelTo = true
	
func update()->void:
	if me.path_finder.is_navigation_finished():
		print("End of path")
		perpendicular = false
	
	if rayCast.is_colliding() and foe.position != oldFoePosition:
		print(rayCast.get_collider())
		print("Ray cast colliding")
		oldFoePosition = foe.position
		var fleeVector: Vector2 = (foe.position + me.position.direction_to(foe.position).rotated(PI/2)*fleeDistance)
		me.path_finder.target_position = fleeVector
		me.travelTo = true
		perpendicular = true
	# Only update flee direction if foe has moved
	elif foe.position != oldFoePosition and !perpendicular:
		var fleeVector: Vector2 = (foe.position + me.position.direction_to(foe.position).rotated(PI)*fleeDistance)
		me.path_finder.target_position = fleeVector
		oldFoePosition = foe.position
		me.travelTo = true
	
	if me.canAttack:
		tranistion.emit(self, approach)
