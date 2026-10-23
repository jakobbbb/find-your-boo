extends Node

@onready var dia: YarnDialogueRunner = %YarnDialogueRunner

func _get_bottom_coord() -> Vector3:
	var c = $Area2D/CollisionShape2D
	var dy = 0.5 * c.shape.get_rect().size.y
	var v2 = self.transform.origin - Vector2(0, dy)
	return Vector3(v2.x, v2.y, dy)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		var node = get_meta("DialogueNode")
		dia.start_dialogue(node)
