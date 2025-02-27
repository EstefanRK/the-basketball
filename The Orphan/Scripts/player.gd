extends CharacterBody3D

# CONSTANTS
const SPEED = 2.5
const JUMP_VELOCITY = 4.5

## VARIABLES
@onready var ball = $"../Basketball"
@onready var ray = $Head/RayCast3D
@onready var game_master = $"../Game Master"
@onready var footstep: AudioStreamPlayer3D = $Footstep
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hoop: Node3D = $"../Hoop"

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
	#if event.is_action_pressed("1"):
		#game_master.event_done = false
		#game_master.set_event(1)
	#if event.is_action_pressed("2"):
		#game_master.event_done = false
		#game_master.set_event(2)
	#if event.is_action_pressed("3"):
		#game_master.event_done = false
		#game_master.set_event(3)
	#if event.is_action_pressed("4"):
		#game_master.event_done = false
		#game_master.set_event(4)
	#if event.is_action_pressed("5"):
		#game_master.event_done = false
		#game_master.set_event(5)
	#if event.is_action_pressed("6"):
		#game_master.event_done = false
		#game_master.set_event(6)

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
	if direction != Vector3() and is_on_floor():
		animation_player.play("walk")
	else:
		animation_player.stop()

	move_and_slide()

##SOUNDS
func play_sound(name):
	match name:
		"spooky":
			$"Spooky Sounds".play()
		"bass":
			$"Bass".play()
func ambient_sound(i):
	match i:
		true:
			$Ambience.playing = true
		false:
			$Ambience.playing = false
func play_footstep():
	footstep.pitch_scale = randf_range(.8,1.2)
	footstep.play()

func stop_ambience():
	$Ambience.stop()
