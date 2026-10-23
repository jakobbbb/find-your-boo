extends Node2D


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		get_tree().change_scene_to_file("res://test.tscn")
