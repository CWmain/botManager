extends CharacterBody2D

@export_group("Color", "c_")
@export var c_original: Texture2D
@export var c_reColor: Texture2D

## Contains all base stats of the bot[br]
## Dictionary accessed via Enums.MODIFICATION
@export var statBases: Dictionary[Enums.MODIFICATION, float]:
	set(value):
		statBases = value
		updateStatTotals()

## Contains all total stats of the bot[br]
## Dictionary accessed via Enums.MODIFICATION
var statTotals: Dictionary[Enums.MODIFICATION, float]

@export_group("Equipped", "e_")
@export var e_head: PackedScene
@export var e_body: PackedScene
@export var e_legs: PackedScene

var curHead: Equipment
var curBody: Equipment
var curLegs: Equipment

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var path_finder: NavigationAgent2D = $PathFinder
@onready var camera_2d: Camera2D = $Camera2D

var travelTo = false

## Stores the calculation breakdown of each element
var modifierTracker: Dictionary[Enums.MODIFICATION, Array]

func _ready() -> void:
	sprite_2d.material.set_shader_parameter("original", c_original)
	sprite_2d.material.set_shader_parameter("recolor", c_reColor)	
	updateStatTotals()
	print_modifer_tracker()
	path_finder.target_position = Vector2(150,100)
	travelTo = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("GoTo"):
		path_finder.target_position = get_viewport().get_mouse_position()
		travelTo = true
	if Input.is_action_just_pressed("BotCam"):
		camera_2d.enabled = true
	if Input.is_action_just_released("BotCam"):
		camera_2d.enabled = false

func _physics_process(delta: float) -> void:
	var nextPathPosition = path_finder.get_next_path_position()
	rotation = (nextPathPosition - global_position).angle()+PI/2
	
	if travelTo:
		curLegs.playAnimation()
		var moveDirection: Vector2 = Vector2(0,-1).rotated(rotation)
		velocity = moveDirection*statTotals[Enums.MODIFICATION.MOVESPEED]*delta
	else:
		curLegs.endAnimation()
		velocity = Vector2.ZERO
	
	move_and_slide()

## Function which prints out the data in modifierTracker in a clean way
func print_modifer_tracker():
	for mtype in modifierTracker:
		print(Enums.MODIFICATION.find_key(mtype))
		for pair in modifierTracker[mtype]:
			print("	Added %f from equipment %s" % [pair[1], pair[0]])

## Called to recalculate totalStats (i.e moveSpeed)
func updateStatTotals():
	if e_head != null:
		if curHead != null:
			curHead.queue_free()
		curHead = e_head.instantiate()
		curHead.position = Vector2(0,-16)
		add_child(curHead)
		calculateStatsFromEquipment(curHead)
		
	if e_body != null:
		if curBody != null:
			curBody.queue_free()
		curBody = e_body.instantiate()
		curBody.position = Vector2(0,0)
		add_child(curBody)
		calculateStatsFromEquipment(curBody)
		
	if e_legs != null:
		if curLegs != null:
			curLegs.queue_free()
		curLegs = e_legs.instantiate()
		curLegs.position = Vector2(0,16)
		add_child(curLegs)
		calculateStatsFromEquipment(curLegs)

## Calculate the total stats and apply their passive effect onto totalStats
func calculateStatsFromEquipment(equipment: Equipment):
	var statChanges: Dictionary[Enums.MODIFICATION, float] = equipment.statModifers
	statTotals = statBases.duplicate()
	for change in statChanges:
		# Applies change to total stats
		if statTotals.has(change):
			statTotals[change] += statChanges[change]
		else:
			printerr("Enum %s from %s not in StatBases" % [Enums.MODIFICATION.find_key(change), equipment.EID])
		
		# Records the equipment and the change caused for stat breakdown
		if modifierTracker.has(change):
			modifierTracker[change].append([equipment.name, statChanges[change]])
		else:
			modifierTracker[change] = [[equipment.name, statChanges[change]]]


func _on_path_finder_navigation_finished() -> void:
	travelTo = false
