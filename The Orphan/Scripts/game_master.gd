extends Marker3D

@onready var hoop_entrance = $"../Hoop Entrance"
@onready var hoop_end = $"../Hoop End"
@onready var ball = $"../Basketball"
var shots_made = 0
var hoop_entrance_entered = false
var hoop_end_entered = false
var shot_lock = false


func _process(delta: float) -> void:
	pass



func _on_hoop_entrance_body_entered(body: Node3D) -> void:
	if not shot_lock and body.global_position.y > hoop_entrance.global_position.y:
		hoop_entrance_entered = true

func _on_hoop_end_body_entered(body: Node3D) -> void:
	if hoop_entrance_entered and body.global_position.y > hoop_end.global_position.y:
		shots_made += 1
	else:
		shot_lock = true
