extends Node

@warning_ignore_start("unused_signal")
signal set_night()
signal set_day()
signal set_affection(cname: String, affection: int)
signal eliminate_char(cname: String)
signal reveal_char(cname: String)
signal show_char_sprite(cname: String)
@warning_ignore_restore("unused_signal")

func _ready() -> void:
	randomize_spawns()


static func _yarn_command_set_night():
	GameManager.set_night.emit()
	
static func _yarn_command_set_day():
	GameManager.set_day.emit()

static func _yarn_command_reveal(cname: String):
	GameManager.reveal_char.emit(cname)

static func _yarn_command_sprite(cname: String):
	GameManager.show_char_sprite.emit(cname)

func randomize_spawns():
	var spawns = []
	var npcs = []
	for node in get_children():
		if node.name.begins_with("NPC"):
			npcs.append(node)
			spawns.append(node._get_bottom_coord())
	
	spawns.shuffle()
	
	for i in range(spawns.size()):
		npcs[i].transform.origin = Vector2(spawns[i].x, spawns[i].y + spawns[i].z)
