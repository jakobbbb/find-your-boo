extends Node

@onready var dia: YarnDialogueRunner = %YarnDialogueRunner

func _ready() -> void:
	GameManager.eliminate_char.connect(_on_elim_char)

func _on_elim_char(cname: String) -> void:
	if cname == get_meta("DialogueNode"):
		self.transform.origin = Vector2(99999999, 9999999999)
	
func _get_bottom_coord() -> Vector3:
	var c = $Area2D/CollisionShape2D
	var dy = 0.5 * c.shape.get_rect().size.y
	var v2 = self.transform.origin - Vector2(0, dy)
	return Vector3(v2.x, v2.y, dy)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not event.is_pressed():
		return
		
	if get_day() == 2:
		var char_name = get_meta("Day2CharName")
		const node = "singles2"
		dia.variable_storage.set_value("$charname", char_name)
		dia.start_dialogue(node)
		return
		
	var node_base = get_meta("DialogueNode")
	var node = node_base + str(get_day())
	print("Starting node", node)
	dia.start_dialogue(node)

func get_day() -> int:
	return dia.variable_storage.get_value("$day")
