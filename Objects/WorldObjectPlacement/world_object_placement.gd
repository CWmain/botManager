extends Node

@export var tml: TileMapLayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("PlaceObject"):
		var mousePos: Vector2 = get_viewport().get_mouse_position() if get_viewport().get_camera_2d()==null else get_viewport().get_camera_2d().get_global_mouse_position()
		var mouseInMap: Vector2 = tml.local_to_map(mousePos)

		tml.set_cell(mouseInMap, 1, Vector2i.ZERO, 1)
