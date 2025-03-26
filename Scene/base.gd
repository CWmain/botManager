extends Control

@onready var dojo: SubViewportContainer = $Dojo
@onready var home: SubViewportContainer = $Home

func _on_top_bar_ui_show_dojo() -> void:
	dojo.show()
	home.hide()


func _on_top_bar_ui_show_home() -> void:
	home.show()
	dojo.hide()
#
#func _input(event: InputEvent) -> void:
	#if dojo.visible:
		#dojo.get_children()[0].push_input(event)

func _on_test_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	printerr("On Hover!")


func _on_color_rect_mouse_entered() -> void:
	printerr("NNNNN")


func _on_test_mouse_entered() -> void:
	printerr("Mouse entered")
