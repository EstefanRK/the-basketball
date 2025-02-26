extends Node3D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var game_master: Marker3D = $"../Game Master"

func play_sound():
	audio_stream_player_3d.play()
func stop_sound():
	audio_stream_player_3d.stop()
func police_siren_event():
	anim.play("Police_event")
	game_master.event_done = true
	
