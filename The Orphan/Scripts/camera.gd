extends Node3D

const mouse_sensitivity = 0.005
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_parent().rotate_y(-event.relative.x*mouse_sensitivity)
		rotate_x(-event.relative.y*mouse_sensitivity)
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
