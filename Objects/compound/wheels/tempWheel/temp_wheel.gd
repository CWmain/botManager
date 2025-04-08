@tool
extends WheelBase

func _ready() -> void:
	if Engine.is_editor_hint():
		dash()
	if has_method("dash"):
		print("Method exists")
	else:
		print("It does not")
		
func dash() -> void:
	update_configuration_warnings()
	print("Implemented dash")
	
func _get_configuration_warnings():
	var warnings = super()
	if dash == self.dash:
		warnings.append("Unimplemented dash")
	return warnings
