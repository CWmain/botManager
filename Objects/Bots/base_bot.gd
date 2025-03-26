extends CharacterBody2D
class_name Bot

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

var curHealth: int = 1
# TODO: Refactor to take into account the source of the hit to give immunity
#		to, so multiple foes can hit but a single foe can not
var damageImmune: bool = false
@onready var damage_cooldown: Timer = $Timers/DamageCooldown

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

# State Machine
@onready var combat_state_machine: Node = $CombatStateMachine
@export var foe: Bot

# Attack
@onready var attack_cooldown: Timer = $Timers/AttackCooldown
var canAttack: bool = true

# Flee
@onready var wall_detector: RayCast2D = $WallDetector

# Death
@onready var bot_explode: CPUParticles2D = $Bot_Explode

# Moving Scenes
@export var home: SubViewport

# Bot Options
@onready var bot_options: PanelContainer = $BotOptions


signal attackComplete
signal withinAttackRange
signal outOffAttackRange

func _ready() -> void:
	combat_state_machine.foe = foe
	# Have to duplicate the material locally otherwise an update in
	# one instance updates all instances for recoloring
	sprite_2d.material = sprite_2d.material.duplicate()
	sprite_2d.material.set_shader_parameter("original", c_original)
	sprite_2d.material.set_shader_parameter("recolor", c_reColor)
	updateStatTotals()
	print_current_equipment()
	print_modifer_tracker()
	path_finder.target_position = Vector2(150,100)
	travelTo = true
	curHealth = int(statTotals[Enums.MODIFICATION.MAX_HEALTH])

func _process(_delta: float) -> void:
	if curHealth == 0:
		triggerDeath()
		
	if Input.is_action_just_pressed("GoTo") and foe == null:
		var mousePos: Vector2 = get_viewport().get_mouse_position() if get_viewport().get_camera_2d()==null else get_viewport().get_camera_2d().get_global_mouse_position()
		path_finder.target_position = mousePos
		travelTo = true
		
	if Input.is_action_just_pressed("BotCam"):
		camera_2d.enabled = !camera_2d.enabled
		camera_2d.make_current()

func _physics_process(delta: float) -> void:
	var nextPathPosition = path_finder.get_next_path_position()
	if travelTo:
		var idealRotation: float = (nextPathPosition - global_position).angle()+PI/2
		rotation = rotate_toward(rotation, idealRotation, statTotals[Enums.MODIFICATION.ROTATIONSPEED]*delta)		

		if Func.cmpRotations(rotation, idealRotation):
			if (curLegs != null):
				curLegs.playAnimation()
			var moveDirection: Vector2 = Vector2(0,-1).rotated(rotation)
			velocity = moveDirection*statTotals[Enums.MODIFICATION.MOVESPEED]*delta
		else:
			velocity = Vector2.ZERO
	else:
		if (curLegs != null):
			curLegs.endAnimation()
		velocity = Vector2.ZERO
	
	move_and_slide()

## Function which prints out the data in modifierTracker in a clean way
func print_modifer_tracker():
	print("For %s" % name)
	for mtype in modifierTracker:
		print(Enums.MODIFICATION.find_key(mtype))
		for pair in modifierTracker[mtype]:
			print("	Added %f from equipment %s" % [pair[1], pair[0]])

func print_current_equipment():
	var empty: String = "NONE"
	print("Equipment of ", name)
	print("	Head: ", empty if curHead==null else curHead.EID)
	print("	Body: ", empty if curBody==null else curBody.EID)
	print("	Legs: ", empty if curLegs==null else curLegs.EID)

## Called to recalculate totalStats (i.e moveSpeed)
func updateStatTotals():
	#TODO: Refactor logic to handle equiping null while having a curEquipment
	#		Already temp fixed for legs
	statTotals = statBases.duplicate()
	if e_head != null:
		if curHead != null:
			curHead.queue_free()
		curHead = e_head.instantiate()
		curHead.position = Vector2(0,-16)
		add_child(curHead)
		curHead.attackComplete.connect(_on_attack_complete)
		calculateStatsFromEquipment(curHead)
		
	if e_body != null:
		if curBody != null:
			curBody.queue_free()
		curBody = e_body.instantiate()
		curBody.position = Vector2(0,0)
		add_child(curBody)
		calculateStatsFromEquipment(curBody)
	
	if e_legs == null and curLegs != null:
		curLegs.queue_free()
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
	for change in statChanges:
		# Applies change to total stats
		if statTotals.has(change):
			statTotals[change] += statChanges[change]
		else:
			printerr("Enum %s from %s not in StatBases" % [Enums.MODIFICATION.find_key(change), equipment.EID])
		
		# Records the equipment and the change caused for stat breakdown
		if modifierTracker.has(change):
			modifierTracker[change].append([equipment.EID, statChanges[change]])
		else:
			modifierTracker[change] = [[equipment.EID, statChanges[change]]]

func doAttack()->void:
	##TODO Assumed all head is a weapon, fix this later
	if curHead != null and canAttack:
		curHead.equipmentAffect()
		canAttack = false
		attack_cooldown.wait_time = statTotals[Enums.MODIFICATION.ATTACK_COOLDOWN]
		attack_cooldown.start()

func damage_bot(damage: int):
	if damageImmune:
		return
	damageImmune = true
	damage_cooldown.start()
	curHealth -= damage

func wander()->void:
	path_finder.target_position = position + Vector2(randf()*200-100,randf()*200-100)
	travelTo = true
	

func _on_path_finder_navigation_finished() -> void:
	travelTo = false
	#wander()

#region Attack Range
func _on_attack_range_body_entered(body: Node2D) -> void:
	if body == foe:
		withinAttackRange.emit()
		
func _on_attack_range_body_exited(body: Node2D) -> void:
	if body == foe:
		outOffAttackRange.emit()
#endregion
func _head_reset() -> void:
	canAttack = true

func _on_attack_complete()->void:
	attackComplete.emit()

func _on_attack_cooldown_timeout() -> void:
	canAttack = true

func _on_damage_cooldown_timeout() -> void:
	damageImmune = false

func triggerDeath()->void:
	bot_explode.emitting = true

func _on_bot_explode_finished() -> void:
	reparent(home)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		if bot_options.visible:
			bot_options.hide()
		else:
			bot_options.show()

func _on_mouse_entered() -> void:
	printerr("Mouse Entered")
