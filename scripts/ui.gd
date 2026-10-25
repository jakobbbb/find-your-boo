extends Control

@onready var night = $Night/AnimationPlayer

var skipping = false

var last_day_ended = -1

func _ready() -> void:
	GameManager.set_night.connect(_on_set_night)
	GameManager.set_day.connect(_on_set_day)
	set_night_day(false)
	show_char_sprite("NONE")
	GameManager.show_char_sprite.connect(show_char_sprite)
	GameManager.change_cursor.connect(_on_change_cursor)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_skip"):
		skipping = true
	elif event.is_action_released("debug_skip"):
		skipping = false
		
func _process(_delta: float) -> void:
	if skipping:
		%YarnDialogueRunner.request_next_content()
	check_elim_button_visible()


func set_night_day(is_night: bool) -> void:
	# night.color.a = 1 if is_night else 0
	# night.play("fade_night")
	if is_night:
		night.play("fade_night")
	else:
		night.play_backwards("fade_night")

func _on_line() -> void:
	pass

func _on_set_day() -> void:
	set_night_day(false)


func _on_set_night() -> void:
	print("ui: Good night")
	set_night_day(true)


func _on_end_day_button_pressed() -> void:
	var day = str(int(%YarnDialogueRunner.variable_storage.get_value("$day")))
	
	if (last_day_ended >= int(day)):
		return
		
	last_day_ended = int(day)
	check_elim_button_visible()
	
	var node = "end" + day
	print(node)
	%YarnDialogueRunner.start_dialogue(node)

func check_elim_button_visible() -> void:
	var day = int(%YarnDialogueRunner.variable_storage.get_value("$day"))
	if day > last_day_ended:
		$"End Day Button".show()
	else:
		$"End Day Button".hide()

func _on_change_cursor(cur: Control.CursorShape) -> void:
	mouse_default_cursor_shape = cur

func show_char_sprite(cname: String) -> void:
	var found = false
	var sprites = $CharSprites
	if cname.ends_with("_fight"):
		sprites = $CharSpritesFight
		cname.replace("_fight", "")
	for c in sprites.get_children():
		if c.name == cname:
			c.show()
			$Night.color.a = 0.8
			found = true
		elif cname == "host":
			$Night.color.a = 0.8
			found = true
		else:
			c.hide()
	if not found:
		$Night.color.a = 0.0
