@tool extends YarnDialogueRunner

enum Chars {
	DrAcula,
	Fishman,
	Twinkch,
	StrongLesb,
	Ghost,
	Mothy,
}

func _ready() -> void:
	super()
	GameManager.eliminate_char.connect(elim)
	GameManager.set_affection.connect(set_affection)
	node_completed.connect(_on_node_end)

func _input(event: InputEvent) -> void:
	if is_running() and event.is_action_pressed("ui_cancel"):
		stop_dialogue()
		_on_node_end("")
		print(get_affection(Chars.Mothy))

func elim(cname: String) -> void:
	print("Eliminating " + cname)
	print()
	for character in %EliminationCeremony.get_children():
		if not character.has_meta("DialogueNode"):
			continue
		if character.get_meta("DialogueNode") == cname:
			character.hide()
			

func get_affection(c: Chars) -> int:
	var v = ""
	match c:
		Chars.DrAcula:
			v = "$drac"
		Chars.Fishman:
			v = "$fish"
		Chars.Twinkch:
			v = "$witch"
		Chars.StrongLesb:
			v = "$franc"
		Chars.Mothy:
			v = "$moth"
	return variable_storage.get_value_or_default(v, -1)

func set_affection(cname: String, val: int) -> void:
	
	variable_storage.set_value("$"+cname, val)
	print("Set affection for " + cname + " to " + str(val))
	if val == 1000:
		start_dialogue("bye")

func _on_set_day() -> void:
	pass # Replace with function body.

func _on_node_end(_node_name) -> void:
	GameManager.show_char_sprite.emit("NONE")
	GameManager.play_theme.emit("main")
