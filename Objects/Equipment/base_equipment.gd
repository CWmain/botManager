extends Node2D

class_name Equipment

enum placement{
	HEAD,
	BODY,
	LEGS
}

@export var location: placement
@export var toModify: Enums.MODIFICATION
@export var modifier: float

@export var statModifers: Dictionary[Enums.MODIFICATION, float]
	
## Does the effect of the equipment
func equipmentAffect():
	print_debug("Unmodified equipment Affect")
