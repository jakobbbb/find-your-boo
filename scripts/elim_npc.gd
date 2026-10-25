extends Node2D

var revealed = false

func _ready() -> void:
	GameManager.reveal_char.connect(_on_reveal_char)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_pressed():
		if is_immune():
			print(name + " is immune, won't yeet")
			return
		var cname = get_meta("DialogueNode")
		if cname != "ghost":
			GameManager.set_affection.emit(cname, 1000)
		else:
			print("won't eliminate the ghost :)")
			GameManager.trigger_dialogue.emit("noghost")

func _on_reveal_char(cname: String) -> void:
	if revealed:
		return
	if has_meta("DialogueNode") and get_meta("DialogueNode") == cname:
		$AnimationPlayer.play("ghost_reveal")
		revealed = true

func _on_area_2d_mouse_entered() -> void:
	print(GameManager.immune)
	if is_immune():
		GameManager.change_cursor.emit(Control.CURSOR_FORBIDDEN)
	else:
		GameManager.change_cursor.emit(Control.CURSOR_POINTING_HAND)


func _on_area_2d_mouse_exited() -> void:
	GameManager.change_cursor.emit(Control.CURSOR_ARROW)

func is_immune() -> bool:
	return get_meta("DialogueNode") == GameManager.immune
