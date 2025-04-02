@tool
extends CompoundBase
class_name WheelBase

var wheel_texture: Sprite2D = null

func _ready() -> void:			
	child_entered_tree.connect(_on_child_entered_tree)
	child_exiting_tree.connect(_on_child_exiting_tree)
	
	for child in get_children():
		if child is Sprite2D:
			wheel_texture = child

# Add any wheel related functions here
func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	
	# Check wheel texture is assigned
	if wheel_texture == null:
		warnings = ["Missing Sprite2D as child"]
	
	# Check only 1 wheel texture assigned
	var spriteCount: int = 0
	for child in get_children():
		if child is Sprite2D:
			spriteCount += 1
	if spriteCount > 1:
		warnings.append("Too many Sprite2D, should only have %s" % wheel_texture.name)

	# Ensure wheel has id
	if EID == "Default" or EID.length() < 3:
		warnings.append("Assign EID of length 3")
	
	return warnings

func _on_child_entered_tree(node: Node) -> void:
	# Only assign wheel texture when wheel is assigned
	if node is Sprite2D and wheel_texture == null:
		wheel_texture = node

func _on_child_exiting_tree(node: Node) -> void:
	# Only remove from wheel texture if it is the current texture
	if node == wheel_texture:
		wheel_texture = null
		for child in get_children():
			if node == child or child is not Sprite2D:
				continue
			wheel_texture = child
			break
			
