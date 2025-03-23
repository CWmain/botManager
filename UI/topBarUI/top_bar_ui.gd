extends HBoxContainer

signal showHome
signal showDojo

func _on_home_button_pressed() -> void:
	showHome.emit()
	
func _on_dojo_button_pressed() -> void:
	showDojo.emit()
