extends YarnDialogueRunner

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

func _input(event: InputEvent) -> void:
	if is_running() and event.is_action_pressed("ui_cancel"):
		stop_dialogue()
		print(get_affection(Chars.Mothy))

func elim(cname: String) -> void:
	print("Eliminating " + cname)
	variable_storage.set_value("$"+cname, 1000)
	start_dialogue("bye")
	print()
	for char in get_children():
		print(char)
		print(char.get_script().get_global_name())
		print()
	print()
	print()

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


func _on_set_day() -> void:
	pass # Replace with function body.
