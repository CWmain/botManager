extends State

var isConnect: bool = false
var updateTargetPosition: bool = false

@onready var update_target_position_delay: Timer = $updateTargetPositionDelay

func enter()->void:
	if !isConnect:
		me.path_finder.navigation_finished.connect(toggleUpdateTargetPosition)
	
func update()->void:
	if me.wall_detector.is_colliding():
		me.path_finder.target_position = randomLocation()
		me.travelTo = true
		update_target_position_delay.stop()
	if updateTargetPosition:

		me.path_finder.target_position = randomLocation()
		me.travelTo = true
		updateTargetPosition = false

func randomLocation()->Vector2:
	return Vector2(100+randf()*200,100+randf()*200)

func toggleUpdateTargetPosition():
	if update_target_position_delay.is_stopped():
		update_target_position_delay.start()


func _on_update_target_position_delay_timeout() -> void:
	updateTargetPosition = true
