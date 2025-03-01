extends Node3D

const mouse_sensitivity = 0.005
const controller_sensitivity = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_parent().rotate_y(-event.relative.x*mouse_sensitivity)
		rotate_x(-event.relative.y*mouse_sensitivity)
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
		

func _process(delta):
	var cam_input_dir := Input.get_vector("look_left", "look_right", "look_up", "look_down")
	if cam_input_dir.length() > 0.02:  # Prevents tiny accidental movement
		rotate_x(-cam_input_dir.y * controller_sensitivity * delta)
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))

		get_parent().rotate_y(-cam_input_dir.x * controller_sensitivity * delta)
