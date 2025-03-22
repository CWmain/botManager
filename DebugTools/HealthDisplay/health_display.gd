extends Label

@export var toDisplay: Bot
var timer: float = 0

func _ready() -> void:
	assert(toDisplay != null, "HealthDisplay is unassigned")


func _process(delta: float) -> void:
	timer += delta
	if (timer > 0.1):
		timer -= 0.1
		text = str(toDisplay.curHealth)
		position = toDisplay.position+Vector2(0,-48)
