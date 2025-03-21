extends State

@export var approach: State
@export var fleeDistance: float = 1000

var oldFoePosition: Vector2
var goPerpendicular: bool = false
func enter()->void:
	# Get direction to foe
	var fleeVector: Vector2 = (foe.position + me.position.direction_to(foe.position).rotated(PI)*fleeDistance)
	me.path_finder.target_position = fleeVector
	oldFoePosition = foe.position
	me.travelTo = true
	
	goPerpendicular = false
	
func update()->void:
	# Finished travelling perdicular so reset bool, allowing for foward travel
	if me.path_finder.is_navigation_finished() and goPerpendicular:
		goPerpendicular = false
	
	# If the bot raycast hits a wall, set the target location to a spot perpendicular to the target bot
	# TODO: Current formula is not perpendicular but works, may want to revise later
	if me.wall_detector.is_colliding():
		oldFoePosition = foe.position
		var fleeVector: Vector2 = (foe.position + me.position.direction_to(foe.position).rotated(PI/2)*fleeDistance)
		me.path_finder.target_position = fleeVector
		me.travelTo = true
		goPerpendicular = true
		
	# Only update flee direction if foe moved and not travelling away from a wall
	if foe.position != oldFoePosition and !goPerpendicular:
		var fleeVector: Vector2 = (foe.position + me.position.direction_to(foe.position).rotated(PI)*fleeDistance)
		me.path_finder.target_position = fleeVector
		oldFoePosition = foe.position
		me.travelTo = true
	
	if me.canAttack:
		tranistion.emit(self, approach)
