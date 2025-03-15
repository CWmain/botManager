extends Node2D

@export_group("Color", "c_")
@export var c_original: PackedColorArray
@export var c_reColor: PackedColorArray

@export var baseMoveSpeed: float = 10




@export_group("Equipped", "e_")
@export var e_head: PackedScene
@export var e_body: PackedScene
@export var e_legs: PackedScene

var curHead: Equipment
var curBody: Equipment
var curLegs: Equipment

@onready var sprite_2d: Sprite2D = $Sprite2D


var modifiers: Dictionary[Enums.MODIFICATION, Array]
## The total calculate movespeed
var totalMoveSpeed: float = 1

func _ready() -> void:
	sprite_2d.material.set_shader_parameter("original", c_original)
	sprite_2d.material.set_shader_parameter("recolor", c_reColor)
	
	updateEquipment()
	print(totalMoveSpeed)

func _process(_delta: float) -> void:
	var hor: float = Input.get_axis("ui_left", "ui_right")
	rotation += hor*0.01
	var ver: float = Input.get_axis("ui_up", "ui_down")
	if ver:
		curLegs.playAnimation()
	else:
		curLegs.endAnimation()
	
	var moveDirection: Vector2 = Vector2(0,ver).normalized().rotated(rotation)
	position += moveDirection*totalMoveSpeed
	
## Called to recalculate totalStats (i.e moveSpeed)
func updateEquipment():
	var curEquipment: Equipment
	if e_head != null:
		curHead = e_head.instantiate()
		curHead.position = Vector2(0,-16)
		add_child(curHead)
		calculateTotalStats(curHead.statModifers)
		
	if e_body != null:
		curBody = e_body.instantiate()
		curBody.position = Vector2(0,0)
		add_child(curBody)
		calculateTotalStats(curBody.statModifers)
		
	if e_legs != null:
		curLegs = e_legs.instantiate()
		curLegs.position = Vector2(0,16)
		add_child(curLegs)
		calculateTotalStats(curLegs.statModifers)
		
	pass
func calculateTotalStats(statChanges: Dictionary[Enums.MODIFICATION, float]):
	for change in statChanges:
		match change:
			Enums.MODIFICATION.MOVESPEED:
				totalMoveSpeed += statChanges[change]
		print(statChanges[change])
	pass
