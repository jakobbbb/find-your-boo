extends Camera2D

var a = []

func _ready() -> void:
	for c in get_children():
		if c.name == "Arrow":
			a.append(c)


func _on_arrow_pressed() -> void:
	make_current()
