extends Node2D

func _ready() -> void:
	GameManager.reveal_char.connect(_on_reveal_char)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_pressed():
		var cname = get_meta("DialogueNode")
		if cname != "ghost":
			GameManager.eliminate_char.emit(cname)
		else:
			print("won't eliminate the ghost :)")

func _on_reveal_char(cname: String) -> void:
	if has_meta("DialogueNode") and get_meta("DialogueNode") == cname:
		$AnimationPlayer.play("ghost_reveal")
