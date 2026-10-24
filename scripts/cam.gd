extends Camera2D

@onready var dia: YarnDialogueRunner = %YarnDialogueRunner


func _on_arrow_pressed() -> void:
	if not dia.is_running():
		make_current()

func _yarn_command_cam() -> void:
	make_current()
