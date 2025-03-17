extends Node


signal on_any_ui_appear
signal on_all_ui_closed
signal on_player_touched_object(object: InteractableObject)
signal on_player_departed_from_object


var gui: Gui


func _ready() -> void:
	Dialogic.timeline_ended.connect(on_timeline_ended)


func start_dialogic(timeline: DialogicTimeLine):
	var timeline_name: String = DialogicTimeLine.find_key(timeline).to_lower()
	print(timeline_name)
	Dialogic.start(timeline_name)

	on_any_ui_appear.emit()




func on_timeline_ended():
	on_all_ui_closed.emit()


enum DialogicTimeLine{
	None,

	T_TABLE_0 = 10,

	T_COMPUTER_0 = 20
}

enum Levels{
	None,
	Home,
	Corridor
}
