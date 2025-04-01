extends CharacterBody2D
class_name worldBot

@export var wheels: PackedScene
@export var chassis: PackedScene
@export var weapon: PackedScene
@export var brain: PackedScene

func _ready() -> void:
	#Initialise and place all bot componenets
	add_child(wheels.instantiate())
	add_child(chassis.instantiate())
	add_child(weapon.instantiate())
	add_child(brain.instantiate())
	printerr("WORK")
