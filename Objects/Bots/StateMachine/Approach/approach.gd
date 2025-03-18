extends State

@export var attack: State

var triggerTranisition: bool = false
var isConnected: bool = false
func enter()->void:
	if !isConnected:
		me.withinAttackRange.connect(goToNextState)
		isConnected = true
	me.path_finder.target_position = foe.position
	me.travelTo = true
	triggerTranisition = false
	
func update()->void:
	me.path_finder.target_position = foe.position
	me.travelTo = true
	if triggerTranisition:
		tranistion.emit(self, attack)
	
func goToNextState()->void:
	triggerTranisition = true
