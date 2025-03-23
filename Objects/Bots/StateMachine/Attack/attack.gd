extends State

@export var idle: State
var isConnected: bool = false
func enter()->void:
	if !isConnected:
		me.attackComplete.connect(finishAttack)
		isConnected = true
	print("In Attack")

func update()->void:
	me.travelTo = false
	doAttack()
	var idealRotation: float = (foe.position - me.position).angle()+PI/2
	me.rotation = rotate_toward(me.rotation, idealRotation, me.statTotals[Enums.MODIFICATION.ROTATIONSPEED])

func doAttack()->void:
	me.doAttack()

func finishAttack()->void:
	tranistion.emit(self, idle)
	
