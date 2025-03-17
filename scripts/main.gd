extends Node


func _ready() -> void:
	Globals.gui = $GUI

	Globals.move_player_to_spawn_point(Globals.SpawnPoints.HomeNearBed)
