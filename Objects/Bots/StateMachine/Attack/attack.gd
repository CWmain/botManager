extends State

@export var idle: State

func enter()->void:
	print("In Attack")

func update()->void:
	doAttack()

func doAttack()->void:
	print("Unimplemented attack, imagine some cool animation")
	me.doAttack()
	tranistion.emit(self, idle)
