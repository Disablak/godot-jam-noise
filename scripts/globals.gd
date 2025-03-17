extends Node


signal on_any_ui_appear
signal on_all_ui_closed
signal on_player_touched_object(object: InteractableObject)
signal on_player_departed_from_object


var gui: Gui
var _dict_spawn_points: Dictionary[SpawnPoints, Vector2]
var _player: Player


func _ready() -> void:
	Dialogic.timeline_ended.connect(func(): on_all_ui_closed.emit())

	_player = get_tree().get_first_node_in_group("player")
	print(_player)

	var points = get_tree().get_nodes_in_group("spawn_points")
	for point: SpawnPoint in points:
		_dict_spawn_points[point.sp] = point.global_position
	print(_dict_spawn_points)


func start_dialogic(timeline: DialogicTimeLine):
	var timeline_name: String = DialogicTimeLine.find_key(timeline).to_lower()
	print(timeline_name)
	Dialogic.start(timeline_name)

	on_any_ui_appear.emit()


func move_player_to_spawn_point(sp: SpawnPoints):
	_player.global_position = _dict_spawn_points[sp]


enum DialogicTimeLine{
	None,

	T_TABLE_0 = 10,

	T_COMPUTER_0 = 20
}

enum Levels{
	None = 0,
	Home = 1,
	Corridor = 2
}

enum SpawnPoints{
	None = 0,

	HomeNearBed,
	HomeNearDoor,
	HomeNearPC,

	CorridorNearHouse = 10
}
