extends Node


signal on_any_ui_appear
signal on_all_ui_closed
signal on_player_touched_object(object: InteractableObject)
signal on_player_departed_from_object


var gui: Gui

var _dict_spawn_points: Dictionary[SpawnPoints, Node2D]
var _player: Player
var _pcam: PhantomCamera2D
var _cam: Camera2D
var fade_transition: FadeTransition


func _ready() -> void:
	Dialogic.timeline_ended.connect(func(): on_all_ui_closed.emit())

	_player = get_tree().get_first_node_in_group("player")
	print(_player)

	_pcam = get_tree().get_first_node_in_group("pcam")
	print(_pcam)

	fade_transition = get_tree().get_first_node_in_group("fade_trans")
	print(fade_transition)

	_cam = get_tree().get_first_node_in_group("cam")
	print(_cam)

	var points = get_tree().get_nodes_in_group("spawn_points")
	for point: SpawnPoint in points:
		_dict_spawn_points[point.sp] = point
	print(_dict_spawn_points)


func start_dialogic(timeline: DialogicTimeLine):
	var timeline_name: String = DialogicTimeLine.find_key(timeline).to_lower()
	print(timeline_name)
	Dialogic.start(timeline_name)

	on_any_ui_appear.emit()


func move_player_to_spawn_point(sp: SpawnPoints, with_cover: bool = true, with_uncover: bool = true):
	if with_cover:
		fade_transition.cover()
		await get_tree().create_timer(fade_transition.default_cover_duration).timeout

	var level: Level = _dict_spawn_points[sp].get_parent() as Level
	_player.global_position = _dict_spawn_points[sp].global_position
	_pcam.follow_damping = false
	#_cam.global_position = _player.global_position
	#await get_tree().process_frame
	#_pcam.follow_mode = PhantomCamera2D.FollowMode.SIMPLE

	await get_tree().create_timer(0.1).timeout
	_pcam.follow_damping = true
	#_pcam.set_limit_target(level.limit_camera.get_path())

	if with_uncover:
		fade_transition.uncover()


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
