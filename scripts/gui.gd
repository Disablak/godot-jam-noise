class_name Gui
extends Control


@onready var panel_interact: PanelInteract = $PanelInteract


func _ready() -> void:
	Globals.on_player_touched_object.connect(_on_player_touched_object)
	Globals.on_player_departed_from_object.connect(_on_player_departed_from_object)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		panel_interact.hide_panel()
		Globals.on_all_ui_closed.emit()


func _on_player_touched_object(object: InteractableObject):
	panel_interact.show_panel(object.global_position, object.res_interact)


func _on_player_departed_from_object():
	panel_interact.hide_panel()
