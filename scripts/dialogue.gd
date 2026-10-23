extends YarnDialogueRunner

func _input(event: InputEvent) -> void:
	if is_running() and event.is_action_pressed("ui_cancel"):
		stop_dialogue()
