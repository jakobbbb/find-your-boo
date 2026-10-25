extends Node

@onready var dia: YarnDialogueRunner = %YarnDialogueRunner

func _ready() -> void:
	GameManager.eliminate_char.connect(_on_elim_char)
	dia.node_started.connect(_on_node_start)
	set_ghost_visible(true)  # starting off ghostly

func _on_elim_char(cname: String) -> void:
	if not has_meta("DialogueNode"):
		return
	if cname == get_meta("DialogueNode"):
		self.transform.origin = Vector2(99999999, 9999999999)

func _on_node_start(node_name: String) -> void:
	if node_name.begins_with("day"):
		var d = int(node_name.replace("day", ""))
		set_ghost_visible(d == 1)
			
	
func _get_bottom_coord() -> Vector3:
	var c = $Area2D/CollisionShape2D
	var dy = 0.5 * c.shape.get_rect().size.y
	var v2 = self.transform.origin - Vector2(0, dy)
	return Vector3(v2.x, v2.y, dy)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not event.is_pressed():
		return
		
	if get_meta("DialogueNode") != "ghost":
		if get_day() == 2:
			var char_name = get_meta("Day2CharName")
			dia.variable_storage.set_value("$charname", char_name)
			dia.start_dialogue("singles2")
			return
		if get_day() == 4:
			var char_name = get_meta("Day4CharName")
			dia.variable_storage.set_value("$charname", char_name)
			dia.start_dialogue("family4")
			return
			
	var node_base = get_meta("DialogueNode")
	var node = node_base + str(get_day())
	print("Starting node", node)
	dia.start_dialogue(node)

func get_day() -> int:
	return dia.variable_storage.get_value("$day")

func set_ghost_visible(ghostly: bool) -> void:
	var g = $"Sprite2D Ghost"
	var n = $"Sprite2D"
	if ghostly:
		g.show()
		n.hide()
	else:
		g.hide()
		n.show()


func _on_area_2d_mouse_entered() -> void:
	GameManager.change_cursor.emit(Control.CURSOR_POINTING_HAND)


func _on_area_2d_mouse_exited() -> void:
	GameManager.change_cursor.emit(Control.CURSOR_ARROW)
