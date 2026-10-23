extends Node

@onready var dia: YarnDialogueRunner = %YarnDialogueRunner


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		var node = get_meta("DialogueNode")
		dia.start_dialogue(node)
		
