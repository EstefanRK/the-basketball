extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter"):
		get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
