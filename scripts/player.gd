class_name Player
extends CharacterBody2D


@export var speed: float = 10


func _update_velocity_by_inputs(delta):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed * delta


func _physics_process(delta: float) -> void:
	_update_velocity_by_inputs(delta)
	move_and_slide()
