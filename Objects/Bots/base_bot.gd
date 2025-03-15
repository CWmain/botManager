extends Node2D

@export_group("Color", "c_")
@export var c_original: Texture2D
@export var c_reColor: Texture2D

@export var baseMoveSpeed: float = 20
@export var baseRotationSpeed: float = 1

@export_group("Equipped", "e_")
@export var e_head: PackedScene
@export var e_body: PackedScene
@export var e_legs: PackedScene

var curHead: Equipment
var curBody: Equipment
var curLegs: Equipment

@onready var sprite_2d: Sprite2D = $Sprite2D

## Stores the calculation breakdown of each element
var modifierTracker: Dictionary[Enums.MODIFICATION, Array]

## The total calculate movespeed
var totalMoveSpeed: float = 0
var totalRotationSpeed: float = 0

func _ready() -> void:
	sprite_2d.material.set_shader_parameter("original", c_original)
	sprite_2d.material.set_shader_parameter("recolor", c_reColor)	
	updateEquipment()
	print_modifer_tracker()

func _process(delta: float) -> void:	
	var hor: float = Input.get_axis("ui_left", "ui_right")
	rotation += hor*delta*totalRotationSpeed
	var ver: float = Input.get_axis("ui_up", "ui_down")
	if ver:
		curLegs.playAnimation()
	else:
		curLegs.endAnimation()
	
	var moveDirection: Vector2 = Vector2(0,ver).normalized().rotated(rotation)
	position += moveDirection*totalMoveSpeed*delta

## Function which prints out the data in modifierTracker in a clean way
func print_modifer_tracker():
	for mtype in modifierTracker:
		print(Enums.MODIFICATION.find_key(mtype))
		for pair in modifierTracker[mtype]:
			print("	Added %f from equipment %s" % [pair[1], pair[0]])

## Called to recalculate totalStats (i.e moveSpeed)
func updateEquipment():
	if e_head != null:
		if curHead != null:
			curHead.queue_free()
		curHead = e_head.instantiate()
		curHead.position = Vector2(0,-16)
		add_child(curHead)
		calculateTotalStats(curHead)
		
	if e_body != null:
		if curBody != null:
			curBody.queue_free()
		curBody = e_body.instantiate()
		curBody.position = Vector2(0,0)
		add_child(curBody)
		calculateTotalStats(curBody)
		
	if e_legs != null:
		if curLegs != null:
			curLegs.queue_free()
		curLegs = e_legs.instantiate()
		curLegs.position = Vector2(0,16)
		add_child(curLegs)
		calculateTotalStats(curLegs)

## Calculate the total stats and apply their passive effect onto totalStats
func calculateTotalStats(equipment: Equipment):
	var statChanges: Dictionary[Enums.MODIFICATION, float] = equipment.statModifers
	totalMoveSpeed = baseMoveSpeed
	totalRotationSpeed = baseRotationSpeed
	for change in statChanges:
		match change:
			Enums.MODIFICATION.MOVESPEED:
				totalMoveSpeed += statChanges[change]
			Enums.MODIFICATION.ROTATIONSPEED:
				totalRotationSpeed += statChanges[change]
			_:
				printerr("Unhandled Enum %s in %s" % [Enums.MODIFICATION.find_key(change), equipment.name])
		if modifierTracker.has(change):
			modifierTracker[change].append([equipment.name, statChanges[change]])
		else:
			modifierTracker[change] = [[equipment.name, statChanges[change]]]
