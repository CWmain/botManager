extends State

@export var idle: State

func enter()->void:
	print("In Attack")

func update()->void:
	doAttack()

func doAttack()->void:
	me.doAttack()
	tranistion.emit(self, idle)
