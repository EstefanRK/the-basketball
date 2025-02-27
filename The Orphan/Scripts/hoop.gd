extends Node3D

@onready var hoop_entrance: Area3D = $"Hoop Entrance"
@onready var game_master: Marker3D = $"../Game Master"
@onready var hoop_end: Area3D = $"Hoop End"
@onready var hoop_correct: AudioStreamPlayer3D = $"Hoop Correct"
@onready var hoop_wrong: AudioStreamPlayer3D = $"Hoop Wrong"
@onready var visible_on_screen_notifier_3d: VisibleOnScreenNotifier3D = $VisibleOnScreenNotifier3D
@onready var rim_area: Marker3D = $"Rim area"
@onready var meat_monster: Node3D = $"../Meat monster"

@onready var player: CharacterBody3D = $"../Player"

var shots_made = 0
var shots_cheated = 0
var hoop_entrance_entered = false
var hoop_end_entered = false
var shot_lock = false
var disabled = false
## HOOP FUNCTIONS
func _on_hoop_entrance_body_entered(body: Node3D) -> void:
	if !shot_lock && body.global_position.y > hoop_end.global_position.y:
		hoop_entrance_entered = true

func _on_hoop_end_body_entered(body: Node3D) -> void:
	# Checks if player made a shot and gives one point.
	if hoop_entrance_entered && body.global_position.y > hoop_end.global_position.y && !shot_lock:
		if meat_monster.final_event:
			hoop_wrong.play()
			shot_lock = true
			game_master.event_done = false
		else:
			if !disabled:
				shots_made += 1
				game_master.event_done = false
			hoop_correct.play()
			shot_lock = true
	# If player tries to cheat and throw from under.
	elif !hoop_entrance_entered && body.global_position.y < hoop_end.global_position.y && !shot_lock:
		shots_cheated += 1
		hoop_wrong.play()
	shot_lock = true

## CHANGE LOCATION EVENT 2
var location_changed = false
func teleport():
	visible_on_screen_notifier_3d.visible = true

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	if !location_changed:
		rotate_y(deg_to_rad(180))
		rim_area.global_position = rim_area.global_position
		hoop_entrance.global_position = hoop_entrance.global_position
		hoop_end.global_position = hoop_end.global_position
		hoop_entrance.set_deferred("monitoring", true)
		hoop_end.set_deferred("monitoring", true)
		location_changed = true
		disabled = false
		game_master.event_done = true
	
	
func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	if location_changed:
		visible_on_screen_notifier_3d.visible = false
		player.play_sound("spooky")
		game_master.event_done = true
