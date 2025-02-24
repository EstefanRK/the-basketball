extends Marker3D

@onready var hoop_entrance = $"../Hoop/Hoop Entrance"
@onready var hoop_end = $"../Hoop/Hoop End"
@onready var ball = $"../Basketball"
@onready var scream_audio_player = $"../Scream Audio Player"
var shots_made = 0
var shots_cheated = 0
var hoop_entrance_entered = false
var hoop_end_entered = false
var shot_lock = false
var world_timer = 0

func _process(delta: float) -> void:
	#world_timer += 1
	#if fmod(world_timer,10) == 6:
		#print(shots_made)
	pass



func _on_hoop_entrance_body_entered(body: Node3D) -> void:
	if !shot_lock && body.global_position.y > hoop_entrance.global_position.y:
		hoop_entrance_entered = true

func _on_hoop_end_body_entered(body: Node3D) -> void:
	# Checks if player made a shot and gives one point.
	if hoop_entrance_entered && body.global_position.y > hoop_end.global_position.y && !shot_lock:
		shots_made += 1
		print(shots_made)
	# If player tries to cheat and throw from under.
	elif !hoop_entrance_entered && body.global_position.y < hoop_end.global_position.y:
		print("really?")
		shots_cheated += 1
	shot_lock = true

func set_event(num):
	print("event: "+str(num))
	if num == 1:
		scream_audio_player.play()

func event_updater():
	if shots_made == 2:
		set_event(1)


func _on_timer_timeout() -> void:
	pass # Replace with function body.
