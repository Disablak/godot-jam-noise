class_name PanelInteract
extends Control


@onready var container = $VBoxContainer


func show_panel(pos: Vector2, res_interact: ResInteract):
	position = pos
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
		btn.button_down.connect(func(): _on_click_btn(option.time_line))
		btn.text = option.title
		container.add_child(btn)


func _on_click_btn(timeline):
	Globals.start_dialogic(timeline)
	hide_panel()
