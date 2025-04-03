@tool
extends CompoundBase
class_name WheelBase

func dash() -> bool:
	update_configuration_warnings()
	return false

func _get_configuration_warnings():
	var warnings = super()
	warnings.append("Unimplemented dash")
	return warnings
