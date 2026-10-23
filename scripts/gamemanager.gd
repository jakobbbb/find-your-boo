extends Node

func _ready() -> void:
	randomize_spawns()

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
