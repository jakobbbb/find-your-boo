extends Control

@onready var night = $Night/AnimationPlayer


func _ready() -> void:
	GameManager.set_night.connect(_on_set_night)
	GameManager.set_day.connect(_on_set_day)
	set_night_day(false)

func set_night_day(is_night: bool) -> void:
	# night.color.a = 1 if is_night else 0
	# night.play("fade_night")
	if is_night:
		night.play("fade_night")
	else:
		night.play_backwards("fade_night")


func _on_set_day() -> void:
	set_night_day(false)


func _on_set_night() -> void:
	print("ui: Good night")
	set_night_day(true)


func _on_end_day_button_pressed() -> void:
	var day = str(int(%YarnDialogueRunner.variable_storage.get_value("$day")))
	var node = "end" + day
	print(node)
	%YarnDialogueRunner.start_dialogue(node)
