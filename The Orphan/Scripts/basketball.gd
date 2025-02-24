extends RigidBody3D

const throw_power = 10.0
const pickup_sensitivity = 1.5
@onready var game_master = $"../Game Master"
@onready var player = $"../Player"
@onready var audio_player = $AudioStreamPlayer3D
@onready var rimpos = $"../Rim area".global_position
@export var ball_hit_floor: AudioStream
@export var ball_hit_rim: AudioStream
var pickedup

func _process(delta: float) -> void:
	if player.item_picked_up:
		var head = player.get_child(1)
		position = head.global_position
		rotation = head.global_rotation
		linear_velocity = Vector3(0,0,0)

func pickup():
	if !player.item_picked_up && linear_velocity.length() < pickup_sensitivity:
		player.item_picked_up = true
		visible = false
	elif player.item_picked_up:
		player.item_picked_up = false
		apply_impulse(basis.z*(-throw_power))
		visible = true
		audio_player.volume_db = 0

func _on_body_entered(body: Node) -> void:
	if position.distance_to(rimpos) < 1.0:
		audio_player.stream = ball_hit_rim
		audio_player.play()
	else:
		audio_player.stream = ball_hit_floor
		audio_player.play()
		game_master.hoop_entrance_entered = false
		game_master.hoop_end_entered = false
		game_master.shot_lock = false
	audio_player.volume_db -= 1
