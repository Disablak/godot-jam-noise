class_name PanelInteract
extends Control


@onready var container = $VBoxContainer


func show_panel(pos: Vector2, res_interact: ResInteract):
	global_position = pos
	visible = true

	#set_focus_neighbor(SIDE_TOP, focus_neighbor_top)

	_spawn_btns(res_interact)


func hide_panel():
	visible = false


func _spawn_btns(res_interact: ResInteract):
	for child in container.get_children():
		child.queue_free()

	for option in res_interact.options:
		var btn = Button.new()
		btn.button_down.connect(func(): _on_click_btn(option))
		btn.text = option.title
		container.add_child(btn)


func _on_click_btn(option: ResInteractOption):
	hide_panel()

	if option.time_line != Globals.DialogicTimeLine.None:
		Globals.start_dialogic(option.time_line)
		return

	if option.move_to_sp != Globals.SpawnPoints.None:
		Globals.move_player_to_spawn_point(option.move_to_sp)
		return
