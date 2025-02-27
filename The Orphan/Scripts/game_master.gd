extends Marker3D

@onready var hoop: Node3D = $"../Hoop"
@onready var hoop_entrance = $"../Hoop/Hoop Entrance"
@onready var hoop_end = $"../Hoop/Hoop End"
@onready var ball = $"../Basketball"
@onready var scream_audio_player = $"../Scream Audio Player"
@onready var player = $"../Player"
@onready var bloody_texts: Node3D = $"../Bloody texts"
@onready var visible_on_screen_notifier_3d: VisibleOnScreenNotifier3D = $"../Hoop/VisibleOnScreenNotifier3D"
@export var incorrect: AudioStream
@export var correct: AudioStream
@onready var police_siren: Node3D = $"../Police Siren"
@onready var crime_scene: Node3D = $"../Crime Scene"
@onready var meat_monster: Node3D = $"../Meat monster"

var event_done = false

## EVENTS
func set_event(num):
	print("Event number: "+str(num))
	if event_done:  # Prevent multiple events in one frame
		return
	match num:
		1: # Screaming lady + text on walls
			scream_audio_player.play()
			bloody_texts.visible = true
			event_done = true
			hoop.disabled = true
		2: # Police sirens
			police_siren.police_siren_event()
		3: # The teleporting hoop
			hoop.teleport()
			hoop.disabled = true
		4: # The parents spawning
			crime_scene.start_crime_scene_event()
		5: # Monster spawn and stands there
			meat_monster.visible = true
			hoop.disabled = true
			meat_monster.play_breathe()
		6: # Monster kills protagonist
			meat_monster.final_event = true
			hoop.disabled = true


func event_updater():
	match hoop.shots_made:
		2:
			set_event(1)
		4:
			set_event(2)
		6:
			set_event(3)
		8:
			set_event(4)
		10:
			set_event(5)
		12:
			set_event(6)

## EVENT 1
func _on_scream_audio_player_finished() -> void:
	player.play_sound("spooky")
	hoop.disabled = false
	
## EVENT 3
