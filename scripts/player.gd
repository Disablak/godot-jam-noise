class_name Player
extends CharacterBody2D


@export var speed: float = 10

var _last_collision_id: int = -1


func _update_velocity_by_inputs(delta):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed * delta


func _physics_process(delta: float) -> void:
	_update_velocity_by_inputs(delta)
	move_and_slide()
	_manage_collision()


func _manage_collision():
	var last_collision: KinematicCollision2D = get_last_slide_collision()
	if last_collision:
		if _last_collision_id != last_collision.get_collider_id():
			_last_collision_id = last_collision.get_collider_id()
			print(_last_collision_id)
	else:
		_last_collision_id = -1
