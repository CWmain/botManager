@tool
extends Node2D
class_name CompoundBase

@export var statChange: Dictionary[compoundBot.STATS, float]
@export var EID: String = "Default":
	set(value):
		EID = value
		_get_configuration_warnings()
		update_configuration_warnings()

@export var texture: Sprite2D = null:
	set(value):
		texture = value
		_get_configuration_warnings()
		update_configuration_warnings()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	
	# Check wheel texture is assigned
	if texture == null:
		warnings = ["Missing Sprite2D in texture"]
	
	# Ensure wheel has id
	if EID == "Default" or EID.length() < 3:
		warnings.append("Assign EID of length 3")
	
	return warnings
