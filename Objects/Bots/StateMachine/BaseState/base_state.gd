extends Node
class_name State

signal tranistion(from: State, to: State)

@export var me: Bot
@export var foe: Bot

func enter()->void:
	printerr("Enter not implemented")
	
func update()->void:
	printerr("%s update not implemented" % name)
	
