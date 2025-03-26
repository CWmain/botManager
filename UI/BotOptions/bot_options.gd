extends PanelContainer

@export var botList: Array[Bot]
@export var home: SubViewport
@export var dojo: SubViewport

@onready var title: Label = $VBoxContainer/Title

var displayedBot: Bot = null

func _ready() -> void:
	for bot in botList:
		bot.showBotOptions.connect(_revealBotOptions)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Select") and visible:
		_hideBotOptions()

func _revealBotOptions(bot: Bot):
	displayedBot = bot
	var mousePosition: Vector2 = get_viewport().get_mouse_position()
	var windowSize: Vector2 = DisplayServer.window_get_size()
	
	# Adjusts the position of the opened window to 
	# allows be within the visable screen
	position = mousePosition
	if mousePosition.x > windowSize.x / 2.0:
		position.x -= size.x
	if mousePosition.y > windowSize.y / 2:
		position.y -= size.y
	
	# Display unique bot information
	title.text = bot.name
	
	show()

func _hideBotOptions()->void:
	hide()
	# remove the displayedBot when menu is closed
	displayedBot = null

func _on_heal_pressed() -> void:
	assert(displayedBot != null, "Trying to use menu without a displayed bot")
	# Looks up the max health and sets current health to that value
	displayedBot.curHealth = int(displayedBot.statTotals[Enums.MODIFICATION.MAX_HEALTH])


func _on_go_home_pressed() -> void:
	displayedBot.goToSubviewport(home)
	_hideBotOptions()


func _on_go_dojo_pressed() -> void:
	displayedBot.goToSubviewport(dojo)
	_hideBotOptions()
