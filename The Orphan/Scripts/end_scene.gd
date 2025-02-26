extends Control
@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	print("here")
	animation_player.play("ending")

func end():
	label.visible = true
	audio_stream_player_2d.play()
