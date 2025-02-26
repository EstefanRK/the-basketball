extends Node3D

@onready var game_master: Marker3D = $"../Game Master"
@onready var player: CharacterBody3D = $"../Player"
@onready var hoop: Node3D = $"../Hoop"
@onready var trigger_1: VisibleOnScreenNotifier3D = $Trigger1
@onready var trigger_2: VisibleOnScreenNotifier3D = $Trigger2

@onready var bodybag_left: Node3D = $"Bodybag left"
@onready var bodybag_right: Node3D = $"bodybag right"
@onready var marker: Node3D = $marker
@onready var marker_2: Node3D = $marker2

func start_crime_scene_event():
	trigger_1.visible = true
var hoop_gone = false
func _on_trigger_1_screen_entered() -> void:
	if game_master.event_done:
		return
func _on_trigger_1_screen_exited() -> void:
	if game_master.event_done:
		return
	hoop.visible = false
	if hoop_gone:
		trigger_2.visible = true
		bodybag_left.visible = true
		bodybag_right.visible = true
		marker.visible = true
		marker_2.visible = true	
	hoop_gone = true

func _on_trigger_2_screen_entered() -> void:
	if game_master.event_done:
		return
	hoop.visible = true
	player.play_sound("name")
	game_master.event_done = true


func _on_trigger_2_screen_exited() -> void:
	if game_master.event_done:
		trigger_2.visible = false
		bodybag_left.visible = false
		bodybag_right.visible = false
		marker.visible = false
		marker_2.visible = false
