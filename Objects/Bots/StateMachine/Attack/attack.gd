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

func doAttack()->void:
	me.doAttack()

func finishAttack()->void:
	tranistion.emit(self, idle)
	
