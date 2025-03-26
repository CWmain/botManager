extends PanelContainer

@export var botList: Array[Bot]
@onready var title: Label = $VBoxContainer/Title

func _ready() -> void:
	for bot in botList:
		bot.showBotOptions.connect(_revealBotOptions)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Select") and visible:
		hide()

func _revealBotOptions(bot: Bot):
	position = get_viewport().get_mouse_position()
	title.text = bot.name
	show()
