extends CharacterBody2D
class_name worldBot

enum STATS{
	MOVESPEED,
	ROTATIONSPEED,
	CAPACITY,
	ATTACK_COOLDOWN,
	MAX_HEALTH
}

@export var statsBase: Dictionary[STATS, float]
var statsTotal: Dictionary[STATS, float]

## Stores the calculation breakdown of each element
var modifierTracker: Dictionary[Enums.MODIFICATION, Array]


@export var wheels: PackedScene
@export var chassis: PackedScene
@export var weapon: PackedScene
@export var brain: PackedScene



func _ready() -> void:
	#Initialise and place all bot componenets
	add_child(wheels.instantiate())
	add_child(chassis.instantiate())
	add_child(weapon.instantiate())
	add_child(brain.instantiate())

## Calculate the total stats and apply their passive effect onto totalStats
func calculateStatsFromEquipment(equipment: Equipment):
	var statsChange: Dictionary[Enums.MODIFICATION, float] = equipment.statModifers
	for change in statsChange:
		# Applies change to total stats
		if statsTotal.has(change):
			statsTotal[change] += statsChange[change]
		else:
			printerr("Enum %s from %s not in StatBases" % [Enums.MODIFICATION.find_key(change), equipment.EID])
		
		# Records the equipment and the change caused for stat breakdown
		if modifierTracker.has(change):
			modifierTracker[change].append([equipment.EID, statsChange[change]])
		else:
			modifierTracker[change] = [[equipment.EID, statsChange[change]]]
