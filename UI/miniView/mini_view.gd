extends SubViewportContainer

## The node 2d to center the camera on[br] 
## The viewport is derived from toTack
@export var toTrack: Node2D: 
	set(value):
		toTrack = value
		updateViewportWorld2D()

## The amount of zoom on the camera
@export_range(0, 10, 0.1, "or_less", "or_greater") var cameraZoomScale: float = 1.0:
	set(value):
		cameraZoomScale = value
		if camera_2d != null:
			camera_2d.zoom = Vector2(cameraZoomScale,cameraZoomScale)

@onready var camera_2d: Camera2D = $SubViewport/Camera2D
@onready var sub_viewport: SubViewport = $SubViewport

func _ready() -> void:
	updateViewportWorld2D()
	camera_2d.zoom = Vector2(cameraZoomScale,cameraZoomScale)

func _process(_delta: float) -> void:
	if toTrack != null:
		camera_2d.position = toTrack.position
		camera_2d.rotation = toTrack.rotation

## Call updateViewportWorld2D whenever the target moves worlds
func updateViewportWorld2D():
	if toTrack == null || sub_viewport == null:
		return
	sub_viewport.world_2d = toTrack.get_viewport().world_2d
