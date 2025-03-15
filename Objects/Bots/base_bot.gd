extends Node2D

@export_group("Color", "c_")
@export var c_original: PackedColorArray
@export var c_reColor: PackedColorArray

@export var baseMoveSpeed: float = 10
## Dictionary containing the moveSpeed modifier and the source
var moveSpeedModifiers: Dictionary[String, float]

## The total calculate movespeed
var totalMoveSpeed: float = 1

@export var equipped: Array[PackedScene]

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.material.set_shader_parameter("original", c_original)
	sprite_2d.material.set_shader_parameter("recolor", c_reColor)
	print(totalMoveSpeed)
	for packed in equipped:
		var e: Equipment = packed.instantiate()
		add_child(e)

		if e.location == e.placement.FEET:
			e.position.y = 16
			e.position.x = 0
			moveSpeedModifiers[e.name] = e.moveSpeed
			
	for modifier in moveSpeedModifiers:
		print("Gained %f from %s" % [moveSpeedModifiers[modifier], modifier])
		totalMoveSpeed += moveSpeedModifiers[modifier]
		
	print(totalMoveSpeed)

func _process(_delta: float) -> void:
	var hor: float = Input.get_axis("ui_left", "ui_right")
	var ver: float = Input.get_axis("ui_up", "ui_down")
	var moveDirection: Vector2 = Vector2(hor,ver).normalized()
	position += moveDirection*totalMoveSpeed
	
	
