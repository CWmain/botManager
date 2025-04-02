@tool
extends CompoundBase
class_name WheelBase

var wheel_texture: Sprite2D = null

func _ready() -> void:			
	child_entered_tree.connect(_on_child_entered_tree)
	child_exiting_tree.connect(_on_child_exiting_tree)
	_get_configuration_warnings()
	update_configuration_warnings()
	
	#wheel_texture.texture = sprite

# Add any wheel related functions here
func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if wheel_texture == null:
		warnings = ["Missing Sprite2D as child"]
	return warnings

func _on_child_entered_tree(node: Node) -> void:
	if node is Sprite2D:
		wheel_texture = node

func _on_child_exiting_tree(node: Node) -> void:
	if node is Sprite2D:
		wheel_texture = null
