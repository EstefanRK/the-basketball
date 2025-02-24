extends CharacterBody3D

# CONSTANTS
const SPEED = 2.5
const JUMP_VELOCITY = 4.5

# VARIABLES
@onready var ball = $"../Basketball"
@onready var ray = $Head/RayCast3D
@onready var game_master = $"../Game Master"
var item_picked_up = false

##INTERACT
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("click"):
		if item_picked_up:
			ball.pickup()
		if ray.is_colliding():
			var hit = ray.get_collider()
			if hit.has_method("pickup"):
				ball.pickup()
	# DEVELOPER TOOLS
	if event.is_action_pressed("1"):
		game_master.event_done = false
		game_master.set_event(1)
	if event.is_action_pressed("2"):
		game_master.event_done = false
		game_master.set_event(2)

##MOVEMENT
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

##SOUNDS
func play_sound(name):
	$"Spooky Sounds".play()
