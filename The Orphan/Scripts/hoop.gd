extends Node3D

@onready var hoop_entrance: Area3D = $"Hoop Entrance"
@onready var game_master: Marker3D = $"../Game Master"
@onready var hoop_end: Area3D = $"Hoop End"
@onready var hoop_sounds: AudioStreamPlayer3D = $"Hoop Sounds"
@onready var visible_on_screen_notifier_3d: VisibleOnScreenNotifier3D = $VisibleOnScreenNotifier3D
@export var incorrect: AudioStream
@export var correct: AudioStream
@onready var rim_area: Marker3D = $"Rim area"

@onready var player: CharacterBody3D = $"../Player"

var shots_made = 0
var shots_cheated = 0
var hoop_entrance_entered = false
var hoop_end_entered = false
var shot_lock = false

## HOOP FUNCTIONS
func _on_hoop_entrance_body_entered(body: Node3D) -> void:
	print("yes",shot_lock)
	if !shot_lock && body.global_position.y > hoop_end.global_position.y:
		print("yes1")
		hoop_entrance_entered = true

func _on_hoop_end_body_entered(body: Node3D) -> void:
	print("no")
	print(hoop_entrance_entered)
	print(body.global_position.y)
	print(hoop_end.global_position.y)
	print(shot_lock)
	# Checks if player made a shot and gives one point.
	if hoop_entrance_entered && body.global_position.y > hoop_end.global_position.y && !shot_lock:
		print("yes2")
		shots_made += 1
		hoop_sounds.stream = correct
		hoop_sounds.play()
		print(shots_made, game_master.event_done)
		shot_lock = true
		game_master.event_done = false
	# If player tries to cheat and throw from under.
	elif !hoop_entrance_entered && body.global_position.y < hoop_end.global_position.y && !shot_lock:
		print("really?")
		shots_cheated += 1
		hoop_sounds.stream = incorrect
		hoop_sounds.play()
	shot_lock = true

## CHANGE LOCATION EVENT 2
var location_changed = false
func event_2():
	#print("here")
	visible_on_screen_notifier_3d.visible = true

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	if !location_changed:
		#print("here2")
		rotate_y(deg_to_rad(180))
		rim_area.global_position = rim_area.global_position
		hoop_entrance.global_position = hoop_entrance.global_position
		hoop_end.global_position = hoop_end.global_position
		# Optionally, you can call this on the Area3D nodes to ensure collision is updated
		hoop_entrance.set_deferred("monitoring", true)
		hoop_end.set_deferred("monitoring", true)
		#print("here3")
		location_changed = true
	
	
func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	if location_changed:
		visible_on_screen_notifier_3d.visible = false
		player.play_sound("")
		game_master.event_done = true
