extends Node

signal pressed


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_pressed():
		print("Arrow says hi")
		pressed.emit()


func _on_area_2d_mouse_entered() -> void:
	GameManager.change_cursor.emit(Control.CURSOR_POINTING_HAND)


func _on_area_2d_mouse_exited() -> void:
	GameManager.change_cursor.emit(Control.CURSOR_ARROW)
