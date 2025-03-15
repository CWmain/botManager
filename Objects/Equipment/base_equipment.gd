extends Node2D

class_name Equipment

enum placement{
	HEAD,
	CHEST,
	FEET
}

@export var location: placement

func equipmentAffect():
	print_debug("Unmodified equipment Affect")
