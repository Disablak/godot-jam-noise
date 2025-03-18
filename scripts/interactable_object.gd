class_name InteractableObject
extends StaticBody2D


@export var res_interact: ResInteract

var _mat: ShaderMaterial


func _ready() -> void:
	_mat = $Sprite2D.material
	outline(false)


func outline(enable: bool):
	_mat.set_shader_parameter("width", 2 if enable else 0)
