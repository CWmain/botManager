extends ColorRect

@export var toTrack: CharacterBody2D

func _process(delta: float) -> void:
	material.set_shader_parameter("toTrack", toTrack.global_position)
