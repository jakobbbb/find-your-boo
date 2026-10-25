extends Node

var next_to_be_eliminated = ""
var immune = ""

@warning_ignore_start("unused_signal")
signal set_night()
signal set_day()
signal set_affection(cname: String, affection: int)
signal eliminate_char(cname: String)
signal reveal_char(cname: String)
signal show_char_sprite(cname: String)
signal play_theme(cname: String)
signal change_cursor(cursor: Input.CursorShape)
@warning_ignore_restore("unused_signal")

func _ready() -> void:
	randomize_spawns()
	set_affection.connect(_on_set_affection)


static func _yarn_command_set_night():
	GameManager.set_night.emit()
	GameManager.randomize_spawns()
	
static func _yarn_command_set_day():
	GameManager.set_day.emit()

static func _yarn_command_reveal(cname: String):
	GameManager.reveal_char.emit(cname)

static func _yarn_command_sprite(cname: String):
	GameManager.show_char_sprite.emit(cname)

static func _yarn_command_trigger_elim():
	if GameManager.next_to_be_eliminated != "":
		# GameManager.eliminate_char.emit("ghost")
		GameManager.eliminate_char.emit(GameManager.next_to_be_eliminated)
		GameManager.next_to_be_eliminated = ""

static func _yarn_command_set_immune(cname: String) -> void:
	GameManager.immune = cname

static func _yarn_command_theme(cname: String) -> void:
	GameManager.play_theme.emit(cname)

func _on_set_affection(cname: String, affection: int) -> void:
	if affection == 1000:
		GameManager.next_to_be_eliminated = cname

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
