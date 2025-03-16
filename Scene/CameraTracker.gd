extends Camera2D

@export var toFollow: CharacterBody2D
@export var cameraOn: bool = false: 
	set(value):
		cameraOn = value
		enabled = value
	

func _process(delta: float) -> void:
	position = toFollow.position
	rotation = toFollow.rotation

func toggleCamera() -> void:
	print("HI")
	enabled = !enabled
