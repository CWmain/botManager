extends Node2D

var toClear: bool = false 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RemoveObject") and toClear:
		queue_free()

func _on_area_2d_mouse_entered() -> void:
	toClear = true

func _on_area_2d_mouse_exited() -> void:
	toClear = false
