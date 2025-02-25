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
var shots_made = 0
var shots_cheated = 0
var hoop_entrance_entered = false
var hoop_end_entered = false
var shot_lock = false
var event_done = false
## HOOP FUNCTIONS
func _on_hoop_entrance_body_entered(body: Node3D) -> void:
	if !shot_lock && body.global_position.y > hoop_entrance.global_position.y:
		hoop_entrance_entered = true

func _on_hoop_end_body_entered(body: Node3D) -> void:
	# Checks if player made a shot and gives one point.
	if hoop_entrance_entered && body.global_position.y > hoop_end.global_position.y && !shot_lock:
		shots_made += 1
		hoop_sounds.stream = correct
		hoop_sounds.play()
		print(shots_made, event_done)
		shot_lock = true
		event_done = false
	# If player tries to cheat and throw from under.
	elif !hoop_entrance_entered && body.global_position.y < hoop_end.global_position.y && !shot_lock:
		print("really?")
		shots_cheated += 1
		hoop_sounds.stream = incorrect
		hoop_sounds.play()
	shot_lock = true

## EVENTS
func set_event(num):
	print("event: "+str(num))
	if event_done:  # Prevent multiple events in one frame
		return
	match num:
		1:
			scream_audio_player.play()
			bloody_texts.visible = true
		2:
			visible_on_screen_notifier_3d.visible = true


func event_updater():
	if shots_made == 2:
		set_event(1)
	if shots_made == 4:
		set_event(2)

## EVENT 1
func _on_scream_audio_player_finished() -> void:
	player.play_sound("")

## EVENT 2
var location_changed = false
func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	if !location_changed:
		hoop.rotate_y(deg_to_rad(180)) # DOESN'T ROTATE CHILDREN
		location_changed = true
	
	
func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	if location_changed:
		visible_on_screen_notifier_3d.visible = false
		player.play_sound("")
