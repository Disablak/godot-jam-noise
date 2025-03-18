class_name Player
extends CharacterBody2D


@export var speed: float = 10

var _last_collision_id: int = -1
var _last_inter_object: InteractableObject


func _ready() -> void:
	Globals.on_any_ui_appear.connect(_on_any_ui_appear)
	Globals.on_all_ui_closed.connect(_on_all_ui_closed)


func _update_velocity_by_inputs(delta):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed * delta


func _physics_process(delta: float) -> void:
	_update_velocity_by_inputs(delta)
	move_and_slide()
	_manage_collision()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and _last_inter_object:
		Globals.on_player_touched_object.emit(_last_inter_object)


func _manage_collision():
	var last_collision: KinematicCollision2D = get_last_slide_collision()
	if last_collision:
		if _last_collision_id != last_collision.get_collider_id():
			_last_inter_object = last_collision.get_collider() as InteractableObject
			if _last_inter_object:
				_last_collision_id = last_collision.get_collider_id()
				_last_inter_object.outline(true)
				#Globals.on_player_touched_object.emit(_last_inter_object)
				#_show_panel_interaction(last_collision.get_position())
				#print(_last_collision_id)
	else:
		if _last_collision_id != -1:
			_last_collision_id = -1
			_last_inter_object.outline(false)
			_last_inter_object = null
			Globals.on_player_departed_from_object.emit()


func _on_any_ui_appear():
	set_physics_process(false)


func _on_all_ui_closed():
	set_physics_process(true)
