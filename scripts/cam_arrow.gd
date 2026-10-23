extends Node

signal pressed


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		print("Arrow says hi")
		pressed.emit()
