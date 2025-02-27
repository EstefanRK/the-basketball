extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var dead_zone: Area3D = $"Dead zone"
@onready var player: CharacterBody3D = $"../Player"
@onready var hoop: Node3D = $"../Hoop"

var final_event = false
var first_seen = false
var final_seen = false
func _process(delta: float) -> void:
	look_at(player.global_position, Vector3(0,1,0))
	rotation.x = 0
	rotation.z = 0
	if final_seen:
		var direction = -global_transform.basis.z
		global_translate(direction * 80 * delta)  # Apply movement
		animation_player.play("Armature|run")
func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	if !first_seen:
		player.play_sound("bass")
	first_seen = true
	hoop.disabled = false
	if final_event:
		audio_stream_player_3d.play()
		final_seen = true

func _on_dead_zone_body_entered(body: Node3D) -> void:
	if final_seen == true:
		if body.get_name() == "Player":
			get_tree().change_scene_to_file("res://Scenes/end_scene.tscn")

func play_breathe():
	$Breathe.play()
