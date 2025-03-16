extends SubViewport

@export var toCopy: SubViewport

func _ready() -> void:
	world_2d = toCopy.world_2d
