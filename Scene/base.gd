extends Control

@onready var dojo: SubViewportContainer = $Dojo
@onready var home: SubViewportContainer = $Home

func _on_top_bar_ui_show_dojo() -> void:
	dojo.show()
	home.hide()


func _on_top_bar_ui_show_home() -> void:
	home.show()
	dojo.hide()
