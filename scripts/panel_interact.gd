class_name PanelInteract
extends Control


func show_panel(pos: Vector2):
	position = pos
	visible = true
	set_focus_neighbor(SIDE_TOP, focus_neighbor_top)


func hide_panel():
	visible = false
