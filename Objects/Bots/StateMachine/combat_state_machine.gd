extends Node

@export var me: Bot
@export var foe: Bot

@export var initialState: State

var currentState: State:
	set(value):
		if (currentState != null):
			print("%s: Change state %s -> %s" % [get_parent().name, currentState.name, value.name])
		value.enter()
		currentState = value

func _ready() -> void:
	currentState = initialState
	call_deferred("connectChildren")
	

func connectChildren()-> void:
	for child: State in get_children():
		child.tranistion.connect(transistionState)
		child.me = me
		child.foe = foe

func _process(_delta: float) -> void:
	currentState.update()

func transistionState(from: State, to: State)->void:
	if from != currentState:
		printerr("Attempting to transition from %s when current state is %s" % [from.name, currentState.name])
		return
	if to == null:
		printerr("Attempting to transition from %s to NULL" % [from.name])
		return
	currentState = to
	
