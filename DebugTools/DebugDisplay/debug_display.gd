extends VBoxContainer

@export var toDisplay: Bot
var timer: float = 0

@onready var bot_name: Label = $BotName
@onready var health: Label = $Health

func _ready() -> void:
	assert(toDisplay != null, "DebugDisplay is unassigned")
	bot_name.text = toDisplay.name


func _process(delta: float) -> void:
	timer += delta
	if (timer > 0.1):
		timer -= 0.1
		health.text = str(toDisplay.curHealth)
		position = toDisplay.position+Vector2(0,-16-size.y)
