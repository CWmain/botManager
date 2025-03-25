extends State

@export var attack: State
@export var wonder: State

var triggerTranisition: bool = false
var isConnected: bool = false

func enter()->void:
	if !isConnected:
		me.withinAttackRange.connect(goToNextState)
		me.outOffAttackRange.connect(preventNextState)
		isConnected = true
	me.path_finder.target_position = foe.position
	me.travelTo = true
	
	
func update()->void:
	me.path_finder.target_position = foe.position
	me.travelTo = true
	
	
	if foe.curHealth <= 0:
		tranistion.emit(self, wonder)
	
	if triggerTranisition:
		tranistion.emit(self, attack)
	
func goToNextState()->void:
	triggerTranisition = true

func preventNextState()->void:
	triggerTranisition = false
