extends PanelContainer

@export var botList: Array[Bot]
@onready var title: Label = $VBoxContainer/Title

var displayedBot: Bot = null

func _ready() -> void:
	for bot in botList:
		bot.showBotOptions.connect(_revealBotOptions)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Select") and visible:
		hide()
		#displayedBot = null

func _revealBotOptions(bot: Bot):
	displayedBot = bot
	position = get_viewport().get_mouse_position()
	title.text = bot.name
	print(bot)
	show()


func _on_heal_pressed() -> void:
	assert(displayedBot != null, "Trying to use menu without a displayed bot")
	displayedBot.curHealth = displayedBot.statTotals[Enums.MODIFICATION.MAX_HEALTH]
