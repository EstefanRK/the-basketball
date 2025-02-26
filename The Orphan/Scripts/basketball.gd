extends RigidBody3D

const throw_power = 10.0
const pickup_sensitivity = 1.5
@onready var game_master = $"../Game Master"
@onready var player = $"../Player"
@onready var audio_player = $AudioStreamPlayer3D
@onready var rimpos = $"../Hoop/Rim area".global_position
@onready var hoop: Node3D = $"../Hoop"
@export var ball_hit_floor: AudioStream
@export var ball_hit_rim: AudioStream

func _process(_delta: float) -> void:
	if player.item_picked_up:
		var head = player.get_child(1)
		position = head.global_position
		rotation = head.global_rotation
		linear_velocity = Vector3(0,0,0)

func pickup():
	if !player.item_picked_up && linear_velocity.length() < pickup_sensitivity:
		player.item_picked_up = true
		visible = false
		game_master.event_updater()
	# Throw the ball
	elif player.item_picked_up:
		player.item_picked_up = false
		apply_impulse(basis.z*(-throw_power))
		visible = true
		audio_player.volume_db = 0

func _on_body_entered(body: Node) -> void:
	if abs(position.y - rimpos.y) < 2 && body.get_name() == "Hoop":
		audio_player.stream = ball_hit_rim
		audio_player.play()
	else:
		audio_player.stream = ball_hit_floor
		audio_player.play()
		hoop.hoop_entrance_entered = false
		hoop.hoop_end_entered = false
		hoop.shot_lock = false
	audio_player.volume_db -= 1
	#print(rimpos)
