extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var dead_zone: Area3D = $"Dead zone"
@onready var player: CharacterBody3D = $"../Player"

var final_event = false
var first_seen = false
var final_seen = false
func _process(delta: float) -> void:
	look_at(player.global_position, Vector3(0,1,0))
	rotation.x = 0
	rotation.z = 0
	if final_seen:
		print("RUNN")
		var direction = -global_transform.basis.z
		global_translate(direction * 80 * delta)  # Apply movement
		animation_player.play("Armature|ArmatureAction")
func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	first_seen = true
	if final_event:
		audio_stream_player_3d.play()
		final_seen = true

func _on_dead_zone_body_entered(body: Node3D) -> void:
	pass # KILL
