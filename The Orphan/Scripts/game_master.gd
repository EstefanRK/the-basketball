extends Marker3D

@onready var hoop: Node3D = $"../Hoop"
@onready var hoop_entrance = $"../Hoop/Hoop Entrance"
@onready var hoop_end = $"../Hoop/Hoop End"
@onready var ball = $"../Basketball"
@onready var scream_audio_player = $"../Scream Audio Player"
@onready var player = $"../Player"
@onready var hoop_sounds: AudioStreamPlayer3D = $"../Hoop/Hoop Sounds"
@onready var bloody_texts: Node3D = $"../Bloody texts"
@onready var visible_on_screen_notifier_3d: VisibleOnScreenNotifier3D = $"../Hoop/VisibleOnScreenNotifier3D"
@export var incorrect: AudioStream
@export var correct: AudioStream

var event_done = false

## EVENTS
func set_event(num):
	print("event: "+str(num))
	if event_done:  # Prevent multiple events in one frame
		return
	match num:
		1:
			scream_audio_player.play()
			bloody_texts.visible = true
			event_done = true
		2:
			hoop.event_2()


func event_updater():
	if hoop.shots_made == 2:
		set_event(1)
	if hoop.shots_made == 4:
		set_event(2)

## EVENT 1
func _on_scream_audio_player_finished() -> void:
	player.play_sound("")
	
## EVENT 3
