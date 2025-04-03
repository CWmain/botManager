@tool
extends WheelBase

func _ready() -> void:
	if Engine.is_editor_hint():
		dash()
	if has_method("dash"):
		print("Method exists")
	else:
		print("It does not")
		
func dash():
	print("Implemented dash")
