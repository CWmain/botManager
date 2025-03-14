extends Sprite2D

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_down"):
		print("Attempting to work")
		position.y += 1
		print(position)
