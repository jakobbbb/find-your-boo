extends Node2D


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_pressed():
		var cname = get_meta("DialogueNode")
		GameManager.eliminate_char.emit(cname)
