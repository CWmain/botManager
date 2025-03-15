extends Node2D

@export_group("Color", "c_")
@export var c_original: PackedColorArray
@export var c_reColor: PackedColorArray

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	sprite_2d.material.set_shader_parameter("original", c_original)
	sprite_2d.material.set_shader_parameter("recolor", c_reColor)
	
