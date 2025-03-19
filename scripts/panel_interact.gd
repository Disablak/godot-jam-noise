class_name PanelInteract
extends Control


@onready var container = $VBoxContainer


var _cur_res_interact: ResInteract


func _ready() -> void:
	for i in container.get_child_count():
		var btn: Button = container.get_child(i)
		btn.button_down.connect(func(): _on_click(i))


func show_panel(pos: Vector2, res_interact: ResInteract):
	global_position = pos
	visible = true
	_cur_res_interact = res_interact

	_show_btns(res_interact)

	await get_tree().process_frame
	await get_tree().process_frame

	var count = res_interact.options.size()
	size = Vector2(
		size.x,
		(container.get_child(0).size.y * count) + (4 * (count - 1))
	)

	container.get_child(0).grab_focus()
	#print("panel showed")


func hide_panel():
	if not visible:
		return

	visible = false
	Globals.on_all_ui_closed.emit()
	release_focus()
	#print("panel hided")


func _show_btns(res_interact: ResInteract):
	# hide btns
	for child in container.get_children():
		child.visible = false

	# set btns
	for i in res_interact.options.size():
		var btn: Button = container.get_child(i)
		var option: ResInteractOption = res_interact.options[i]
		btn.visible = true
		btn.text = option.title

	# set focus
	var count: int = res_interact.options.size()
	for i in count:
		var btn: Button = container.get_child(i)

		btn.focus_neighbor_bottom = ""
		btn.focus_neighbor_top = ""

		if i + 1 < count:
			btn.focus_neighbor_bottom = container.get_child(i + 1).get_path()

		if i - 1 >= 0:
			btn.focus_neighbor_top = container.get_child(i - 1).get_path()


func _on_click(id: int):
	_on_click_btn(_cur_res_interact.options[id])


func _on_click_btn(option: ResInteractOption):
	if option.time_line != Globals.DialogicTimeLine.None:
		Globals.start_dialogic(option.time_line)
		hide_panel()
		return

	if option.move_to_sp != Globals.SpawnPoints.None:
		Globals.move_player_to_spawn_point(option.move_to_sp)
		hide_panel()
		return
