@tool
extends CompoundBase
class_name WheelBase

func dash() -> void:
	update_configuration_warnings()
	

func _get_configuration_warnings():
	var warnings = super()
	warnings.append("Unimplemented dash")
	return warnings
