@tool
extends CompoundBase
class_name WheelBase

func dash() -> void:
	printerr("unimplemnted Dash")
	

func _get_configuration_warnings():
	var warnings = super()
	if name != "WheelBase":
		warnings.append("Unimplemented dash")
	return warnings
